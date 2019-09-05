io.stdout:setvbuf('no')
function love.conf(t)
	t.console = true
end
--Main
local startMenu = require "StartMenu"
local Player = require "Player"
-- local Timer = require "Timer" 
local pauseForDebug = false
local debugMessage = nil
local debugTime = 360
local debugMode = false

local screens = {}
local currentScreen = nil
-- local timer = nil

function init()
	player = Player.new(setDebug)
	startMenu:init(timer)
	-- timer = timer.new()
end

function love.load()
	love.window.setMode(800, 604, {resizable=true, vsync=false, minwidth=400, minheight=300, msaa=0, highdpi=true})
	love.window.setTitle( "Extreme Body Builder Pro Super Edition" )
	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	love.graphics.setNewFont('Resources/Fonts/Andale Mono.ttf', 24)
	screens["StartMenu"] = startMenu
	currentScreen = screens["StartMenu"]
	init()
end

function love.draw()
	if (pauseForDebug) then
		love.graphics.printf(debugMessage, 0, 250, 800, 'center')
		debugTime = debugTime - 1
		if (debugTime == 0) then
			pauseForDebug = false
			debugMessage = nil
			debugTime = 360
		end
	else
		currentScreen:draw()
	end
end

function love.update(dt)
    newScreen = currentScreen:update(dt)
    switchScreen(newScreen)
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

	newScreen, interaction = currentScreen:keyreleased( key , setDebug)
	switchScreen(newScreen, interaction)
end

function switchScreen(screen, interaction)
	if screen == nil then
	elseif screens[screen] then
		currentScreen = screens[screen]
		currentScreen:reset()
	else
		if screen == "interaction" then
			currentScreen = interaction
		else
			screens[screen] = require (screen)
			currentScreen = screens[screen]
			currentScreen:init(timer)
			if currentScreen["player"] ~= nil then
				currentScreen:player(player)
			end
		end
	end
end