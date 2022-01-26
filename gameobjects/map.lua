local Tile = require("gameobjects.tile")
local bresenham = require("lib.bresenham.bresenham")

local w = require "lib.tilesize"
local h = require "lib.tilesize"

local Map = function(game)
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

    map.lightrefresh = true
    map.lights = {
        {x = 20, y = 30},
    }

    local canvas, lightcanvas

    map.predrawLights = function(self)
        if not map.lightrefresh then return end
        map.lightrefresh = false
        local cachedCanvas = love.graphics.getCanvas()
        lightcanvas = lightcanvas or love.graphics.newCanvas(maxWidth, maxHeight)
        love.graphics.setCanvas(lightcanvas)
        love.graphics.clear()
        local lightmap = {}

        local d = 5
        for i =-d,d do
            for j=-d,d do
                bresenham.los(game.hero.x,game.hero.y,game.hero.x+i,game.hero.y+j, function(x,y)
                    lightmap[x..","..y] = 1
                    if not map.isWalkable(x,y) then return false end
                    return true
                end)
            end
        end

        for i=0, mw do
            for j=0,mh do
                local c = 0
                local a = lightmap[i..","..j] or 0
                for _, v in ipairs(map.lights) do
                    a = a + math.min(5/(math.abs(v.x - i)^2 + math.abs(v.y - j)^2), 1)
                end
                -- if a < 0.2 then a = 0 end
                love.graphics.setColor(c,c,c,1-a)
                love.graphics.rectangle("fill", i*20, j*20, 20, 20)
            end
        end
        
        love.graphics.setCanvas(cachedCanvas)
    end
    map.predraw = function(self)
        map:predrawLights()
        if canvas and not map.refresh then return end
        map.refresh = false
        local cachedCanvas = love.graphics.getCanvas()

        canvas = canvas or love.graphics.newCanvas(maxWidth, maxHeight)
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
        love.graphics.setCanvas(cachedCanvas)
    end
    map.draw = function()
        love.graphics.setColor(1,1,1)
        love.graphics.draw(canvas, 0,0)
    end

    map.drawLight = function(self)
        love.graphics.setColor(1,1,1)
        love.graphics.draw(lightcanvas)
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