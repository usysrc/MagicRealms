

local tilesize = require "lib.tilesize"

local Entity = function()
    local e = {}
    e.type = "entity"
    e.x = 0
    e.y = 0
    e.z = 100 
    e.zfight = math.random()*0.1 -- against zfighting when drawing
    e.w = tilesize
    e.h = tilesize
    e.dir = 1
    e.draw = function() end
    e.update = function() end
    e.keypressed = {}
    e.getX = function(self)
        return self.x * self.w
    end
    e.getY = function(self)
        return self.y * self.h
    end
    e.turn = function() end
    return e
end

return Entity