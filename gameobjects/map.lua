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

local Tile = require("gameobjects.tile")

local w = 24
local h = 24

local Map = function()
    local data = {}

    local map = {}
    local mw, mh = 100, 50

    local generateMap = function(mw, my)
        for i=1, mw do
            for j=1, mh do
                    data[i..","..j] = Tile(1)
            end
        end
    
        for n=1, 500 do
            local i = math.random(5, mw)
            local j = math.random(0, mh)
            local len = math.random(1, 3)
            local oi, oj, di, dj = 0, 0, 0, 0
            if math.random() < 0.5 then
                di = 1
            else
                dj = 1
            end
            -- if math.random() < 0.5 then
            --     di, dj = -di, -dj
            -- end
            local t = 2
            while len >= 0 do
                len = len - 1
                oi = oi + di
                oj = oj + dj
                data[(i+oi)..","..(j+oj)] = Tile(t)
            end
        end
    end

    generateMap(mw, mh)

    map.isWalkable = function(x,y)
        local tile = data[x..","..y]
        return tile and tile.walkable
    end

    local canvas
    map.predraw = function(self)
        if canvas then return end
        canvas = love.graphics.newCanvas(8192, 8192)
        love.graphics.setCanvas(canvas)
        love.graphics.setColor(1,1,1)
        for i=1, 100 do
            for j=1, 100 do
                local tile = map.get(i, j)
                if tile then
                    love.graphics.draw(tile.img, i * w, j * h)
                end
            end
        end
        love.graphics.setCanvas()
    end
    map.draw = function()
        love.graphics.setColor(1,1,1)
        love.graphics.draw(canvas, 0,0)
    end

    map.get = function(x,y)
        return data[x..","..y]
    end

    map.set = function(x,y, id)
        data[x..","..y] = Tile(id)
    end

    

    return map
end

return Map