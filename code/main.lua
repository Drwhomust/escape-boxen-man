-- game jammer
-- made by Drwhomust and Dyl_Pickel5

-- loads stuff
wf = require("windfield/windfield")
Camera = require("hump/camera")

function love.load()
    player = {}
    player.pos = {}
    player.pos.x = 1
    player.pos.y = 1
    camera = Camera(player.pos.x, player.pos.y)
    player.x = player.pos.x
    player.y = player.pos.y
end

function love.update(dt)
    local dx,dy = player.x - camera.x, player.y - camera.y
    camera:move(dx/2, dy/2)

    if love.keyboard.isDown("right") then
        player.pos.x = player.pos.x + 1
    end

    if love.keyboard.isDown("left") then
        player.pos.x = player.pos.x - 1
    end

    if love.keyboard.isDown("up") then
        player.pos.x = player.pos.y - 1
    end

    if love.keyboard.isDown("down") then
        player.pos.x = player.pos.y + 1
    end
end

function love.draw()
    camera:attach()
    
    love.graphics.circle("fill", 1, 4, 5 )
    camera:detach()

    love.graphics.circle("line", player.pos.x, player.pos.y , 5 )
end