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
end

function Sprite:draw()
	self.animations[self.direction]:draw(self.x, self.y, self.moving)
end

--Getters and Setters
function Sprite:setAnimationSpeed(speed)
	for d, animation in pairs(self.animations) do
		animation:setFrameRate(speed)
	end
end

function Sprite:setDirection( direction )
	self.direction = direction
end

function Sprite:setBaseOffest(offset)
	self.baseOffset = offset
	self.baseCenterY = ((self.height - self.baseOffset) / 2) + self.baseOffset
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


--Constructor
function Sprite.new(folder)
  local self = setmetatable({}, Sprite)
  self:init(folder)

  return self
end

return Sprite