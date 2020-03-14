--Start menu
local StartMenu = {}

StartMenu.__index = StartMenu

StartMenu.background = love.graphics.newImage('Resources/Backgrounds/interaction.png')
StartMenu.dialogueOption = love.graphics.newImage('Resources/Images/dialogueOption.png')
StartMenu.selectedDialogueOption = love.graphics.newImage('Resources/Images/selectedDialogueOption.png')

function StartMenu:init()
	self.image = love.graphics.newImage('Resources/Backgrounds/StartMenu.png')
	self.options = {"New Game", "Continue Game"}
	self.selected = 1
	self.dirty = true
end

function StartMenu:draw()
	if self.dirty then
		love.graphics.draw(self.image, 0, 0)
		for i=1,length do
			self:drawOption(self.optionText[i], i, self.selected == i)
		end
		love.graphics.printf("Press any key to start", 0, 250, 800, 'center')
		self.dirty = false
	end
end

function Interaction:drawOption(text, pos, isSelected)
	if isSelected then
		love.graphics.draw(StartMenu.selectedDialogueOption, 48, 356 + pos * 56)
	else
		love.graphics.draw(StartMenu.dialogueOption, 48, 356 + pos * 56)
	end
	love.graphics.printf(text, 64, 368 + pos * 56, 672, 'left')
end

function StartMenu:newScreen()
	self = nil
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