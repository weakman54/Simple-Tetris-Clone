--[[
Simple Love2d Game
made by Erik Wallin
]]--


-- Libraries
Gamestate = require("libs/hump.gamestate")
Timer = require("libs/hump.timer")
Input = require("libs/boipushy.Input")
suit = require("libs/suit")

-- helper functions
require("helperFunctions")

-- States
require("Start_Menu")
require("Game")
require("Pause_Menu")

-- Constants
Width, Height = love.graphics.getWidth(), love.graphics.getHeight()

function love.load(arg)
	-- Init Gamestate
    Gamestate.registerEvents()
    Gamestate.switch(Start_Menu)

    -- Init input and set bindings
    input = Input()
    
    input:bind("escape", "PauseQuit") -- Is there a better way to do this? bind as two different commands?
end


function love.update(dt)
    Timer.update(dt)
end


function love.draw(dt)
	suit.draw() -- Draw GUI last
end
