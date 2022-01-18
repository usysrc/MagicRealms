--[[
Copyright (c) 2022, usysrc

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
]]--


local Entity = require "gameobjects.entity"

local Draw = require "gameobjects.actions.draw"
local Walk = require "gameobjects.actions.walk"
local Keyboard = require "gameobjects.actions.keyboard"
local UI = require "gameobjects.actions.ui"
local Die = require "gameobjects.actions.die"
local Done = require "gameobjects.actions.done"

local Hero = function(game)

    local hero = Entity()
    hero.game = game
    hero.hideUI = true
    hero.items = {}
    hero.x = 15
    hero.y = 25
    hero.z = 100
    hero.color = {1,1,1}
    hero.maxhp = 100
    hero.hp = hero.maxhp
    hero.attack = 10
    
    Draw(hero, "hero")
    Walk(hero)
    Keyboard(hero)
    UI(hero)
    Die(hero)
    Done(hero)

    return hero
end

return Hero