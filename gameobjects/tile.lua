

local Image = require "lib.image"

local TilePreset = function(name, img, walkable, flags)
    
    local fl = {}
    if flags then
        for flag in all(flags) do
            fl[flag] = true
        end
    end

    return {
        name = name,
        img = img,
        walkable = walkable,
        flags = fl
    }
end

local tiles = {
    TilePreset("grass", Image.flowertile, true),
    TilePreset("grass", Image.tile, true),
    TilePreset("grass", Image.grass, true),
    TilePreset("block", Image.block, false, {"block"}),
    TilePreset("block", Image.verticalblock, false, {"block"}),
}

local Tile = function(id)
    local preset = tiles[id]

    local tile = {}

    tile.name = preset.name
    tile.img = preset.img
    tile.walkable = preset.walkable
    tile.flags = preset.flags
    tile.id = id

    return tile
end

return Tile