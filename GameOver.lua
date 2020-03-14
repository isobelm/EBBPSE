--Game Over
local GameOver = {}

GameOver.__index = GameOver

function GameOver:init()
	self.image = love.graphics.newImage('Resources/Backgrounds/GameOver.png')
	self.dirty = true
end

function GameOver:draw()
	if self.dirty then
		love.graphics.draw(self.image, 0, 0)
		self.dirty = false
	end
end

function GameOver:reset()
end

function GameOver:update(dt) 
end

function GameOver:keyreleased( key )
	-- return "Levels/TownGate"
end

function GameOver:keypressed(key)
end

function GameOver.new(player)
	local self = setmetatable({}, GameOver)
	self:init()
	return self
end

setmetatable(GameOver,{__index = GameScreen})


return GameOver