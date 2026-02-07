local jokers = {
    -- mason system
    OBJE_MASON = {rarity = 3, desc = {"All evidence pieces provide 1 {C:nflame_silicon}Silicon{} value"} },
    -- trucy
    CHAR_Trucy = {rarity = 3, desc = {"Destroys a random {C:attention}non-negative evidence piece at end of ante", 
                                     "and create a {C:dark_edition}negative{} copy"}},
    -- red slime
    CHAR_RdSlm = {rarity = 2, desc = {"When a card is scored, draw a card of the same rank if possible"}},
    -- cheese
    FOOD_Chees = {rarity = 1, desc = {"{C:green}1 in 3{} chance to destroy self",
                                     "and create an {C:attention}Uncommon Tag{} when Blind is selected"}},
    -- blue cheese
    FOOD_BlChs = {rarity = 1, desc = {{"{C:green}1 in 2{} chance to destroy self",
                                      "and create a {C:attention}Rare Tag{} when Blind is selected"},
                                      {"{C:inactive}NOTE_1: only spawns when cheese is destroyed"}}},
    -- superiority complex
    OTHR_SupCx = {rarity = 1, desc = {"{C:mult}+2{} mult for every hand played less times than the current hand"}},
    -- dark side of the moon
    OBJE_DSoMn = {rarity = 2,
       desc = {"{C:attention}Secret hands{} level up an extra time for every hand of a higher {C:planet}level{}"}},
    -- garbage license
    OBJE_GarbL = { rarity = 2, desc = {"Go up to 2 {C:blue}hands{} and {C:red}discards{} in {C:red}debt"}}
}


local retr = {}
for k, v in pairs(jokers) do
    table.insert(retr, {
        key = k,
        name = k,
        object_type = "Joker",
        discovered = true,
        no_collection = true,
        atlas = "placeholders",
        pos = { x = 2, y = 0 },

        loc_txt = { name = k, text = v.desc },
        rarity = v.rarity,
        pools = { unfinished = true },
        in_pool = function() return false end
    })
end


-- custom collection category
SMODS.current_mod.custom_collection_tabs = function()
    local num = #G.P_CENTER_POOLS.unfinished
    return {
        UIBox_button({
            button = "your_collection_nflame_uf",
            id = "your_collection_nflame_uf",
            count = { tally = num, of = num },
            minw = 5,
            minh = 1
        })
    }
end

G.FUNCS.your_collection_nflame_uf = function()
    for _, v in pairs(G.P_CENTER_POOLS.unfinished) do v.no_collection = nil end

    local overlay = SMODS.card_collection_UIBox(G.P_CENTER_POOLS.unfinished, { 5, 5 }, {
        snap_back = true,
        hide_single_page = true,
        collapse_single_page = true,
    })

    G.SETTINGS.paused = true,
    G.FUNCS.overlay_menu { definition = overlay }
    for _, v in pairs(G.P_CENTER_POOLS.unfinished) do v.no_collection = true end
end


return retr
