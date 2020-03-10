--Animation
local Animation = {}
Animation.__index = Animation

function Animation:init(folder)
	folderName = folder .. "/"
	files = love.filesystem.getDirectoryItems( folder )
	self.images = {}
	index = 0;
	for i, filename in pairs(files) do
		if filename ~= ".DS_Store" then
			self.images[index] = love.graphics.newImage(folderName .. filename)
			index = index + 1
		end
	end
	self.frame = 0
	self.currentImage = 0
	self.numberOfImages = table.getn(self.images) + 1
	self.frameRate = 100
	self.dirty = true
end

function Animation:setFrameRate(fr)
	self.frameRate = fr
end

function Animation:draw(x, y, moving)
	love.graphics.draw(self.images[self.currentImage], x, y)
	self.dirty = false
end

function Animation:update()
	-- print("update")
	-- print(self.frame)
	-- print(self.moving)
	if (self.frame >= self.frameRate) then
		self.currentImage = math.fmod(self.currentImage + 1, self.numberOfImages)
		self.frame = 0
		self.dirty = true
		-- print("update")
	end
	if (self.moving) then
		self.frame = self.frame + 1
	end
end

function Animation.new(folder)
  local self = setmetatable({}, Animation)
  self:init(folder)
  return self
end

function Animation:getHeight()
	return self.images[0]:getHeight()
end

function Animation:getWidth()
	return self.images[0]:getWidth()
end

return Animation