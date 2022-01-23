

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