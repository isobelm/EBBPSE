--TestFile
local TestFile = {}
TestFile.__index = TestFile

local image = love.graphics.newImage('Resources/Player/player.png')

function TestFile:init()
	self.x = 0
	self.y = 0
end

function TestFile:draw()
	love.graphics.draw(image, self.x, self.y)
end

function TestFile:setPos( x, y )
	self.x = x
	self.y = y
end

function TestFile.new()
  local self = setmetatable({}, TestFile)
  self:init()

  return self
end

return TestFile