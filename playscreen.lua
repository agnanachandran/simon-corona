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
	scoreDisplay = display.newText( "Score:", 0, 0, "Helvetica", 30 )
	
	scoreDisplay:setTextColor(0, 0, 0)
	scoreDisplay.alpha = 1
	scoreDisplay.x = centerX
	scoreDisplay.y = centerY
	
	redSquare = display.newImage('red.jpg')
	greenSquare = display.newImage('red.jpg') -- change these images
	blueSquare = display.newImage('red.jpg')
	yellowSquare = display.newImage('red.jpg')


	redSquare:scale(0.1,0.1)
	greenSquare:scale(0.1,0.1)
	blueSquare:scale(0.1,0.1)
	yellowSquare:scale(0.1,0.1)

	local xfirst = centerX - 0.1*display.contentWidth
	local xsecond = centerX + 0.1*display.contentWidth
	local yfirst = centerY - 0.1*display.contentHeight
	local ysecond = centerY + 0.1*display.contentHeight
	redSquare.x = xfirst
	redSquare.y = yfirst
	greenSquare.x = xsecond
	greenSquare.y = yfirst
	blueSquare.x = xfirst
	blueSquare.y = ysecond
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
	local tab = { redSquare, greenSquare, blueSquare, yellowSquare }
	local numPanels = #tab -- could just change to 4
	local isRight
--------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	local function updateScore( upScore)
		if upScore == true then
			score = score + 1
		else
			score = score - 1
		end
		scoreDisplay.text = "Score: " .. score
	end

	local function updateGame( event )
		local obj = event.target
		table.insert( sequence, math.random( numPanels ) )
	
		if tab[sequence[currentPos]] == obj then
			updateScore( true )
		else
			updateScore( false )
		end

		currentPos = currentPos + 1
		return true
	end
-- change to iterate over all elements in 'tab', and add this eventlistener
	redSquare:addEventListener('tap', updateGame)
	greenSquare:addEventListener('tap', updateGame)
	yellowSquare:addEventListener('tap', updateGame)
	blueSquare:addEventListener('tap', updateGame)

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