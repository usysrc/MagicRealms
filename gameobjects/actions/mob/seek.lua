local rndselect = require "lib.randomselect"
local dijkstramap = require "lib.dijkstramap"

return function(entity)
    entity.turn = function(self)
        if math.random() < 0.1 then
            self:move(rndselect{{-1,0}, {0, 1}, {0, -1}} )
            return self
        end

        local guys = {}
        for guy in all(self.game.entities) do
            if guy ~= self.game.hero and guy ~= self and guy.z == self.z then
                guys[guy.x..","..guy.y] = guy
            end
        end

        local tx, ty = 0, 0
        local num = dijkstramap.get(self.x, self.y) or 100000
        local lower = function(x,y)
            if guys[x..","..y] then return end
            local t = dijkstramap.get((self.x+x), (self.y+y))
            local found = t and t < num
            if found then num = t end
            return found
        end
        if num then
            local dir = {
                x = 0,
                y = 0
            }
            if lower(-1, 0) then
                dir.x = -1
                dir.y = 0
            end
            if lower(1, 0) then
                dir.x = 1
                dir.y = 0
            end
            if lower(0, -1) then
                dir.x = 0
                dir.y = -1
            end
            if lower(0, 1) then
                dir.x = 0
                dir.y = 1
            end
            tx = dir.x
            ty = dir.y
        end
        self:move(tx, ty)
    end
end