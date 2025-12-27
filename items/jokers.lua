SMODS.Joker {
    key = "jokerhelp",
    name = "Helping Hand",

    atlas = "jokers1",
    pos = { x = 0, y = 0 },

    config = { extra = { bonus = 1 } },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.bonus} }
    end,

    calculate = function(self, card, context)
        if context.blueprint then return end
	
        if context.setting_blind or context.forcetrigger
	or (context.card_added and context.card == card)
	then
	    bonus_hand = 0
	    for _, tcard in ipairs(G.jokers.cards) do
               if tcard:is_rarity(1) then
	        G.E_MANAGER:add_event(Event({
		    trigger = "after",
		    delay = 0.3,
		    func = function()
		        tcard:juice_up(0.8, 0.5)
			return true
		    end,
		}))

		bonus_hand = bonus_hand + card.ability.extra.bonus
                end
	    end

	    G.E_MANAGER:add_event(Event({
	        func = function()
		    ease_hands_played(bonus_hand)
		    card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
		        messsage = localize({ type = "variable", key = "a_hands", vars = {bonus_hand} })
		    })

		    return true
		end
	    }))
	end
    end,
}

SMODS.Joker {
    name = "Hoarder",
    key = "hoarder",

    atlas = "jokers1",
    pos = { x = 1, y = 0 },

    rarity = 3,
    cost = 5,
    blueprint_compat = true,
    config = { extra = { mult = 0.5 }, immutable = { lv = 1 } },
    loc_vars = function(self, info_queue, center)
        return {vars = { center.ability.extra.mult, center.ability.extra.mult * center.ability.immutable.lv }}
    end,

    update_numbers = function(self, card)
        local value = 0
	if G.STEAM and G.STEAM.user then
	    value = G.STEAM.user.getPlayerSteamLevel()
	end

	card.ability.immutable.lv = 1 + value
    end,

    set_ability = function(self, card, initial, delay_sprites)
        self:update_numbers(card)
    end,

    load = function(self, card, card_table, other_card)
        self:update_numbers(card)
    end,

    calculate = function(self, card, context)
	
        if context.joker_main or context.forcetrigger
	then
	    local cmult = card.ability.extra.mult * card.ability.immutable.lv
	    
	    return {
	        message = localize({ type = "variable", key = "a_xmult", vars = { cmult } }),
		Xmult_mod = cmult,
		colour = G.C.MULT,
	    }
	end
    end,
}


SMODS.Joker {
    key = "nflame",
    name = "Neonflame",

    atlas = "jokers1",
    pos = { x = 2, y = 0 },

    -- hardcoding the timestamp will definitely not bite me in the butt later
    config = {extra = { Xmult = 1, decay = 0.1 }, immutable = { cards = 0, timestamp = 1766691189 }},
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult, card.ability.extra.decay, self:calc_xmult(card) } }
    end,

    update_numbers = function(self, card)
    	local scale = 0
        for _, jok in pairs(G.P_CENTER_POOLS.Joker) do
	    if jok.original_mod and jok.original_mod.id == "nflame" then
	        scale = scale + 1
	    end
	end

	card.ability.immutable.cards = scale
    end,

    calc_xmult = function(self, card)
    	local xm = card.ability.extra.Xmult * card.ability.immutable.cards
	local decaytime = (os.time() - card.ability.immutable.timestamp) / 86400
	xm = xm - (card.ability.extra.decay * decaytime)

	return math.max(xm, 1.5)
    end,

    set_ability = function(self, card, initial, delay_sprites)
    	self:update_numbers(card)
    end,

    load = function(self, card, card_table, other_card)
    	self:update_numbers(card)
    end,

    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger
	then
	    local xm = self:calc_xmult(card)
	    return {
	        message = localize({ type = "variable", key = "a_xmult", vars = { xm } }),
		Xmult_mod = xm,
		colour = G.C.MULT,
	    }
	end
    end,
}

SMODS.Joker {
    key = "forecast",
    name = "Forecast",

    atlas = "jokers1",
    pos = { x = 3, y = 0 },

    config = { extra = { cards = 8 } },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.cards} }
    end,

    calculate = function(self, card, context)
    	if context.ending_booster then
 	    card.stopinf = false
	end

        if context.other_drawn or context.force_trigger then
	    if card.stopinf then return end
	    G.E_MANAGER:add_event(Event({
		func = function()
		    card:juice_up(0.8, 0.5)
		    SMODS.draw_cards(card.ability.extra.cards)

		    return true
		end,
	    }))

	    card.stopinf = true
	end
    end,
}
 
