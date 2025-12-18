
return {
    descriptions = {
        Back = {
            b_nflame_selfinsert = {
                name = "Deck of Many Slimes",
                text = {
                    "Start with {C:attention}every Sappy Joker",
                    "from installed mods",
                    "Neonflame jokers are {C:dark_edition}100X",
                    "more likely to appear"
                },
            },

            b_nflame_ramped = {
                name = "Ramped Deck",
                text = {
                    "Start run with",
                    "{C:tarot,T:v_reroll_surplus}#1#",
                    "and {C:tarot,T:v_reroll_glut}#2#",
                    "Rerolls resets at {C:attention}end of ante",
                    "{C:inactive}Art by Camostar34"
                }
            }
        },

        Joker = {
		    j_nflame_jokerhelp = {
		        name = "Helping Hand",
                text = {
                    "{C:blue}+#1#{} Hands for each {C:attention}Common Joker{}",
                }
		    },
	
		    j_nflame_hoarder = {
		        name = "Hoarder",
                text = {
                    "Gains {C:white,X:mult} X#1# {} Mult",
                    "for each {C:attention}Steam Level{}",
                    "{C:inactive,s:0.8}(Currently {C:white,X:mult,s:0.8}X#2#{C:inactive,s:0.8})"
                }
		    },
	
		    j_nflame_nflame = {
		        name = "Neonflame",
                text = {
                    "Gains {C:white,X:mult} X#1# {} Mult",
                    "for each {C:attention}new card added by Neonflame{}",
                    "Loses {C:white,X:mult} X#2# {} Mult for each day",
                    "since a new update",
                    "{C:inactive,s:0.8}(Currently {C:white,X:mult,s:0.8}X#3#{C:inactive,s:0.8})"
                }
		    },
	
		    j_nflame_forecast = {
		        name = "Forecast",
                text = {
                    "When booster pack is opened",
                    "draw #1# more cards",
                    "{s:0.8,C:inactive}Idea by badfontkeming{}",
                },
		    },
	
		    j_nflame_numberup = {
		        name = "Number Go Up",
                text = {
                    "Jokers give {C:white,X:mult}X#1#{}",
                    "If hand scored more than X#2# of blind score, lose all money",
                }
		    },
	
		    j_nflame_tjhenry = {
		        name = "TJ 'Henry' Yoshi",
                text = {
                    "If played hand has #1# or less cards",
                    "Scored cards gain {C:white,X:mult}X#2#{}",
                    "and are {C:attention}drawn to hand next round{}"
                }
		    },
	
		    j_nflame_stanleybucket = {
		        name = "Nostalgic Reassurance Bucket",
                text = {
                    "Siphons {C:purple}round score {C:attention}on discard{}",
                    "Adds {C:purple}stored round score{} when {C:attention}playing a hand{}",
                    "{C:inactive,s:0.8}(Currently {C:purple,s:0.8}+#1#{C:inactive,s:0.8} score){}",
                    "{s:0.8,C:inactive}Stanley and the bucket couragously bet all of their",
                    "{s:0.8,C:inactive}life savings on a poker game. Let's see how this turns out."
                }
		    },
	
		    j_nflame_acpart = {
		        name = "Agamemnon Counterpart",
                text = {
                    "If {C:attention}played hand{} contains an {C:attention}Ace{},",
                    "convert a {C:attention}random card in hand{} to an {C:attention}Ace{}",
                    "{C:inactive}a{}"
                }
		    },
	
		    j_nflame_opensource = {
		        name = "Open Source",
                text = {
                    "When a {C:cry_code}Green Seal{} is scored",
                    "Create a {C:cry_code}Commit, Rework, or Delete{} card",
                    "{C:inactive,s:0.8}(Must have room){}"
                }
		    },
	
		    j_nflame_miafey = {
		        name = "Mia Fey",
                text = {
                    "When {C:attention}Ghost Cards{} are played and unscored",
                    "{C:attention}Scored Cards{} gain the {C:white,X:mult}XMult{}",
                    "of the {C:attention}Ghost Cards{}"
                }
		    },
	
		    j_nflame_potatorevenge = {
		        name = "Cold Potato",
                text = {
                    "{C:attention}You aren't ready for this joker{}.",
                    "It is so {C:blue,E:1}#1#{}.",
                    "{s:1.2,C:red}IT WILL BLOW YOUR MIND{}.",
                    "It gets {E:1}better over time{}, too!",
                    "{C:inactive}(Currently #2#){}",
                    "{s:0.8,C:inactive}idea by astro{}",
                }
		    },
	
	        j_nflame_genplanet = {
	           name = "Blind Telescope",
	           text = {
	              "All hands are scored as {C:attention}Poker Hand All{}",
	              "All hand level ups also level {C:attention}Poker Hand All{}"
	           }
	        },
	
	        j_nflame_bakerfool = {
	           name = "Bakers Dozen",
	           text = {
	              "When {C:attention}Booster Pack{} is opened",
	              "create the {C:attention}default card{} for the set"
	           }
	        },
	
	        j_nflame_sappy = {
	           name = "Sappy",
	           text = {
	              "Discarded cards are {C:attention}drawn back to hand{}",
	              "with a bonus {C:white,X:mult}X#1#{} mult when held in hand",
	              "Draw an extra card for each discarded card"
	           }
	        },

			j_nflame_refund = {
				name = "Refund Policy",
				text = {
				  "Sold consumables have a {C:green}#1# in #2#{} chance",
				  "to {C;attention}create a card of the same type{}",
				  "{C:inactive,s:0.8}(Each card can only be resold once)"
				}
			},

			j_nflame_rapdog = {
				name = "PaRappa",
				text = {
					"Gains {C:white,X:mult}X#1#{} if the {C:attention}last scored card this game",
					"matches the {C:attention}rank{} of the first scoring card",
					-- "and hand contains {C:attention}two ranks{}",
					"Retriggers itself {C:attention}#2#{} times",
					"{C:inactive,s:0.8}(Rank #3# and {C:white,X:mult,s:0.8}X#4#{C:inactive,s:0.8})",
					"{C:inactive,s:0.8}oops- oops- oops- oops"
				}
			},

            j_nflame_stasis = {
                name = "Stasis",
                text = {
                    "{C:mult}+#1#{} mult",
                    "On first hand of round, {C:attention}copies mult{}",
                    "{C:inactive,s:0.8}(Resets at end of round)"
                },
            },

            j_nflame_localfunc = {
                name = "local function x() x() end; x()",
                text = {
                    "Gains {C:white,X:mult}X#1#{} for each consecutive hand",
                    "with the first card matching {C:attention}rank OR suit{}",
                    "Changes after each hand",
                    "{C:inactive,s:0.8}(Currently {C:white,X:mult,s:0.8}X#2#{C:inactive,s:0.8} and {C:attention,s:0.8}#3#{C:inactive,s:0.8} or {V:1,s:0.8}#4#{C:inactive,s:0.8})"
                }
            },

            j_nflame_clovercoin = {
                name = "Fake Coin",
                text = {
                    "{C:green}#1# in #2#{} chance for {C:blue}an extra hand{}",
                    "and {C:white,X:mult}X#3#{} for the next hand",
                    "{C:red,E:2}Self destructs{} if triggered more than {C:attention}#4# times{} in a blind",
                    "{s:0.8,C:inactive}(Currently #5# triggers and {s:0.8,V:1}#6#{s:0.8,C:inactive})"
                }
            },

            j_nflame_slime_steel = {
                name = "Steel Slime",
                text = {
                    "Each {C:attention}#1#{} held in hand gives {C:white,X:mult}X2{} mult",
                    "{s:0.8,C:inactive}(Rank changes at end of round)"
                }
            },

            j_nflame_offshorebank = {
                name = "Offshore Bank",
                text = {
                    "When {C:attention}Boss Blind{} is defeated, create",
                    "a {C:dark_edition}negative{} copy of a Joker sold this ante",
                    "{s:0.8,C:inactive}(Currently #1# Jokers)"
                }
            },

            j_nflame_henchmen = {
                name = "Henchmen",
                text = {
                    "When {C:attention}Blind{} is selected, create #1# random Jokers",
                    "{C:inactive,s:0.8}(Must NOT have room)"
                }
            },

            j_nflame_furnace = {
                name = "Furnace",
                text = {
                    "Held in hand {C:attention}Sand Cards{} give {C:white,X:mult}X#1#{} Mult",
                    "and have a {C:green}#2# in #3#{} chance to be destroyed{}"
                }
            },

            j_nflame_bluecat = {
                name = "asro",
                text = {
                    "Scored Spade cards give {C:white,X:blue}X#1#{} Chips"
                }
            },

            j_nflame_susie = {
                name = "Susie Deltarune",
                text = {
                    "On the first hand of a round, {C:attention}destroy{} a random unscoring card",
                    "and add {C:attention}half{} its {C:blue}chip value{} as {C:red}permanent mult{} to {C:attention}all scoring cards"
                }
            },

            j_nflame_ralsei = {
                name = "Ralsei Deltarune",
                text = {
                    "When a card is {C:attention}destroyed{}",
                    "create a copy of the {C:attention}leftmost{} card in hand and draw it to hand",
                    "{C:inactive,s:0.8}(Hand must be drawn)"
                }
            },

            j_nflame_kris = {
                name = "Kris Deltarune",
                text = {
                    "When adding a card to deck, create a {C:red}Hearts{} copy",
                    "with {C:attention}double{} the chips value and put it in deck",
                    "Retrigger all played cards once for each {C:attention}unscoring Hearts{} card"
                }
            },

            j_nflame_lavalamp = {
                name = "Lava Lamp",
                text = {
                    "{C:green}#1#{} to listed {C:green}probabilities",
                    "{C:inactive,s:0.8}(Changes at end of round)",
                    "{s:0.8,C:inactive}Art by Camostar34"
                }
            },

            j_nflame_cstar = {
                name = "Samson",
                text = {
                    "First played and {C:attention}unscoring{} card",
                    "is converted to a {C:attention}Gold Card",
                    "and gives {C:money}$3",
                    "{s:0.8,C:inactive}OC by Camostar34"
                }
            },

            j_nflame_stanleybucket_new = {
                name = "Reassurance Bucket",
                text = {
                    "Swaps {C:blue}chips{} and {C:purple}round score",
                    "{s:0.8,C:inactive}Come now, Stanley (and the bucket), this is the",
                    "{s:0.8,C:inactive}thrill you were looking for! Don't let something as",
                    "{s:0.8,C:inactive}minor as \"having no money\" stop you from GAMBLING!",
                }
            },

            j_nflame_mcbedrock = {
                name = "Minecraft: Bedrock Edition",
                text = {
                    "{C:green}#1# in #2#{} chance to {C:attention}siphon",
                    "the base {C:blue}chips{} and {C:red}mult{} from played hand",
                    "{s:0.8,C:inactive}(Currently {s:0.8,C:blue}+#3#{s:0.8,C:inactive} chips and {s:0.8,C:red}+#4#{s:0.8,C:inactive} mult)"
                }
            },

            j_nflame_hitch_brokenprob = {
                name = "Improbability Drive",
                text = {
                    "All {C:green}random {V:1}#1#{} use the {C:attention}first possible option",
                    "{s:0.8,C:inactive}(every. single. one. expect lots of wackiness)"
                }
            },

            j_nflame_ntmed = {
                name = "Medibot",
                text = {
                    "Scored cards gain {C:mult}+#1#{} Mult",
                    "for each {C:nflame_silicon}Silicon{} card owned",
                }
            },

            j_nflame_odgamble = {
                name = "Gamblobot",
                text = {
                    "{C:green}#1# in #2#{} chance to gain {C:money}$#3#{} at end of round",
                    "{C:green}+1{} numerator for each {C:nflame_silicon}Silicon{} card owned"
                }
            },
        },

        Enhanced = {
            m_nflame_snow = {
                name = "Snow Card",
                text = {
                "Gains {C:mult}+#1#{} Mult {C:attention}permanently{}",
                "for each {C:attention}Snow Card{} in hand",
                "when hand played"
            }
            },

            m_nflame_rules = {
                name = "Rouxls Kaard",
            text = {
                "Decreases {C:attention}Blind Requirement{} by {C:attention}#1#%{}",
                "{C:green}#2# in #3#{} chance to {C:attention}disable boss blind{}",
                "{C:inactive,s:0.8}Thou thought me a {C:inactive,E:1,s:0.8}fool{C:inactive,s:0.8}, didest thou?",
                "{C:inactive,E:1,s:0.8}Worms{C:inactive,s:0.8}, if thereseth one thingeth I'm {C:red,s:0.8}NOT{},",
                "{C:inactive,s:0.8}its a {C:red,E:1}COURTETH JESTER.{}"
            }
            },
        },

        evidence = {
            c_nflame_badge = {
                name = "Attorneys Badge",
                text = {
                    "Use this card to {C:red}destroy{} another evidence piece",
                    "and {C:attention}prevent death{} this round",
                    "Can only be used on the {C:attention}last hand of a round",
                    "{C:attention}+1 Consumable slot",
                    "{C:inactive,s:0.8}\"otherwise, how will people know im an attorney?\""
                }
            },

            c_nflame_passport = {
                name = "Cindy's Passport",
                text = {
                    "Use this card to {C:red}destroy{} all rankless card in hand",
                    "Can only be used if a straight was played this round",
                    "{C:inactive,s:0.8}\"stone can't be their real last name, right?\""
                }
            },

            c_nflame_thinker = {
                name = "The Thinker (Replica)",
                text = {
                    "Use this card to create a {C:dark_edition}negative {C:tarot}Fool",
                    "for every #1# cards {C:attention}destroyed{} this ante",
                    "Can only be used in a {C:attention}Boss Blind",
                    "{C:inactive,s:0.8}(Currently #2# cards destroyed)",
                    "{C:inactive,s:0.8}\"this thing qualifies as a serial killer by now...\""
                }
            },

            c_nflame_wpowers = {
                name = "Steel Samurai Spear",
                text = {
                    "Use this card to convert {C:attention}all cards in hand{} to {C:attention}Steel Cards",
                    "Can only be used if {C:attention}#1#{} Steel Cards triggered in the last hand",
                    "{C:inactive,s:0.8}(Currently {V:1,s:0.8}#2#{C:inactive,s:0.8})",
                    "{C:inactive,s:0.8}\"the steel samurai....always wins!\""
                }
            },
        },

        Tarot = {
            c_nflame_frost = {
                name = "The Frost",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2#{}"
                }
            },
            c_nflame_trabant = {
                name = "The Trabant",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2#{}"
                }
            }
        },
	},

    misc = {
    	 challenge_names = {
             c_nflame_moderntech = "Day-One Patches",
             c_nflame_bugkey = "Bugged Seed"
         },

         dictionary = {
             b_evidence_cards = "Evidence Pieces",
             k_evidence = "Evidence",

             k_silicon = "Silicon",

             ph_attorneys = "Bluffed your way out...",
         },

         poker_hands = {
             nflame_generic = "Poker Hand All"
         },

         poker_hand_descriptions = {
             nflame_generic = { "Any cards." }
         },

         labels = {
            evidence = "Evidence Piece",
         },

         v_dictionary = {
             k_silicon_desc = {
                 "Multiple copies of Silicon cards can appear",
                 "#1# Silicon cards owned"
             },
         },

         v_text = {
             -- ch_c_nflame_fullrand = "All random numbers are {C:green}fixed"
         }
    },
}
