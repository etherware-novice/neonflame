-- fuck you and fuck your stupid mod

G.E_MANAGER.add_event(Event({
    func = function()
        for k, v in pairs(G.P_CENTER_POOLS.Joker) do
            v.hpot_unbreedable = true
        end

        return false
    end
}))
