
Game = {}

function Game:init()
    -- Initialize game state and grid
    Game.grid = {}
    for y=1,20 do
        Game.grid[y] = {}
        for x=1,10 do
            Game.grid[y][x] = {block=false}
        end
    end

    Game.tetros = {"I", "J", "L", "O", "S", "T", "Z"}

    Game.curTetro = false
    Game.nextTetro = Game:newTetro("I")

    Game.roundTime = 0.01 -- seconds per round
end

function Game:enter(previous, ...)
    print("Game enter")
    if previous == Start_Menu then
        print("...From Start_Menu")
        -- Reinitialize game state and grid
        Game.grid = {}
        for y=1,20 do
            Game.grid[y] = {}
            for x=1,10 do
                Game.grid[y][x] = {block=false}
            end
        end

        Game.curTetro = false
        Game.nextTetro = Game:newTetro("I")

    elseif previous == Pause_Menu then
        print("From pause menu")
    end

    if self.roundTimer then
        print("cancel roundTimer: " .. tostring(Game.roundTimer))
        Timer.cancel(self.roundTimer)
    end

    
    Game.roundTimer = Timer.every(self.roundTime, self.roundFunction)
    print("set roundTimer: " .. tostring(Game.roundTimer))
end
function Game:leave()
    print("Game leave")
    if Game.roundTimer then
        print("cancel roundTimer: " .. tostring(Game.roundTimer))
        Timer.cancel(Game.roundTimer)
    end
end


function Game:update(dt)
    -- toggle pause
    if input:pressed("PauseQuit") then
        paused = not paused -- Can this be removed?
        Gamestate.switch(Pause_Menu)
    end

    self:drawGUI()
end

function Game:draw(dt)
    love.graphics.setColor(255, 255, 255, 255)

    local offset = {x=100, y=30}

    for y, row in ipairs(self.grid) do
        for x, tile in ipairs(row) do
            if tile.block then
                love.graphics.setColor(128, 128, 128, 255)
            else
                love.graphics.setColor(255, 255, 255, 255)
            end
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
    --print("Round")
    if Game.curTetro then
        -- check and perform rotations

        local colliding = false
        for _, pos in ipairs(Game.curTetro.blocksI) do
            -- check collisions
            if Game.grid[pos.y + 1] == nil then -- bottom of grid
                colliding = true
            elseif Game.grid[pos.y + 1][pos.x].block == true then
                colliding = true
            end
        end

        if colliding then
            for _, pos in ipairs(Game.curTetro.blocksI) do
                --print(pos.x, pos.y)
                if pos.y <= 1 then
                    -- End game if colliding and any block is at/above top-line
                    -- use return here to stop further execution of the function
                    print("cancel roundTimer: " .. tostring(Game.roundTimer))
                    Timer.cancel(Game.roundTimer)
                    return Gamestate.switch(Game_Over) -- GAME OVER state
                end
            end
            -- stop checking this block
            Game.curTetro = false
        else
            -- fall
            for _, pos in ipairs(Game.curTetro.blocksI) do
                Game.grid[pos.y][pos.x].block = false -- remove old
                pos.y = pos.y + 1
                Game.grid[pos.y][pos.x].block = true -- set new
            end
        end

    else
        -- check and remove rows
        index = Game:checkRows()
        while index do
            -- remove rows
            index = Game:checkRows()
        end


        -- spawn new tetro
        Game.curTetro  = Game.nextTetro
        Game.nextTetro = Game:newTetro("I")--Game.tetros[math.random(1, #Game.tetros)]

        -- initialize grid blocks
        for _, pos in ipairs(Game.curTetro.blocksI) do
            --print("setting pos: (" .. pos.x .. ", " .. pos.y .. ")")
            Game.grid[pos.y][pos.x].block = true
        end

    end

    return true -- return false to stop the timer
end

function Game:gameLoop(dt)
    -- Do actual gamestuff
end

function Game:newTetro(strType)
    if strType == "I" then
        retVal = {
            centerBlockI = 3, -- which index in blocksI that should be used as center of rot
            blocksI = {
                {x=3, y=1},
                {x=4, y=1},
                {x=5, y=1},
                {x=6, y=1},
            }
        }
    end

    return retVal
end
