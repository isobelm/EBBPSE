--Interaction

local Interaction = {}

Interaction.__index = Interaction

function Interaction:init(objectName, objectImage, optionText, optionActions, screen, object)
	self.background = love.graphics.newImage('Resources/Backgrounds/interaction.png')
	self.dialogueOption = love.graphics.newImage('Resources/Images/dialogueOption.png')
	self.selectedDialogueOption = love.graphics.newImage('Resources/Images/selectedDialogueOption.png')
	self.font = love.graphics.newImageFont('Resources/Fonts/alphabet.png', "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789#.!?: +-", 2)
	love.graphics.setFont(self.font)
	self.objectName = objectName
	self.optionText = optionText
	self.optionActions = optionActions
	self.objectImage = love.graphics.newImage(objectImage)
	self.x = (800 - self.objectImage:getWidth()) / 2
	self.y = (332 - self.objectImage:getHeight()) / 2
	self.selected = 1;
	self.screen = screen
	self.object = object
	self.dirty = true
	self.choosing = true
	self.explanation = ""
end

function Interaction:draw()
	if (self.dirty) then
		love.graphics.draw(self.background, 0, 0)
		love.graphics.draw(self.objectImage, self.x, self.y)
		if (self.choosing) then
			love.graphics.printf("You have encountered " .. self.objectName .. ". What would you like to do?", 64, 332, 672, 'left')

			length = table.getn(self.optionText)
			for i=1,length do
				self:drawOption(self.optionText[i], i, self.selected == i)
			end
		else
			love.graphics.printf(self.explanation, 64, 332, 672, 'left')
		end
		self.dirty = false
	end

end

function Interaction:drawOption(text, pos, isSelected)
	if isSelected then
		love.graphics.draw(self.selectedDialogueOption, 48, 356 + pos * 56)
	else
		love.graphics.draw(self.dialogueOption, 48, 356 + pos * 56)
	end
	love.graphics.printf(text, 64, 368 + pos * 56, 672, 'left')
end

function Interaction:update(dt) 
	
end

function Interaction:keyreleased( key )
	if (self.choosing) then
		if key == "up" then
			if (self.selected > 1) then
				self.selected = self.selected - 1
			end
		elseif key == "down" then
			if (self.selected < table.getn(self.optionText)) then
				self.selected = self.selected + 1
			end
		elseif key == "space" or key == "return" then
			self.explanation = self.object:interactionOptions(self.selected)
			self.choosing = false
		end
	else
		if key == "space" or key == "return" then
			return "return"
		end
	end
	self.dirty = true;
end

function Interaction.new(objectName, objectImage, optionText, optionActions, screen, object)
  local self = setmetatable({}, Interaction)
  self:init(objectName, objectImage, optionText, optionActions, screen, object)

  return self
end

return Interaction