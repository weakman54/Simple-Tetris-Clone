
Game = {}

function Game:init()
    Game.grid = {}
    for y=1,20 do
        Game.grid[y] = {}
        for x=1,10 do
            Game.grid[y][x] = {block=false, falling=false}
        end
    end
end


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

    local offset = {x=100, y=30}

    for y, row in ipairs(self.grid) do
        for x, block in ipairs(row) do
            love.graphics.rectangle("fill", x*16+offset.x, y*16+offset.y, 15, 15)
        end
    end
end


function Game:drawGUI()
   resetMenuUI("Game") -- Placeholder for actual stuff, clipping with pausemenu tolerated
end

function Game:gameLoop(dt)
    -- Do actual gamestuff
end
