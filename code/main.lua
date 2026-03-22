-- game jammer
-- made by Drwhomust and Dyl_Pickel5

-- loads stuff
wf = require("windfield/windfield") -- for hitboxes
camera = require("hump/camera") -- camera... what else
timer = require("hump/timer") -- for timing
fire = require("hump/signal") -- used to fire (run) functions when it's time for them to shine
debugmode = true -- a flag if you want to config

function love.load()
    print("Now loading.... please wait owo :3")
    love.graphics.setDefaultFilter("nearest", "nearest") -- shows the GOOD pixel art
    world = wf.newWorld(0,0, true)

    -- player
    player = {}
    player.x = 200 -- x and y for their starting
    player.y = 200
    player.speed = 25 -- their speed
    player.speedyness = 0
    player.mods = {}
    player.hitbox = world:newRectangleCollider(player.x,player.y,60,70) -- makes their hit box
    player.hitbox:setFixedRotation(true) -- to prevent them from getting stuck
    player.emo = "" -- for the emotations
    player.canjump = true

    time_to_win = 232 -- in secounds

    -- rooms
    function make_starting() -- makes the starting area
        top_wall = world:newRectangleCollider(200,0,600,100)
        top_wall:setType('static')
        left_wall = world:newRectangleCollider(0,0,200,600)
        left_wall:setType('static')
        ground = world:newRectangleCollider(200,530,600,70)
        ground:setType('static')
    end

    -- fire stuff
    -- plus functions i guess

    function jump()
        timer.after(0.5, function()
        player.y = player.y - 3
        end)
    end

    fire.register("start game", function()
        print("ooooo new game")
        make_starting()
    end)

    fire.register("Player Move", function (where)

        if where == "Right" then -- checks where

            player.x = player.x + speed -- movess

            --pizza tower like. read it and you will get it
            if speedyness == 0 then
                timer.after(3, function()
                    speedyness = 1
                    speed = speed + 20
                end)
            end

            if speedyness == 1 then
                timer.after(3, function()
                    speedyness = 2
                    speed = speed + 25
                end)
            end
        end

        ---------------------------------------------
        if where == "Left" then

            player.x = player.x - speed

            if speedyness == 0 then
                timer.after(3, function()
                    speedyness = 1
                    speed = speed + 20
                end)
            end

            if speedyness == 1 then
                timer.after(3, function()
                    speedyness = 2
                    speed = speed + 25
                end)
            end
        end

        -----------------------------------------------
        if where == "Up" then
            if player.canjump == true then
                player.canjump = false
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                jump()
                timer.after(1, function()
                player.canjump = true
                end)
            end
        end

    end)

    make_starting()

    print("loading finished! :3 hav fun")
end

function love.update(dt)
    world:update(dt)
    timer.update(dt)
end

function love.draw()
    if debugmode == true then -- drawing drawing drawing
        world:draw() -- draws hitboxes
    end
end