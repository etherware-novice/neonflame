
return {
    descriptions = {
        Back = {
            b_nflame_selfinsert = {
                name = "Deck of Many Slimes",
                text = {
                    "Start with {C:attention}every Sappy Joker",
                    "from installed mods",
                    "Neonflame jokers are {C:dark_edition}100X",
                    "more likely to appear",
                    "{C:inactive}Art by Camostar34"
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
            },

            b_nflame_capital = {
                name = "Capitalist Deck",
                text = {
                    "Start run with",
                    "{C:tarot,T:v_seed_money}#1#",
                    "and {C:tarot,T:v_money_tree}#2#",
                    "Win ante is {C:attention}set{} when",
                    "entering a shop with {C:money}$#3#",
                    "{C:inactive}Art by Camostar34"
                }
            }
        },

        Blind = {
            bl_nflame_jpenguin = {
                name = "Jade Penguin",
                text = {
                    "Played hand must contain",
                    "an unscoring card"
                }
            },

            bl_nflame_jp_mole = {
                name = "Maroon Mole",
                text = {
                    "Deck is sorted with the",
                    "most played cards at bottom"
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
                    "{C:white,X:mult}X#1#{} mult",
                    "If hand scores {C:attention}more{} than blind requirement",
                    "{C:attention}Double blind requirement{} and create a {C:spectral}Ethereal Tag"
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
	              "Discarded cards are {C:attention}shuffled into deck",
	              "with a bonus {C:white,X:mult}X#1#{} mult when held in hand",
	              "Draw an {C:attention}extra card{} for each discarded card"
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
                    "{C:nflame_silicon}Silicon{} cards each have a",
                    "{C:green}#1# in #2#{} chance to give {C:money}$#3#{}",
                }
            },

            j_nflame_spbump = {
                name = "Bumpscosity-Bot",
                text = {
                    "+#1# Bumpscosity"
                }
            },

            j_nflame_jpenguin = {
                name = "Jade Penguin",
                text = {
                    "Played and {C:attention}unscoring{} cards have a",
                    "{C:green}#1# in #2#{} chance to be {C:red}destroyed",
                    "Gain a tenth of its rank as {C:white,X:mult}XMult",
                    "{s:0.8,C:inactive}(Currently {s:0.8,C:white,X:mult}X#3#{s:0.8,C:inactive} Mult)"
                }
            },

            j_nflame_ntfloor = {
                name = "Floorbot",
                text = {
                    "If played hand contains",
                    "5 scoring cards or a 5 card hand",
                    "each card in hand gives {C:mult}+#1#{} Mult",
                    "for each {C:nflame_silicon}Silicon{} held"
                }
            },

            j_nflame_ntfabricator = {
                name = "Fabricator",
                text = {
                    "When blind is selected, create a random {C:nflame_silicon}Silicon",
                    "if at least one {C:nflame_silicon}Silicon{} is owned",
                    "{s:0.8,C:inactive}(Must have room)"
                }
            },

            j_nflame_personalhomeshredder = {
                name = "Theoretical Shredder",
                text = {
                    "All cards in the first discard",
                    "are considered {C:red}destroyed",
                    "then {C:attention}added to deck"
                }
            },

            j_nflame_spbird = {
                name = "Silly Bird Feed",
                text = {
                    "Discard #1# {C:attention}random{} cards",
                    "when {C:attention}hand played",
                    "and draw {C:attention}#2#{} extra cards"
                }
            },

            j_nflame_flynn = {
                name = "Flynn from Flynnsanity",
                text = {
                    "Scored {C:clubs}#1#{} cards have a {C:green}#2# in #3#",
                    "chance to create a enhanced card with the {C:attention}same rank"
                }
            },

            j_nflame_bompaul = {
                name = "Paul, the Favorite of All",
                text = {
                    "{C:attention}Glass Cards{} create a {C:tarot}Tarot{} Card",
                    "and {C:attention}halves the blind requirement{} when {C:red}destroyed",
                    "{C:inactive,s:0.8}\"vecalius, invictissimi, what is the color on the roof of",
                    "{C:inactive,s:0.8}a house with human skeletons and should be heard?\""
                }
            },

            j_nflame_bompaul_mf = {
                name = "BasePaul tFoA",
                text = {
                    "{C:attention}Shattered Glass Cards{} give {C:tarot}Tarot",
                    "and {C:attention}halved blind requirement",
                    "{C:inactive,s:0.8}no, you aren't getting {C:white,X:mult}X12.5{C:inactive,s:0.8} mult.",
                }
            },

            j_nflame_cery = {
                name = "Cery",
                text = {
                    "{C:red}-#1#{} hand size",
                    "Always draw {C:attention}#2#{} extra cards"
                }
            },

            j_nflame_ultshowdown = {
                name = "Ultimate Showdown of Ultimate Destiny",
                text = {
                    "If a {C:attention}Kiln{} or {C:attention}Rouxles Kaard{} is scored",
                    "Create a {C:attention}Hand{} and {C:attention}Flynnsane{} tag",
                    "and all cards in hand become {C:attention}Ghost {C:dark_edition}Glitter {C:attention}100% Seal{} cards",
                    "And create a {C:dark_edition}negative{C:attention} Stardust{} card for each {C:attention}Jolly Joker",
                    "And create {C:red,s:1.2}EVERY{s:0.8} Astro{} and {C:attention}Sappy Joker"
                }
            },

            j_nflame_as_jwarosa = {
                name = "John #1#arosa",
                text = {
                    "When at least {C:money}$#3#{C:inactive} ($#4#){} is lost, create a {C:tarot}Tarot",
                    "and increase the requirement by {C:money}$#5#",
                    "If requirement is at least {C:money}$#6#{}, instead create",
                    "a {C:dark_edition}Negative Soul{} and {C:red,E:2}destroy this card",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:inactive,s:0.8}\"just forget any issue,",
                    "{C:inactive,s:0.8}or discussion about the {C:dark_edition,s:0.8}soul,",
                    "{C:inactive,s:0.8}called mister barrister john #2#arosa\""
                }
            },

            j_nflame_dicechain = {
                name = "Dice Chain",
                text = {
                    "Scored cards have a {C:green}#1# in #2#{} chance to be retriggered {C:attention}multiple times",
                    "{C:attention}Decrease{} {C:green}base numerator{} by {C:green}1{} for each successful retrigger {C:attention}this hand",
                    "{C:inactive}Art by Camostar34"
                }
            },

            j_nflame_nt4no = {
                name = "4no Raisins",
                text = {
                    "The next {C:attention}#1#{} cards {C:red}destroyed",
                    "creates a {C:planet}Meteor Tag",
                    "{C:red,E:2}self destructs"
                }
            },

            j_nflame_buzzy = {
                name = "Buzzy Beetle",
                text = {
                    "If played hand has at least 5 {C:attention}scoring{} cards",
                    "{C:green}rescore{} a random card in played or held hand",
                    "for each {C:attention}Stone Card{} in the {C:attention}remaining deck"
                }
            }
        },

        Partner = {
            pnr_nflame_snugglepenguin = {
                name = "Snugglebug",
                text = {
                    "When card is {C:attention}destroyed",
                    "{C:green}#1# in #2#{} chance to",
                    "gain half its {C:blue}chips",
                    "{C:inactive}(Currently {C:blue}+#3#{C:inactive} Chips)"
                }
            },

            pnr_nflame_snugglepenguin_1 = {
                name = "Snugglebug",
                text = {
                    "When card is {C:attention}destroyed",
                    "gain half its {C:blue}chips",
                    "{C:green}#1# in #2#{} chance to",
                    "instead gain all of its rank",
                    "{C:inactive,s.0.8}(Currently {C:blue}+#3#{} Chips)"
                }
            }
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

            m_nflame_hp = {
                name = "Holepunch Card",
                text = {
                    "If hand played while a {C:attention}Holepunch Card{} is held",
                    "{C:attention}Discard it{} and return played cards to hand"
                }
            }
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

            c_nflame_parrot = {
                name = "Parrot",
                text = {
                    "Convert {C:attention}all{} selected cards to",
                    "the {C:attention}last scored rank{} this round (#1#)",
                    "Can only be used if the rank has been",
                    "scored #2# {V:1}(#3#){} times this {C:attention}round",
                    "{C:inactive,s:0.8}\"squack! don't forget dl-6!\""
                }
            }
        },

        Other = {
            p_nflame_evidence = {
                name = "Evidence Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:nflame_evidence} Evidence Pieces"
                }
            }
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
            },
            c_nflame_mathey = {
                name = "The Mathematician",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#"
                }
            }
        },
	},

    misc = {
    	 challenge_names = {
             c_nflame_moderntech = "Day-One Patches",
             c_nflame_bugkey = "Bugged Seed",
             c_nflame_robofund = "House Always Wins"
         },

         dictionary = {
             b_evidence_cards = "Evidence Pieces",
             k_evidence = "Evidence",

             k_silicon = "Silicon",
             k_spess = "Space Station 13",
             k_modcom = "Balatro Modding Community",
             k_oc = "slime pond",
             k_cloverpit = "Cloverpit",
             k_minecraft = "Minecraft",
             k_internet = "Internet",
             k_mario = "Mario",
             k_gimmiko = "GIMMIKO",
             k_zelda = "Zelda",
             k_hitch = "Hitchhikers Guide",
             k_parable = "The Stanley Parable UD",
             k_deltarune = "Deltarune",
             k_inscr = "Inscryption",
             k_pwright = "Phoenix Wright",
             k_crossmod = "Crossmod",

             k_upgrade_eat = {
                 "Consumed!",
                 "Fine dined!",
                 "Bit!",
                 "Snacked!",
                 "Oops!",
                 "Digested!"
             },

             ph_attorneys = "Bluffed your way out...",

             k_nflame_evidence_pack = "Evidence Pack"
         },

         poker_hands = {
             nflame_generic = "Poker Hand All",
             nflame_Blaze = "Blaze"
         },

         poker_hand_descriptions = {
             nflame_generic = { "Any cards." },
             nflame_Blaze = { "5 Face cards" }
         },

         quips = {
             -- jpenguin came up with all of these
             -- blame him not me
             pnr_nflame_snugglepenguin_1 = {
                 "Trust me, my appetite",
                 "is way beyond what",
                 "you would expect"
             },

             pnr_nflame_snugglepenguin_2 = {
                 "I like eating",
                 "cards, they",
                 "remind me of",
                 "crackers"
             },

             pnr_nflame_snugglepenguin_3 = {
                 "I won't accept just",
                 "fish and krill, I",
                 "require fine dining..."
             },

             pnr_nflame_snugglepenguin_4 = {
                 "My tummy rumbles for",
                 "some sweet action"
             },

             pnr_nflame_snugglepenguin_5 = {
                 "This'll be a piece",
                 "of cake, now that",
                 "your favorite casino",
                 "penguin is here!"
             },

             lq_jpenguin_1 = {
                 "Maybe next time... uhhh,",
                 "not let one of your stuff",
                 "not score?"
             },

             lq_jpenguin_2 = {
                 "I'm not sure what you're",
                 "trying to do but it's absolutely",
                 "funny, keep doing that."
             },

             lq_jpenguin_3 = {
                 "I'm hungry,",
                 "what's for dessert?"
             },

             lq_jpenguin_4 = {
                 "Hey, chin up, not everyone",
                 "can win against me" 
             },

             lq_endless_jpenguin_1 = {
                 "C'mon man, can't you let",
                 "a penguin like me rest",
                 "for a while?"
             },

             lq_endless_jpenguin_2 = {
                 "I'm too drowsy to even",
                 "finish my...",
                 "zzzzz..."
             },

             lq_endless_jpenguin_3 = {
                 "I believe it's a good",
                 "time to get up and",
                 "stretch. Thank me later!"
             },
         },

         labels = {
            evidence = "Evidence Piece",
         },

         v_dictionary = {
             k_bump = "+#1# Bumpscosity",

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
