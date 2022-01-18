--[[
Copyright (c) 2022, usysrc

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
]]--

local Timer = require "hump.timer"

local Entity = require "gameobjects.entity"

local Stats = require "gameobjects.actions.herostats"
local Draw = require "gameobjects.actions.draw"
local Walk = require "gameobjects.actions.walk"
local Die = require "gameobjects.actions.mob.die"
local Seek = require "gameobjects.actions.mob.seek"

local Mob = function(game, x,y)
    local tile = game.map.get(x,y)
    if tile and not tile.walkable then return end

    local mob = Entity()
    mob.game = game
    mob.type = "mob"
    mob.x = x or 40
    mob.y = y or 25
    mob.color = {1,1,1}

    Stats(mob)
    Draw(mob, "bandit")
    Walk(mob)
    Die(mob)
    Seek(mob)

    return mob
end

return Mob