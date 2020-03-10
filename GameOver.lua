--Game Over
local this = {}

function this:init()
	this.image = love.graphics.newImage('Resources/Backgrounds/GameOver.png')
end

function this:draw()
	love.graphics.draw(this.image, 0, 0)
end

function this:reset()
end

function this:update(dt) 
end

function this:keyreleased( key )
	return "Levels/TownGate"
end

function this:keypressed(key)
end

return this