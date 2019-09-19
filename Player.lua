--Player
-- local Animation = require "Animation"
local Head = require "Head"

local Player = {}

Player.__index = Player

local INTERACTIVE_DIST = 32

function Player:init(setDebug)
	self.body = Head.new(setDebug)
	self:setX(200)
	self:setY(150)
	self.magic = 100
	self.setDebug = setDebug
	self.timer = 0
end

function Player:draw()
	self.body:draw()
end

function Player:canMove(direction)
	if direction == "right" then
		if math.modf(self:getX() + self:getSpeed()) == math.modf(self:getX()) then
			return true
		elseif self:getX() + self:getSpeed() + self:getWidth() > love.graphics.getWidth() then
			return false
		end
		for j = self:getY() + self:getBaseOffset(), self:getY() + self:getHeight() do
			if j >= 0 and j < love.graphics.getHeight() then
				local r, g, b, a = self.objectMap:getPixel(self:getX() + self:getWidth() + self:getSpeed(), j)
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

	elseif direction == "left" then
		if math.modf(self:getX() - self:getSpeed()) == math.modf(self:getX()) then
			return true
		elseif (self:getX() - self:getSpeed()) < 0 then
			return false
		end
		for j = self:getY() + self:getBaseOffset(), self:getY() + self:getHeight() do
			if j >= 0 and j < love.graphics.getHeight() then
				local r, g, b, a = self.objectMap:getPixel(self:getX() - self:getSpeed(), j)
				if r == 1 and g == 0 and b == 0 then
					return self.portals.red
				elseif g == 1 and r == 0 and b == 0 then
					return self.portals.green
				elseif b == 1 and g == 0 and r == 0 then
					return self.portals.blue
				elseif r == 0x0 and g == 0x0 and b == 0x0 then
					return false
				end
			end
		end

	elseif direction == "up" then
		if math.modf(self:getY() + self:getBaseOffset() - self:getSpeed()) == math.modf(self:getY() + self:getBaseOffset()) then
			return true
		elseif (self:getY() + self:getBaseOffset() - self:getSpeed()) < 0 then
			return false
		end
		for i = self:getX(), self:getX() + self:getWidth() do
			if i >= 0 and i < love.graphics.getWidth() then
				local r, g, b, a = self.objectMap:getPixel(i, self:getY() + self:getBaseOffset() - self:getSpeed())
				if r == 1 and g == 0 and b == 0 then
					return self.portals.red
				elseif g == 1 and r == 0 and b == 0 then
					return self.portals.green
				elseif b == 1 and g == 0 and r == 0 then
					return self.portals.blue
				elseif r == 0x0 and g == 0x0 and b == 0x0 then
					return false
				end
			end
		end

	elseif direction == "down" then
		if math.modf(self:getY() + self:getBaseOffset() + self:getSpeed()) == math.modf(self:getY() + self:getBaseOffset()) then
			return true
		elseif self:getY() + self:getSpeed() + self:getHeight() > love.graphics.getHeight() then
			return false
		end
		for i = self:getX(), self:getX() + self:getWidth() do
			if i >= 0 and i < love.graphics.getWidth() then
				local r, g, b, a = self.objectMap:getPixel(i, self:getY() + self:getSpeed() + self:getHeight())
				if r == 1 and g == 0 and b == 0 then
					return self.portals.red
				elseif g == 1 and r == 0 and b == 0 then
					return self.portals.green
				elseif b == 1 and g == 0 and r == 0 then
					return self.portals.blue
				elseif r == 0x0 and g == 0x0 and b == 0x0 then
					return false
				end
			end
		end
	end

	return true
end

function Player:setObjectMap( objectMap )
	self.objectMap = objectMap
end

function Player:update(dt)
	if love.keyboard.isDown('right') or love.keyboard.isDown('left') or love.keyboard.isDown('up') or love.keyboard.isDown('down') or
			love.keyboard.isDown('w') or love.keyboard.isDown('a') or love.keyboard.isDown('s') or love.keyboard.isDown('d') then
		self.body.moving = true
		if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
			self:setDirection("r")
			local canMove = self:canMove("right")
			if canMove == true then
				self:setX(self:getX() + self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end
		elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
			self:setDirection("l")
			local canMove = self:canMove("left")
			if (canMove ~= true) then
				self.setDebug(canMove)
			end
			if canMove == true then
				self:setX(self:getX() - self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end
		elseif love.keyboard.isDown('up') or love.keyboard.isDown('w') then  
			self:setDirection("u")
			local canMove = self:canMove("up")
			if canMove == true then
				self:setY(self:getY() - self:getSpeed())
			elseif canMove ~= false then
				return canMove
			end
		elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
			self:setDirection("d")
			local canMove = self:canMove("down")
			if canMove == true then
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
		end
	end

	self.timer = self.timer + 1
end

function Player:keyreleased( key, interactables)
	self.body.moving = true

	if (key == "space") then
		print ("space Released")
		local closest = nil
		local closestDist = 0;
		local length = table.getn(interactables)
		print (length)
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
function Player.new(setDebug)
  local self = setmetatable({}, Player)
  self:init(setDebug)

  return self
end

return Player