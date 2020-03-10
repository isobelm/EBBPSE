--TownGate

GameScreen = require "GameScreen"
Spider = require "Spider"
StaticObject = require "StaticObject"

local TownGate = {}
TownGate.__index = TownGate


function TownGate:initTownGate()
	self.name = "Levels/TownGate"
	self.portals = {}
	self.portals.red = nil
	self.portals.green = "Levels/Marsh_1"
	self.player.portals = self.portals
	self.dirty = true
end

function TownGate:reset()
	love.graphics.setFont(self.font)
	self.dirty = true
end

function TownGate:initObjects()
	self.objects = {}
	self.objects[3] = StaticObject.new('Resources/Sprites/StaticObjects/tree_left.png')
	self.objects[3]:setPos(24, 32)
	self.objects[1] = StaticObject.new('Resources/Sprites/StaticObjects/tree_right.png')
	self.objects[1]:setPos(248, 75)
	self.objects[2] = StaticObject.new('Resources/Sprites/StaticObjects/full_wall.png')
	self.objects[2]:setPos(0, 10)
end

function TownGate:update(dt)
	self.timer = self.timer + dt
	-- print(self.timer)
	GameScreen.update(self, dt)
	if self.timer > 2000 and self.spider == nil then
		self:createSpider()
	end
	if (self.spider) then
		if self.spider:getX() == 410 and self.spider:getDirection() == 'l' then
			self.spider:setDirection("u")
		elseif self.spider:getY() == 100 and self.spider:getDirection() == 'u' then
			self.spider:setDirection("l")
		elseif self.spider:getX() < 0 then
			self.spider = nil
		end
	end
	return self.player:update()
end

function TownGate:draw()
	GameScreen.draw(self)
	if (self.spider ~= nil) then
	self.spider:draw()
	end
end

function TownGate:createSpider()
	self.spider = Spider.new(self.player, self.name)
	self.spider:setX(400)
	self.spider:setY(192)
	self.spider:setDirection("l")
	self.spider.moving = true
	table.insert(self.objects, self.spider)
	table.insert(self.interactables, self.spider)
end


function TownGate.new(player)
	local self = setmetatable({}, TownGate)
	self:init("Resources/Areas/TownGate", player)
	self:initTownGate()
	return self
end

function TownGate:keypressed( key )
	GameScreen.keypressed( self, key )
end

setmetatable(TownGate,{__index = GameScreen})


return TownGate