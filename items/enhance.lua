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
        if context.playing_card_end_of_round and context.cardarea == G.hand then
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