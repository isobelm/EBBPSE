--Static Object

local Tree = {}

Tree.__index = Tree


function Tree:init(left)
	if left == true then
		self.image = love.graphics.newImage('Resources/Sprites/Tree/tree_left.png')
	else
		self.image = love.graphics.newImage('Resources/Sprites/Tree/tree_right.png')
	end
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