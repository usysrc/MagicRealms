-- Creates a proxy via rawset.
-- Credit goes to vrld: https://github.com/vrld/Princess/blob/master/main.lua
-- easier, faster access and caching of resources like images and sound
-- or on demand resource loading
local function Proxy(f)
	return setmetatable({}, {__index = function(self, k)
		local v = f(k)
		rawset(self, k, v)
		return v
	end})
end

-- Standard proxies
local image   = Proxy(function(k) return love.graphics.newImage('assets/img/' .. k .. '.png') end)
-- Sfx     = Proxy(function(k) return love.audio.newSource('sfx/' .. k .. '.ogg', 'static') end)
-- Music   = Proxy(function(k) return love.audio.newSource('music/' .. k .. '.ogg', 'stream') end)

return image