--TownGate

GameScreen = require "GameScreen"
Spider = require "Spider"
StaticObject = require "StaticObject"

local TownGate = {}
TownGate.__index = TownGate


function TownGate:initTownGate()
	self.name = "Levels/TownGate"
	self.portals.green = "Levels/Marsh_1"
	self.player.portals = self.portals
	self.dirty = true
end

function TownGate:reset()
	love.graphics.setFont(self.font)
	self.dirty = true
end

function TownGate:newScreen(portal)
	if (portal == "Levels/Marsh_1") then
		self.player:setX(400 - self.player:getX() - player:getWidth())
	end
	self = nil
end

function TownGate:initObjects()
	local tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_left.png')
	tmpObj:setPos(24, 32)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/tree_right.png')
	tmpObj:setPos(248, 75)
	table.insert(self.objects, tmpObj)
	tmpObj = StaticObject.new('Resources/Sprites/StaticObjects/full_wall.png')
	tmpObj:setPos(0, 10)
	table.insert(self.objects, tmpObj)

end

function TownGate:update(dt)
	local tmp = GameScreen.update(self, dt)
	if tmp ~= nil then return tmp end
	if self.timer > 2 and self.timer < 2.01 and self.spider == nil then
		self:createSpider()
	end
	if (self.spider) then
		if math.modf(self.spider:getX()) == 215 and self.spider:getDirection() == 'l' then
			self.spider:setDirection("u")
		elseif math.modf(self.spider:getY()) == 80 and self.spider:getDirection() == 'u' then
			self.spider:setDirection("l")
		elseif self.spider:getX() < 0 then
			self.spider = nil
		end
	end
end

function TownGate:draw()
	GameScreen.draw(self)
end

function TownGate:createSpider()
	self.spider = Spider.new(self.player, self.name)
	self.spider:setX(400)
	self.spider:setY(192)
	self.spider:setDirection("l")
	self.spider:setMoving(true)
	table.insert(self.objects, self.spider)
	table.insert(self.interactables, self.spider)
end

function TownGate:keypressed( key )
	GameScreen.keypressed( self, key )
end

function TownGate.new(player)
	local self = setmetatable({}, TownGate)
	self:init("Resources/Areas/TownGate", player)
	self:initTownGate()
	return self
end

setmetatable(TownGate,{__index = GameScreen})

return TownGate