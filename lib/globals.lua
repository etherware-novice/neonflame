-- not everyone has debugplus
local send_debug = sendDebugMessage
function sendDebugMessage(str) if send_debug then send_debug(str) end end

local send_warn = sendWarnMessage
function sendWarnMessage(str) if send_warn then send_warn(str) end end

G.nflame_pick_idol_style = function()
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end

    return pseudorandom_element(valid_cards, "nflame_idol")
end

-- returns true if we're in a potential lockup
G.nflame_lockup_prevention = function(key, frame_tolarance, trigger_tolarance)
    --[[
    love.filesystem.append("candycane-delta-debug-why-does-it-not-print-oh-no.txt", love.timer.getDelta())
    if love.timer.getDelta() > 2 then return true end
    return false
    --]]
    
    frame_tolarance = frame_tolarance or 10 -- im prretty sure G.FRAMES.DRAW runs at a fixed 30FPS
    trigger_tolarance = trigger_tolarance or 200

    local micromoment = love.timer.getTime()
    micromoment = G.FRAMES.DRAW

    G.NFLAME_IDRFIRE = G.NFLAME_IDRFIRE or {}
    G.NFLAME_IDRFIRE[key] = G.NFLAME_IDRFIRE[key] or {}
    local action = G.NFLAME_IDRFIRE[key]

    action.frame = action.frame or 0
    action.count = action.count or 0

    local delta = micromoment - action.frame
    if delta < 1 then delta = 0 end


    -- action.count = math.max(0, math.floor(action.count - ((delta + 1)^1.5)))
    -- if action.frame + (frame_tolarance * 1) < micromoment then action.count = 0 end
    if delta > frame_tolarance then action.count = 0 end
    action.count = action.count + 1

    local panicmsg = string.format("POTENTIAL LOCKUP ( %s / deltaframe %d vs %d / %d triggers vs %d)",
                                    key, micromoment - action.frame, frame_tolarance,
                                    action.count, trigger_tolarance)
    -- love.filesystem.append("candycane-loop-panic.txt", panicmsg .. "\n")

    -- if delta < frame_tolarance              -- this triggered less than x frames ago
    if action.count > trigger_tolarance then -- this triggered more than x times
        sendDebugMessage(panicmsg)
        return true
    end

    action.frame = micromoment
    return false
    --]]
end

function G.nflame_first_possible(f, starting_point)
    local i = starting_point or 0
    local retr = f(i)
    while not retr do
        i = i + 1
        retr = f(i)
    end

    return retr
end


local ginit = Game.init_game_object
function Game:init_game_object()
    local g = ginit(self)

    g.nflame_offshore_jokers = {}

    return g
end

local gdraw = Game.draw
function Game:draw()
    local g = gdraw(self)

    if not G.NFLAME_IDRFIRE then return g end
    -- love.graphics.print(string.format("Time: %d", love.timer.getTime()), 10, 200)
    love.graphics.print(string.format("Frame %d", G.FRAMES.DRAW), 10, 200)
    local i = 1
    for k, v in pairs(G.NFLAME_IDRFIRE) do
        love.graphics.print(string.format("%s: frame %d / %d triggers", k, v.frame, v.count), 10, 200 + (i * 25))
        i = i + 1
    end

    return g
end

SMODS.current_mod.calculate = function(self, context)
    -- attorneys badge stuff
    if context.end_of_round and context.game_over and context.main_eval and G.GAME.current_round.attorneysluck then
        return { saved = "ph_attorneys" }
    end

    if context.setting_blind then G.GAME.current_round.attorneysluck = false end
end

test = "item"
