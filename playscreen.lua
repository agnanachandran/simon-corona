----------------------------------------------------------------------------------
--
-- playscreen.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

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
	scoreDisplay = display.newText( "Score: 0", 0, 0, "Helvetica", 24 )
	
	scoreDisplay:setTextColor(0, 0, 0)
	scoreDisplay.alpha = 1
	scoreDisplay.x = 0.8*display.contentWidth
	scoreDisplay.y = 0.05*display.contentHeight
	redSquare = display.newImage('res/red1.png')
	blueSquare = display.newImage('res/blue2.png')
	yellowSquare = display.newImage('res/yellow3.png')
	greenSquare = display.newImage('res/green4.png')

	restartButton = display.newImage('res/back.jpg')	
	restartButton.x = 0.05*display.contentWidth
	restartButton.y = 0.9*display.contentHeight
	local scaleSize = 0.2
	restartButton:scale(scaleSize,scaleSize)
	redSquare:scale(scaleSize,scaleSize)
	greenSquare:scale(scaleSize,scaleSize)
	blueSquare:scale(scaleSize,scaleSize)
	yellowSquare:scale(scaleSize,scaleSize)

	local xfirst = centerX - 0.1*display.contentWidth
	local xsecond = centerX + 0.1*display.contentWidth
	local yfirst = centerY - 0.1*display.contentHeight
	local ysecond = centerY + 0.1*display.contentHeight
	redSquare.x = xfirst
	redSquare.y = yfirst
	greenSquare.x = xfirst
	greenSquare.y = ysecond
	blueSquare.x = xsecond
	blueSquare.y = yfirst
	yellowSquare.x = xsecond
	yellowSquare.y = ysecond


	group:insert(redSquare)
	group:insert(greenSquare)
	group:insert(blueSquare)
	group:insert(yellowSquare)
	group:insert(scoreDisplay)

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

	local tab = { redSquare, greenSquare, blueSquare, yellowSquare }
	local numPanels = #tab -- could just change to 4
	local isRight
	local alive = true
	local count = 0
	local function flashPanel()
		if (count > 0) then
			transition.to (tab[sequence[count]], {time=1000, alpha=0.1})
			transition.to (tab[sequence[count]], {time=1000, delay=1500, alpha=1.0})
			count = count - 1
		end 
	end

	local function playGame()
		table.insert( sequence, math.random( numPanels ) )
		count = #sequence
		timer.performWithDelay( 2500, flashPanel, #sequence)
	end

	local function playGameOverSound()
	end

	-- true = correct, false = incorrect
	local function updateScore( upScore )
		if upScore == true then -- TODO: can we just say if upScore??
			score = score + 1
		else
			score = score - 1
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
			playGame()
		end

		currentPos = currentPos + 1
		return true
	end
	--can we change to iterate over all elements in 'tab', and add this eventlistener?

	local function goBack( event )
		storyboard.gotoScene( "homescreen", "slideLeft", 750 )
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