SMODS.Joker {
    key = "numberup",
    name = "Number Go Up",

    atlas = "jokers1",
    pos = { x = 4, y = 0 },

    config = { extra = { increase = 1.5, requirement = 3 } },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increase, card.ability.extra.requirement} }
    end,

    calculate = function(self, card, context)
        local xm_trigger = context.forcetrigger
	
        if context.other_joker and context.other_joker.ability.set == "Joker" then
	    G.E_MANAGER:add_event(Event({
	        func = function()
		    context.other_joker:juice_up(0.5, 0.5)
		    return true
		end
	    }))
	    xm_trigger = true
	end

	if xm_trigger then
	    local multv = card.ability.extra.increase
	    return {
	        message = localize({ type = "variable", key = "a_xmult", vars = { multv }}),
		colour = G.C.MULT,
		Xmult_mod = multv,
	    }
	end

	if context.final_scoring_step then
	    if SMODS.calculate_round_score() > (G.GAME.blind.chips * card.ability.extra.requirement) then
	        return {
		    dollars = math.floor(G.GAME.dollars * -1),
		    color = G.C.MONEY
		}
	    end
	end
    end,
}


SMODS.Joker {
    key = "tjhenry",
    name = "TJ HENRY Yoshi",

    atlas = "layerjoker",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0},

    config = { extra = { size = 3, xmgain = 0.1 } },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.size, card.ability.extra.xmgain} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
	    if #context.full_hand > card.ability.extra.size and not context.force_trigger then return end

	    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmgain
            context.other_card.ability.nflame_tjdraw = true
	    
	    return {
	        extra = {
		    message = localize('k_upgrade_ex'),
		    colour = G.C.MULT
		},
	    }

	end

        if context.first_hand_drawn then
            for _, c in pairs(G.deck.cards) do
                if c.ability.nflame_tjdraw then
		    draw_card(G.deck, G.hand, nil, "up", true, c)
		    c.ability.nflame_tjdraw = false
		end
            end

	    card:juice_up(0.5, 0.5)
	end
    end,
}

SMODS.Joker {
    key = "stanleybucket",
    name = "Reassurance Bucket",

    atlas = "jokers1",
    pos = { x = 5, y = 0 },

    -- its a stanley parable item of course we reference "8"
    config = { extra = { score = 8 } },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    demicolon_compat = false,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.score} }
    end,

    calculate = function(self, card, context)


        if context.press_play then

	    G.E_MANAGER:add_event(Event({
	        func = function()
		    card:juice_up(0.5, 0.5)
		    return true
		end,
	    }))


	    G.E_MANAGER:add_event(Event({
	        trigger = 'ease',
		ref_table = G.GAME,
		ref_value = "chips",
		ease_to = G.GAME.chips + card.ability.extra.score,
		delay = 1,
		func = (function(t) return math.floor(t) end)
	    }))

	    return {
	           message = "...",
		   message_card = card,
		   -- func = (function() G.GAME.chips = to_big(G.GAME.chips + card.ability.extra.score) end),
            }
	end


	if context.pre_discard and not context.hook then
	    G.E_MANAGER:add_event(Event({
	        func = function()
		    card:juice_up(0.5, 0.5)
		    return true
		end,
	    }))

  	    card.ability.extra.score = card.ability.extra.score + G.GAME.chips

	    G.E_MANAGER:add_event(Event({
	        trigger = 'ease',
		ref_table = G.GAME,
		ref_value = "chips",
		ease_to = 0,
		delay = 1,
		func = (function(t) return math.floor(t) end)
	    }))

	    return {
	           message = "...",
		   message_card = card,
		   -- func = (function() G.GAME.chips = to_big(G.GAME.chips + card.ability.extra.score) end),
            }
	end
    end,
}

