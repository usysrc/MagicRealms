local Dialove = require "lib.dialove.Dialove"
local Gamestate = require "lib.hump.gamestate"

local dialogManager

local dialog = {}

dialog.init = function()
    dialogManager = Dialove.init({
        font = love.graphics.newFont('fonts/monogram.ttf', 16)
    })
end

dialog.enter = function(self, prev)
    dialogManager:show({text = "lets go"})
end

dialog.update = function(self, dt)
    dialogManager:update(dt)
end

dialog.draw = function()
    love.graphics.setCanvas()
    dialogManager:draw()
end

dialog.keypressed = function(self, k)
    if k == 'return' or k == 'space' then
        -- dialogManager:pop()
        Gamestate.pop()
    end
end

return dialog