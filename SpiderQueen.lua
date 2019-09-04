-- SpiderQueen
local Body = require "Body"
local Sprite = require "Sprite"


local SpiderQueen = {}

SpiderQueen.__index = SpiderQueen


function SpiderQueen:initHead()
	self.spiderCount = 1
	self.speed = 0.1
	self.magicLossSpeed = 700
	self.type = "spider"
end

function SpiderQueen.new()
 	local self = setmetatable({}, SpiderQueen)
 	self:init("Resources/Player/Spider_1")
 	self:initHead();

 	return self
end

setmetatable(SpiderQueen,{__index = Body})

return SpiderQueen