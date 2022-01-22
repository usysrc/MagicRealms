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
     

    add(entity.keypressed, function(self, key)
        if not self.hideUI then return end
        move(self, key)
    end)
end