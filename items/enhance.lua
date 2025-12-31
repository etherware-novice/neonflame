SMODS.Enhancement {
    key = "snow",
    name = "Snow Card",

    atlas = "enhance",
    pos = { x = 0, y = 0 },

    config = { extra = { mult = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card and card.ability.extra.mult or self.config.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.hand then
	    local bonus_m = 0
	    for _, playing_card in pairs(G.hand.cards) do
	        if SMODS.has_enhancement(playing_card, "m_nflame_snow") then
		    bonus_m = bonus_m + card.ability.extra.mult
		end
	    end

            card.ability.perma_mult = (card.ability.perma_mult or 0) + bonus_m

	    return {
	        message = localize('k_upgrade_ex'),
		colour = G.C.CHIPS
	    }
	end
    end
}

SMODS.Enhancement {
    key = "rules",
    name = "Rouxles",

    atlas = "enhance",
    pos = { x = 1, y = 0 },

    config = { extra = { decreaseperc = 10, reroll = 4, disable = 5 } },

    loc_vars = function(self, info_queue, card)
    	local renum, reden = SMODS.get_probability_vars(card, 1, card and card.ability.extra.reroll or self.config.extra.reroll, "nflame_rules")
        return { vars = {
	    card and card.ability.extra.decreaseperc or self.config.extra.decreaseperc,
	    renum, reden
	} }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then

	    local doublehit = SMODS.pseudorandom_probability(card, "nflame_rules", 1, card.ability.extra.reroll)

	    G.E_MANAGER:add_event(Event({
	        func = function()
		    local newperc = card.ability.extra.decreaseperc
		    if doublehit then
		        newperc = newperc * 2

			if not G.GAME.blind.disabled then G.GAME.blind:disable() end
		    end
		    newperc = (100 - newperc) / 100
		    
		    G.GAME.blind.chips = math.floor(G.GAME.blind.chips * newperc)
		    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

		    G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
		    G.HUD_blind:recalculate()
		    G.hand_text_area.blind_chips:juice_up()
		    return true
		end,
	    }))

	    return {
	        message = doublehit and "Disabled!" or nil
	    }
	end
    end
}

SMODS.Enhancement {
    key = "hp",
    name = "Holepunch Card",

    atlas = "enhance",
    pos = { x = 3, y = 0 },

    calculate = function(self, card, context)
    end
}

local drpd = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    -- more copying from hook

    local candidate = {}
    for i, playing_card in ipairs(G.hand.cards) do
        if
            (not playing_card.shattered) and (not playing_card.destroyed)
            and SMODS.has_enhancement(playing_card, "m_nflame_hp")
        then
            table.insert(candidate, i)
        end
    end

    local target = pseudorandom_element(candidate, "nflame_hp")
    if not target then return drpd(e) end

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.7,
        func = function()
            G.hand:add_to_highlighted(G.hand.cards[target])
            G.FUNCS.discard_cards_from_highlighted(nil, true)

            return true
        end
    }))

    for i = 1, #G.play.cards do
        if not G.play.cards[i].shattered and not G.play.cards[i].destroyed then
            draw_card(G.play, G.hand, i*100/#G.hand.cards, "up", true, G.play.cards[i])
        end
    end

    -- return drpd(e)
end
