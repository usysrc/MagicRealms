local Image = require "lib.image"
local tilesize = require "lib.tilesize"
local tilequad = require "lib.tilequad"

return function(entity, tileID)
    entity.color = {1,1,1}
    entity.w = entity.w or tilesize
    entity.h = entity.h or tilesize
    entity.quad = tilequad(entity.tileID or tileID)
    entity.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(
            Image.tileset,
            entity.quad,
            self:getX()+entity.w/2,
            self:getY()+entity.h/2,
            0, self.dir, 1, tilesize/2, tilesize/2
        )
        love.graphics.setColor(1,1,1)
    end
end