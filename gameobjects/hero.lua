local Entity = require "gameobjects.entity"

local Stats = require "gameobjects.actions.herostats"
local Draw = require "gameobjects.actions.draw"
local Walk = require "gameobjects.actions.walk"
local Keyboard = require "gameobjects.actions.keyboard"
local UI = require "gameobjects.actions.ui"
local Die = require "gameobjects.actions.die"
local Done = require "gameobjects.actions.done"
local Inventory = require "gameobjects.actions.inventory"

local Hero = function(game)

    local hero = Entity()
    hero.game = game
    hero.x = 15
    hero.y = 25
    hero.z = 100
    
    Stats(hero)
    Inventory(hero)
    Draw(hero, "hero")
    Walk(hero)
    Keyboard(hero)
    UI(hero)
    Die(hero)
    Done(hero)

    return hero
end

return Hero