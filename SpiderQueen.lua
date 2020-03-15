-- SpiderQueen
local Body = require "Body"
local Sprite = require "Sprite"


local SpiderQueen = {}

SpiderQueen.__index = SpiderQueen


function SpiderQueen:initSpiderQueen()
	self.spiderCount = 1
	self.speed = 0.1
	self.magicLossSpeed = 700
	self.maxSpiders = 5
	self.type = "spider"
end

function SpiderQueen:addSpider()
	if self.spiderCount < self.maxSpiders then
		self.speed = self.speed + 0.025
		self.spiderCount = self.spiderCount + 1
		
		if self.spiderCount == self.maxSpiders then
			self.magicLossSpeed = self.magicLossSpeed + 700
			return "+0.025 speed\n\t+700 magic retention\n\tYour body has improved as much as it can by adding spiders."
		else
			return "+0.025 speed\n\tspider count: " .. self.spiderCount
		end
	else
		return "This was of no bebefit"
	end
end

function SpiderQueen.new()
 	local self = setmetatable({}, SpiderQueen)
 	self:init("Resources/Player/Spider_1")
 	self:initSpiderQueen();

 	return self
end

setmetatable(SpiderQueen,{__index = Body})

return SpiderQueen