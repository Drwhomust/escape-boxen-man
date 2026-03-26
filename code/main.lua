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
    world:setGravity(0, 512)
    world:addCollisionClass('Player')
    world:addCollisionClass('Walls')
    world:addCollisionClass('Bad guys')

    -- player
    player = {}
    player.x = 200 -- x and y for their starting
    player.y = 200
    player.speed = 15 -- their speed
    player.speedyness = 0
    player.mods = {}
    player.hitbox = world:newRectangleCollider(player.x,player.y,70,70) -- makes their hit box
    player.hitbox:setFixedRotation(true) -- to prevent them from getting stuck
    player.hitbox:setCollisionClass('Player')
    player.emo = "" -- for the emotations
    player.canjump = true
    player.is_Moving = false

    cam = camera.new()

    time_to_win = 232 -- in secounds

    -- rooms
    function make_starting() -- makes the starting area
        top_wall = world:newRectangleCollider(200,0,600,100)
        top_wall:setType('static')
        top_wall:setCollisionClass('Walls')
        left_wall = world:newRectangleCollider(0,0,200,600)
        left_wall:setType('static')
        left_wall:setCollisionClass('Walls')
        ground = world:newRectangleCollider(200,530,600,70)
        ground:setType('static')
        ground:setCollisionClass('Walls')
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

            player.hitbox:applyAngularImpulse(player.speed)

            --pizza tower like. read it and you will get it
            if player.speedyness == 0 then
                timer.after(3, function()
                    player.speedyness = 1
                    player.speed = player.speed + 20
                end)
            end

            if player.speedyness == 1 then
                timer.after(3, function()
                    player.speedyness = 2
                    player.speed = player.speed + 25
                end)
            end
        end

        ---------------------------------------------
        if where == "Left" then

            player.x = player.x - player.speed

            if player.speedyness == 0 then
                timer.after(3, function()
                    player.speedyness = 1
                    player.speed = player.speed + 20
                end)
            end

            if player.speedyness == 1 then
                timer.after(3, function()
                    player.speedyness = 2
                    player.speed = player.speed + 25
                end)
            end
        end

        -----------------------------------------------
        if where == "Up" then
            if player.canjump == true then
                player.canjump = false
                player.hitbox:applyAngularImpulse(5000)
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
    if player.is_Moving == false then
        player.speed = 15
        player.speedyness = 0
    end

    -- key board con
    if love.keyboard.isDown("right") then
        fire.emit("Player Move", "Right")
        player.is_Moving = true
    else
        player.is_Moving = false
    end

    if love.keyboard.isDown("left") then
        fire.emit("Player Move", "Left")
        player.is_Moving = true
    else
        player.is_Moving = false
    end

    if love.keyboard.isDown("up") then
        fire.emit("Player Move", "Up")
        player.is_Moving = true
    else
        player.is_Moving = false
    end

    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    

    if player.hitbox:enter('Walls') then
        print("hiT1")
        player.x = player.x - 30
        player.y = player.y - 30
    end

    world:update(dt)
    timer.update(dt)
end

function love.draw()
    if debugmode == true then -- drawing drawing drawing
        world:draw() -- draws hitboxes
        love.graphics.print("player x: " .. player.x,10,10)
        love.graphics.print("player y: " .. player.y,10,25)
        love.graphics.print("speed " .. player.speed,10,40)
        love.graphics.print("speedy " .. player.speedyness,10,60)
    end
end