-- Furnace: Scored Sand Cards give X2 and have a 1 in 4 chance to break 

SMODS.Joker {
    key = "furnace",
    name = "furnace",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    config = { extra = { xmult = 2, chance = 4 } },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_ortalab_sand
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_furnace")
        return { vars = {card.ability.extra.xmult, num, den} }
    end,

    calculate = function(self, card, context)
        if context.forcetrigger then return { xmult = card.ability.extra.xmult } end

        if context.individual and context.cardarea == G.hand
            and SMODS.has_enhancement(context.other_card, "m_ortalab_sand") then

            local shattered = false
            return { xmult = card.ability.extra.xmult }
        end

        if context.destroy_card and context.cardarea == G.hand and not context.blueprint 
            and SMODS.has_enhancement(context.destroy_card, "m_ortalab_sand") then
            
            if SMODS.pseudorandom_probability(card, "nflame_furnace", 1, card.ability.extra.chance) then
                return { remove = true }
            end
        end
    end
}
