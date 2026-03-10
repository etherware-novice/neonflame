local lastfling
local xinit

local dpsource

function NF_flingactive()
    if not lastfling then return false end
    if lastfling.shattered or lastfling.getting_sliced or lastfling.shattered then return false end
    return true
end

-- ctx also scores the card and makes eval messages appear on the fake
function NF_cardfling(mirror, ctx)
    if NF_flingactive() then NF_cardunfling() end

    xinit = G.deck.T.x * 2
    local xfin = G.deck.T.x
    local y = G.deck.T.y - G.CARD_H * 2
    local nc = Card(xinit, y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.c_base)
    lastfling = nc

    copy_card(mirror, nc)
    nc.states.drag.can = false

    G.E_MANAGER:add_event(Event{
        func = function()
            nc.T.x = xfin
            return true
        end
    })

    if ctx then
        dpsource = mirror
        SMODS.score_card(mirror, ctx)
        G.E_MANAGER:add_event(Event{
            func = function()
                dpsource = nil
                return true 
            end
        })
    end

    return nc
end

function NF_cardunfling()
    if not NF_flingactive() then return end

    print(xinit)
    lastfling.T.x = xinit

    G.E_MANAGER:add_event(Event{
        trigger = "after",
        delay = 3.8,
        blocking = false,
        func = function()
            lastfling:remove()
            return true
        end
    })

    lastfling = nil
end


local cest = card_eval_status_text
function card_eval_status_text(card, eval_type, amt, percent, dir, extra)
    if dpsource and dpsource == card then
        card = lastfling
        if extra then extra.focus = nil end
    end

    return cest(card, eval_type, amt, percent_dir, extra)
end
