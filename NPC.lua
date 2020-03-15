-- NPC
local Sprite = require "Sprite"
local Directions = require "Directions"
local Interaction = require "Interaction"

local NPC = {}

NPC.__index = NPC


function NPC:init(player, screen, type)
    Sprite.init(self, type)
	self.name = "NPC"
	self:setAnimationSpeed(60)
    self.moving = false
    self.speed = 0
	self.player = player
	self.screen = screen
    self.dying = false
    self.autopilot = true
    self.maxStep = 100
    self.minStep = 50
    self.currentStep = 0
end

function NPC:die() 
	self.dying = true
	self.dirty = true
end

function NPC:update()
	if self.moving then
        self:move()
    elseif self.autopilot then
        self:moveOnAuto()
	end
	Sprite.update(self)
end

function NPC:moveOnAuto()
    if self.currentStep <= 0 then
        local i = math.random(4)
        if i == 1 then self:setDirection(Directions.up)
        elseif i == 2 then self:setDirection(Directions.right)
        elseif i == 3 then self:setDirection(Directions.down)
        else self:setDirection(Directions.left)
        end
        self.currentStep = math.random(self.minStep, self.maxStep)
    else
        if self:canMove(self.direction) then
            self:move()
        else
            self.currentStep = 0
		end
	end
end

function NPC:move()
	direction = self.direction
	if direction == Directions.up then
		self:setY(self:getY() - self.speed)
	elseif direction == Directions.down then
		self:setY(self:getY() + self.speed)
	elseif direction == Directions.right then
		self:setX(self:getX() + self.speed)
	elseif direction == Directions.left then
		self:setX(self:getX() - self.speed)
	end
end


function NPC:canMove(direction)
	-- print("canMove")
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
			if r == 0 and g == 0 and b == 0 then
				return false
			end
		end
	end

	return true
end

function NPC:setX(x)
	if (math.modf(x) ~= math.modf(self.x)) then
		self.dirty = true
	end
	self.x = x
end

function NPC:setY(y)
	if (math.modf(y) ~= math.modf(self.y)) then
		self.dirty = true
	end
	self.y = y
end

function NPC:getX()
	return self.x
end

function NPC:getSpeed()
	return self.speed
end

function NPC:getY()
    return self.y
end

function NPC:getWidth()
    return self.width
end

function NPC:getHeight()
    return self.height
end

function NPC:getDirection()
    return self.direction
end

function NPC:getInteraction()
	return Interaction.new(self.title, self.interactionImage, self.interactionOptionText, self.interactionOptions, self.screen, self)
end

function NPC.new(player, screen)
  local self = setmetatable({}, NPC)
  self:init(player, screen)
  return self
end

setmetatable(NPC,{__index = Sprite})


return NPC