SMODS.Joker {
    key = "acpart",
    name = "Agamemnon Counterpart",

    atlas = "jokers1",
    pos = { x = 0, y = 1 },

    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    calculate = function(self, card, context)
        local trigger = context.force_trigger

	if context.before then
	    for _, playing_card in ipairs(G.play.cards) do
	    	print(playing_card:get_id())
	        if playing_card:get_id() == 14 then
		    trigger = true
		    print("trigger enable")
		end
	    end
	end

	if not trigger then return end

	-- looking for non aces in hand
	local ace_hand = {}
	for _, playing_card in ipairs(G.hand.cards) do
	    if playing_card:get_id() ~= 14 then ace_hand[#ace_hand + 1] = playing_card end
	    print(playing_card:get_id())
	end

	if #ace_hand < 1 then return end

	local c = pseudorandom_element(ace_hand, "nflame_acpart")
        G.E_MANAGER:add_event(Event({
	    func = function()
	        assert(SMODS.change_base(c, nil, 'Ace'))
	        c:juice_up(0.8, 0.5)
		card:juice_up(0.5, 0.5)
		return true
	    end,
	}))
    end
}

SMODS.Joker {
   key = "potatorevenge",
   name = "Cold Potato",

   atlas = "jokers1",
   pos = { x = 2, y = 1 },

   rarity = 1,
   price = 4,
   blueprint_compat = true,
   demicolon_compat = true,
   perishable_compat = true,
   eternal_compat = true,

   config = { extra = { enigmatic = 1, fires = {}, newcounter = 0 } },

   blowingsmoke = {
      "acceptable", "excellent", "exceptional", "favorable", "great",
      "marvelous", "positive", "satisfactory", "satisfying", "superb",
      "valuable", "wonderful", "ace", "capital", "pleasing", "prime",
      "quality", "rad", "sterling", "superior", "superior", "superior", "superior",
      "worthy", "admirable", "agreeable", "commendable", "cogneial",
      "deluxe", "first-class", "first-rate", "gnarly", "honorable",
      "jake", "neat", "precious", "reputable", "select", "shipshape",
      "splendid", "stupendous", "super-excellent", "tiptop", "upright",
      "ethical", "blameless", "incorrupt", "capable", "clever", "proper",
      "appropriate", "beneficial", "decent", "desirable", "fruitful",
      "healthy", "helpful", "proper", "satisfying", "suitable", "right",
      "ample", "apt", "favoring", "opprotune", "flawless", "normal",
      "perfect", "safe", "solid", "stable", "eatable", "fresh", "loyal",
      "unhurt", "considerate", "humane", "true", "valid", "reliable",
      "legitimate", "dependable", "genuine", "trustworthy", "well-founded",
      "dutiful", "profitable", "respectable", "worthwhile", "great", "full",
      "extensive", "immesurable", "lucrative", "sizeable", "substantial",
      "godsend", "favor", "profitable", 
   },

   loc_vars = function(self, info_queue, card)
      return { vars = {
		  pseudorandom_element(self.blowingsmoke, "nflame_potato"),
		  card.ability.extra.enigmatic
      } }
   end,

   set_ability = function(self, card, inital, delay_sprites)
      self:add_ability(card)
   end,

   add_ability = function(self, card)
      local newability = {}

      local outcomes = {
	 nonblind = { "scale", "xscale", "create" },
	 blind = { "scale", "xscale", "create", "score" },
	 score = { "scale", "xscale", "create", "mult", "chips", "xmult", "xchips" }
      }

      local requirements = {
	 cardtype = { "Joker", "Consumeables", "Tarot", "Spectral", "Planet", "dollars", "Default" },
	 cardsuit = { "Hearts", "Clubs", "Spades", "Diamonds", "Stone" }, -- stone is any non rank
	 cardrank = { 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }, -- 0 is no rank
	 cardany = { "Stone", "Hearts", "Clubs", "Spades", "Diamonds", 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 },
	 blind = { "Small", "Big", "Boss" },
	 rarity = { 1, 2, 3, 4, 5 } -- 5 is modded
      }
      
      local possibility = {
	 open_booster = { out = outcomes.nonblind },
	 buying_card = { out = outcomes.nonblind, req = "cardtype" },
	 selling_card = { out = outcomes.blind, req = "cardtype" },
	 reroll_shop = { out = outcomes.nonblind },
	 skip_blind = { out = outcomes.nonblind },
	 skipping_booster = { out = outcomes.nonblind },
	 playing_card_added = { out = outcomes.nonblind, req = "cardany" },
	 first_hand_drawn = { out = outcomes.blind, req = "cardany", },
	 setting_blind = { out = outcomes.blind, req = "bind" },
	 remove_playing_cards = { out = outcomes.nonblind, req = "cardany" },
	 using_consumeable = { out = outcomes.nonblind }, -- once per round :(
	 debuffed_hand = { out = outcomes.score },
	 pre_discard = { out = outcomes.blind },
	 discard = { out = outcomes.blind, req = "cardany" },
	 end_of_round = { out = outcomes.blind, req = "cardany" },
	 individual = { out = outcomes.score, req = "cardany" },
	 other_joker = { out = outcomes.score, req = "rarity" },
	 before = { out = outcomes.nonblind },
	 after = { out = outcomes.nonblind },
	 joker_main = { out = outcomes.score }
      }

      local desc, ctx = pseudorandom_element(possibility, "nflame_potato")
      newability.context = ctx

      if desc.req and requirements[desc.req] and (pseudorandom("nflame_potato") < 0.5) then
	 newability.requiretype = desc.req
	 newability.requires = pseudorandom_element(requirements[desc.req], "nflame_potato")
      end

      newability.outcome = pseudorandom_element(desc.out, "nflame_potato")
      if newability.outcome == "create" then
	 newability.outcome = pseudorandom_element(requirements.cardtype, "nflame_potato")
      end
      if newability.outcome == "Joker" and (pseudorandom("nflame_potato") < 0.5) then
	 -- this isnt implemented yet, but someday?
	 newability.rarity = pseudorandom_element(requirements.rarity, "nflame_potato")
      end

      -- rng 0 - 30
      newability.scalar = (pseudorandom("nflame_potato") * 30)

      card.ability.extra.fires[#card.ability.extra.fires + 1] = newability
   end,

   check_requirements = function(self, context, ability)
      if not ability.requiretype then return true end

      local rtype = ability.requiretype

      if rtype == "cardtype" then
	 if not context.other_card then return false end
	 
	 if context.other_card.set == ability.requires then return true end
	 if (context.other_card.set == "Default") and (ability.requires == "Enhanced") then return true end
	 if (context.other_card.set == "Enhanced") and (ability.requires == "Default") then return true end
	 if context.other_card.ability.consumeable and (ability.requires == "consumeable") then return true end
      end

      if rtype == "cardany" then
	 if type(ability.requires) == "string" then rtype = "cardsuit" end
	 else rtype = "cardrank"
      end
      
      if rtype == "cardsuit" then
	 if not context.other_card then return false end
	 
	 if context.other_card.is_suit and context.other_card:is_suit(ability.requires) then return true end
	 if ability.requires == "Stone" and SMODS.has_no_suit(context.other_card) then return true end
      end
      
      if rtype == "cardrank" then
	 if not context.other_card then return false end
	 
	 if context.other_card.get_id and (context.other_card:get_id() == ability.requires) then return true end
	 if (ability.requires == 0) and (SMODS.has_no_rank(context.other_card)) then return true end
      end

      if rtype == "rarity" then
	 if not context.other_card then return false end

	 if context.other_card:is_rarity(ability.requires) then return true end
	 if type(context.other_card.rarity) == "string" and ability.requires == 5 then return true end
      end
	 
   end,

   calculate = function(self, card, context)
      local fire = false
      for _, ability in pairs(card.ability.extra.fires) do
	 if context[ability.context] and self:check_requirements(self, context, ability)
	 and not (ability.context == "individual" and context.area ~= G.Jokers)
	 then
	    fire = ability
	 end
      end

      if not fire then return end

      card.ability.extra.newcounter = card.ability.extra.newcounter + 1
      if card.ability.extra.newcounter > 3 then
	 self:add_ability(card) -- no indication to the player, minor trolling :3
	 card.ability.extra.newcounter = 0
      end
      
      if fire.outcome == "scale" then
	 card.ability.extra.enigmatic = card.ability.extra.enigmatic + (fire.scalar - 5)
	 return {
	    message = localize('k_upgrade_ex'),
	    message_card = card
	 }
      end

      if fire.outcome == "xscale" then
	 card.ability.extra.enigmatic = card.ability.extra.enigmatic + (fire.scalar / 10)
	 return {
	    message = localize('k_upgrade_ex'),
	    message_card = card
	 }
      end

      if fire.outcome == "score" then
	 G.GAME.blind.chips = G.GAME.blind.chips + (fire.scalar * 3000)
	 return {
	    message = localize('k_upgrade_ex'),
	    message_card = card
	 }
      end

      if fire.outcome == "mult" or fire.outcome == "chips"
	 or fire.outcome == "xmult" or fire.outcome == "xchips"
         or fire.outcome == "dollars" then

	 local ff = {}
	 ff[fire.outcome] = fire.scalar
	 return ff
      end

      if fire.outcome == "Default" then fire.outcome = "Enhanced" end
      -- we've gotten all the other ones out first so we can do this one with minimal checking :)
      SMODS.add_card { set = fire.outcome }
   end
}

SMODS.Joker {
   key = "bakerfool",
   name = "Bakers Dozen",

   atlas = "jokers1",
   pos = { x = 4, y = 1 },

   rarity = 2,
   price = 5,
   blueprint_compat = true,
   demicolon_compat = true,
   perishable_compat = true,
   eternal_compat = true,

   calculate = function(self, card, context)
      if context.open_booster then

         G.E_MANAGER:add_event(Event({
            func = function()
               -- wait for the cards to generate before we do anything
               if not G.pack_cards.cards[1] then return false end

               local set = G.pack_cards.cards[1].ability.set
               local ckey = nil

               -- we are NOT creating new playing cards
               if set == "Default" or set == "Enhanced" then return true end

               if SMODS.ObjectTypes[set] and SMODS.ObjectTypes[set].default and G.P_CENTERS[SMODS.ObjectTypes[set].default] then
                  ckey = SMODS.ObjectTypes[set].default
                  
               -- unfortunately we need to hardcode these becaues the game does
               -- also idk if any pack gives tags but might as well put it ere
               elseif set == "Tarot"    then ckey = "c_strength"
               elseif set == "Joker"    then ckey = "j_joker"
               elseif set == "Planet"   then ckey = "c_pluto"
               elseif set == "Spectral" then ckey = "c_incantation"
               elseif set == "Tag"      then ckey = "tag_handy"
               end

               if not ckey then
                  sendWarnMessage("No default for set " .. set .. " found, defaulting to Tarot", "Neonflame - Bakers Dozen")
                  ckey = "c_fool"
               end

               SMODS.add_card { key = ckey }
               card:juice_up(0.5, 0.5)
               return true
            end
         }))
      end
   end
}

SMODS.Joker {
   key = "sappy",
   name = "Sappy",

   atlas = "layerjoker",
   pos = { x = 2, y = 0 },
   soul_pos = { x = 3, y = 0 },

   config = { extra = { xmhandgain = 0.25 } },
   rarity = 4,
   price = 20,
   blueprint_compat = true,
   demicolon_compat = true,
   perishable_compat = true,
   eternal_compat = true,

   loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmhandgain } }
   end,

   calculate = function(self, card, context)
      if context.pre_discard then
         local carddraw = 0
         for i, c in ipairs(context.full_hand) do
            G.E_MANAGER:add_event(Event({
                func = function()
                   c:juice_up(0.5, 0.5)
                   card:juice_up(0.5, 0.5)

                   return true
                end
            }))

            c.ability.perma_h_x_mult = (c.ability.perma_h_x_mult or 1) + card.ability.extra.xmhandgain

         card.ability.extra.bonusdraw = #context.full_hand
         card.ability.extra.discard_progress = 0
         end

         return {
            extra = {
               card = card,
               message = localize("k_upgrade_ex"),
               colour = G.C.MULT
            },
         }
      end

      if context.discard then
          card.ability.extra.discard_progress = card.ability.extra.discard_progress + 1
          local progress = card.ability.extra.discard_progress*100/#context.full_hand

          G.E_MANAGER:add_event(Event({
              blocking = false,
              func = function()
                  if G.STATE ~= G.STATES.SELECTING_HAND then return false end
                  
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          draw_card(G.discard, G.deck, progress, 'down', nil, context.other_card, 0.07)
                          -- god this is jank :(
                          -- but i REALLY dont want to patch emplace
                          -- table.insert(G.deck.cards, G.deck.cards[1])
                          -- table.remove(G.deck.cards, 1)

                          -- guess we're shuffling 5 times idec anymore
                          G.deck:shuffle("nflame_sappy")

                          return true
                      end
                  }))

                  return true
              end
          }))
      end

      if context.drawing_cards then
          local bdraw = card.ability.extra.bonusdraw or 0
          -- if context.amount < 1 then bdraw = math.floor(bdraw * 1.5) end  -- bonuses for if your hand is full
          return { cards_to_draw = context.amount + bdraw }
      end
   end
}

