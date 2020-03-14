--Start menu
local StartMenu = {}

StartMenu.__index = StartMenu

StartMenu.background = love.graphics.newImage('Resources/Backgrounds/interaction.png')
StartMenu.menuOption = love.graphics.newImage('Resources/Images/menuOption.png')
StartMenu.selectedMenuOption = love.graphics.newImage('Resources/Images/selectedMenuOption.png')

function StartMenu:init()
	self.image = love.graphics.newImage('Resources/Backgrounds/StartMenu.png')
	self.options = {"New Game", "Continue Game"}
	self.selected = 1
	self.dirty = true
end

function StartMenu:draw()
	if self.dirty then
		love.graphics.draw(self.image, 0, 0)
		for i=1, table.getn(self.options) do
			self:drawOption(self.options[i], i, self.selected == i)
		end
		-- love.graphics.printf("Press any key to start", 0, 250, 800, 'center')
		self.dirty = false
	end
end

function StartMenu:drawOption(text, pos, isSelected)
	if isSelected then
		love.graphics.draw(StartMenu.selectedMenuOption, 224, 169 + pos * 65)
	else
		love.graphics.draw(StartMenu.menuOption, 224, 169 + pos * 65)
	end
	love.graphics.printf(text, 64, 169 + 15 + pos * 65, 672, 'center')
end

function StartMenu:newScreen()
	self = nil
end

function StartMenu:reset()
end

function StartMenu:update(dt) 
end

function StartMenu:keyreleased( key )
		if key == "up" then
			if (self.selected > 1) then
				self.selected = self.selected - 1
			end
		elseif key == "down" then
			if (self.selected < table.getn(self.options)) then
				self.selected = self.selected + 1
			end
		elseif key == "space" or key == "return" then
			return "Levels/TownGate"
		end
	self.dirty = true;
end

function StartMenu:keypressed(key)
end

return StartMenu