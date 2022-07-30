local Camera = require "lib.hump.camera"
local cameralerp = require "lib.cameralerp"
local Timer = require "lib.hump.timer"
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
    hero.x, hero.y = 54,60
    game.hero = hero
    game.hero:addItem(Items.Sword(game))
    for i=1, 4 do
        game.hero:addItem(Items.Potion(game))
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
        add(entities, Mob(game, i*2, 5))
    end
    for i=0, 3 do
        for j=0, 3 do
            add(entities, Items.Potion(game, 2+i*8, 2+j*8))
        end
    end
end

function game:update(dt)
    Timer.update(dt)
    cameralerp.update(cam, hero, dt)
end

function game:draw()
    love.graphics.clear()
    
    cam:attach(nil,nil,nil,nil,true)
    map:draw()
    
    table.sort(entities, function(a,b) return a.z+a.zfight<b.z+b.zfight end)
    for ent in all(entities) do
        ent:draw()
    end
    cam:detach()

    for effect in all(effects) do
        effect:draw()
    end
    
    hero:drawUI()
    love.graphics.setCanvas()
    love.graphics.print("(i) inventory | (.) wait", 0, love.graphics.getHeight()-16)
end

function game:keypressed(key)
    if key == "q" then
        love.event.quit()
    end
    for ent in all(entities) do
        if not ent.locked then
            for f in all(ent.keypressed) do
                f(ent, key)
            end
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
