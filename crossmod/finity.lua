-- setting it doesnt work for some reason so we're doing something ELSE
local smaps = {}
local quips = {}
local decks = {}

local retr = {}

table.insert(retr, {
    key = "jpenguin",
    name = "Jade Penguin",
    object_type = "Joker",

    atlas = "finity",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    pools = { modcom = true },

    config = { extra = { chance = 3, xm = 1 } },
    rarity = "finity_showdown",
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_jpenguin")
        return { vars = {num, den, card.ability.extra.xm} }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) 
                    and SMODS.pseudorandom_probability(card, "nflame_jpenguin", 1, card.ability.extra.chance) then

                    v.ability.nflame_youreated = true
                end
            end
        end

        if context.destroy_card and context.destroy_card.ability.nflame_youreated and not context.blueprint then
            local xmvalue = context.destroy_card:get_id()
            if SMODS.has_no_rank(context.destroy_card) then xmvalue = 5 end
            xmvalue = xmvalue / 10

            card.ability.extra.xm = card.ability.extra.xm + xmvalue

            local msgs = localize("k_upgrade_eat")
            return { sound = "nflame_jp_consume", message = pseudorandom_element(msgs), remove = true }
        end

        if context.joker_main or context.force_trigger then return { xmult = card.ability.extra.xm } end
    end
})

smaps.bl_nflame_jpenguin = {"j_nflame_jpenguin", "Jade Penguin"}
quips.bl_nflame_jpenguin = {"jpenguin", 4, 3}
decks.bl_nflame_jpenguin = {"nflame_finitydeck", { x = 0, y = 0 }}


FinisherBossBlindStringMap = FinisherBossBlindStringMap or {}
FinisherBossBlindQuips = FinisherBossBlindQuips or {}
FinisherBossBlinddecksprites = FinisherBossBlinddecksprites or {}

-- im desperate man
local mmref = Game.main_menu
function Game.main_menu(self, change_context)
    for k, v in pairs(smaps) do FinisherBossBlindStringMap[k] = v end
    for k, v in pairs(quips) do FinisherBossBlindQuips[k] = v end
    for k, v in pairs(decks) do FinisherBossBlinddecksprites[k] = v end
    return mmref(self, change_context)
end

return retr
