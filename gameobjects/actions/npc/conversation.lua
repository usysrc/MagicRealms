local Gamestate = require "lib.hump.gamestate"
local dialog = require "gamestates.dialog"

return function(entity)
    entity.walkon = function()
        Gamestate.push(dialog, {
            title = "Gysberth",
            text = "hey, how are you doing? I am bit tired from working all day in the brickyard. I am sure looking forward to a nice cold one in the alehouse.",
        })
    end
end