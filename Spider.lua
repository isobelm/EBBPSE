-- Spider
local Sprite = require "Sprite"
local Directions = require "Directions"
local Interaction = require "Interaction"

local Spider = {}

Spider.__index = Spider


function Spider:init(player, screen)
	self.sprite = Sprite.new("Resources/Sprites/Spider")
	self.sprite:setAnimationSpeed(60)
	self.speed = 0.1
	self.moving = false
	self.player = player
	self.interactionOptionText = {"eat", "incorporate", "leave be"}
	self.screen = screen
	self.dying = false
end

function Spider:eat() 
	self.player.magic = self.player.magic + 25
	self:die()
end

function Spider:incorporate() 
	self.player.magic = self.player.magic - 20
	if (self.player.magic > 0) then
		if self.player:getBodyType() == "SpiderQueen" then
			self.player:getBody():addSpider()
		else
			self.player:setBodyType("SpiderQueen")
		end
	end
	self:die()
end

function Spider:die() 
	self.dying = true
end

function Spider:interactionOptions(selected)
	if selected == 1 then
		self:eat()
	elseif selected == 2 then
		self:incorporate()
	end
end

function Spider:draw()
	self.sprite:draw()
	self.dirty = false
end

function Spider:update()
	if self.moving then
		self:move()
		-- self.sprite:update()
		-- if self.sprite.dirty == true then
		-- 	self.dirty = true
		-- end
	end
	self.sprite:update()
	if self.sprite.dirty then
		self.dirty = true
	end
end

function Spider:move()
	direction = self.sprite.direction
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

function Spider:setX(x)
	if (math.modf(x) ~= math.modf(self.sprite.x)) then
		self.dirty = true
	end
	self.sprite.x = x
end

function Spider:setY(y)
	if (math.modf(y) ~= math.modf(self.sprite.y)) then
		self.dirty = true
	end
	self.sprite.y = y
end

function Spider:getX()
	return self.sprite.x
end

function Spider:getY()
	return self.sprite.y
end

function Spider:setDirection( direction )
	if (direction ~= self.direction) then
		self.dirty = true
	end
	self.sprite:setDirection(direction)
end

function Spider:getDirection()
	return self.sprite.direction
end

function Spider:getInteraction()
	return Interaction.new("a spider", "Resources/Images/spider_big_no_line.png", self.interactionOptionText, self.interactionOptions, self.screen, self)
end

function Spider:getBottomY()
	return self.sprite:getBottomY()
end

function Spider:getBaseCentreY()
	return self.sprite:getBaseCentreY()
end

function Spider:getBaseCentreX()
	return self.sprite:getBaseCentreX()
end

function Spider:setMoving(moving)
	self.moving = moving
	self.sprite:setMoving(moving)
end

function Spider.new(player, screen)
  local self = setmetatable({}, Spider)
  self:init(player, screen)

  return self
end

return Spider