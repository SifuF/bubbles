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

local bubbles = {
    {"gfx/bubble.png"},
    {"gfx/bubble2.png"},
    {"gfx/bubble3_1.png", "gfx/bubble3_2.png", "gfx/bubble3_3.png", "gfx/bubble3_4.png", "gfx/bubble3_5.png", "gfx/bubble3_6.png", "gfx/bubble3_7.png", "gfx/bubble3_8.png", "gfx/bubble3_9.png", "gfx/bubble3_10.png", "gfx/bubble3_11.png", "gfx/bubble3_12.png", "gfx/bubble3_13.png", "gfx/bubble3_14.png", "gfx/bubble3_15.png", "gfx/bubble3_16.png", "gfx/bubble3_17.png", "gfx/bubble3_18.png", "gfx/bubble3_19.png", "gfx/bubble3_20.png"},
    {"gfx/bubble4_1.png", "gfx/bubble4_2.png", "gfx/bubble4_3.png", "gfx/bubble4_4.png", "gfx/bubble4_5.png", "gfx/bubble4_6.png", "gfx/bubble4_7.png", "gfx/bubble4_8.png", "gfx/bubble4_9.png", "gfx/bubble4_10.png", "gfx/bubble4_11.png", "gfx/bubble4_12.png", "gfx/bubble4_13.png", "gfx/bubble4_14.png", "gfx/bubble4_15.png", "gfx/bubble4_16.png", "gfx/bubble4_17.png", "gfx/bubble4_18.png", "gfx/bubble4_19.png", "gfx/bubble4_20.png"},
    {"gfx/bubble5_1.png"}, --"gfx/bubble5_2.png", "gfx/bubble5_3.png", "gfx/bubble5_4.png", "gfx/bubble5_5.png", "gfx/bubble5_6.png",},
    {"gfx/bubble6_1.png", "gfx/bubble6_2.png", "gfx/bubble6_3.png", "gfx/bubble6_4.png", "gfx/bubble6_5.png", "gfx/bubble6_6.png", "gfx/bubble6_7.png", "gfx/bubble6_8.png", "gfx/bubble6_9.png", "gfx/bubble6_10.png", "gfx/bubble6_11.png", "gfx/bubble6_12.png", "gfx/bubble6_13.png", "gfx/bubble6_14.png", "gfx/bubble6_15.png"},
    {"gfx/bubble7_1.png", "gfx/bubble7_2.png", "gfx/bubble7_3.png", "gfx/bubble7_4.png", "gfx/bubble7_5.png", "gfx/bubble7_6.png", "gfx/bubble7_7.png", "gfx/bubble7_8.png", "gfx/bubble7_9.png"},
    {"gfx/bubble8.png"},
    {"gfx/bubble9_1.png", "gfx/bubble9_2.png", "gfx/bubble9_3.png", "gfx/bubble9_4.png", "gfx/bubble9_5.png", "gfx/bubble9_6.png", "gfx/bubble9_7.png", "gfx/bubble9_8.png", "gfx/bubble9_9.png", "gfx/bubble9_10.png", "gfx/bubble9_11.png", "gfx/bubble9_12.png"},
    {"gfx/bubble10_1.png", "gfx/bubble10_2.png", "gfx/bubble10_3.png", "gfx/bubble10_4.png", "gfx/bubble10_5.png", "gfx/bubble10_6.png", "gfx/bubble10_7.png", "gfx/bubble10_8.png", "gfx/bubble10_9.png"},
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

local function touchListener( event )
    if event.phase == "began" then
        event.target:removeSelf()
        activeBubbles = activeBubbles-1
        audio.play(popSounds[math.random(#popSounds)])
    end
end

local function createBubbles() 
    local shift = 0		   
    for i=1, numberOfBubbles do
        bubble[i] = display.newImage(bubbles[level][((i - 1) % #bubbles[level]) + 1])
        bubble[i]:addEventListener("touch", touchListener)
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

local function accelerometerListener(event)
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
    Runtime:addEventListener( "accelerometer", accelerometerListener)

    reset()
end

start()
