--[[
Copyright (c) 2022, usysrc

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
]]--

local Image = require "lib.image"
local Timer = (require "hump.timer")

local tilesize = require "lib.tilesize"

local addOrbEffect = function(game, tx, ty, mx, my)
    local cx, cy = game.cam:cameraCoords(tx * tilesize, ty * tilesize)
    local obj = {
        x = cx + tilesize/4,
        y = cy + tilesize/4,
        draw = function(self)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(Image.orb, self.x, self.y)
        end
    }
    add(game.effects, obj)
    Timer.after(math.random()*0.1,function()
    Timer.tween(0.5+math.random()*0.1, obj, {x = mx * tilesize + tilesize/2, y = my * tilesize + tilesize/2}, 'in-out-quad', function()
        del(game.effects, obj)
    end) end)
end

return addOrbEffect