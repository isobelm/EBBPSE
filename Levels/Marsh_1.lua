-- Marsh_1

local GameScreen = require "GameScreen"

local Marsh_1 = {}

Marsh_1.__index = Marsh_1


function Marsh_1:initMarsh_1()
end

function Marsh_1:initObjects()
	self.objects = {}
	local tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_big.png')
	tmpObj:setPos(210, -74)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_big.png')
	tmpObj:setPos(0, 16)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_left.png')
	tmpObj:setPos(219, 74)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_right.png')
	tmpObj:setPos(330, 47)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_right.png')
	tmpObj:setPos(234, 190)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/bush.png')
	tmpObj:setPos(26, 39)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/bush.png')
	tmpObj:setPos(135, 22)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/bush.png')
	tmpObj:setPos(153, 69)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/bush.png')
	tmpObj:setPos(296, 69)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/bush.png')
	tmpObj:setPos(80, 163)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/bush.png')
	tmpObj:setPos(58, 259)
	table.insert(self.objects, tmpObj)

end

function Marsh_1.new(player)
 	local self = setmetatable({}, Marsh_1)
 	self:init("Resources/Areas/Marsh_1", player)
 	self:initMarsh_1();

 	return self
end

setmetatable(Marsh_1,{__index = GameScreen})

return Marsh_1