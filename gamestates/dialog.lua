local Gamestate = require "lib.hump.gamestate"
local display = require "display.display"
local Image = require "lib.image"
local Sfx = require "lib.sfx"
local Timer = require "lib.hump.timer"
local str = require "lib.str"

local pos, text, title
local speed = 30
local timer
local blink
local time

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
    time, blink = 0, 0
    pos = 0
    text = str.partition(data.text)
    title = data.title
    timer:clear()
    startRevealText()
end

dialog.update = function(self, dt)
    timer:update(dt)
    time = time + dt
    blink = math.sin(time*10)
end

dialog.draw = function(self)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(Image.framehori, 0, display:getHeight() - 64)
    if title then 
        love.graphics.print(title..":", 32, display:getHeight() - 52) 
    end
    love.graphics.print(string.sub(text, 1, pos), 100, display:getHeight() - 52)
    love.graphics.setColor(1,1,1, blink)
    love.graphics.draw(Image.downarrow, display:getWidth()/2, display:getHeight() - 16)
    love.graphics.setColor(1,1,1,1)
end

dialog.keypressed = function(self, k)
    if k == 'return' or k == 'space' then
        if pos < #text then
            timer:clear()
            pos = #text
        else
            Gamestate.pop()
        end
    end
end

return dialog