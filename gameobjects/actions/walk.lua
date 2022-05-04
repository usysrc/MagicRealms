local Timer = require "lib.hump.timer"

return function(entity)

    entity.walkinto = function(self, x, y, tx, ty)
        local found = false
        for ent in all(self.game.entities) do
            if ent ~= self and ent.x == tx and ent.y == ty and ent.z == self.z then
                ent:walkon(self)
                found = true
            end
        end
        if not found then
            self:lock()
            entity.tx = -x
            entity.ty = -y
            entity.x = tx
            entity.y = ty
            entity.walkTweenHandle = Timer.tween(0.05, entity, {tx = 0, ty = 0}, "linear", function() 
                self:unlock()
                self:done()
            end)
        end
    end

    entity.move = function(self, x, y)
        local tx, ty = entity.x + x, entity.y + y
        if self.game.map.isWalkable(tx, ty) then
            self:walkinto(x, y, tx, ty)
        end
    end
    entity.done = function(self) end

    entity.lock = function(self)
        self.locked = true
    end
    entity.unlock = function(self)
        self.locked = false
    end

    -- gets walked on by other
    entity.walkon = function(self, other)
        self:hit(other)
    end

    entity.modifiers = {}

    entity.getAttack = function(self)
        local attack = self.attack
        for i,v in pairs(entity.equipment) do
            if v.type and v.type.attack then attack = attack + v.type.attack end
        end
        return attack
    end

    -- gets hit by other
    entity.hit = function(self, other)
        self.hp = self.hp - other:getAttack()
        if self.hp <= 0 then self:die() end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end
end