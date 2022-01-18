local Image = require "lib.image"

return function(entity)
    entity.drawUI = function(self)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill", 100, 4, 100 * self.hp/self.maxhp, 16)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", 100, 4, 100, 16)
        love.graphics.setColor(1,1,1)
        if self.hideUI then return end
        local x,y = 440, 32
        love.graphics.draw(Image.frame, x, y)
        local k = 0
        for item in all(self.items) do
            k = k + 1
            local x,y = x+20, y + k*16
            love.graphics.print(k..")  "..item.name, x,y)
            love.graphics.draw(item.img, x + 5, y - 4)
        end
    end

end