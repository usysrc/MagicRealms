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

local Timer = require "hump.timer"

local randomselect = require "lib.randomselect"
local Image = require "lib.image"
local Entity = require "gameobjects.entity"
local NotFound = require "gameobjects.types.notfound"

local Item = function(game, x, y, ItemType)
    -- local tile = game.map.get(x,y)
    -- if tile and not tile.walkable then return end

    local item = Entity()
    item.type = ItemType and ItemType() or NotFound()

    item.use = function(self, entity)
        self.type:use(entity)
    end

    item.x = x or 40
    item.y = y or 25
    item.color = {1,1,1}

    item.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(self.type.img, self:getX(), self:getY())
        love.graphics.setColor(1,1,1)
    end

    item.walkon = function(self, other)
        other:addItem(self)
        del(game.entities, self)
    end

    item.walkinto = function(self, x, y, tx, ty)
    end

    return item
end

return Item