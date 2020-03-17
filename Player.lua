--Player
-- local Animation = require "Animation"
local Head = require "Bodies/Head"

local Player = {}

Player.__index = Player

local INTERACTIVE_DIST = 32

function Player:init()
	self.name = "player"
	self.body = Head.new()
	self:setX(200)
	self:setY(150)
	self.magic = 100
	self.timer = 0
	self.dirty = true
	self.hurt = false
	self.timeHurt = 0
end

function Player:draw()
	if (self.hurt) then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle( "fill", self:getX(), self:getY(), self:getWidth(), self:getHeight() )
		love.graphics.setColor(255, 255, 255, 255)
	else
		self.body:draw()
	end

	self.dirty = false
end

function Player:canMove(direction)
	local change = {0,0}
	local a, b, x, y
	if direction == "r" then
		change[0] = self:getSpeed()
		change[1] = 0
		a = self:getY() + self:getBaseOffset()
		b = self:getY() + self:getHeight()
	elseif direction == "l" then
		change[0] = -self:getSpeed()
		change[1] = 0
		a = self:getY() + self:getBaseOffset()
		b = self:getY() + self:getHeight()
	elseif direction == "u" then
		change[0] = 0
		change[1] = -self:getSpeed()
		a = self:getX()
		b = self:getX() + self:getWidth()
	elseif direction == "d" then
		change[0] = 0
		change[1] = self:getSpeed()
		a = self:getX()
		b = self:getX() + self:getWidth()
	end

	if math.modf(self:getX() + change[0]) == math.modf(self:getX())
			and math.modf(self:getY() + change[1]) == math.modf(self:getY()) then
		return true
	elseif self:getX() + self:getSpeed() + self:getWidth() > love.graphics.getWidth() then
		return false
	end
	for j = a, b do
		if direction == "u" or direction == "d" then 
			x = j
			if direction == "u" then
				y = self:getY() + self:getBaseOffset() - self:getSpeed()
			else
				y = self:getY() + self:getSpeed() + self:getHeight()
			end
		else
			y = j
			if direction == "r" then
				x = self:getX() + self:getWidth() + self:getSpeed()
			else
				x = self:getX() - self:getSpeed()
			end
		end
		if j >= 0 and j < love.graphics.getHeight() then
			local r, g, b, a = self.objectMap:getPixel(x, y)
			if r == 1 and g == 0 and b == 0 then
				return self.portals.red
			elseif g == 1 and r == 0 and b == 0 then
				return self.portals.green
			elseif b == 1 and g == 0 and r == 0 then
				return self.portals.blue
			elseif r == 0 and g == 0 and b == 0 then
				return false
			end
		end
	end
	return true
end

function Player:setObjectMap( objectMap )
	self.objectMap = objectMap
end

function Player:hit(damage)
	if self.hurt == false then
		self.magic = self.magic - damage
		self.hurt = true
	end
end

function Player:update(dt)
	if self.hurt then
		self.timeHurt = self.timeHurt + 1
		if self.timeHurt > 1000 then
			self.timeHurt = 0
			self.hurt = false
		end
	end

	self.body:update()

	if love.keyboard.isDown('right') or love.keyboard.isDown('left') or love.keyboard.isDown('up') or love.keyboard.isDown('down') or
			love.keyboard.isDown('w') or love.keyboard.isDown('a') or love.keyboard.isDown('s') or love.keyboard.isDown('d') then
		self.body:setMoving(true)
		if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
			local canMove = self:canMove("r")
			if canMove == true then
				if math.modf(self:getX() + self:getSpeed()) ~= math.modf(self:getX()) then
					self.dirty = true
				end
				self:setX(self:getX() + self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end
		elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
			local canMove = self:canMove("l")
			if (canMove ~= true) then
			end
			if canMove == true then
				if math.modf(self:getX() + self:getSpeed()) ~= math.modf(self:getX()) then
					self.dirty = true
				end
				self:setX(self:getX() - self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end
		elseif love.keyboard.isDown('up') or love.keyboard.isDown('w') then  
			local canMove = self:canMove("u")
			if canMove == true then
				if math.modf(self:getY() + self:getSpeed()) ~= math.modf(self:getY()) then
					self.dirty = true
				end
				self:setY(self:getY() - self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end
		elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
			local canMove = self:canMove("d")
			if canMove == true then
				if math.modf(self:getY() + self:getSpeed()) ~= math.modf(self:getY()) then
					self.dirty = true
				end
				self:setY(self:getY() + self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end

		end
	end

	if math.fmod(self.timer + 1, self:getMagicLossSpeed()) == 0 then
		self.magic = self.magic - 1;
		if self.magic <= 0 then
			return "GameOver"
		else
			self.dirty = true
		end
	end

	self.timer = self.timer + 1
end

function Player:keyreleased( key, interactables)
	self.body:setMoving(false)
	
	if (key == "space") then
		local closest = nil
		local closestDist = 0;
		local length = table.getn(interactables)
		for i=1,length do
			local object = interactables[i]
			local distance = math.sqrt((object:getBaseCentreY() - self:getBaseCentreY()) * (object:getBaseCentreY() - self:getBaseCentreY()) + (object:getBaseCentreX() - self:getBaseCentreX()) * (object:getBaseCentreX() - self:getBaseCentreX()))
			if distance <= INTERACTIVE_DIST then
				if (closest == nil or distance < closestDist) then
					closest = object
					closestDist = distance
				end
			end
		end

		if (closest ~= nil) then
			return "interaction", closest:getInteraction()
		end
	end
end

function Player:keypressed( key )
	self.body:setMoving(true)
	if (key == "w" or key == "up") then
		self:setDirection("u")
		self.dirty = true
	elseif (key == "d" or key == "right") then
		self:setDirection("r")
		self.dirty = true
	elseif (key == "s" or key == "down") then
		self:setDirection("d")
		self.dirty = true
	elseif (key == "a" or key == "left") then
		self:setDirection("l")
		self.dirty = true
	end
end


--Getters and Setters
function Player:getBody()
	return self.body
end

function Player:getBodyType()
	return self.body:getType()
end

function Player:setBodyType(type)
	local x = self.body:getX()
	local y = self.body:getY()
	local type = require (type)
	self.body = type.new()
	self.body:setX(x)
	self.body:setY(y)
end

function Player:getWidth()
	return self.body:getWidth()
end

function Player:getHeight()
	return self.body:getHeight()
end

function Player:getSpeed()
	return self.body.speed
end

function Player:getX()
	return self.body:getX()
end

function Player:getY()
	return self.body:getY()
end

function Player:getBaseCentreY()
	return self.body:getBaseCentreY()
end

function Player:getBaseCentreX()
	return self.body:getBaseCentreX()
end

function Player:getMagicLossSpeed()
	return self.body.magicLossSpeed
end

function Player:getBaseOffset()
	return self.body:getBaseOffset()
end

function Player:setX(x)
	self.body:setX(x)
end

function Player:setY(y)
	self.body:setY(y)
end

function Player:setDirection(d)
	self.body:setDirection(d)
end


--Constructor
function Player.new()
  local self = setmetatable({}, Player)
  self:init()

  return self
end

return Player
