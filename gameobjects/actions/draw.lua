local Image = require "lib.image"

return function(entity, img)
    entity.img = img and Image[img] or Image.hero
    entity.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(self.img, self:getX()+self.w/2, self:getY()+self.h/2, 0, self.dir, 1, self.w/2, self.h/2)
        love.graphics.setColor(1,1,1)
    end
end