print("Hello World! Shall we pizza the box")

-- libs
local lovesize = require("lovesize")

-- main loading
function love.load()
    -- sets reslaosoon
    lovesize.set(800, 600)

    local flags = {} -- flags for lovesize (check docs)
    flags.resizable = true
    love.window.setMode(lovesize.getWidth(), lovesize.getHeight(), flags)
end

-- Necessary to keep the correct values up to date
function love.resize(width, height)
    lovesize.resize(width, height)
end

function love.update(dt)
end

function love.draw()
    -- Example how to clear the letterboxes with a white color
    love.graphics.clear(255,255,255)

    lovesize.begin()
    -- Draw your game stuff here

    -- ok

    love.graphics.print("a",1,1)
    lovesize.finish()

    -- Draw stuff using screen coords here
end