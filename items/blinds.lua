SMODS.Blind {
    key = "jpenguin",
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX("74CCA8"),

    atlas = "blinds",
    pos = { x = 0, y = 0 },
    
    debuff_hand = function(self, cards, hand, handname, check)
        if #cards < 1 then return true end
        local _, _, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(cards)

        for i, card in ipairs(cards) do
            -- idk if the card.config thing will work but im copying phanta here...
            if not SMODS.in_scoring(card, scoring_hand) and not SMODS.always_scores(card) then return end
        end

        return true
    end
}
