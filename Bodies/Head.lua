--Head implements Body
local Body = require "Body"
local Sprite = require "Sprite"


local Head = {}

Head.__index = Head


function Head:initHead()
	self.speed = 0
	self.magicLossSpeed = 600
	self.type = "head"
end

function Head.new()
 	local self = setmetatable({}, Head)
 	self:init("Resources/Player/Head")
 	self:initHead();

 	return self
end

setmetatable(Head,{__index = Body})

return Head