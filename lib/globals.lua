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


local gstartrun = Game.start_run
function Game:start_run(args)
    local retr = gstartrun(self, args)

    if not G.GAME.modifiers.nflame_var_win then return retr end

    -- any read/writes to win ante will be intercepted for my deck
    G.GAME.win_ante_backup = G.GAME.win_ante
    G.GAME.win_ante = nil
    local mt = getmetatable(G.GAME) or {}

    mt.__index = function(self, _k)
        local vfunc = G.FUNCS["nflame_varwin_" .. G.GAME.modifiers.nflame_var_win]
        if _k == "win_ante" then
            return vfunc and vfunc() or self.win_ante_backup
        end

        return rawget(self, _k)
    end

    mt.__newindex = function(self, _k, _v)
        local vfunc = G.FUNCS["nflame_varwin_" .. G.GAME.modifiers.nflame_var_win]
        if _k == "win_ante" then
            if not self.win_ante_backup then self.win_ante_backup = _k end
            local retr = vfunc and vfunc(_v)
            if retr then return retr end
            self.win_ante_backup = _v
        end

        rawset(self, _k, _v)
    end

    setmetatable(G.GAME, mt)
    return retr
end

function G.FUNCS.nflame_varwin_generic(modify)
    if modify then
        local change = modify - G.GAME.win_ante
        G.GAME.win_ante_backup = G.GAME.win_ante_backup + change
        G.GAME.nflame_var_modifyglob = (G.GAME.nflame_var_modifyglob or 0) + change
        return 0
    end

    if not G.GAME.nflame_varwin_generic_active then return 999 end
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
    -- keepign track for the mole boss
    if context.individual and context.cardarea == G.play then
        context.other_card.ability.nflame_scoredcount = (context.other_card.ability.nflame_scoredcount or 1) + 1
    end
end

local cas = CardArea.shuffle
function CardArea:shuffle(_seed)
    local retr = cas(self, _seed)

    local sortab = {}
    SMODS.calculate_context({ nflame_post_shuffle = true, cardarea = self, seed = _seed }, sortab)
    table.sort(sortab, function(a, b)
        return (a.individual and a.individual.priority or 100) > (b.individual and b.individual.priority or 100)
    end)

    for _, lr in ipairs(sortab) do
        if lr.individual then
            if lr.individual.debug then print(lr.individual.debug) end
            table.sort(self.cards, lr.individual.sort)
        end
    end


    return retr
end

test = "item"
