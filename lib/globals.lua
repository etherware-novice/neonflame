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
