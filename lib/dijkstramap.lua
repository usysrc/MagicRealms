local dijkstramap

local calculate = function(game, entities)
    
    local guys = {}
    for ent in all(entities) do
        if ent ~= game.hero then
            guys[ent.x..","..ent.y] = true
        end
    end

    dijkstramap = {}

    local x = game.hero.x
    local y = game.hero.y
    local k = 0
    local check 
    check = function(x, y, k)
        local t = dijkstramap[x..","..y]
        if game.map.isWalkable(x, y) and (not t or k < t) and not guys[x..","..y] then
            dijkstramap[x..","..y] = k
        else
            return
        end
        if k > 20 then return end
        check(x+1, y, k+1)
        check(x-1, y, k+1)
        check(x, y+1, k+1)
        check(x, y-1, k+1)
    end
    check(x, y, k)
end

local map = {}

map.update = calculate
map.get = function(x,y)
    if dijkstramap ~= nil then
        return dijkstramap[x..","..y]
    end
end

return map