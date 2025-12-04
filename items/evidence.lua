SMODS.ConsumableType {
    key = "evidence",
    primary_colour = HEX("a58547"),
    secondary_colour = HEX("eeba6e"),
    loc_txt = {},

    shop_rate = 1.0,
    select_card = 'consumeables',
    can_stack = false,
    can_divide = false
}

SMODS.Consumable {
    key = "badge",
    set = "evidence",

    atlas = "evidence",
    pos = { x = 0, y = 0 },

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

    can_use = function(self, card)
        if G.GAME.current_round.attorneysluck then return false end
        if G.GAME.current_round.hands_left > 1 then return false end

        for k, v in ipairs(G.consumeables.cards) do
            if v.ability.set == "evidence" and v ~= card then return true end
        end

        return false
    end,

    use = function(self, card, area)
        G.GAME.current_round.attorneysluck = true
    end
}

SMODS.Consumable {
    key = "passport",
    set = "evidence",

    atlas = "placeholders",
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

    atlas = "placeholders",
    pos = { x = 1, y = 0 },
    config = { extra = { destroyed = 0, required = 4 } },

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
