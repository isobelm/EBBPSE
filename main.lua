io.stdout:setvbuf('no')
function love.conf(t)
	t.console = true
end

--Main
require "conf"
local startMenu = require "StartMenu"
local Player = require "Player"
local pauseForDebug = false
local debugMessage = nil
local debugTime = 360
local debugMode = false
local testing = false

local screens = {}
local currentScreen = nil
local interaction = nil
local interacting = false

function init()
	player = Player.new(setDebug)
	player:setX(188)
	player:setY(100)
	startMenu:init(timer)
end

function love.load()
	love.window.setMode(800, 604, {resizable=true, vsync=false, minwidth=400, minheight=300, msaa=0, highdpi=true})
	love.window.setTitle( "Extreme Body Builder Pro Super Edition" )
	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	love.graphics.setNewFont('Resources/Fonts/Andale Mono.ttf', 24)
	if (testing) then 
		testingInit()
	else
		currentScreen = startMenu
		init()
	end
end

function testingInit()
	player = Player.new(setDebug)
	player:setBodyType("SpiderQueen")
	player:setX(188)
	player:setY(100)
	local screentype = require("Levels/Marsh_1")
	currentScreen = screentype.new(player)
end

function love.draw()
	if (pauseForDebug) then
		-- love.graphics.printf(debugMessage, 0, 250, 800, 'center')
		debugTime = debugTime - 1
		if (debugTime == 0) then
			pauseForDebug = false
			debugMessage = nil
			debugTime = 360
		end
	else
		if (interacting) then
			interaction:draw()
		else
			currentScreen:draw()
		end
	end
	love.graphics.print(tostring(love.timer.getFPS( )), 280, 4)
end

function love.update(dt)
	local newScreen = nil
	if (interacting) then
		newScreen = interaction:update(dt)
	else
		newScreen = currentScreen:update(dt)
	end
    switchScreen(newScreen)
    if player == nil then
		setDebug("Sure, that makes sense")
	end
end

function setDebug(message)
	if debugMode then
		debugMessage = message
		debugTime = 360
		pauseForDebug = true
	end
end

function love.keyreleased( key, scancode, isrepeat )
	if (key == "w") then
		key = "up"
	elseif (key == "a") then
		key = "left"
	elseif (key == "s") then
		key = "down"
	elseif (key == "d") then
		key = "right"
	end

	local newScreen, interactionLocal = nil
	if (interacting) then
		newScreen, interactionLocal = interaction:keyreleased( key , setDebug)
	else
		newScreen, interactionLocal = currentScreen:keyreleased( key , setDebug)
	end
	switchScreen(newScreen, interactionLocal)
end

function switchScreen(screen, interactionLocal)
	if screen == nil then
	elseif screen == "interaction" then
		interaction = interactionLocal
		setDebug(interaction.objectName)
		interacting = true
	elseif screen == "return" then
		currentScreen:reset()
		interacting = false
	else
		local screentype = require(screen)
		currentScreen = screentype.new(player)
	end
end