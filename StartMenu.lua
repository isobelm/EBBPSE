--Start menu
local this = {}

function this:init()
	this.image = love.graphics.newImage('Resources/Backgrounds/startMenu.png')
end

function this:draw()
	love.graphics.draw(this.image, 0, 0)
	love.graphics.printf("Press any key to start", 0, 250, 800, 'center')
end

function this:reset()
end

function this:update(dt) 
end

function this:keyreleased( key )
	return "TownGate"
end

return this