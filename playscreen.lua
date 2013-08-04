----------------------------------------------------------------------------------
--
-- playscreen.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local device = require( "device" )
local scene = storyboard.newScene()

local font = {}
font.normal = "Helvetica"
font.bold = "Helvetica-Bold"
font.italic = "Helvetica-Oblique"

if ( device.isAndroid ) then
   font.normal = "DroidSans"
   font.bold = "DroidSans-Bold"
   if ( device.isNook ) then
      font.normal = "Arial"
      font.bold = "Arial Bold"
   elseif ( device.isKindleFire ) then
      font.normal = "arial"
      font.bold = "arial bold"
   end
end

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------
local wheel

local redSquare
local greenSquare
local blueSquare
local yellowSquare

local restartButton

local score = 0
local currentPos = 1
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local sequence = {}
local scoreDisplay

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local scaleSize = 0.3

	-- Background wheel for 4 coloured panels
	wheel = display.newImage('res/wheel.png')
	wheel.x = 0.5*display.contentWidth
	wheel.y = 0.5*display.contentHeight
	wheel:scale(scaleSize, scaleSize)

	roundDisplay = display.newText( "Round: ", 0, 0, "Let's go Digital", 25)
	roundDisplay:setTextColor(255, 255, 255) -- white
	roundDisplay.alpha = 1
	roundDisplay.x = 0.9*display.contentWidth
	roundDisplay.y = 0.05*display.contentHeight

	scoreDisplay = display.newText( "Score:", 0, 0, "Let's go Digital", 25 )
	scoreDisplay:setTextColor(255, 255, 255) -- white
	scoreDisplay.alpha = 1
	scoreDisplay.x = centerX
	scoreDisplay.y = 0.45*display.contentHeight



	redSquare = display.newImage('res/red1.png')
	blueSquare = display.newImage('res/blue2.png')
	yellowSquare = display.newImage('res/yellow3.png')
	greenSquare = display.newImage('res/green4.png')

	restartButton = display.newImage('res/restart.png')	
	restartButton.x = 0.1*display.contentWidth
	restartButton.y = 0.1*display.contentHeight

	restartButton:scale(scaleSize,scaleSize)

	redSquare:scale(scaleSize,scaleSize)
	greenSquare:scale(scaleSize,scaleSize)
	blueSquare:scale(scaleSize,scaleSize)
	yellowSquare:scale(scaleSize,scaleSize)

	local initialAlpha = 1
	redSquare.alpha = initialAlpha
	blueSquare.alpha = initialAlpha
	greenSquare.alpha = initialAlpha
	yellowSquare.alpha = initialAlpha

	local xSpace = 0.22
	local ySpace = 0.147
	local xfirst = centerX - xSpace*display.contentWidth
	local xsecond = centerX + xSpace*display.contentWidth
	local yfirst = centerY - ySpace*display.contentHeight
	local ysecond = centerY + ySpace*display.contentHeight
	redSquare.x = xfirst
	redSquare.y = yfirst
	greenSquare.x = xfirst
	greenSquare.y = ysecond
	blueSquare.x = xsecond
	blueSquare.y = yfirst
	yellowSquare.x = xsecond
	yellowSquare.y = ysecond

	group:insert(wheel)
	group:insert(redSquare)
	group:insert(greenSquare)
	group:insert(blueSquare)
	group:insert(yellowSquare)
	group:insert(restartButton)
	group:insert(scoreDisplay)

	local difficulty = event.params.difficulty
	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	--------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------

	local difficulty = event.params.difficulty

	local tab = { redSquare, greenSquare, blueSquare, yellowSquare }
	local numPanels = #tab -- could just change to 4
	local isRight
	local alive = true
	local count = 0

	local function flashPanel()
		if (count <= #sequence) then
			transition.to (tab[sequence[count]], {time=700, alpha=0.4})
			transition.to (tab[sequence[count]], {time=700, delay=700, alpha=1})
			count = count + 1
		end 
	end

	local function playGame()
		table.insert( sequence, math.random( numPanels ) )
		count = 1
		timer.performWithDelay( 1400, flashPanel, #sequence)
	end

	local function playGameOverSound()
	end

	-- true = correct, false = incorrect
	local function updateScore( upScore )
		if upScore == true then -- TODO: can we just say if upScore??
			score = score + 100
		else
			score = score - 100
		end
		scoreDisplay.text = "Score: " .. score
	end

	local function updateGame( event )
		local obj = event.target
	
		if tab[sequence[currentPos]] == obj then
			updateScore( true )
		else
			updateScore( false )
			playGameOverSound()
		end

		if currentPos == #sequence then
			currentPos = 1
			playGame()
			return true
		end

		currentPos = currentPos + 1
		return true
	end
	--can we change to iterate over all elements in 'tab', and add this eventlistener?

	local function goBack( event )
		local effects =
		{
		effect = "slideRight",
		time = 750,
		}
		storyboard.gotoScene( "homescreen", effects )
		-- storyboard.removeScene( "playscreen" )
	end

	-- listeners
	redSquare:addEventListener('tap', updateGame)
	greenSquare:addEventListener('tap', updateGame)
	yellowSquare:addEventListener('tap', updateGame)
	blueSquare:addEventListener('tap', updateGame)
	restartButton:addEventListener('tap', goBack)

	-- start game loop
	playGame()

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	-- display.remove(group)
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene