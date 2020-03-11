--Static Object

local StaticObject = {}

StaticObject.__index = StaticObject


function StaticObject:init(path)
	self.name = path
	self.image = love.graphics.newImage(path)
	self.baseCenterX = self.image:getWidth() / 2
	self.baseOffset = (self.image:getHeight() / 3) * 2
	self.baseCenterY = ((self.image:getHeight() - self.baseOffset) / 2) + self.baseOffset
	self.dying = false
end

function StaticObject:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function StaticObject:setX(x)
	self.x = x
end

function StaticObject:setY(y)
	self.y = y
end

function StaticObject:setPos(x, y)
	self.x = x
	self.y = y
end

function StaticObject:getX()
	return self.x
end

function StaticObject:getY()
	return self.y
end

function StaticObject:getBaseCentreY()
	return self.y + self.baseCenterY
end

function StaticObject:getBottomY()
	return self.y + self.baseCenterY
end

function StaticObject.new(path)
  local self = setmetatable({}, StaticObject)
  self:init(path)

  return self
end

return StaticObject