-- Marsh_1

local GameScreen = require "GameScreen"
local Spider = require "NPCs/Spider"

local Marsh_1 = {}

Marsh_1.__index = Marsh_1


function Marsh_1:initMarsh_1()
	self.dirty = true
	self.portals.red = "Levels/TownGate"
	self.portals.green = "Levels/Marsh_2"
	self.player.portals = self.portals
	self.maxDisheveled = table.getn(self.interactables)
end

function Marsh_1:newScreen(portal)
	if (portal == "Levels/TownGate" or portal == "Levels/Marsh_2") then
		self.player:setX(400 - self.player:getX() - player:getWidth())
	end
		self = nil
end

function Marsh_1:initObjects()
	local filePath = 'Resources/Sprites/StaticObjects/tree_big_right.png'
	self:addStaticObject(filePath, 210, -74)
	self:addStaticObject(filePath, 0, 16)

	filePath = 'Resources/Sprites/StaticObjects/tree_left.png'
	self:addStaticObject(filePath, 219, 74)
	self:addStaticObject(filePath, 330, 47)
	filePath = 'Resources/Sprites/StaticObjects/tree_right.png'
	self:addStaticObject(filePath, 234, 190)
	filePath = 'Resources/Sprites/StaticObjects/bush.png'
	self:addStaticObject(filePath, 26, 39)
	self:addStaticObject(filePath, 135, 22)
	self:addStaticObject(filePath, 153, 69)
	self:addStaticObject(filePath, 296, 69)
	self:addStaticObject(filePath, 80, 163)
	self:addStaticObject(filePath, 58, 259)

	for i = 1, math.random(5) do
		tmpObj = Spider.new(self.player, self.name)
		tmpObj:setMovement("random")
		self:placeRandomly(tmpObj)
		tmpObj.objectMap = self.objectMap
		table.insert(self.objects, tmpObj)
		table.insert(self.interactables, tmpObj)
	end
end

function Marsh_1.new(player)
 	local self = setmetatable({}, Marsh_1)
 	self:init("Resources/Areas/Marsh_1", player)
 	self:initMarsh_1();

 	return self
end

setmetatable(Marsh_1,{__index = GameScreen})

return Marsh_1