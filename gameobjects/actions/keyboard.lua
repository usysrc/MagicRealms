return function(entity)
    entity.items = {}

    local move = function(self, key)
        local x,y = 0, 0
        if key == "left" or key == "h" then x = -1; self.dir = -1 end
        if key == "right" or key == "l"  then x = 1; self.dir = 1 end
        if key == "up" or key == "k" then y = -1 end
        if key == "down" or key == "j" then y = 1  end
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
