local Gamestate = require "lib.hump.gamestate"
local game = require "gamestates.game"

local loading = {}
local count
loading.enter = function()
    count = 0
end

loading.update = function(dt)
    -- wait a frame to switch to the game
    count = count + 1
    if count == 2 then
        Gamestate.switch(game)
    end
end

loading.draw = function()
    love.graphics.clear()
    love.graphics.print("Loading Game", 250, 150)
end

return loading