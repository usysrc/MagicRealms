

local Image = require "lib.image"
local tiles = {}
local TilePreset = function(id, name, img, walkable, flags)
    local fl = {}
    if flags then
        for flag in all(flags) do
            fl[flag] = true
        end
    end

    local preset = {
        name = name,
        img = img,
        walkable = walkable,
        flags = fl
    }
    tiles[id] = preset
    return preset
end

TilePreset(1, "grass", Image.flowertile, true)
TilePreset(2, "grass", Image.tile, true)
TilePreset(3, "grass", Image.grass, true)
TilePreset(4, "block", Image.block, false, {"block"})
TilePreset(5, "block", Image.verticalblock, false, {"block"})
TilePreset(6, "plank", Image.plank, true)

local Tile = function(id)
    local preset = tiles[id]
    if not preset then error(string.format("no preset found for id, id might be nil, value is %s", id)) end
    
    local tile = {}

    tile.name = preset.name
    tile.img = preset.img
    tile.walkable = preset.walkable
    tile.flags = preset.flags
    tile.id = id

    return tile
end

return Tile