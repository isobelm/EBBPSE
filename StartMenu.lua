--Start menu
local StartMenu = {}

StartMenu.__index = StartMenu

function StartMenu:init()
	self.image = love.graphics.newImage('Resources/Backgrounds/StartMenu.png')
	self.dirty = true
end

function StartMenu:draw()
	if self.dirty then
		love.graphics.draw(self.image, 0, 0)
		love.graphics.printf("Press any key to start", 0, 250, 800, 'center')
		self.dirty = false
	end
end 

function StartMenu:reset()
end

function StartMenu:update(dt) 
end

function StartMenu:keyreleased( key )
	return "Levels/TownGate"
end

function StartMenu:keypressed(key)
end

return StartMenu