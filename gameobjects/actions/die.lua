local Gamestate = require "hump.gamestate"
local diedState = require "gamestates.died"

return function(entity)
    entity.die = function()
        Gamestate.switch(diedState)
    end
end