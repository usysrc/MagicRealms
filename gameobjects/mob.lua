-- libraries
local Timer = require "lib.hump.timer"

-- entity
local Entity = require "gameobjects.entity"

-- components
local Stats = require "gameobjects.actions.mob.stats"
local Draw = require "gameobjects.actions.draw"
local Walk = require "gameobjects.actions.walk"
local Die = require "gameobjects.actions.mob.die"
local Seek = require "gameobjects.actions.mob.seek"
local Inventory = require "gameobjects.actions.inventory"

-- composition of entity
local Mob = function(game, x,y)

    local mob = Entity()
    mob.game = game
    mob.type = "mob"
    mob.x = x
    mob.y = y

    Stats(mob)
    Draw(mob, 3988)
    Walk(mob)
    Die(mob)
    Seek(mob)
    Inventory(mob)

    return mob
end

return Mob