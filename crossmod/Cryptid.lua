SMODS.Joker {
    key = "opensource",
    name = "Open Source",

    atlas = "jokers1",
    pos = { x = 1, y = 1 },

    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_cry_commit
	info_queue[#info_queue + 1] = G.P_CENTERS.c_cry_rework
	info_queue[#info_queue + 1] = G.P_CENTERS.c_cry_delete
    end,

    calculate = function(self, card, context)
        local trigger = context.force_trigger

	if context.individual and context.cardarea == G.play then
	    if context.other_card.seal == "cry_green" then trigger = true end
	end

	if #G.consumeables.cards + G.GAME.consumeable_buffer >= G.consumeables.config.card_limit then return end
	if not trigger then return end

	print("we are triggering!")
	local outcomes = {"c_cry_commit", "c_cry_rework", "c_cry_delete"}
        local judgement = pseudorandom_element(outcomes, "nflame_opensource")

	G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
	G.E_MANAGER:add_event(Event({
	    func = function()
		card:juice_up(0.5, 0.5)
		SMODS.add_card{key = judgement}
		G.GAME.consumeable_buffer = 0
		return true
	    end,
	}))
    end,
}