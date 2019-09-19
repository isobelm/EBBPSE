-- Timer
local Timer = {}

Timer.__index = Timer


function Timer:init(folder)
	self.frame = 0
	self.second = 0
end

function Timer:draw()
	self.animations[self.direction]:draw(self.x, self.y)
end

function Timer:setAnimationSpeed(speed)
	for d, animation in pairs(self.animations) do
		animation:setFrameRate(speed)
	end
end

function setDirection( direction )
	self.direction = direction
end

function Timer.new(folder)
  local self = setmetatable({}, Timer)
  self:init(folder)

  return self
end

return Timer