return function(entity)
    entity.items = {}
    entity.addItem = function(self, item)
        add(self.items, item)
    end
end