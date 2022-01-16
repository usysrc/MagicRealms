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

local Gamestate = require "hump.gamestate"
local diedState = require "gamestates.died"
local Timer = require "hump.timer"
local Image = require "lib.image"

local Entity = require "gameobjects.entity"
local Tile = require("gameobjects.tile")

local Hero = function(game)

    local hero = Entity()
    hero.hideUI = true
    hero.items = {}
    hero.x = 15
    hero.y = 25
    hero.z = 100
    hero.color = {1,1,1}

    hero.hp = 100
    hero.maxhp = 100
    hero.attack = 10

    hero.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(Image.hero, self:getX()+self.w/2, self:getY()+self.h/2, 0, self.dir, 1, self.w/2, self.h/2)
        love.graphics.setColor(1,1,1)
    end

    hero.walkinto = function(self, x,y,tx,ty)
        local found = false
        for ent in all(game.entities) do
            if ent ~= game.hero and ent.x == tx and ent.y == ty and ent.z == self.z then
                ent:walkon(self)
                found = not ent:walkonable()
            end
        end
        if not found then
            hero.x = hero.x + x
            hero.y = hero.y + y
        end
    end

    hero.move = function(self, x, y)
        local tx, ty = hero.x + x, hero.y + y
        if game.map.isWalkable(tx, ty) then
            self:walkinto(x,y,tx,ty)
        else
            -- breakTiles(tx, ty)
        end
        game:turn()
    end

    hero.keypressed = function(self, key)
        if key == "x" then
            self.hideUI = not self.hideUI
            return
        end
        local x,y = 0, 0
        if key == "left"    then x = -1; self.dir = -1 end
        if key == "right"   then x = 1; self.dir = 1 end
        if key == "up"      then y = -1 end
        if key == "down"    then y = 1  end
        if x ~= 0 or y ~= 0 then 
            hero:move(x,y)
        elseif key == "." then
            game:turn()
        end
        if not self.hideUI then
            if #key == 1 then
                local k = 0
                for item in all(self.items) do
                    k = k + 1
                    if k == tonumber(key) then
                        item:use(self)
                        del(self.items, item)
                    end
                end
            end
        end
        
    end

    hero.drawUI = function(self)
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle("fill", 100, 4, 100 * hero.hp/hero.maxhp, 16)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", 100, 4, 100, 16)
        love.graphics.setColor(1,1,1)
        if self.hideUI then return end
        local x,y = 460, 32
        love.graphics.draw(Image.frame, x, y)
        local k = 0
        for item in all(self.items) do
            k = k + 1
            local x,y = x+20, y + k*16
            love.graphics.print(k..")  "..item.name, x,y)
            love.graphics.draw(item.img, x + 5, y - 4)
        end
    end

    -- hero gets walked on by other
    hero.walkon = function(self, other)
        self:hit(other)
    end
 
    -- hero gets hit by other
    hero.hit = function(self, other)
        self.hp = self.hp - other.attack
        if self.hp <= 0 then Gamestate.switch(diedState) end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end

    hero.addItem = function(self, item)
        add(self.items, item)
    end

    return hero
end

return Hero