SMODS.Joker {
    key = "refund",
    name = "Refund Policy",

    atlas = "jokers1",
    pos = { x = 5, y = 1 },

    config = { extra = { chance = 2 } },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_refund")
        return { vars = { num, den } }
	end,

    calculate = function(self, card, context)
		if context.selling_card and context.card and context.card.ability.consumeable 
		and not context.card.ability.nflame_refundjeapordy then
			if SMODS.pseudorandom_probability(card, "nflame_refund", 1, card.ability.extra.chance) then
				local ncard = SMODS.add_card { set = context.card.ability.set }
				ncard.ability.nflame_refundjeapordy = true
			end
		end
	end
}

SMODS.Joker {
    key = "rapdog",
    name = "Parappa",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    config = { extra = { xmgain = 0.02, xm = 1 }, immutable = { rank = "Ace", retrigger = 10 } },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,

	loc_vars = function(self, info_queue, card)
		local rank = localize(card.ability.immutable.rank, "ranks")
		return { vars = { card.ability.extra.xmgain, card.ability.immutable.retrigger, rank, card.ability.extra.xm } }
	end,

	calculate = function(self, card, context)
		if context.before then
			local lead = context.scoring_hand[1]
			if not lead then return end -- thanks cass
			if SMODS.has_no_rank(lead) then return end

			if lead.base.value == card.ability.immutable.rank then
				card.ability.extra.xm = card.ability.extra.xm + card.ability.extra.xmgain
				return { message = localize("k_upgrade_ex") }
			end
		end

		if context.individual and context.cardarea == G.play then
			card.ability.immutable.rank = context.other_card.base.value
		end

        if context.joker_main or context.forcetrigger then
			if card.ability.extra.xm <= 1 then return end

			local accum = 1
			for i = 1, card.ability.immutable.retrigger do
				SMODS.calculate_effect({
					remove_default_message = true,
					xmult = card.ability.extra.xm,
					sound = "nflame_rapdog_oops",
					message = "oops"
				}, card)
				accum = accum * card.ability.extra.xm
			end

			accum = math.floor(accum * 100) / 100
			return { message = accum .. " combo!", color = G.C.MULT, sound = "nflame_rapdog_oops_end" }
		end
	end
}

