local Image = require "lib.image"

return function()
    local itemType = {}
    itemType.img = Image.potion
    itemType.name = "HP Potion"
    itemType.type = "potion"
    itemType.description = math.random(9)
    itemType.use = function(self, entity, item)
        entity.hp = math.min(entity.maxhp, entity.hp + 50)
        del(entity.items, item)
    end
    return itemType
end
