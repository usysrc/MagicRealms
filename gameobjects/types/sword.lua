local Image = require "lib.image"

return function()
    local itemType = {}
    itemType.img = Image.sword
    itemType.name = "Dark Sword"
    itemType.type = "sword"
    itemType.description = ""
    itemType.use = function(self, entity, item)
        if entity.weapon == item then
            entity.weapon = nil
            item.equiped = false
        else
            if entity.weapon then entity.weapon.equiped = false end
            entity.weapon = item
            item.equiped = true
        end
    end
    return itemType
end
