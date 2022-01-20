local Image = require "lib.image"
local tilesize = require "lib.tilesize"

return function(entity, img)
    entity.color = {1,1,1}
    entity.img = img and Image[img] or Image.hero
    entity.w = entity.w or tilesize
    entity.h = entity.h or tilesize
    entity.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(
            self.img, 
            self:getX()+entity.w/2, self:getY()+entity.h/2,
            0, self.dir, 1, self.img:getWidth()/2, self.img:getWidth()/2
        )
        love.graphics.setColor(1,1,1)
    end
end