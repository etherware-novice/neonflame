SMODS.Gradient {
    key = "silicon",
    colours = {
        HEX("1ad846"),
        G.C.UI.TEXT_INACTIVE
    }
}

local sii = SMODS.injectItems
function SMODS.injectItems(...)
    local g = sii(...)

    for _, card in pairs(G.P_CENTER_POOLS.silicon) do
        local variref = card.loc_vars
        card.loc_vars = function(self, info_queue, card)
            local g = variref(self, info_queue, card)

            local silicontotal = G.nflame_get_silicontotal()
            local lines = {}
            for _, t in pairs(localize{ type = "variable", key = "k_silicon_desc", vars = {silicontotal} }) do
                local textn = {
                    n = G.UIT.T,
                    config = { text = t, colour = G.C.WHITE, scale = 0.4 }
                }

                lines[#lines + 1] = {
                    n = G.UIT.R,
                    config = {align = "cm", padding = 0.01},
                    nodes = {textn}
                }
            end

            g.main_end = {{
                n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {{
                    n = G.UIT.C,
                    config = {minh = 0.4, align = "cm", padding = 0.07, colour = G.ARGS.LOC_COLOURS.nflame_silicon, r = 0.1, maxw = 3.8},
                    nodes = lines
                }}
            }}


            return g
        end

        if not card.silicon_worth then card.silicon_worth = 1 end
    end
end

local sman = SMODS.showman
function SMODS.showman(key)
    local pools = G.P_CENTERS[key].pools
    if pools and pools.silicon then return true end
    return sman(key)
end

function G.nflame_get_silicontotal(context)
    if not G.jokers then return 1 end
    if not context then context = {} end

    local count = 0
    for _, tcard in ipairs(G.jokers.cards) do
        context.silicon_tally = count
        local worth = tcard.config.center.silicon_worth or 0
        if type(worth) == "function" then worth = worth(worth, tcard, context) end
        count = count + worth
    end

    return count
end



local retr = {}

table.insert(retr, {
    key = "ntmed",
    name = "medibot",
    object_type = "Joker",

    atlas = "jokers1",
    pos = { x = 5, y = 3 },
    pools = { silicon = true, spess = true },

    config = { extra = { bonus = 2 } },
    rarity = 1,
    cost = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.bonus} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local upgradec = math.floor(G.nflame_get_silicontotal(context) * card.ability.extra.bonus)
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + upgradec
            return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
        end
    end,

    in_pool = function(self, args)
        return true
    end
})

table.insert(retr, {
    key = "odgamble",
    name = "Gamblobot",
    object_type = "Joker",

    atlas = "jokers1",
    pos = { x = 0, y = 4 },
    config = { extra = { chance = 6, dollars = 8 } },
    pools = { silicon = true },

    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_odgamble")
        return { vars = { num, den, card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        -- futureproofing when silicons arent just jokers
        local trigger = false
        if context.other_joker and context.other_joker.config.center.silicon_worth then trigger = true end
        if trigger and not SMODS.pseudorandom_probability(card, "nflame_odgamble", 1, card.ability.extra.chance) then
            trigger = false
        end

        if trigger or context.force_trigger then
            return { dollars = card.ability.extra.dollars, message_card = context.other_joker or card }
        end
    end
})

table.insert(retr, {
    key = "spbump",
    name = "Bumpscosity-Bot",
    object_type = "Joker",

    atlas = "jokers1",
    pos = { x = 1, y = 4 },
    pools = { silicon = true },

    config = { extra = { bonus = 10 } },
    rarity = 1,
    cost = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.bonus} }
    end,

    calculate = function(self, card, context)
        if context.joker_main or context.force_trigger then
            local bumpmsg = localize{ type = "variable", key = "k_bump", vars = {card.ability.extra.bonus} }
            return { message = bumpmsg }
        end
    end
})

table.insert(retr, {
    key = "ntfloor",
    name = "Floorbot",
    object_type = "Joker",

    atlas = "jokers1",
    pos = { x = 2, y = 4 },
    pools = { silicon = true },

    config = { extra = { mult = 2 } },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult} }
    end,

    calculate = function(self, card, context)
        if context.force_trigger then
            local cmult = card.ability.extra.mult * G.nflame_get_silicontotal(context)
            return { mult = cmult }
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            -- checking the vanilla 5 card hands
            if not (
                next(context.poker_hands['Flush']) or
                next(context.poker_hands['Straight']) or
                next(context.poker_hands['Five of a Kind'])
                )
            then
                return
            end

            local maxhand = SMODS.four_fingers('flush') or 5
            if #context.scoring_hand < maxhand then return end

            if context.other_card.debuff then return { message = localize("k_debuffed"), colour = G.C.RED } end

            local cmult = card.ability.extra.mult * G.nflame_get_silicontotal(context)
            return { mult = cmult }
        end
    end
})

return retr
