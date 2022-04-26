--------------------
--Bubbles by SifuF--
--------------------

local main = nil

--Globals--
bubble = {}    -- new array
numberOfBubbles = 20
activeBubbles = numberOfBubbles
local physics = require("physics")

local backGround = display.newImage("gfx/background.jpg")
backGround.x = display.contentCenterX
backGround.y = display.contentCenterY

local thickness = 10
--display.newRect( [parent,] x, y, width, height )
local bottomRectangle = display.newRect(display.contentCenterX, display.contentHeight + thickness, display.contentWidth, thickness)
local topRectangle = display.newRect(display.contentCenterX, -thickness, display.contentWidth, thickness)
local leftRectangle = display.newRect(0 - thickness, display.contentCenterY, thickness, display.contentHeight)
local rightRectangle = display.newRect(display.contentWidth + thickness, display.contentCenterY, thickness, display.contentHeight)

local rectColour = 0.0
bottomRectangle:setFillColor( rectColour )
topRectangle:setFillColor( rectColour )
leftRectangle:setFillColor( rectColour )
rightRectangle:setFillColor( rectColour )

local backgroundMusic = audio.loadStream("wav/backgroundMusic.mp3")
local popSound1 = audio.loadSound("wav/pop1.wav")
local popSound2 = audio.loadSound("wav/pop2.wav")
local popSound3 = audio.loadSound("wav/pop3.wav")


--Event handlers--
local function urTiltFunc( event )
    physics.setGravity( 10 * event.yGravity, 10 * event.xGravity )
 
    if (activeBubbles < 1) then
	    if(event.xGravity > 0.1) then
		    activeBubbles = numberOfBubbles
		    --print("x = "..event.xGravity)
	        --print("y = "..event.yGravity)
	        main()
	    end	
	end 
end 

local function myTouchListener( event )
    if ( event.phase == "began" ) then
        --print( "Touch X location"..event.x )
        --print( event.target )
		event.target:removeSelf()
		activeBubbles = activeBubbles-1
		
		local burstType = math.random(3)
		
		if(burstType == 1) then
		    audio.play( popSound1 )
		    --print(burstType)
		elseif(burstType == 2) then
		    audio.play( popSound2 )
		    --print(burstType)
		else
		    audio.play( popSound3 )
			--print(burstType)
		end
    end
end


local function createBubbles() 
   
    local shift = 0		   
	for i=1, numberOfBubbles do
        bubble[i] = display.newImage("gfx/bubble.png")
		bubble[i]:addEventListener( "touch", myTouchListener )
		bubble[i].x = bubble[i].x + shift
	    physics.addBody(bubble[i], "dynamic", { density = 0.1, friction = 0.3, bounce = 0.8, radius = 60 })
		shift = shift + 50
    end
end

main = function()
   createBubbles()
end

--First tasks and physics engine--
physics.start()
physics.addBody(bottomRectangle, "static")
physics.addBody(topRectangle, "static")
physics.addBody(leftRectangle, "static")
physics.addBody(rightRectangle, "static")
Runtime:addEventListener( "accelerometer", urTiltFunc )

local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }  )  -- play the background music on channel 1, loop infinitely, and fadein over 5 seconds 
--local popChannel = audio.play( popSound )  -- play the laser on any available channel

main()