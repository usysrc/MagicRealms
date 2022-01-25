local Image = require "lib.image"

return function()
    local itemType = {}
    itemType.img = Image.sword
    itemType.name = "Dark Sword"
    itemType.type = "sword"
    itemType.attack = 50
    itemType.description = string.format("A sword stolen from the mounts by grave robbers. Attack: %d", itemType.attack)
    itemType.use = function(self, entity, item)
        if entity.equipment.weapon == item then
            entity.equipment.weapon = nil
            item.equiped = false
        else
            if entity.equipment.weapon then entity.equipment.equiped = false end
            entity.equipment.weapon = item
            item.equiped = true
        end
    end
    return itemType
end
