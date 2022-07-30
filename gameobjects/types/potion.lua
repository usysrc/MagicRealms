local Image = require "lib.image"

return function()
    local itemType = {}
    itemType.tileID = 50 
    itemType.name = "HP Potion"
    itemType.type = "potion"
    itemType.amount = 50
    itemType.description = string.format("An effervescent concotion made after a very old recipe. Drink it to restore %s health points.", itemType.amount)
    itemType.use = function(self, entity, item)
        entity.hp = math.min(entity.maxhp, entity.hp + itemType.amount)
        del(entity.items, item)
    end
    return itemType
end
