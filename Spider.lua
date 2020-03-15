-- Spider
local NPC = require "NPC"

local Spider = {}

Spider.__index = Spider


function Spider:init(player, screen)
	NPC.init(self, player, screen, "Resources/Sprites/Spider")
	self.speed = 0.1
	self.name = "spider"
	self.title = "a spider"
	self.interactionImage = "Resources/Images/spider_big_no_line.png"
	self:setAnimationSpeed(60)
	self.interactionOptionText = {"eat", "incorporate", "leave be"}
end

function Spider:eat() 
	self.player.magic = self.player.magic + 25
	self:die()
	return "You have eaten the spider.\n\t+ 25 magic"
end

function Spider:incorporate() 
	local explanation
	self.player.magic = self.player.magic - 20
	if (self.player.magic > 0) then
		explanation = "You have incorporated the spider.\n\t- 20 magic\n\t"
		if self.player:getBodyType() == "spider" then
			self.player:getBody():addSpider()
			explanation = explanation .. "+ 0.1 speed"
		else
			self.player:setBodyType("SpiderQueen")
			explanation = explanation .. "New Body Acquired!"
		end
	else
		explanation = "You do not have enough magic."
	end
	self:die()
	return explanation
end


function Spider:interactionOptions(selected)
	if selected == 1 then
		return self:eat()
	elseif selected == 2 then
		return self:incorporate()
	else 
		return "You left the spider alone."
	end
end

function Spider.new(player, screen)
  local self = setmetatable({}, Spider)
  self:init(player, screen)

  return self
end

setmetatable(Spider, {__index = NPC})

return Spider