--Static Object

local Tree = {}

Tree.__index = Tree


function Tree:init(left)
	if left == true then
		self.image = love.graphics.newImage('Resources/Sprites/Tree/tree_left.png')
	else
		self.image = love.graphics.newImage('Resources/Sprites/Tree/tree_right.png')
	end
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.baseCentreX = self.width / 2
	self.baseOffset = (self.height / 3) * 2
	self.baseCentreY = ((self.height - self.baseOffset) / 2) + self.baseOffset
end

function Tree:setBaseOffest(offset)
	self.baseOffset = offset
	self.baseCenterY = ((self.height - self.baseOffset) / 2) + self.baseOffset
end

function Tree:getBaseOffset()
	return self.baseOffset
end

function Tree:getBaseCentreY()
	return self.y + self.baseCentreY
end

function Tree:getBaseCentreX()
	return self.x + self.baseCentreX
end

function Tree:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function Tree:setX(x)
	self.x = x
end

function Tree:setY(y)
	self.y = y
end

function Tree:setPos(x, y)
	self.x = x
	self.y = y
end

function Tree:getX()
	return self.x
end

function Tree:getY()
	return self.y
end

function Tree.new(left)
  local self = setmetatable({}, Tree)
  self:init(left)

  return self
end

return Tree