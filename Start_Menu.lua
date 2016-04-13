
Start_Menu = {}

function Start_Menu:update(dt)
    -- Draw GUI
    suit.Label("Menu", {align="center"}, Width/2-50, 20, 100, 20)

    startButton   = suit.Button("Start"  , Width/2-50, 60 , 100, 20)
    optionsButton = suit.Button("Options", Width/2-50, 100, 100, 20)
    quitButton    = suit.Button("Quit"   , Width/2-50, 140, 100, 20)

    if startButton.hit then
        Gamestate.switch(Game)
    end


    -- Check input
    if input:pressed("PauseQuit") then
        love.event.quit()
    end
end

function Start_Menu:draw(dt)

end
