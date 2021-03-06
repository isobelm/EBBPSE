--Sprite
local Animation = require "Animation"
local Directions = require "Directions"

local Sprite = {}

Sprite.__index = Sprite


function Sprite:init(folder)
	self.x = 0
	self.y = 0
	self.direction = Directions.down
	local tmpFolder = folder .. "/" 
	self.animations = {}
	self.animations[Directions.up] = Animation.new(tmpFolder .. "up")
	self.animations[Directions.down] = Animation.new(tmpFolder .. "down")
	self.animations[Directions.right] = Animation.new(tmpFolder .. "right")
	self.animations[Directions.left] = Animation.new(tmpFolder .. "left")
	self.height = self.animations[Directions.up]:getHeight()
	self.width = self.animations[Directions.up]:getWidth()
	self.baseCentreX = self.width / 2
	self.baseOffset = (self.height / 3) * 2
	self.baseCentreY = ((self.height - self.baseOffset) / 2) + self.baseOffset
	self.moving = true
	self.dirty = true
	self.disheveled = false
	self.maxDishevelmentTime = 15
	self.timeOfDishevelment = self.maxDishevelmentTime
end

function Sprite:draw()
	self.animations[self.direction]:draw(self.x, self.y, self.moving)
	self.dirty = false
	self.disheveled = false
	self.timeOfDishevelment = self.maxDishevelmentTime
end

function Sprite:update()
	if self.disheveled  then
		self.timeOfDishevelment = self.timeOfDishevelment - 1
	end
	if self.timeOfDishevelment == 0 then
		self.dirty = true
	end
	self.animations[self.direction]:update()
	if self.animations[self.direction].dirty == true then
		self.disheveled = true
	end
end

--Getters and Setters
function Sprite:setAnimationSpeed(speed)
	for d, animation in pairs(self.animations) do
		animation:setFrameRate(speed)
	end
end

function Sprite:setDirection( direction )
	self.direction = direction
	self.disheveled = true
end

function Sprite:setBaseOffest(offset)
	self.baseOffset = offset
	self.baseCenterY = ((self.height - self.baseOffset) / 2) + self.baseOffset
	self.disheveled = true
end

function Sprite:getBaseOffset()
	return self.baseOffset
end

function Sprite:getBaseCentreY()
	return self.y + self.baseCentreY
end

function Sprite:getBaseCentreX()
	return self.x + self.baseCentreX
end

function Sprite:getBottomY()
	return self.y + self.baseCentreY
end

function Sprite:setMoving(moving)
	self.moving = moving
	for d, animation in pairs(self.animations) do
		animation.moving = moving
	end
	self.animations[self.direction].moving = moving
end

--Constructor
function Sprite.new(folder)
  local self = setmetatable({}, Sprite)
  self:init(folder)

  return self
end

return Sprite