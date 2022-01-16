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

local Timer = require "hump.timer"

local rndselect = require "lib.randomselect"
local Image = require "lib.image"
local Entity = require "gameobjects.entity"
local Bloodsmear = require "gameobjects.bloodsmear"

local dijstramap = require "lib.dijkstramap"

local Mob = function(game, x,y)
    local tile = game.map.get(x,y)
    if tile and not tile.walkable then return end

    local mob = Entity()
    mob.type = "mob"
    mob.x = x or 40
    mob.y = y or 25
    mob.color = {1,1,1}

    -- stats
    mob.maxhp = 30
    mob.hp = mob.maxhp
    mob.attack = 8

    mob.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(Image.bandit, self:getX()+self.w/2, self:getY()+self.h/2, 0, self.dir, 1, self.w/2, self.h/2)
        love.graphics.setColor(1,1,1)
    end

    -- mob gets hit by other
    mob.hit = function(self, other)
        self.hp = self.hp - other.attack
        if self.hp <= 0 then
            add(game.entities, Bloodsmear(game, self.x, self.y, self.dir))
            del(game.entities, self)
        end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end

    -- mob gets walked on by other
    mob.walkon = function(self, other)
        self:hit(other)
    end

    mob.walkinto = function(self, x, y, tx, ty)
        local found = false
        for ent in all(game.entities) do
            if ent ~= self and ent.z == self.z and ent.x == tx and ent.y == ty then
                found = true
                if ent.type ~= self.type and ent.z == self.z then ent:walkon(self) end
            end
        end
        if not found then
            self.x = self.x + x
            self.y = self.y + y
        end
    end

    mob.move = function(self, x, y)
        if x < 0 then self.dir = -1 end
        if x > 0 then self.dir = 1 end
        local tx, ty = self.x + x, self.y + y
        if game.map.isWalkable(tx, ty) then
            self:walkinto(x,y,tx,ty)
        end
    end

    mob.turn = function(self)
        if math.random() < 0.1 then
            self:move(rndselect{{-1,0}, {0, 1}, {0, -1}} )
            return mob
        end

        local guys = {}
        for guy in all(game.entities) do
            if guy ~= game.hero and guy ~= self and guy.z == self.z then
                guys[guy.x..","..guy.y] = guy
            end
        end

        local tx, ty = 0, 0
        local num = dijstramap.get(self.x, self.y) or 100000
        local lower = function(x,y)
            if guys[x..","..y] then return end
            local t = dijstramap.get((self.x+x), (self.y+y))
            local found = t and t < num
            if found then num = t end
            return found
        end
        if num then
            local dir = {
                x = 0,
                y = 0
            }
            if lower(-1, 0) then
                dir.x = -1
                dir.y = 0
            end
            if lower(1, 0) then
                dir.x = 1
                dir.y = 0
            end
            if lower(0, -1) then
                dir.x = 0
                dir.y = -1
            end
            if lower(0, 1) then
                dir.x = 0
                dir.y = 1
            end
            tx = dir.x
            ty = dir.y
        end
        self:move(tx, ty)
    end
    return mob
end

return Mob