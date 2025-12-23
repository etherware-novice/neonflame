SMODS.ConsumableType {
    key = "evidence",
    primary_colour = HEX("a58547"),
    secondary_colour = HEX("eeba6e"),
    loc_txt = {},

    shop_rate = 1.0,
    select_card = 'consumeables',
    default = "c_nflame_badge",
    can_stack = false,
    can_divide = false
}

SMODS.Booster {
    key = "evidence_normal_1",
    kind = "evidence",
    group_key = "k_nflame_evidence_pack",

    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3)
        }
    end,

    create_card = function(self, card)
        return { set = "evidence", skip_materialize = true }
    end
}

SMODS.Consumable {
    key = "badge",
    set = "evidence",

    atlas = "evidence",
    pos = { x = 0, y = 0 },
    config = { extra = {active = false} },

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                return true
            end
        }))
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and card.ability.extra.active then
            SMODS.destroy_cards(card, true)
            return { saved = "ph_attorneys" }
        end

        if context.setting_blind then card.ability.extra.active = false end

    end,

    can_use = function(self, card)
        if card.ability.extra.active then return false end
        if G.GAME.current_round.attorneysluck then return false end
        if G.GAME.current_round.hands_left > 1 then return false end

        for k, v in ipairs(G.consumeables.cards) do
            if v.ability.set == "evidence" and v ~= card then return true end
        end

        return false
    end,

    use = function(self, card, area)
        local targets = {}
        for k, v in ipairs(G.consumeables.cards) do
            if v.ability.set == "evidence" and v ~= card then 
                targets[#targets + 1] = v
            end
        end

        local sac = pseudorandom_element(targets, "nflame_badge")
        if sac then
            SMODS.destroy_cards(sac, nil, nil, true)
        end

        card.ability.extra.active = true
        local eval = function(card) return card.ability.extra.active and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
    end,

    keep_on_use = function(self, card) return true end
}

SMODS.Consumable {
    key = "passport",
    set = "evidence",

    atlas = "evidence",
    pos = { x = 1, y = 0 },

    can_use = function(self, card)
        if not G.hand.cards[1] then return false end
        if G.GAME.hands.Straight.played_this_round < 1 then return false end
        return true
    end,

    use = function(self, card, area)
        for k, v in ipairs(G.hand.cards) do
            if SMODS.has_no_rank(v) then
                SMODS.destroy_cards(v)
            end
        end
    end
}

SMODS.Consumable {
    key = "thinker",
    set = "evidence",

    atlas = "evidence",
    pos = { x = 2, y = 0 },
    config = { extra = { destroyed = 0, required = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.required, card.ability.extra.destroyed} }
    end,

    can_use = function(self, card)
        if card.ability.extra.destroyed < card.ability.extra.required then return false end
        if not G.GAME.blind.boss then return false end
        return true
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards then
            card.ability.extra.destroyed = card.ability.extra.destroyed + #context.removed

            if self:can_use(card) then return { message = localize("k_active_ex") } end
        end

        if context.end_of_round and context.beat_boss then card.ability.extra.destroyed = 0 end
    end,

    use = function(self, card, area)
        local proc = math.floor(card.ability.extra.destroyed / card.ability.extra.required)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, proc do
                    SMODS.add_card { key = "c_fool", edition = "e_negative" }
                end
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "wpowers",
    set = "evidence",

    atlas = "placeholders",
    pos = { x = 1, y = 0 },
    config = { extra = { trigger = 0, required = 4 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel

        local active = "inactive"
        local col = G.C.UI.TEXT_INACTIVE

        if card.ability.extra.trigger >= card.ability.extra.required then
            active = "active"
            col = G.C.RED
        end

        return { vars = {card.ability.extra.required, active, colours = { col }} }
    end,

    calculate = function(self, card, context)
        if context.before then card.ability.extra.trigger = 0 end

        if context.individual and context.cardarea == G.hand
            and SMODS.has_enhancement(context.other_card, "m_steel") then

            card.ability.extra.trigger = (card.ability.extra.trigger or 0) + 1
        end
    end,

    can_use = function(self, card)
        if card.ability.extra.trigger < card.ability.extra.required then return false end
        return true
    end,

    use = function(self, card, area)
        for _, playing_card in ipairs(G.hand.cards) do
            G.E_MANAGER:add_event(Event({
                after = 0.2,
                func = function()
                    playing_card:set_ability("m_steel")
                    playing_card:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
    end,
}

SMODS.Consumable {
    key = "parrot",
    set = "evidence",

    atlas = "placeholders",
    pos = { x = 1, y = 0 },
    config = { extra = { rankscore = {}, required = 5 } },

    loc_vars = function(self, info_queue, card)
        local completed = card.ability.extra.rankscore[card.ability.extra.lastscore] or 0
        local cl = G.C.UI.TEXT_INACTIVE
        if completed >= card.ability.extra.required then cl = G.C.FILTER end

        local rank = "none"
        if card.ability.extra.lastscore then rank = localize(card.ability.extra.lastscore, "ranks") end

        return { vars = {
            rank, card.ability.extra.required, completed, colours = { cl }
        }}
    end,

    calculate = function(self, card, context)
        if context.end_of_round then
            card.ability.extra.rankscore = {}
            card.ability.extra.lastscore = nil
            card.ability.extra.active = false
        end

        if card.ability.extra.active then
            -- if context.modify_scoring_hand then return { add_to_hand = true } end

            if context.before then

            end

            return
        end

        if context.individual and context.cardarea == G.play then
            if SMODS.has_no_rank(context.other_card) then return end
            local rank = context.other_card.base.value
            card.ability.extra.lastscore = rank
            card.ability.extra.rankscore[rank] = (card.ability.extra.rankscore[rank] or 0) + 1
        end

    end,

    can_use = function(self, card)
        if not G.hand then return false end
        if #G.hand.highlighted < 1 then return false end
        if not card.ability.extra.lastscore then return false end
        local count = card.ability.extra.rankscore[card.ability.extra.lastscore]
        if not count then return false end
        return count >= card.ability.extra.required
    end,

    use = function(self, card, area)
        for _, scored_card in ipairs(G.hand.highlighted) do
            SMODS.change_base(scored_card, nil, card.ability.extra.lastscore)
            G.E_MANAGER:add_event(Event({
                func = function()
                    scored_card:juice_up()
                    return true
                end
            }))
        end
    end,
}
