--[[
Simple Love2d Game
made by Erik Wallin
]]--

-- TODO: get hump and integrate its gamestate lib
-- TODO: lookup and use SUIT's row/col layout mechanism
-- TODO: set up a git repository
-- TODO: Figure out what happened with OpenGL before, I think it had to do with the comp
--       disabling the graphics card because of battery savins or something...

Input = require("libs/boipushy.Input")
suit = require("libs/suit")
Gamestate = require("libs/hump.gamestate")

-- States
require("Start_Menu")
require("Game")
require("Pause_Menu")

-- Constants
Width, Height = love.graphics.getWidth(), love.graphics.getHeight()


function love.load(arg)
	-- Init input and set bindings
    input = Input()
    
    input:bind("escape", "PauseQuit") -- Is there a better way to do this? bind as two different commands?

    -- Init Gamestate
    Gamestate.registerEvents()
    Gamestate.switch(Start_Menu)
end


function love.update(dt)
   
end


function love.draw(dt)
	suit.draw() -- Draw GUI last
end
