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

local Camera = require "hump.camera"
local cameralerp = require "lib.cameralerp"
local Timer = (require "hump.timer")

local Hero      = require "gameobjects.hero"
local Mob    = require "gameobjects.mob"
local Potion    = require "gameobjects.potion"
local Map       = require "gameobjects.map"
local dijkstramap = require "lib.dijkstramap"

local entities, map, cam, hero, castle, effects

local game = {}
function game:init()
    
    cam = Camera()
    game.cam = cam

    hero = Hero(game)
    game.hero = hero
    
    cameralerp.init(cam, hero)
    entities = {}
    add(entities, hero)
    game.entities = entities
    
    map = Map()
    game.map = map

    effects = {}
    game.effects = effects

    for i=1, 10 do
        add(entities, Mob(game, i*8, 25))
    end
    for i=1, 10 do
        for j=1, 10 do
            add(entities, Potion(game, 2+i*8, 2+j*8))
        end
    end
end

function game:update(dt)
    Timer.update(dt)
    cameralerp.update(cam, hero, dt)
end

function game:draw()
    love.graphics.clear()
    cam:attach()
    map:draw()
    
    table.sort(entities, function(a,b) return a.z<b.z end)
    for ent in all(entities) do
        ent:draw()
    end
    cam:detach()

    for effect in all(effects) do
        effect:draw()
    end
    
    hero:drawUI()
end

function game:keypressed(...)
    for ent in all(entities) do
        ent:keypressed(...)
    end
end

function game:turn()
    dijkstramap.update(game, map, entities)
    for ent in all(entities) do
        ent:turn()
    end
end

return game