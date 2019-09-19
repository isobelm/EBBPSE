-- GameScreen

StaticObject = require "StaticObject"

local GameScreen = {}

GameScreen.__index = GameScreen

GameScreen.font = love.graphics.newImageFont('Resources/Fonts/numberFont.png', " 1234567890", 1)
GameScreen.magicSymbol = love.graphics.newImage('Resources/Images/magicSymbol.png')

function GameScreen:init(folder, player)
	self.background = love.graphics.newImage(folder .. '/background.png')
	self:initObjects()
	self.objectMap = love.image.newImageData(folder .. '/object_map.png')
	love.graphics.setFont(GameScreen.font)
	self.interactables = {}
	self:addPlayer(player)
	self.timer = 0
end

function GameScreen:reset()
	love.graphics.setFont(GameScreen.font)
end

function GameScreen:initObjects()
end

function GameScreen:draw()
	self.sort(self.objects, function (a, b)
			return a:getBaseCentreY() > b:getBaseCentreY()
		end
	)
	love.graphics.scale( 2, 2 )

	love.graphics.draw(self.background, 0, 0)

	for i = 1, table.getn(self.objects) do
		self.objects[i]:draw()
	end

	love.graphics.draw(GameScreen.magicSymbol, 2, 2)
	love.graphics.printf("" .. self.player.magic, 10, 4, 400, 'left')

	self.timer = self.timer + 1
end

function GameScreen:update(dt, setDebug)
	for i = 1, table.getn(self.interactables) do
		if self.interactables[i].dying == true then
			setDebug("death1")
			table.remove(self.interactables, i)
			i = i - 1
		end
	end

	local a = self.objects 
	local b = a[1]
	local c = b.dying
	for i = 1, table.getn(self.objects) do
		if self.objects[i].dying == true then
			setDebug("death2")
			table.remove(self.objects, i)
			i = i - 1
		end
	end
	return self.player:update()
end

function GameScreen:update(dt)
end

function GameScreen:addPlayer(player)
	self.player = player
	self.player:setX(188)
	self.player:setY(100)
	self.player:setObjectMap(self.objectMap)

	self:addObject(self.player)
end

function GameScreen:addObject(object)
	table.insert(self.objects, object)
end

function GameScreen:keyreleased( key, setDebug )
	return self.player:keyreleased(key, self.interactables, setDebug)
end

function GameScreen.isBefore(a, b)
	return a.getY() < b.getY()
end

function GameScreen.sort( arr, compare)
	length = table.getn(arr)
	if length <= 1 then
		return
	end

	for i = 1, length - 1 do
		for j=i + 1, 2, -1 do
			while (compare(arr[j - 1], arr[j])) do 
				tmp = arr[j - 1]
				arr[j - 1] = arr[j]
				arr[j] = tmp
			end
		end
	end
end

--Constructor

-- function GameScreen.new(folder)
--   local self = setmetatable({}, GameScreen)
--   self:init(folder)

--   return self
-- end

return GameScreen