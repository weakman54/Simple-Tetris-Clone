
Game = {}

function Game:update(dt)
    -- toggle pause
    if input:pressed("PauseQuit") then
        paused = not paused -- Can this be removed?
        Gamestate.switch(Pause_Menu)
    end

    if not paused then
        self:gameLoop(dt)
        self:drawGUI() 
    end
end

function Game:draw(dt)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", 10, 10, 100, 100)
end


function Game:drawGUI()
   resetMenuUI("Game") -- Placeholder for actual stuff, clipping with pausemenu tolerated
end

function Game:gameLoop(dt)
    -- Do actual gamestuff
end
