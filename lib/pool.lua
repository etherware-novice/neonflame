local pools = {
    silicon   = { default = "j_nflame_spbump", color = "nflame_silicon" },
    spess     = { color = "planet" },
    modcom    = { color = "red" },
    oc        = { color = "gold" },
    cloverpit = { color = "money" },
    minecraft = { color = "green" },
    internet  = { color = "planet" },
    mario     = { color = "red" },
    gimmiko   = { color = "green" },
    zelda     = { color = "attention" },
    hitch     = { color = "spectral" },
    parable   = { color = "inactive" },
    deltarune = { color = "dark_edition" },
    inscr     = { color = "spades" },
    pwright   = { color = "blue" }
}

for rkey, p in pairs(pools) do
    if not G.P_CENTER_POOLS[rkey] then
        local reg = p
        reg.key = rkey
        reg.cards = {}
        SMODS.ObjectType(p)
    end
end


local scmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    for key, p in pairs(pools) do
        if obj and obj.pools and obj.pools[key] then
            badges[#badges+1] = create_badge(localize("k_" .. key), G.ARGS.LOC_COLOURS[p.color])
        end
    end

    return scmb(obj, badges)
end
