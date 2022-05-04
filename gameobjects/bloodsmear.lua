local Entity = require "gameobjects.entity"

local Draw = require "gameobjects.actions.draw"

local Bloodsmear = function(game, x, y, dir)
    local tile = game.map.get(x,y)
    if tile and not tile.walkable then return end

    local smear = Entity()
    smear.type = "blood"
    smear.x = x or 40
    smear.y = y or 25
    smear.z = 0
    smear.dir = dir
    smear.color = {1,1,1}

    Draw(smear, 3305)

    return smear
end

return Bloodsmear