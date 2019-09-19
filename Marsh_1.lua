-- Marsh_1

local GameScreen = require "GameScreen"

local Marsh_1 = {}

Marsh_1.__index = Marsh_1


function Marsh_1:initMarsh_1()
end

function Marsh_1:initObjects()
	self.objects = {}

end

function Marsh_1.new(player)
 	local self = setmetatable({}, Marsh_1)
 	self:init("Resources/Areas/Marsh_1", player)
 	self:initMarsh_1();

 	return self
end

setmetatable(Marsh_1,{__index = GameScreen})

return Marsh_1