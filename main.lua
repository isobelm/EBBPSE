io.stdout:setvbuf('no')
function love.conf(t)
	t.console = true
end

local startMenu = require "StartMenu"
local Player = require "Player"
local testing = false

local screens = {}
local currentScreen = nil
local interaction = nil
local interacting = false
local canvas = nil
local font = nil

function init()
	player = Player.new()
	player:setX(188)
	player:setY(100)
	startMenu:init(timer)
end

function love.load()
	love.window.setMode(800, 604, {resizable=true, vsync=false, minwidth=400, minheight=300, msaa=0, highdpi=true})
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.window.setTitle( "Extreme Body Builder Pro Super Edition" )
	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	font = love.graphics.newImageFont('Resources/Fonts/alphabet.png', "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789#.!?: +-", 2)
	love.graphics.setFont(font)
	if (testing) then 
		testingInit()
	else
		currentScreen = startMenu
		init()
	end

	canvas = love.graphics.newCanvas(800, 604)
	

 
end

function love.draw()
    love.graphics.setCanvas(canvas)
	love.graphics.setColor(1, 1, 1, 1)
	if (pauseForDebug) then
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
    love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0)
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
		newScreen, interactionLocal = interaction:keyreleased( key )
	else
		newScreen, interactionLocal = currentScreen:keyreleased( key )
	end
	switchScreen(newScreen, interactionLocal)
end

function love.keypressed(key)
	if interacting == false then
		currentScreen:keypressed( key)
	end
end

function switchScreen(screen, interactionLocal)
	if screen == nil then
	elseif screen == "interaction" then
		love.graphics.setFont(font)
		interaction = interactionLocal
		interacting = true
	elseif screen == "return" then
		currentScreen:reset()
		interacting = false
	else
		currentScreen:newScreen(screen)
		local screentype = require(screen)
		currentScreen = screentype.new(player)
	end
end