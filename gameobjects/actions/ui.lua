local Image = require "lib.image"
local tilesize = require "lib.tilesize"

return function(entity)

    local selected = 1
        
    entity.hideUI = true
    entity.drawUI = function(self)
        self:drawStats()
        self:drawMenu()
    end

    entity.drawStats = function(self)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill", 100, 4, 100 * self.hp/self.maxhp, 16)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", 100, 4, 100, 16)
    end

    entity.drawInventory = function(self)
        love.graphics.setColor(1,1,1)
        local x,y = 440, 32
        love.graphics.draw(Image.frame, x, y)
        local k = math.max(0, selected - 13)
        local h = 24
        for i = 1, 13 do
            local item = self.items[k+i]
            if item then
                if k+i == selected then
                    love.graphics.draw(Image.selector, x+2, y - 8 + i * h )
                    love.graphics.draw(Image.arrow, x+2, y - 4 + i * h )
                end
                local x,y = x+20, y + i * h
                love.graphics.print("  "..item.type.name, x,y)
                -- love.graphics.draw(item.type.img, x + 5, y +8,0,1,1,item.type.img:getWidth()/2, item.type.img:getHeight()/2)
                love.graphics.draw(
                    Image.tileset,
                    item.quad,
                    x + 5,
                    y + 8,
                    0, self.dir, 1, tilesize/2, tilesize/2
                )
                if item.equiped then
                    love.graphics.draw(Image.equip, x, y +8,0,1,1,Image.equip:getWidth()/2, Image.equip:getHeight()/2)
                end
            end
        end
    end

    entity.drawItemDetails = function(self)
        love.graphics.setColor(1,1,1)
        local x,y = 200, 32
        love.graphics.draw(Image.frame_big, x, y)
        local item = self.items[selected]
        if item then
            love.graphics.printf(item.type.description, x + 16, y + 16, 200)
        end
    end
    
    entity.drawMenu = function(self)
        love.graphics.draw(Image.itembox, 16, 16)
        love.graphics.draw(Image.weapon_icon, 16+5, 16+5)
        if self.equipment and self.equipment.weapon then
            -- love.graphics.draw(self.equipment.weapon.type.img, 16+4, 16+4)
            love.graphics.draw(
                    Image.tileset,
                    self.equipment.weapon.quad,
                    16+4,
                    16+4,
                    0, self.dir, 1, tilesize/2, tilesize/2
                )
        end
        if self.hideUI then return end
        self:drawInventory()
        self:drawItemDetails()
    end


    local ui = function(self, key)
        if key == "i" then
            self.hideUI = not self.hideUI
        end
        if key == "escape" and not self.hideUI then
            self.hideUI = not self.hideUI
        end
        if self.hideUI then
            return
        end
        if key == "down" then
            selected = selected + 1
            if selected > #self.items then
                selected = 1
            end
        end
        if key == "up" then
            selected = selected - 1
            if selected == 0 then
                selected = #self.items
            end
        end
        if key == "return" then
            local item = self.items[selected]
            if not item then return end
            item:use(self)
            if selected > #self.items then selected = #self.items end
        end
        -- use items
        if #key == 1 then
            local k = 0
            for i=1, 9 do
                local item = self.items[i]
                if item then
                    k = k + 1
                    if k == tonumber(key) then
                        item:use(self)
                        del(self.items, item)
                    end
                end
            end
        end
    end

    add(entity.keypressed, function(self, key)
        ui(self, key)
    end)
end