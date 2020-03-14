-- SpiderQueen
local Body = require "Body"
local Sprite = require "Sprite"


local SpiderQueen = {}

SpiderQueen.__index = SpiderQueen


function SpiderQueen:initSpiderQueen()
	self.spiderCount = 1
	self.speed = 0.1
	self.magicLossSpeed = 700
	self.type = "spider"
end

function SpiderQueen:addSpider()
	self.speed = self.speed + 0.1
end

function SpiderQueen.new()
 	local self = setmetatable({}, SpiderQueen)
 	self:init("Resources/Player/Spider_1")
 	self:initSpiderQueen();

 	return self
end

setmetatable(SpiderQueen,{__index = Body})

return SpiderQueen