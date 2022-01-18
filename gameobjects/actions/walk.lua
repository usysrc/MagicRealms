local Timer = require "hump.timer"

return function(entity)
    entity.walkinto = function(self, x,y,tx,ty)
        local found = false
        for ent in all(self.game.entities) do
            if ent ~= self and ent.x == tx and ent.y == ty and ent.z == self.z then
                ent:walkon(self)
                found = not ent:walkonable()
            end
        end
        if not found then
            entity.x = entity.x + x
            entity.y = entity.y + y
        end
    end

    entity.move = function(self, x, y)
        local tx, ty = entity.x + x, entity.y + y
        if self.game.map.isWalkable(tx, ty) then
            self:walkinto(x,y,tx,ty)
        end
        entity:done()
    end

    entity.done = function(self)

    end

    -- gets walked on by other
    entity.walkon = function(self, other)
        self:hit(other)
    end

    -- gets hit by other
    entity.hit = function(self, other)
        self.hp = self.hp - other.attack
        if self.hp <= 0 then self:die() end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end

    entity.addItem = function(self, item)
        add(self.items, item)
    end
end