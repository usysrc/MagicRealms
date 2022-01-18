return function(entity)
    entity.items = {}

    local move = function(self, key)
        local x,y = 0, 0
        if key == "left"    then x = -1; self.dir = -1 end
        if key == "right"   then x = 1; self.dir = 1 end
        if key == "up"      then y = -1 end
        if key == "down"    then y = 1  end
        if x ~= 0 or y ~= 0 then 
            entity:move(x,y)
        elseif key == "." then
            entity:turn()
        end
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
        -- use items
        if #key == 1 then
            local k = 0
            for item in all(self.items) do
                k = k + 1
                if k == tonumber(key) then
                    item:use(self)
                    del(self.items, item)
                end
            end
        end
    end

    entity.keypressed = function(self, key)
        ui(self, key)
        if not self.hideUI then return end
        move(self, key)
    end
end