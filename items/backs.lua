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
