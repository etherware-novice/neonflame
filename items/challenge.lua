SMODS.Challenge {
    key = "bugkey",
    unlocked = true,

    jokers = {
        {id = "j_nflame_hitch_brokenprob", eternal = true, edition = "negative"},
        {id = "j_ring_master", eternal = true, edition = "negative"},
        {id = "j_nflame_lavalamp", eternal = true},
    }
}

SMODS.Challenge {
    key = "robofund",
    unlocked = true,
    
    rules = {
        custom = {
            { id = "no_reward" },
            { id = "no_extra_hand_money" },
            { id = "no_interest" }
        }
    },

    jokers = {
        { id = "j_nflame_odgamble", eternal = true, edition = "negative" },
        { id = "j_nflame_spbump" },
        { id = "j_nflame_spbump" },
    }
}
