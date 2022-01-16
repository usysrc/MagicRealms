local Timer = require "hump.timer"
local display = require "display.display"

local calcTarget = function(cam, obj)
    local tx = (obj:getX()) + love.graphics.getWidth()/4
    local ty = (obj:getY()) + love.graphics.getHeight()/4
    return tx, ty
end

local options = {}
options.max = 0
options.xperturn = 12

local init = function(cam, obj)
    cam.x, cam.y = calcTarget(cam, obj)
    options.max = cam.x
end

local update = function(cam, obj, dt, speed)
    local speed = 3
    local tx, ty = calcTarget(cam, obj)
    cam.x = cam.x + (tx - cam.x) * dt * speed
    cam.y = cam.y + (ty - cam.y) * dt * speed
    -- if cam.x < options.max then cam.x = options.max end
    -- if cam.x > options.max then options.max = cam.x end
end

local turn = function(cam)
    Timer.tween(0.25, options, {max = options.max + options.xperturn})
end

return {
    init = init,
    update = update,
    turn = turn
}