--TownGate

Spider = require "Spider"
StaticObject = require "StaticObject"

local TownGate = {}

function TownGate:init(player)
	TownGate.background = love.graphics.newImage('Resources/Areas/TownGate/background.png')
	TownGate.initObjects()
	TownGate.objectMap = love.image.newImageData('Resources/Areas/TownGate/object_map.png')
	TownGate.timer = 0
	TownGate.font = love.graphics.newImageFont('Resources/Fonts/numberFont.png', " 1234567890", 1)
	TownGate.magicSymbol = love.graphics.newImage('Resources/Images/magicSymbol.png')
	love.graphics.setFont(TownGate.font)
	TownGate.interactables = {}
	TownGate.name = "TownGate"
	TownGate.portals = {}
	TownGate.portals.red = nil
	TownGate.portals.green = "Marsh_1"
	TownGate.addPlayer(player)
end

function TownGate:reset()
	love.graphics.setFont(TownGate.font)
end

function TownGate:initObjects()
	TownGate.objects = {}
	TownGate.objects[0] = StaticObject.new('Resources/Sprites/StaticObjects/tree_left.png')
	TownGate.objects[0]:setPos(24, 32)
	TownGate.objects[1] = StaticObject.new('Resources/Sprites/StaticObjects/tree_right.png')
	TownGate.objects[1]:setPos(248, 75)
	TownGate.objects[2] = StaticObject.new('Resources/Sprites/StaticObjects/full_wall.png')
	TownGate.objects[2]:setPos(0, 10)
end

function TownGate:draw()
	TownGate.sort(TownGate.objects, function (a, b)
			return a:getBaseCentreY() > b:getBaseCentreY()
		end
	)
	love.graphics.scale( 2, 2 )

	love.graphics.draw(TownGate.background, 0, 0)

	for i = 0, table.getn(TownGate.objects) do
		TownGate.objects[i]:draw()
	end

	love.graphics.draw(self.magicSymbol, 2, 2)
	love.graphics.printf("" .. self.player.magic, 10, 4, 400, 'left')

	TownGate.timer = TownGate.timer + 1;


end

function TownGate:update(dt)
	for i = 1, table.getn(TownGate.interactables) do
		if TownGate.interactables[i].dying == true then
			table.remove(TownGate.interactables, i)
			i = i - 1
			-- TownGate.setDebug("Dead! (int)")
		end
	end

	local a = TownGate.objects 
	local b = a[1]
	local c = b.dying
	for i = 1, table.getn(TownGate.objects) do
		if TownGate.objects[i] ~= nil and TownGate.objects[i].dying == true then
			table.remove(TownGate.objects, i)
			i = i - 1
			-- TownGate.setDebug("Dead! (obj)")
		end
	end
	if TownGate.timer == 120 then
		TownGate:createSpider()
	end
	if (TownGate.spider) then
		if TownGate.timer == 2000 then
			TownGate.spider:setDirection("u")
		elseif TownGate.timer == 3100 then
			TownGate.spider:setDirection("l")
		elseif TownGate.timer == 5500 then
			TownGate.spider = nil
		end
	end
	return TownGate.player:update()
end

function TownGate:createSpider()
	-- TownGate.setDebug("spider!")
	TownGate.spider = Spider.new(TownGate.player, TownGate.name)
	TownGate.spider:setX(400)
	TownGate.spider:setY(192)
	TownGate.spider:setDirection("l")
	TownGate.spider.moving = true
	table.insert(TownGate.objects, TownGate.spider)
	-- TownGate.spider.objInd = table.getn(TownGate.objects)
	table.insert(TownGate.interactables, TownGate.spider)
	-- TownGate.spider.interactInd = table.getn(TownGate.objects)
end

function TownGate:addPlayer(player)
	if player == nil then
		setDebug(nil)
		return
	end
	TownGate.player = player
	TownGate.player:setX(188)
	TownGate.player:setY(100)
	TownGate.player.timer = TownGate.timer
	TownGate.player:setObjectMap(TownGate.objectMap)
	TownGate.player.portals = TownGate.portals

	TownGate:addObject(player)
end

function TownGate:addObject(object)
	table.insert(TownGate.objects, player)
end

function TownGate:keyreleased( key, setDebug )
	return TownGate.player:keyreleased(key, TownGate.interactables, setDebug)
end

function TownGate.isBefore(a, b)
	return a.getY() < b.getY()
end

function TownGate.sort( arr, compare)
	length = table.getn(arr)
	for i = 0, length - 1 do
		for j=i + 1, 1, -1 do
			while (compare(arr[j - 1], arr[j])) do 
				tmp = arr[j - 1]
				arr[j - 1] = arr[j]
				arr[j] = tmp
			end
		end
	end
end

function TownGate.new(player)
	TownGate:init(player)
	return TownGate
end

return TownGate