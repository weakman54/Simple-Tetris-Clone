
Game = {}

function Game:update(dt)
    -- toggle pause
    if input:pressed("PauseQuit") then
        paused = not paused
    end
    
    if paused then
        self:drawPauseGUI() -- TODO: LOW Priority: Fix the pause menu to be an overlay proper
    else
        self:gameLoop(dt)
        self:drawGameGUI() 
    end
end

function Game:draw(dt)
    if paused then
        -- Draw overlay
        love.graphics.push()
        love.graphics.setColor(255, 255, 255, 12)
        love.graphics.rectangle("fill", 0, 0, Width, Height)
        love.graphics.pop()
    end
end

function Game:drawPauseGUI()
    suit.Label("Game", Width/2, 80, 100, 20)

    backButton = suit.Button("go back", 100, 200, 200, 30)
    
    if backButton.hit then
        currentState = Start_Menu
    end
end

function Game:drawGameGUI()
    suit.Label("Health", 10, 10, 50, 20)
    -- Draw a rect? or is there a way to make a UI element here?
    -- It probably needs to be different, like a slider but with
    -- another theme. can you theme specific things? or make an
    -- entirely new UI element "Progress Bar" I guess...
end

function Game:gameLoop(dt)
    -- Do actual gamestuff
end