SMODS.Joker {
    key = "stasis",
    name = "Stasis",

    atlas = "jokers1",
    pos = { x = 0, y = 2 },

    config = { extra = { mult = 0 } },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            card.ability.extra.mult = mult
            return { message = localize('k_upgrade_ex') }
        end

        if context.joker_main or context.forcetrigger then
            return { mult = card.ability.extra.mult }
        end

        if context.end_of_round then
            card.ability.extra.mult = 0
        end

    end
}

SMODS.Joker {
    key = "localfunc",
    name = "local function x() x() end; x()",

    atlas = "jokers1",
    pos = { x = 1, y = 2 },

    config = { extra = { mult = 1, multgain = 0.25 } },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,

    -- TODO make this use G.GAME.current_round
    loc_vars = function(self, info_queue, card)
        local rank = card.ability.extra.rank or "Ace"
        rank = localize(rank, "ranks")
        local suit = card.ability.extra.suit or "Spades"
        suit = localize(suit, "suits_plural")
        return { vars = {
            card.ability.extra.multgain, card.ability.extra.mult, rank, suit,
            colours = { G.C.SUITS[card.ability.extra.suit] }
        }}
    end,

	calculate = function(self, card, context)
		if context.before then
			local lead = context.scoring_hand[1]
			if not lead then return end -- thanks cass

            if lead:is_suit(card.ability.extra.suit) or
                lead.base.value == card.ability.extra.rank or
                context.forcetrigger then

                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multgain
                return { message = localize("k_upgrade_ex") }
            else
                card.ability.extra.mult = 1
                return { message = localize("k_reset") }
            end

        end

        if context.joker_main or context.forcetrigger then
            return { xmult = card.ability.extra.mult }
        end

        if context.after then
            local newcard = G.nflame_pick_idol_style()
            if newcard then
                card.ability.extra.rank = newcard.base.rank
                card.ability.extra.suit = newcard.base.value
            end
        end
    end
}

