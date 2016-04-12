
Game = {}

function Game:update(dt)
    -- toggle pause
    if input:pressed("PauseQuit") then
        print("Test")
        paused = not paused
    end
    
    if paused then
        self:drawPauseGUI()
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

end

function Game:gameLoop(dt)
    -- Do actual gamestuff
end
