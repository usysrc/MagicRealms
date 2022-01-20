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
    TilePreset("grass", Image.tile, true),
    TilePreset("block", Image.block, false, {"breakable"}),
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