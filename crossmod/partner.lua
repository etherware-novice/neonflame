Partner_API.Partner {
    key = "snugglepenguin",
    name = "Snugglebug",
    unlocked = true,
    discovered = true,
    individual_quips = true,

    atlas = "partner",
    pos = { x = 0, y = 0 },
    soul_pos = nil,
    config = { extra = {chips = 0, chance = 3} },

    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local key = self.key
        if link_level and link_level > 0 then key = key .. "_" .. link_level end

		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_jpenguin")
        return { vars = { num, den, card.ability.extra.chips }, key = key }
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                message = localize{type = "variable", key = "a_chips", vars = {card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end

        if context.remove_playing_cards then
            local benefit = self:get_link_level() or 0
			if SMODS.pseudorandom_probability(card, "nflame_jpenguin", 1, card.ability.extra.chance) then
                benefit = benefit + 1
            end

            if benefit < 1 then return end
            for _, destroyed in pairs(context.removed) do
                local bonus = destroyed:get_chip_bonus() * (benefit / 2)
                print("adding " .. bonus)
                card.ability.extra.chips = card.ability.extra.chips + bonus
            end
            card.ability.extra.chips = math.floor(card.ability.extra.chips)

            return { message = localize("k_upgrade_ex") }
        end
    end
}
