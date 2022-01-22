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

local NotFound = require "gameobjects.types.notfound"
local Potion = require "gameobjects.types.potion"
local Sword = require "gameobjects.types.sword"
local Item = require "gameobjects.item"

local make = function(ItemType)
    return function(game, x, y)
        return Item(game, x, y, ItemType)
    end
end

return {
    ["NotFound"] = make(NotFound),
    ["Potion"] = make(Potion),
    ["Sword"] = make(Sword),
}