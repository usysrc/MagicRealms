local sti = require "lib.sti"
local Mob    = require "gameobjects.mob"
local NPC    = require "gameobjects.npc"

-- create objects from all objects on the object layer and then remove the object layer
local initObjects = function(game, map)
    local deleted = {}
    for k, v in pairs(map.objects) do
        if v.type == "Mob" then
            add(game.entities, Mob(game, map:convertPixelToTile(v.x, v.y)))
        elseif v.type == "NPC" then
            add(game.entities, NPC(game, map:convertPixelToTile(v.x, v.y)))
        end
    end
    map:removeLayer("Object Layer 1")
end

local Map = function(game)
    local map = sti("assets/maps/map01.lua")
    initObjects(game, map)

    local m = {}
    m.draw = function(self, ...) map:draw(...) end
    m.get = function() end
    m.isWalkable = function(x, y)
        local layer = "Tile Layer 2"
        if x <= 0 or x > map.width then return end
        if y <= 0 or y > map.height then return end
        local prop = map:getTileProperties(layer, x, y)
        if prop and prop.solid then
            return false
        end
        return true
    end
    return m
end

return Map