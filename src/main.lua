--------------------
--Bubbles by SifuF--
--------------------

local level = 1
local levelBubbleCounts = {1, 20, 9, 20, 1, 15, 9, 1, 12, 10}
local bubbles = {}
local bubbleTextures = {}
local backgroundTextures = {}
local musics = {}
local popSounds = {}
local numberOfBubbles = 20
local activeBubbles = numberOfBubbles
local physics

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
        bubbles[i] = display.newImage(bubbleTextures[level][((i - 1) % #bubbleTextures[level]) + 1])
        bubbles[i]:addEventListener("touch", touchListener)
        bubbles[i].x = bubbles[i].x + shift
        physics.addBody(bubbles[i], "dynamic", {density = 0.1, friction = 0.3, bounce = 0.8, radius = 60})
        shift = shift + 50
    end
end

local function reset()
    audio.stop(1)
    audio.play(musics[level], { channel=1, loops=-1 })

    local backGround = display.newImage(backgroundTextures[level])
    backGround.x = display.contentCenterX
    backGround.y = display.contentCenterY

    activeBubbles = numberOfBubbles
    createBubbles()

    level = (level % #backgroundTextures) + 1
end

local function accelerometerListener(event)
    physics.setGravity(10 * event.yGravity, 10 * event.xGravity)
    if activeBubbles < 1 then
        local shakeSquared = 2.5
        local accel = event.xInstant^2 + event.yInstant^2 + event.zInstant^2
        if accel > shakeSquared then
            reset()
        end	
    end 
end 

local function start()
    for i = 1, #levelBubbleCounts do
        table.insert(backgroundTextures, "gfx/background" .. i .. ".jpg")
        table.insert(musics, audio.loadStream("wav/music" .. i .. ".mp3"))

        bubbleTextures[i] = {}
        for j = 1, levelBubbleCounts[i] do
            bubbleTextures[i][j] = "gfx/bubble" .. i .. "_" .. j .. ".png"
        end
    end

    for i = 1, 3 do
        table.insert(popSounds, audio.loadSound("wav/pop" .. i .. ".wav"))
    end
    
    physics = require("physics")
    physics.start()

    local wallThickness = 10
    local walls = {
        {x = display.contentCenterX, y = display.contentHeight + wallThickness, width = display.contentWidth, height = wallThickness}, -- bottom
        {x = display.contentCenterX, y = -wallThickness, width = display.contentWidth, height = wallThickness},                        -- top
        {x = -wallThickness, y = display.contentCenterY, width = wallThickness, height = display.contentHeight},                       -- left
        {x = display.contentWidth + wallThickness, y = display.contentCenterY, width = wallThickness, height = display.contentHeight}  -- right
    }
    for i, rect in ipairs(walls) do
        local r = display.newRect(rect.x, rect.y, rect.width, rect.height)
        r:setFillColor(0)
        physics.addBody(r, "static")
    end
    
    Runtime:addEventListener( "accelerometer", accelerometerListener)

    reset()
end

start()