SMODS.Joker {
    key = "clovercoin",
    name = "Fake Coin",

    atlas = "jokers1",
    pos = { x = 2, y = 2 },

    config = { extra = { chance = 3, xmult = 3, thistrigger = 0, maxtrigger = 3 } },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_refund")
        
        local active = "inactive"
        local color = G.C.UI.TEXT_INACTIVE

        if card.ability.extra.active then
            active = "active"
            color = G.C.MULT
        end

        return { vars = {
            num, den, card.ability.extra.chance, card.ability.extra.maxtrigger, card.ability.extra.thistrigger,
            active,
            colours = { color }
        }}
    end,

    calculate = function(self, card, context)
        if context.after then
            if SMODS.pseudorandom_probability(card, "nflame_clovercoin", 1, card.ability.extra.chance) then
                card.ability.extra.thistrigger = card.ability.extra.thistrigger + 1
                if card.ability.extra.thistrigger >= card.ability.extra.maxtrigger then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return { message = localize("k_extinct_ex") }
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(1)
                        return true
                    end
                }))

                card.ability.extra.active = true

                -- maybe make it play the coin sound from clovpit here too?
                return { message = localize("k_active") }
            end
        end

        if (context.joker_main and card.ability.extra.active) or context.forcetrigger then
            card.ability.extra.active = false
            return { xmult = card.ability.extra.xmult }
        end

        if context.end_of_round then
            card.ability.extra.thistrigger = 0
        end
    end
}
 
SMODS.Joker {
    key = "slime_steel",
    name = "Steel Slime",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    config = { extra = { xmult = 1.5 } },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        local rs = G.GAME.current_round.nflame_slimesteel or { rank = "Ace" }
        return { vars = { localize(rs.rank, "ranks"), card.ability.extra.bonus } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and
            context.other_card:get_id() == G.GAME.current_round.nflame_slimesteel.id then

            if context.other_card.debuff then return { message = localize("k_debuffed"), color = G.C.RED }
            else return { xmult = card.ability.extra.xmult }
            end
        end

        if context.forcetrigger then
            return { xmult = card.ability.extra.xmult }
        end

        if context.end_of_round and context.main_eval and not context.blueprint then
        end
    end
}

local function reset_nflame_slimesteel()
    local newcard = G.nflame_pick_idol_style()
    if newcard then
        G.GAME.current_round.nflame_slimesteel = { id = newcard.base.id, rank = newcard.base.value }
    end
end

SMODS.Joker {
    key = "offshorebank",
    name = "Offshore Bank Account",

    atlas = "jokers1",
    pos = { x = 3, y = 2 },

    config = { extra = { offshore = {} } },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { #card.ability.extra.offshore or 0 } }
    end,

    calculate = function(self, card, context)
        if context.blueprint then return end

        if context.selling_card and context.card.ability.set == "Joker" then
            card.ability.extra.offshore[#card.ability.extra.offshore + 1] = context.card.config.center_key
            return
        end

        if not (context.end_of_round and context.main_eval and context.beat_boss)
            and not context.forcetrigger then return end

        local new_card, index = pseudorandom_element(card.ability.extra.offshore, "nflame_offshorebank")

        if new_card then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.8, 0.8)
                    SMODS.add_card { set = "Joker", key = new_card, edition = "e_negative" }
                    G.GAME.joker_buffer = 0

                    return true
                end
            }))

            -- table.remove(card.ability.extra.offshore, index)
            card.ability.extra.offshore = {}
            return
        end


   end
}

SMODS.Joker {
    key = "henchmen",
    name = "Henchmen",

    atlas = "jokers1",
    pos = { x = 4, y = 3 },

    config = { extra = { bonus = 2 } },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.bonus } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer >= G.jokers.config.card_limit then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, card.ability.extra.bonus do
                        SMODS.add_card { set = "Joker", key_append = "nflamne_henchmen" }
                    end
                    G.GAME.joker_buffer = 0

                    return true
                end
            }))

            return {
                message = localize("k_plus_joker"),
                color = G.C.BLUE
            }
        end
    end
}

