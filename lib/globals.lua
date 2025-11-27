G.nflame_pick_idol_style = function()
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end

    return pseudorandom_element(valid_cards, "nflame_idol")
end


local ginit = Game.init_game_object
function Game:init_game_object()
    local g = ginit(self)

    g.nflame_offshore_jokers = {}

    return g
end

SMODS.current_mod.calculate = function(self, context)
    if context.end_of_round and context.game_over and context.main_eval and G.GAME.current_round.attorneysluck then
        return { saved = "ph_attorneys" }
    end

    if context.setting_blind then G.GAME.current_round.attorneysluck = false end
end

test = "item"
