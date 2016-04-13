-- pause gamestate
Pause_Menu = {}

function Pause_Menu:enter(from)
    self.from = from -- record previous state
end

function Pause_Menu:update(dt)
    
end

function Pause_Menu:draw(dt)
    self.from:drawGUI()
    self.from:draw(dt)
    
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.rectangle("fill", 0, 0, Width, Height)
    love.graphics.setColor(255, 255, 255, 255)

    self:drawGUI()
    suit.draw()
end


function Pause_Menu:drawGUI()
    backButton = suit.Button("Back", 100, 150, 100, 30)
    menuButton = suit.Button("Menu", 100, 200, 100, 30)

    if backButton.hit then
        paused = false
        Gamestate.pop()
    end

    if menuButton.hit then
        paused = false
        Gamestate.switch(Start_Menu) -- What happens with the pushed pause state?
    end
end
