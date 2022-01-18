local Bloodsmear = require "gameobjects.bloodsmear"

return function(entity)
    entity.die = function(self)
        add(self.game.entities, Bloodsmear(self.game, self.x, self.y, self.dir))
        del(self.game.entities, self)
    end
end