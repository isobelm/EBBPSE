-- GameScreen

StaticObject = require "StaticObject"

local GameScreen = {}

GameScreen.__index = GameScreen

GameScreen.font = love.graphics.newImageFont('Resources/Fonts/numberFont.png', " 1234567890", 1)
GameScreen.magicSymbol = love.graphics.newImage('Resources/Images/magicSymbol.png')
GameScreen.lowMagicSymbol = love.graphics.newImage('Resources/Images/lowMagicSymbol.png')
GameScreen.veryLowMagicSymbol = love.graphics.newImage('Resources/Images/veryLowMagicSymbol.png')

function GameScreen:init(folder, player)
	self.portals ={}
	self.background = love.graphics.newImage(folder .. '/background.png')
	self.objectMap = love.image.newImageData(folder .. '/object_map.png')
	self.objects = {}
	self.interactables = {}
	self:addPlayer(player)
	self:initObjects()
	love.graphics.setFont(GameScreen.font)
	self.timer = 0
	self.timeBetweenFrames = 0
	self.lastTimeBetweenFrames = 0
end

function GameScreen:reset()
	love.graphics.setFont(GameScreen.font)
end

function GameScreen:draw()
	if self.dirty then
		self.sort(self.objects, function (a, b)
				return a:getBaseCentreY() > b:getBaseCentreY()
			end
		)
		love.graphics.scale( 2, 2 )

		love.graphics.draw(self.background, 0, 0)
		self.dirty = false

		for i = 1, table.getn(self.objects) do
			self.objects[i]:draw()
		end


		if player.magic < 10 then
			love.graphics.draw(GameScreen.veryLowMagicSymbol, 4, 4)
			love.graphics.setColor(1, 116/255, 116/255, 1)
			love.graphics.printf("" .. self.player.magic, 14, 6, 400, 'left')
			love.graphics.setColor(1, 1, 1, 1)
		elseif player.magic < 25 then
			love.graphics.draw(GameScreen.lowMagicSymbol, 4, 4)
			love.graphics.setColor(1, 243/255, 137/255, 1)
			love.graphics.printf("" .. self.player.magic, 14, 6, 400, 'left')
			love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.draw(GameScreen.magicSymbol, 4, 4)
			love.graphics.printf("" .. self.player.magic, 14, 6, 400, 'left')
		end

		self.lastTimeBetweenFrames = self.timeBetweenFrames;
		self.timeBetweenFrames = 0
		love.graphics.printf("" .. self.lastTimeBetweenFrames, 300, 4, 400, 'left')
		love.graphics.scale( 0.5, 0.5 )
		self.dirty = false
	else
		self.timeBetweenFrames = self.timeBetweenFrames + 1
	end
end

function GameScreen:update(dt)
	self.timer = self.timer + dt
	local disheveledCount = 0

	for i = 1, table.getn(self.objects) do
		if self.objects[i].dirty == true then
			self.dirty = true
		elseif self.objects[i].disheveled ~= nil and self.objects[i].disheveled then
			disheveledCount = disheveledCount + 1
		end
	end

	if disheveledCount > self.maxDisheveled then
		self.dirty = true
	end

	for i = 1, table.getn(self.interactables) do
		local a = self.interactables[i]
		if a == nil or (a.dying ~= nil and a.dying == true) then
			table.remove(self.interactables, i)
			i = i - 1
		end
	end

	for i = 1, table.getn(self.objects) do
		local a = self.objects[i]
		if a == nil or ( a.dying ~= nil and a.dying == true ) then
			table.remove(self.objects, i)
			i = i - 1
		elseif self.objects[i].update ~= nil then
			local tmp = self.objects[i]:update()
			if tmp ~= nil then return tmp end
		end
	end
end

function GameScreen:addStaticObject(path, x, y) 
	local tmpObj = StaticObject.new(path)
	tmpObj:setPos(x, y)
	table.insert(self.objects, tmpObj)
end

function GameScreen:placeRandomly(object)
	local canPlaceObject = false
	local x = 0
	local y = 0
	while (canPlaceObject == false) do
		x = math.modf(math.random(0, 399 - tmpObj:getWidth()))
		y = math.modf((math.random(0 + tmpObj:getBaseOffset(), 301 - tmpObj:getHeight())))
		canPlaceObject = self:canPlace(tmpObj, x, y)
	end
	
	tmpObj:setX(x)
	tmpObj:setY(y)
end

function GameScreen:canPlace(object, x, y)
	for i=0, object:getWidth() do
		local r1, g1, b1, a1 = self.objectMap:getPixel(x + i, y)
		local r2, g2, b2, a2 = self.objectMap:getPixel(x + i, y + object:getHeight())
		if (r1 == 0 and g1 == 0 and b1 == 0) or (r2 == 0 and g2 == 0 and b2 == 0) then
			return false
		end
	end

	for j=0, object:getHeight() do
		local r1, g1, b1, a1 = self.objectMap:getPixel(x, y + j)
		local r2, g2, b2, a2 = self.objectMap:getPixel(x + object:getWidth(), y + j)
		if (r1 == 0 and g1 == 0 and b1 == 0) or (r2 == 0 and g2 == 0 and b2 == 0) then
			return false
		end
	end

	return true
end

function GameScreen:addPlayer(player)
	self.player = player
	self.player:setObjectMap(self.objectMap)

	-- print("player")
	self:addObject(self.player)
end

function GameScreen:addObject(object)
	table.insert(self.objects, object)
end

function GameScreen:keyreleased( key )
	return self.player:keyreleased(key, self.interactables)
end

function GameScreen.isBefore(a, b)
	return a.getY() < b.getY()
end

function GameScreen.sort( arr, compare )
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

function GameScreen:keypressed( key )
	if (self.player ~= nil) then
		self.player:keypressed( key )
	end
end

--Constructor

-- function GameScreen.new(folder)
--   local self = setmetatable({}, GameScreen)
--   self:init(folder)

--   return self
-- end

return GameScreen