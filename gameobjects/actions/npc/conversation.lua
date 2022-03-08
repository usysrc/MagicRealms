local Gamestate = require "lib.hump.gamestate"
local dialog = require "gamestates.dialog"

return function(entity)
    entity.walkon = function()
        Gamestate.push(dialog)
    end
end