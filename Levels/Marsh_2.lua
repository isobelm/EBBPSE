-- Marsh_2

local GameScreen = require "GameScreen"
local Spider = require "NPCs/Spider"
local BigSpider = require "NPCs/BigSpider"

local Marsh_2 = {}

Marsh_2.__index = Marsh_2


function Marsh_2:initMarsh_2()
	self.dirty = true
	self.portals.red = "Levels/Marsh_1"
	self.player.portals = self.portals
	self.maxDisheveled = table.getn(self.interactables)

end

function Marsh_2:newScreen(portal)
	if (portal == "Levels/Marsh_1") then
		self.player:setX(400 - self.player:getX() - player:getWidth())
	end
		self = nil
end

function Marsh_2:initObjects()
	self:addStaticObject('Resources/Sprites/StaticObjects/tree_big_right.png', 211, 4)
	self:addStaticObject('Resources/Sprites/StaticObjects/tree_big_left.png', 179, 155)
	self:addStaticObject('Resources/Sprites/StaticObjects/bush.png', 99, 159)
	self:addStaticObject('Resources/Sprites/StaticObjects/bush.png', 95, 261)
	self:addStaticObject('Resources/Sprites/StaticObjects/bush.png', 336, 261)
	self:addStaticObject('Resources/Sprites/StaticObjects/bush.png', 364, 104)


	for i = 1, math.random(2) do
		tmpObj = Spider.new(self.player, self.name)
		tmpObj:setMovement("random")
		self:placeRandomly(tmpObj)
		tmpObj.objectMap = self.objectMap
		table.insert(self.objects, tmpObj)
		table.insert(self.interactables, tmpObj)
	end

	for i = 1, math.random(5) do
		tmpObj = BigSpider.new(self.player, self.name)
		tmpObj:setMovement("random")
		self:placeRandomly(tmpObj)
		tmpObj.objectMap = self.objectMap
		table.insert(self.objects, tmpObj)
		table.insert(self.interactables, tmpObj)
	end
end

function Marsh_2.new(player)
 	local self = setmetatable({}, Marsh_2)
 	self:init("Resources/Areas/Marsh_2", player)
 	self:initMarsh_2();

 	return self
end

setmetatable(Marsh_2,{__index = GameScreen})

return Marsh_2