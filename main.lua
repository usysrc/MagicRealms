require "lib.table"

local system = require "system"
local Gamestate = require "lib.hump.gamestate"
local loading = require "gamestates.loading"


function love.load()
    -- love.profiler = require('lib.profile.profile') 
    -- love.profiler.start()
    math.randomseed(os.time())
    Gamestate.registerEvents()
    Gamestate.switch(loading)
end

love.frame = 0
function love.update()
    -- love.frame = love.frame + 1
    -- if love.frame%200 == 0 then
    --     love.report = love.profiler.report(20)
    --     love.profiler.reset()
    -- end
end

function love.draw()
    -- print(love.report or "Please wait...")˚
end
