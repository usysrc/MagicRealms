return function(entity)
    entity.done = function(self)
        self.game:turn()
    end
end