SMODS.Joker {
    key = "bluecat",
    name = "Helping Hand",

    atlas = "enhance",
    pos = { x = 2, y = 0 },

    config = { extra = { xchips = 2 } },
    rarity = 4,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xchips} }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit("Spades") then

            return { xchips = card.ability.extra.xchips }
        end
    end
}

SMODS.Joker {
    key = "susie",
    name = "Susie",

    atlas = "jokers1",
    pos = { x = 4, y = 2 },

    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    calculate = function(self, card, context)
        if context.blueprint then return end
        local enemyroundup = {}
        local procupgrade = 0
        if context.forcetrigger then procupgrade = 5 end

        if G.GAME.current_round.hands_played == 0 and context.before then
            for k, v in pairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) then
                    table.insert(enemyroundup, v)
                end
            end
        end

        local picked_card, id = pseudorandom_element(enemyroundup, "nflame_susie")
        if picked_card then
            picked_card.ability.nflame_susietarget = true
            procupgrade = math.floor(picked_card:get_chip_bonus() / 2)
        end

        if procupgrade > 0 then
            for k, v in pairs(context.scoring_hand) do
                v.ability.perma_mult = (v.ability.perma_mult or 0) + procupgrade
            end
            return { message = localize("k_upgrade_ex") }
        end

        if context.destroy_card and context.destroy_card.ability.nflame_susietarget then
            return { remove = true }
        end
    end
}

SMODS.Joker {
    key = "ralsei",
    name = "Ralsei",

    atlas = "jokers1",
    pos = { x = 5, y = 2 },

    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local revived = G.hand.cards[1]
            if not revived then return end

            for i = 1, #context.removed do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local dupe = copy_card(revived)
                        G.hand:emplace(dupe)
                        dupe:add_to_deck()
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, dupe)
                        dupe:start_materialize()
                        SMODS.calculate_context({ playing_card_added = true, cards = { dupe } })

                        return true
                    end,
                }))
            end
        end
    end
}

SMODS.Joker {
    key = "kris",
    name = "Kris",

    atlas = "jokers1",
    pos = { x = 0, y = 3 },

    rarity = 3,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    in_pool = function(self, args)
        return next(SMODS.find_card('j_nflame_susie')) or next(SMODS.find_card('j_nflame_ralsei'))
    end,

    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint and not context.nflame_kris then
            for k, v in pairs(context.cards) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local dupe = copy_card(v)
                        SMODS.change_base(dupe, 'Hearts')
                        dupe.perma_bonus = dupe:get_chip_bonus()

                        G.deck:emplace(dupe)
                        dupe:add_to_deck()
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, dupe)
                        dupe:start_materialize()
                        SMODS.calculate_context({ playing_card_added = true, cards = { dupe }, nflame_kris = true })

                        return true
                    end,
                }))
            end
        end

        if context.repetition and context.cardarea == G.play then 
            local soulpower = 0
            for k, v in pairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) and v:is_suit("Hearts") then
                    soulpower = soulpower + 1
                end
            end

            return { repetitions = soulpower }
        end
    end
}

SMODS.Joker {
    key = "lavalamp",
    name = "Lava Lamp",

    atlas = "jokers1",
    pos = { x = 1, y = 3 },

    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        local mod = G.GAME.current_round.nflame_lamp or 1
        if mod >= 0 then mod = "+" .. mod end
        return { vars = {mod} }
    end,

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return { numerator = context.numerator + (G.GAME.current_round.nflame_lamp or 1) }
        end
    end
}

local function reset_nflame_lamp()
    -- range of -1 to 3, rounded to 0.1
    local new_r = pseudorandom("nflame_lavalamp") * 40
    new_r = math.floor(new_r) / 10
    G.GAME.current_round.nflame_lamp = new_r - 1

    -- fun lil synergy to really get your moneys worth
    if next(SMODS.find_card("j_nflame_hitch_brokenprob")) then G.GAME.current_round.nflame_lamp = 5 end
end

SMODS.Joker {
    key = "cstar",
    name = "Camostar",

    atlas = "jokers1",
    pos = { x = 2, y = 3 },

    rarity = 2,
    cost = 5,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    calculate = function(self, card, context)
        local trigger = context.force_trigger

        if context.before and not context.blueprint then
            if #context.scoring_hand < #context.full_hand then trigger = true end
        end

        if not trigger then return end

        local pcard = nil
        for k, v in pairs(context.full_hand) do
            if not SMODS.in_scoring(v, context.scoring_hand) then
                pcard = v
                break
            end
        end

        if not pcard then return end

        pcard:set_ability("m_gold", nil, true)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up()
                pcard:juice_up()
                return true
            end
        }))

        return { dollars = 3 }
end,
}

