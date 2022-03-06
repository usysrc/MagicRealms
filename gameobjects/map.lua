local sti = require "lib.sti"

local Map = function(game)
    local map = sti("assets/maps/map01.lua")

    local m = {}
    m.draw = function(self, ...) map:draw(...) end
    m.get = function() end
    m.isWalkable = function(x, y)
        local layer = "Tile Layer 2"
        if x <= 0 or x > map.tilewidth then return end
        if y <= 0 or y > map.tileheight then return end
        local prop = map:getTileProperties(layer, x, y)
        if prop and prop.solid then
            return false
        end
        return true
    end
    return m
end

return Map