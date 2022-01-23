

local Timer = require "hump.timer"

local Entity = require "gameobjects.entity"

local Stats = require "gameobjects.actions.mob.stats"
local Draw = require "gameobjects.actions.draw"
local Walk = require "gameobjects.actions.walk"
local Die = require "gameobjects.actions.mob.die"
local Seek = require "gameobjects.actions.mob.seek"
local Inventory = require "gameobjects.actions.inventory"


local Mob = function(game, x,y)
    local tile = game.map.get(x,y)
    if tile and not tile.walkable then return end

    local mob = Entity()
    mob.game = game
    mob.type = "mob"
    mob.x = x or 40
    mob.y = y or 25

    Stats(mob)
    Draw(mob, "bandit")
    Walk(mob)
    Die(mob)
    Seek(mob)
    Inventory(mob)

    return mob
end

return Mob