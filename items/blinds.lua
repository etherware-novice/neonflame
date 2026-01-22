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

SMODS.Blind {
    key = "jp_mole",
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX("A61A1F"),

    atlas = "blinds",
    pos = { x = 0, y = 0 },

    calculate = function(self, blind, context)
        if context.nflame_post_shuffle and not blind.disabled then
            return {
                sort = function(a, b)
                    return (a.ability.nflame_scoredcount or 0) > (b.ability.nflame_scoredcount or 0)
                end,
                priority = 0,
                debug = "woawow"
            }
        end
    end,

    disable = function(self)
        G.deck.cards:shuffle("nflame_mole")
    end
}
