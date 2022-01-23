

local Image = require "lib.image"
local Entity = require "gameobjects.entity"
local tilesize = require "lib.tilesize"

local Target = function(game, i, j)
    local tile = game.map.get(game.hero.x + i, game.hero.y)
    if not tile or not tile.walkable then return end
    local obj = Entity()
    obj.x = game.hero.x + i
    obj.y = game.hero.y + j

    obj.attack = 10

    obj.draw = function(self)
        love.graphics.draw(Image.target, self.x * tilesize, self.y * tilesize)
    end
    obj.walkon = function(self, other)
        del(game.entities, self)
        other:hit(self)
    end
    add(game.entities, obj)
end

return Target