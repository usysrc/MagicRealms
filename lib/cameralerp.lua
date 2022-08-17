local Timer = require "lib.hump.timer"
local display = require "display.display"

local calcTarget = function(cam, obj)
    local tx = (obj:getX()) 
    local ty = (obj:getY()) 
    return tx, ty
end

local options = {}
options.xMax = 0
options.yMax = math.huge

local init = function(cam, obj, xMax, yMax)
    cam.x, cam.y = calcTarget(cam, obj)
    options.xMax = xMax or options.xMax
    options.yMax = yMax or options.yMax
end

local update = function(cam, obj, dt, speed)
    local speed = 3
    local tx, ty = calcTarget(cam, obj)
    cam.x = cam.x + (tx - cam.x) * dt * speed
    cam.y = cam.y + (ty - cam.y) * dt * speed
    cam.x = math.floor(cam.x*1000)/1000
    cam.y = math.floor(cam.y*1000)/1000
    if cam.x - love.graphics.getWidth()/2 < 0 then cam.x = options.xMax end
    --if cam.x > options.max then options.max = cam.x end
end

local turn = function(cam)
   
end

return {
    init = init,
    update = update,
    turn = turn
}
