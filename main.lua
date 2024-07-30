function love.load()
    print("Loading Game")
    anim8 = require 'libs/anim8'
    camera = require 'libs/camera'
    wf = require 'libs/windfield'
    sti = require 'libs/sti/sti'
    print("Loading Player")

    player = {}
    player.x = 400
    player.y = 300
    PlayerSpeed = 2
    player.spritesheet = love.graphics.newImage('player/spriteshit.png')
    player.grid = anim8.newGrid(96, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight())
    player.animations = {}
    player.animations.walk = anim8.newAnimation(player.grid('1-8', 3), 0.1)
    player.animations.walk1 = anim8.newAnimation(player.grid('1-8', 3), 0.1):flipH()
    player.animations.idle = anim8.newAnimation(player.grid('1-8', 4), 0.1)
    player.animations.idle1 = anim8.newAnimation(player.grid('1-8', 4), 0.1):flipH()
    player.animations.crafting = anim8.newAnimation(player.grid('1-8', 2), 0.1)
    player.animations.crafting1 = anim8.newAnimation(player.grid('1-8', 2), 0.1):flipH()
    player.animations.hammering = anim8.newAnimation(player.grid('1-23', 1), 0.07)
    player.animations.hammering1 = anim8.newAnimation(player.grid('1-23', 1), 0.07):flipH()
    player.animations.damaged = anim8.newAnimation(player.grid('1-8', 5), 0.1)
    player.animations.damaged1 = anim8.newAnimation(player.grid('1-8', 5), 0.1):flipH()
    player.animations.watering = anim8.newAnimation(player.grid('1-5', 6), 0.1)
    player.animations.mining = anim8.newAnimation(player.grid('1-10', 7), 0.06)
    player.animations.mining1 = anim8.newAnimation(player.grid('1-10', 7), 0.06):flipH()
    player.animations.attack = anim8.newAnimation(player.grid('1-9', 8), 0.05)
    player.animations.attack1 = anim8.newAnimation(player.grid('1-9', 8), 0.05):flipH()
    player.animations.axing = anim8.newAnimation(player.grid('1-10', 9), 0.06)
    player.animations.axing1 = anim8.newAnimation(player.grid('1-10', 9), 0.06):flipH()
    player.animations.rolling = anim8.newAnimation(player.grid('1-10', 10), 0.1)
    player.animations.rolling1 = anim8.newAnimation(player.grid('1-10', 10), 0.1):flipH()
    player.anim = player.animations.idle
    print("Loading Mechs")
    print("Game Loaded!")
end

local isMoving = false
local direction = "right"
local keypressed = nil
local tapped = false

function love.keypressed(key, scancode, isrepeat)
    if key == "p" then
        keypressed = "p"
    else
        keypressed = nil
    end
end
function love.keyreleased(key, scancode, isrepeat)
    if key == "p" then
        keypressed = nil
    end
end

function love.update(dt)
    isMoving = false

    if love.keyboard.isDown("escape") then
        love.event.quit()
        print("closing game")
    end

    if love.keyboard.isDown("d") then
        player.x = player.x + PlayerSpeed
        player.anim = player.animations.walk
        direction = "right"
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        player.x = player.x - PlayerSpeed
        player.anim = player.animations.walk1
        direction = "left"
        isMoving = true
    end

    if love.keyboard.isDown("s") and direction == "left" then
        player.y = player.y + PlayerSpeed
        player.anim = player.animations.walk1
        isMoving = true
    end

    if love.keyboard.isDown("s") and direction == "right" then
        player.y = player.y + PlayerSpeed
        player.anim = player.animations.walk
        isMoving = true
    end

    if love.keyboard.isDown("w") and direction == "left" then
        player.y = player.y - PlayerSpeed
        player.anim = player.animations.walk1
        isMoving = true
    end

    if love.keyboard.isDown("w") and direction == "right" then
        player.y = player.y - PlayerSpeed
        player.anim = player.animations.walk
        isMoving = true
    end

    if love.keyboard.isDown("e") and keypressed == "p" then
        if direction == "right" then
            player.anim = player.animations.hammering
        elseif direction == "left" then
            player.anim = player.animations.hammering1
        end
        isMoving = true
    end

    if not isMoving then
        if direction == "right" and love.keyboard.isDown("e") then
            player.anim = player.animations.mining
        elseif direction == "left" and love.keyboard.isDown("e") then 
            player.anim = player.animations.mining1
        elseif keypressed == "p" and direction == "right" then 
            player.anim = player.animations.attack
        elseif keypressed == "p" and direction == "left" then 
            player.anim = player.animations.attack1
        elseif direction == "right" and love.keyboard.isDown("space") then
            player.anim = player.animations.hammering
        elseif direction == "left" and love.keyboard.isDown("space") then
            player.anim = player.animations.hammering1
        elseif direction == "right" and love.keyboard.isDown("q") then
            player.anim = player.animations.axing
        elseif direction == "left" and love.keyboard.isDown("q") then
            player.anim = player.animations.axing1
        elseif direction == "left" and not tapped then
            player.anim = player.animations.idle1
            animreset()
        elseif direction == "right" and not tapped then
            player.anim = player.animations.idle
            animreset()
        end
    end

    player.anim:update(dt)
end

function love.draw()
    player.anim:draw(player.spritesheet, player.x, player.y, nil, 2, 2)
end

function animreset()
    player.animations.mining:gotoFrame(1)
    player.animations.mining1:gotoFrame(1)
    player.animations.hammering1:gotoFrame(1)
    player.animations.hammering:gotoFrame(1)
    player.animations.crafting:gotoFrame(1)
    player.animations.crafting1:gotoFrame(1)
    player.animations.walk:gotoFrame(1)
    player.animations.walk1:gotoFrame(1)
    player.animations.axing:gotoFrame(1)
    player.animations.axing1:gotoFrame(1)
    player.animations.attack:gotoFrame(1)
    player.animations.attack1:gotoFrame(1)
end
