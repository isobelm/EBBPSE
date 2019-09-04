--Body
local Sprite = require "Sprite"

local Body = {}

Body.__index = Body


function Body:init(folder, setDebug)
	self.sprite = Sprite.new(folder)
	self.speed = 1
	self.magicLossSpeed = 600
	self.setDebug = setDebug
end

function Body:draw()
	self.sprite:draw()
end


--Getters and setters

function Body:getType()
	return self.type
end

function Body:getX()
	return self.sprite.x
end

function Body:getY()
	return self.sprite.y
end

function Body:setX(x)
	self.sprite.x = x
end

function Body:setY(y)
	self.sprite.y = y
end

function Body:getHeight()
	return self.sprite.height
end

function Body:getWidth()
	return self.sprite.width
end

function Body:setAnimationSpeed(speed)
	self.sprite:setAnimationSpeed(speed)
end

function Body:setDirection( direction )
	self.sprite:setDirection(direction)
end

function Body:setBaseOffset(offset)
	self.sprite:setBaseOffset(offset)
end

function Body:getBaseOffset()
	return self.sprite:getBaseOffset()
end

function Body:getBaseCentreY()
	return self.sprite:getBaseCentreY()
end

function Body:getBaseCentreX()
	return self.sprite:getBaseCentreX()
end

function Body:getBottomY()
	return self.sprite:getBottomY()
end


--Constructor

function Body.new(folder)
  local self = setmetatable({}, Body)
  self:init(folder)

  return self
end

return Body