local Camera = require "hump.camera"
local cameralerp = require "lib.cameralerp"
local Timer = (require "hump.timer")

local Hero      = require "gameobjects.hero"
local Mob    = require "gameobjects.mob"
local Items    = require "gameobjects.items"
local Map       = require "gameobjects.map"
local dijkstramap = require "lib.dijkstramap"

local entities, map, cam, hero, castle, effects

local game = {}
function game:init()
    
    cam = Camera()
    game.cam = cam

    hero = Hero(game)
    game.hero = hero
    game.hero:addItem(Items.Sword(game))
    for i=1, 20 do
        if i%2 == 0 then
            game.hero:addItem(Items.Potion(game))
        end
    end

    
    cameralerp.init(cam, hero)
    entities = {}
    add(entities, hero)
    game.entities = entities
    
    map = Map(game)
    game.map = map

    effects = {}
    game.effects = effects

    for i=1, 10 do
        add(entities, Mob(game, i*2, 25))
    end
    for i=1, 10 do
        for j=1, 5 do
            if map.isWalkable(2+i*8, 2+j*8) and math.random() < 0.2 then
                add(entities, Items.Potion(game, 2+i*8, 2+j*8))
            end
        end
    end
end

function game:update(dt)
    Timer.update(dt)
    cameralerp.update(cam, hero, dt)
end

function game:draw()
    love.graphics.clear()
    map:predraw()
    cam:attach()
    map:draw()
    
    table.sort(entities, function(a,b) return a.z+a.zfight<b.z+b.zfight end)
    for ent in all(entities) do
        ent:draw()
    end
    map:drawLight()
    cam:detach()

    for effect in all(effects) do
        effect:draw()
    end
    
    
    hero:drawUI()
end

function game:keypressed(...)
    for ent in all(entities) do
        for f in all(ent.keypressed) do
            f(ent, ...)
        end
    end
end

function game:turn()
    dijkstramap.update(game, entities)
    for ent in all(entities) do
        ent:turn()
    end
    map.lightrefresh = true
end

return game