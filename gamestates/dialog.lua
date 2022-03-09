local Gamestate = require "lib.hump.gamestate"
local display = require "display.display"
local Image = require "lib.image"
local Sfx = require "lib.sfx"
local Timer = require "lib.hump.timer"

local pos, text
local speed = 30
local timer

local dialog = {}
dialog.init = function() 
    timer = Timer.new()
end

local startRevealText = function()
    local showText
    showText = function()
        timer:after(0.01, function()
            if text:sub(pos,pos)~=" " then
                Sfx.typing:play()
            end
            pos = pos + 1
            if pos <= #text then
                showText()
            end
        end)
    end
    showText()
end

dialog.enter = function(self, prev, data)
    pos = 0
    text = data.text
    timer:clear()
    startRevealText()    
end

dialog.update = function(self, dt)
    timer:update(dt)
    
end

dialog.draw = function(self)
    love.graphics.draw(Image.framehori, 0, display:getHeight() - 64)
    love.graphics.print(string.sub(text, 1, pos), 100, display:getHeight() - 50) 
end

dialog.keypressed = function(self, k)
    if k == 'return' or k == 'space' then
        Gamestate.pop()
    end
end

return dialog