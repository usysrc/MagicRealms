return function(entity)
    add(entity.keypressed, function(self, key)
        if key == "." then
           self:done() 
        end
    end)
end