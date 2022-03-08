

local Timer = require "lib.hump.timer"

local Entity = require "gameobjects.entity"

local Stats = require "gameobjects.actions.mob.stats"
local Draw = require "gameobjects.actions.draw"
local Walk = require "gameobjects.actions.walk"
local Die = require "gameobjects.actions.mob.die"
local Inventory = require "gameobjects.actions.inventory"
local Conversation = require "gameobjects.actions.npc.conversation"

local NPC = function(game, x,y)

    local npc = Entity()
    npc.game = game
    npc.type = "npc"
    npc.x = x or 40
    npc.y = y or 25

    Stats(npc)
    Draw(npc, "bandit")
    Walk(npc)
    Die(npc)
    Inventory(npc)
    Conversation(npc)

    return npc
end

return NPC