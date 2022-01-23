

local Timer = require "hump.timer"

local randomselect = require "lib.randomselect"
local Image = require "lib.image"
local Entity = require "gameobjects.entity"
local NotFound = require "gameobjects.types.notfound"

local Item = function(game, x, y, ItemType)
    -- local tile = game.map.get(x,y)
    -- if tile and not tile.walkable then return end

    local item = Entity()
    item.type = ItemType and ItemType() or NotFound()

    item.use = function(self, entity)
        self.type:use(entity, self)
    end

    item.x = x or 40
    item.y = y or 25
    item.color = {1,1,1}

    item.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(self.type.img, self:getX(), self:getY())
        love.graphics.setColor(1,1,1)
    end

    item.walkon = function(self, other)
        other:addItem(self)
        del(game.entities, self)
    end

    item.walkinto = function(self, x, y, tx, ty)
    end

    return item
end

return Item