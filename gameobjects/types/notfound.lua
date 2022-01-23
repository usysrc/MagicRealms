

local Image = require "lib.image"

return function()
    local itemType = {}
    itemType.img = Image.notfound
    itemType.name = "notfound"
    itemType.type = "notfound"
    itemType.description = ""
    return itemType
end