SMODS.Joker {
    key = "stanleybucket_new",
    name = "Reassurance Bucket",

    atlas = "jokers1",
    pos = { x = 3, y = 3 },

    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            local swap = G.GAME.chips
            G.GAME.chips_text_temp = G.GAME.chips_text
            G.GAME.chips = hand_chips
            G.hand_text_area.game_chips.config.ref_value = "chips_text_temp"

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.game_chips.config.ref_value = "chips_text"
                    G.hand_text_area.game_chips:juice_up()

                    return true
                end
            }))

            return { chip_mod = swap - hand_chips, message = "..." }
        end
    end
}

SMODS.Joker {
    key = "mcbedrock",
    name = "Minecraft Bedrock",

    atlas = "jokers1",
    pos = { x = 3, y = 4 },

    config = { extra = { chance = 4, chip = 5, mult = 1 } },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_mcbedrock")
        return { vars = {num, den, card.ability.extra.chip, card.ability.extra.mult} }
    end,

    calculate = function(self, card, context)
        if context.initial_scoring_step and not context.blueprint and 
			SMODS.pseudorandom_probability(card, "nflame_mcbedrock", 1, card.ability.extra.chance) then

            card.ability.extra.chip = card.ability.extra.chip + hand_chips
            card.ability.extra.mult = card.ability.extra.mult + mult

            return { mult_mod = -mult, chip_mod = -hand_chips, message = localize("k_upgrade_ex") }
        end

        if context.joker_main or context.forcetrigger then
            return { chips = card.ability.extra.chip, mult = card.ability.extra.mult }
        end
    end
}

SMODS.Joker {
    key = "hitch_brokenprob",
    name = "Improbability Drive",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    rarity = 2,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    loc_vars = function(self, info_queue, card)
        local word = "choices"
        local col = G.C.GREEN

        if next(SMODS.find_card("j_ring_master")) then
            word = "numbers"
            col = G.C.RED
        end

        return { vars = { word, colours = { col } } }
    end
}

local randelem_ref = pseudorandom_element
function pseudorandom_element(list, seed, args)
    if next(SMODS.find_card("j_nflame_hitch_brokenprob")) then
        dispseed = seed or "[noseed]"

        for i = 1, #list do
            -- because shop gen calls pseudorand with DIFFERENT seeds we cant use the calling seed
            -- sooo this will break with multiple random events at once potentially
            -- i dont CARE im SICK of coding this
            if not G.nflame_lockup_prevention("nflame_hbp_elem_" .. i) then
                -- sendDebugMessage("using index " .. i)
                return list[i]
            end
        end
        --]]
    end

    -- if next(SMODS.find_card("j_nflame_hitch_brokenprob")) and not G.nflame_lockup_prevention(500) then
    --    return list[1]
    -- end
    return randelem_ref(list, seed, args)
end

local randpick_ref = pseudorandom
function pseudorandom(seed, min, max)
    if next(SMODS.find_card("j_nflame_hitch_brokenprob")) and next(SMODS.find_card("j_ring_master")) then
    -- if next(SMODS.find_card("j_nflame_hitch_brokenprob")) then
    -- if G.GAME.modifiers.nflame_fullrand then
        dispseed = seed or "[noseed]"

        if min and max then
            for i = min, max do
                if not G.nflame_lockup_prevention("nflame_hbp_num_" .. "_" .. i) then
                    -- sendDebugMessage("using number " .. i .. "(" .. min .. " - " .. max .. ")")
                    return i
                end
            end
        else
            -- this one starts at 1 and goes down to 0, for fun
            for i = 1, 9 do
                i = 10 - i
                if not G.nflame_lockup_prevention("nflame_hbp_num_" .. "_" .. i) then
                    -- sendDebugMessage("using number " .. i)
                    return i / 10
                end
            end
        end

    end

    return randpick_ref(seed, min, max)
end

SMODS.Joker {
    key = "ntfabricator",
    name = "Helping Hand",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = true,

    calculate = function(self, card, context)
        local trigger = context.force_trigger
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            -- probably a bit jank
            if G.nflame_get_silicontotal() > 0 then trigger = true end
        end

        if trigger then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card { set = "silicon", key_append = "nflame_ntfabricator" }
                    G.GAME.joker_buffer = 0

                    return true
                end
            }))
        end
    end
}

SMODS.Joker {
    key = "personalhomeshredder",
    name = "Theoretical Shredder",

    atlas = "jokers1",
    pos = { x = 4, y = 4 },

    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.pre_discard and not context.blueprint then
            SMODS.calculate_context{ remove_playing_cards = true, removed = context.full_hand }
            SMODS.calculate_effect{ message = localize("k_extinct_ex") }
            SMODS.calculate_context{ playing_card_added = true, cards = context.full_hand }
            SMODS.calculate_effect{ message = localize("k_copied_ex") }
        end
    end
}


function SMODS.current_mod.reset_game_globals(run_start)
    reset_nflame_slimesteel()
    reset_nflame_lamp()
end
