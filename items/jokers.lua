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