-- Spider
local NPC = require "NPC"

local BigSpider = {}

BigSpider.__index = BigSpider


function BigSpider:init(player, screen)
	NPC.init(self, player, screen, "Resources/Sprites/BigSpider")
	self.speed = 0.1
	self.name = "big spider"
	self.title = "a big spider"
	self.interactionImage = "Resources/Images/spider_big_no_line.png"
	self:setAnimationSpeed(60)
	self.interactionOptionText = {"eat", "incorporate", "leave be"}
	self.damage = 40
	self.hostile = true
	self:setMovement("hostile")
end

function BigSpider:update()
	NPC.update(self)
	if (self.player.body.type == "bigSpider" ) or
			(self.player.body.type == "spider" and self.player.body.spiderCount >= 5) then
		self:setMovement("random")
	else
		self:setMovement("hostile")
	end
end


function BigSpider:incorporate() 
	local explanation
	self.player.magic = self.player.magic - 40
	if (self.player.magic > 0) then
		explanation = "You have incorporated the big spider.\n\t-40 magic\n\t"
		if self.player:getBodyType() == "bigSpider" then
			explanation = explanation .. self.player:getBody():addSpider()
		else
			self.player:setBodyType("Bodies/BigSpiderBody")
			explanation = explanation .. "New Body Acquired!"
		end
	else
		explanation = "You do not have enough magic."
	end
	self:die()
	return explanation
end


function BigSpider:interactionOptions(selected)
	if selected == 1 then
		return self:eat(50)
	elseif selected == 2 then
		return self:incorporate()
	else 
		return "You left the big spider alone."
	end
end

function BigSpider.new(player, screen)
  local self = setmetatable({}, BigSpider)
  self:init(player, screen)

  return self
end

setmetatable(BigSpider, {__index = NPC})

return BigSpider