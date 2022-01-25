return function(entity)
    entity.items = {}
    entity.equipment = {}
    entity.addItem = function(self, item)
        add(self.items, item)
    end
end