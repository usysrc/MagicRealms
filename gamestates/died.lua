local Gamestate = require "lib.hump.gamestate"

local died = {}

died.draw = function()
    love.graphics.clear()
    love.graphics.print("YOU DIED", 250, 150)
end

died.keypressed = function(self, key)
    if key == "escape" then
        love.event.quit()
    end
end

return died