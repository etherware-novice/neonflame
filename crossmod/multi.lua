
local mods = {
    "Bunco",
    "SMSN", -- berries and honey
    "ortalab",
    "GSPhanta",
    "flynnsanity",
    "entr", -- entropy
    "Cryptid",
    "nflame",
    "starspace"
}

for _, v in ipairs(mods) do if not next(SMODS.find_mod(v)) then return end end

-- dear god this is stupid


SMODS.Joker {
    key = "ultshowdown",
    name = "Ultimate Showdown of Ultimate Destiny",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    -- the challenge is getting all these mods
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_entr_ceramic
        info_queue[#info_queue + 1] = G.P_CENTERS.m_nflame_rules
        info_queue[#info_queue + 1] = G.P_CENTERS.tag_ortalab_hand
        info_queue[#info_queue + 1] = G.P_CENTERS.tag_flynnset_flynnsane_tag
        info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bunc_glitter
        info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
    end,

    calculate = function(self, card, context)
        local trigger = context.force_trigger

        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_entr_ceramic") then trigger = true end
            if SMODS.has_enhancement(context.other_card, "m_nflame_rules") then trigger = true end
        end

        if not trigger then return end

        add_tag(Tag("tag_ortalab_hand", false, "Small"))
        add_tag(Tag("tag_flynnset_flynnsane_tag", false, "Small"))

        for _, playing_card in ipairs(G.hand.cards) do
	        G.E_MANAGER:add_event(Event({
                func = function()
                    playing_card:set_edition("e_bunc_glitter")
                    playing_card:set_ability("m_phanta_ghostcard")
                    -- once b&h is more finished ill add the 100% seal
                    return true
                end
            }))
        end

        for _, joker in ipairs(G.jokers.cards) do
            --if G.jokers.cards:is_jolly() then -- why is this nil wtf
            if false then
                -- add astros card type here
                print("oops")
            end
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                    local key = localize({ type = "name_text", key = v.key, set = "Joker" }) or "nil"
                    if string.find(string.lower(key), "sappy") or string.find(v.key, "sappy")  then
                        SMODS.add_card { key = v.key, edition = "e_negative" }
                    end
                end

                return true
            end
        }))

    end
}
