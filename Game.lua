
Game = {}

function Game:init()
    Game.grid = {}
    for y=1,20 do
        Game.grid[y] = {}
        for x=1,10 do
            Game.grid[y][x] = {block=false}
        end
    end

    Game.tetros = {"I", "J", "L", "O", "S", "T", "Z"}

    Game.curTetro = false
    Game.nextTetro = self.tetros[math.random(1, #self.tetros)]

    Game.roundTime = 1 -- seconds per round
end

function Game:enter(previous, ...)
    if self.roundTimer then
        Timer.cancel(self.roundTimer)
    end
    Game.roundTimer = Timer.every(self.roundTime, self.roundFunction)
end
function Game:leave()
    if self.roundTimer then
        Timer.cancel(self.roundTimer)
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
    resetMenuUI()
    suit.layout:col()
    suit.Label("Game", suit.layout:row())
end


function Game:checkRows()
    return false -- returns y of lowest row, false if no row
end

function Game:roundFunction()

    -- TODO: figure out why self is apparently a function-value here...
    -- Probably something with timer-lib
    -- Work-around is to use direct reference to Game
    print("Round")
    if Game.curTetro then
        -- fall
    else
        -- check and remove rows
        index = Game:checkRows()
        while index do
            -- remove rows
            index = Game:checkRows()
        end

        -- spawn new tetro
        Game.curTetro = Game.nextTetro
        Game.nextTetro = Game.tetros[math.random(1, #Game.tetros)]
    end

    return true -- return false to stop the timer
end

function Game:gameLoop(dt)
    -- Do actual gamestuff
end
