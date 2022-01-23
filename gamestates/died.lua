

local died = {}

died.draw = function()
    love.graphics.clear()
    love.graphics.print("YOU DIED", 250, 150)
end

return died