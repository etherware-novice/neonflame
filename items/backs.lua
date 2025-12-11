SMODS.Back({
    key = "selfinsert",
    name = "Deck of Slimes",

    atlas = "backs",
    pos = { x = 0, y = 0 },

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                        local key = localize({ type = "name_text", key = v.key, set = "Joker" }) or "nil"
                        if string.find(key, "sappy") or string.find(key, "Sappy") or string.find(v.key, "sappy")  then
                            SMODS.add_card { key = v.key }
                        end
                    end

                    return true
                end
            end
        }))
    end
})

SMODS.Back {
    key = "ramped",
    name = "Ramped Deck",

    atlas = "backs",
    pos = { x = 1, y = 0 },
    config = { cost = 1 },

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.cost } }
    end,

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = self.config.cost
                return true
            end
        }))
    end,

    calculate = function(self, back, context)
        if context.ending_shop then
            G.GAME.nflame_past_reroll = G.GAME.current_round.reroll_cost
        end
        
        if context.end_of_round and context.beat_boss then
            G.GAME.nflame_past_reroll = nil
        end

        if context.starting_shop then
            G.GAME.round_resets.temp_reroll_cost = G.GAME.nflame_past_reroll 
            calculate_reroll_cost(true)
        end
    end,

    in_pool = function(self, args)
        print(args)
    end,
}
