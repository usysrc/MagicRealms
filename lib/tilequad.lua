local tilesize = require "lib.tilesize"
local Image = require "lib.image"

return function(tileID)
    local w = math.floor(Image.tileset:getWidth()/tilesize)
    local i,j = math.floor(tileID%w), math.floor(tileID/w)
    return love.graphics.newQuad(i*tilesize, j*tilesize, tilesize, tilesize, Image.tileset:getWidth(), Image.tileset:getHeight())
end