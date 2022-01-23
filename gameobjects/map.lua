local Tile = require("gameobjects.tile")

local w = require "lib.tilesize"
local h = require "lib.tilesize"

local Map = function()
    local data = {}

    local map = {}

    -- the actual size in tiles
    local mw, mh = 100, 50

    -- the maximum canvas size
    local maxWidth, maxHeight = 2048, 2048

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
        if canvas and not map.refresh then return end
        map.refresh = false
        canvas = love.graphics.newCanvas(maxWidth, maxHeight)
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