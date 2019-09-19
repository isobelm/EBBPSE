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
local debugMode = true

local screens = {}
local currentScreen = nil

function init()
	player = Player.new(setDebug)
	startMenu:init(timer)
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
	love.graphics.print(tostring(love.timer.getFPS( )), 280, 4)
end

function love.update(dt)
    newScreen = currentScreen:update(dt)
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

	newScreen, interaction = currentScreen:keyreleased( key , setDebug)
	switchScreen(newScreen, interaction)
end

function switchScreen(screen, interaction)
	-- local player = _G.player
	if screen == nil then
	elseif screens[screen] then
		currentScreen = screens[screen]
		currentScreen:reset()
	else
		if screen == "interaction" then
			currentScreen = interaction
		else
			local screentype = require(screen)
			currentScreen = screentype.new(player)
			screens[screen] = currentScreen
		end
	end
end