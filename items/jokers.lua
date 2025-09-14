SMODS.Joker {
    key = "jokerhelp",
    name = "Helping Hand",

    atlas = "jokers1",
    pos = { x = 0, y = 0 },

    config = { extra = { bonus = 1 } },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.bonus} }
    end,

    calculate = function(self, card, context)
        if context.blueprint then return end
	
        if context.setting_blind or context.forcetrigger
	or (context.card_added and context.card == card)
	then
	    bonus_hand = 0
	    for _, tcard in ipairs(G.jokers.cards) do
	        G.E_MANAGER:add_event(Event({
		    trigger = "after",
		    delay = 0.3,
		    func = function()
		        tcard:juice_up(0.8, 0.5)
			return true
		    end,
		}))

		bonus_hand = bonus_hand + card.ability.extra.bonus
	    end

	    G.E_MANAGER:add_event(Event({
	        func = function()
		    ease_hands_played(bonus_hand)
		    card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
		        messsage = localize({ type = "variable", key = "a_hands", vars = {bonus_hand} })
		    })

		    return true
		end
	    }))
	end

	if context.after then
	    if G.GAME.current_round.hands_left < #G.jokers.cards then
		
	        local sac_card = G.jokers.cards[1]
		if sac_card.is_eternal or sac_card.getting_sliced then
		    sac_card = card -- sacrifices must be made
		end
		sac_card.getting_sliced = true

		G.GAME.joker_buffer = G.GAME.joker_buffer - 1
		G.E_MANAGER:add_event(Event({
		    func = function()
		        G.GAME.joker_buffer = 0
			card:juice_up(0.8, 0.8)
			sac_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			play_sound("slice1", 0.96 + math.random() * 0.08)
			return true
		    end,
		}))
	    end
	end
    end,
}

SMODS.Joker {
    name = "Hoarder",
    key = "hoarder",

    atlas = "jokers1",
    pos = { x = 1, y = 0 },

    rarity = 3,
    cost = 5,
    blueprint_compat = true,
    config = { extra = { mult = 1 }, immutable = { lv = 1 } },
    loc_vars = function(self, info_queue, center)
        return {vars = { center.ability.extra.mult, center.ability.extra.mult * center.ability.immutable.lv }}
    end,

    update_numbers = function(self, card)
        local value = 0
	if G.STEAM and G.STEAM.user then
	    value = G.STEAM.user.getPlayerSteamLevel()
	end

	card.ability.immutable.lv = 1 + value
    end,

    set_ability = function(self, card, initial, delay_sprites)
        self:update_numbers(card)
    end,

    load = function(self, card, card_table, other_card)
        self:update_numbers(card)
    end,

    calculate = function(self, card, context)
	
        if context.joker_main or context.forcetrigger
	then
	    local cmult = card.ability.extra.mult * card.ability.immutable.lv
	    
	    return {
	        message = localize({ type = "variable", key = "a_xmult", vars = { cmult } }),
		Xmult_mod = cmult,
		colour = G.C.MULT,
	    }
	end
    end,
}


SMODS.Joker {
    key = "nflame",
    name = "Neonflame",

    atlas = "jokers1",
    pos = { x = 2, y = 0 },

    -- hardcoding the timestamp will definitely not bite me in the butt later
    config = {extra = { Xmult = 1, decay = 0.1 }, immutable = { cards = 0, timestamp = 1757737690 }},
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult, card.ability.extra.decay, self:calc_xmult(card) } }
    end,

    update_numbers = function(self, card)
    	local scale = 0
        for _, jok in pairs(G.P_CENTER_POOLS.Joker) do
	    if jok.original_mod and jok.original_mod.id == "nflame" then
	        scale = scale + 1
	    end
	end

	card.ability.immutable.cards = scale
    end,

    calc_xmult = function(self, card)
    	local xm = card.ability.extra.Xmult * card.ability.immutable.cards
	local decaytime = (os.time() - card.ability.immutable.timestamp) / 86400
	xm = xm - (card.ability.extra.decay * decaytime)

	return math.max(xm, 1.5)
    end,

    set_ability = function(self, card, initial, delay_sprites)
    	self:update_numbers(card)
    end,

    load = function(self, card, card_table, other_card)
    	self:update_numbers(card)
    end,

    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger
	then
	    local xm = self:calc_xmult(card)
	    return {
	        message = localize({ type = "variable", key = "a_xmult", vars = { xm } }),
		Xmult_mod = xm,
		colour = G.C.MULT,
	    }
	end
    end,
}

SMODS.Joker {
    key = "forecast",
    name = "Forecast",

    atlas = "jokers1",
    pos = { x = 3, y = 0 },

    config = { extra = { cards = 4 } },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.cards} }
    end,

    calculate = function(self, card, context)
    	if context.ending_booster then
 	    card.stopinf = false
	end

        if context.other_drawn or context.force_trigger then
	    if card.stopinf then return end
	    G.E_MANAGER:add_event(Event({
		func = function()
		    card:juice_up(0.8, 0.5)
		    SMODS.draw_cards(card.ability.extra.cards)

		    return true
		end,
	    }))

	    card.stopinf = true
	end
    end,
}

SMODS.Joker {
    key = "numberup",
    name = "Number Go Up",

    atlas = "jokers1",
    pos = { x = 4, y = 0 },

    config = { extra = { increase = 0.1, requirement = 5 } },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {self:calc_xmult(card), card.ability.extra.increase, card.ability.extra.requirement} }
    end,

    calc_xmult = function(self, card)
        local dollar = (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)
	local bonus = math.floor(dollar / card.ability.extra.requirement) * card.ability.extra.increase
        return bonus + 1
    end,

    set_ability = function(self, card, initial, delay_sprites)
        self:calc_xmult(card)
    end,

    calculate = function(self, card, context)
        local xm_trigger = context.forcetrigger
	
        if context.other_joker and context.other_joker.ability.set == "Joker" then
	    G.E_MANAGER:add_event(Event({
	        func = function()
		    context.other_joker:juice_up(0.5, 0.5)
		    return true
		end
	    }))
	    xm_trigger = true
	end

	if xm_trigger then
	    local multv = self:calc_xmult(card)
	    return {
	        message = localize({ type = "variable", key = "a_xmult", vars = { multv }}),
		colour = G.C.MULT,
		Xmult_mod = multv,
	    }
	end

	if context.final_scoring_step then
	    if SMODS.calculate_round_score() < (G.GAME.blind.chips * 0.25) then
	        return {
		    dollars = math.floor(G.GAME.dollars * -0.75),
		    color = G.C.MONEY
		}
	    end
	end
    end,
}