--------------------
--Bubbles by SifuF--
--------------------

level = 1
bubble = {}
numberOfBubbles = 20
activeBubbles = numberOfBubbles
local physics = require("physics")

local thickness = 10
local bottomRectangle = display.newRect(display.contentCenterX, display.contentHeight + thickness, display.contentWidth, thickness)
local topRectangle = display.newRect(display.contentCenterX, -thickness, display.contentWidth, thickness)
local leftRectangle = display.newRect(0 - thickness, display.contentCenterY, thickness, display.contentHeight)
local rightRectangle = display.newRect(display.contentWidth + thickness, display.contentCenterY, thickness, display.contentHeight)

local rectColour = 0.0
bottomRectangle:setFillColor(rectColour)
topRectangle:setFillColor(rectColour)
leftRectangle:setFillColor(rectColour)
rightRectangle:setFillColor(rectColour)

local backgrounds = {
    "gfx/background1.jpg",
    "gfx/background2.jpg",
    "gfx/background3.jpg",
    "gfx/background4.jpg",
    "gfx/background5.jpg",
    "gfx/background6.jpg",
    "gfx/background7.jpg",
    "gfx/background8.jpg",
    "gfx/background9.jpg",
    "gfx/background10.jpg"
}

local musics = {
    audio.loadStream("wav/music1.mp3"),
    audio.loadStream("wav/music1.mp3"),
    audio.loadStream("wav/music3.mp3"),
    audio.loadStream("wav/music4.mp3"),
    audio.loadStream("wav/music5.mp3"),
    audio.loadStream("wav/music6.mp3"),
    audio.loadStream("wav/music7.mp3"),
    audio.loadStream("wav/music8.mp3"),
    audio.loadStream("wav/music9.mp3"),
    audio.loadStream("wav/music10.mp3")
}

local popSounds = {
    audio.loadSound("wav/pop1.wav"),
    audio.loadSound("wav/pop2.wav"),
    audio.loadSound("wav/pop3.wav"),
}

local function myTouchListener( event )
    if event.phase == "began" then
        event.target:removeSelf()
        activeBubbles = activeBubbles-1
        audio.play(popSounds[math.random(#popSounds)])
    end
end

local function createBubbles() 
    local shift = 0		   
    for i=1, numberOfBubbles do
        bubble[i] = display.newImage("gfx/bubble.png")
        bubble[i]:addEventListener("touch", myTouchListener)
        bubble[i].x = bubble[i].x + shift
        physics.addBody(bubble[i], "dynamic", {density = 0.1, friction = 0.3, bounce = 0.8, radius = 60})
        shift = shift + 50
    end
end

local function reset()
    audio.stop(1)
    audio.play(musics[level], { channel=1, loops=-1 })

    local backGround = display.newImage(backgrounds[level])
    backGround.x = display.contentCenterX
    backGround.y = display.contentCenterY

    activeBubbles = numberOfBubbles
    createBubbles()

    level = (level % #backgrounds) + 1
end

local function tiltFunc(event)
    physics.setGravity(10 * event.yGravity, 10 * event.xGravity)
    if activeBubbles < 1 then
        local shakeSquared = 3.5 
        local accel = event.xInstant^2 + event.yInstant^2 + event.zInstant^2
        if accel > shakeSquared then
            reset()
        end	
    end 
end 

local function start()
    physics.start()
    physics.addBody(bottomRectangle, "static")
    physics.addBody(topRectangle, "static")
    physics.addBody(leftRectangle, "static")
    physics.addBody(rightRectangle, "static")
    Runtime:addEventListener( "accelerometer", tiltFunc)

    reset()
end

start()
