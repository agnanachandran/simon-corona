local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- imports
require( "tilebg" )

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

local score = 0
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local background = tileBG('bg.png', 27, 15)
local addMenuScreen
local menuScreen
local showStart
local showInstructions
local showSettings
local showCredits
local titleText
local startGameText
local instructionsText
local startGame
local addGameScreen
local x
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.

-- Called when the scene's view does not exist:
function scene:createScene( event )
	-- local tab = { titleText, startGameText, instructionsText, settingsText, creditsText }
	-- for x in ipairs(tab) do
	-- 	x.alpha = 0
	-- 	x.x = centerX
	-- 	x:setTextColor(0, 0, 0)
	-- end
	local group = self.view
	function addMenuScreen()
		titleText = display.newText( "Simon", 0, 0, "Helvetica", 30 )
		titleText.alpha = 0
		titleText.x = centerX
		titleText.y = 200
		titleText:setTextColor(0, 0, 0)
		group:insert(titleText)
		transition.to( titleText, { time = 500, alpha = 1, onComplete = showStart } )
	end

	function showStart()
		startGameText = display.newText( "Start", 0, 0, "Helvetica", 30 )
		startGameText.alpha = 0
		startGameText.x = centerX
		startGameText.y = 280
		startGameText:setTextColor(0, 0, 0)
		group:insert(startGameText)
		transition.to( startGameText, { time = 500, alpha = 1, onComplete = showInstructions } )
	end

	function showInstructions()
		instructionsText = display.newText( "Instructions", 0, 0, "Helvetica", 30 )
		instructionsText.alpha = 0
		instructionsText.x = centerX
		instructionsText.y = 320
		instructionsText:setTextColor(0, 0, 0)
		group:insert(instructionsText)
		transition.to( instructionsText, { time = 500, alpha = 1, onComplete = showSettings } )
	end

	function showSettings()
		settingsText = display.newText( "Settings", 0, 0, "Helvetica", 30 )
		settingsText.alpha = 0
		settingsText.x = centerX
		settingsText.y = 360
		settingsText:setTextColor(0, 0, 0)
		group:insert(settingsText)
		transition.to( settingsText, { time = 500, alpha = 1, onComplete = showCredits} )
	end

	function showCredits()
		creditsText = display.newText( "Credits", 0, 0, "Helvetica", 30 )
		creditsText.alpha = 0
		creditsText.x = centerX
		creditsText.y = 400
		creditsText:setTextColor(0, 0, 0)
		group:insert(creditsText)
		transition.to( creditsText, { time = 500, alpha = 1} )
		startGameText:addEventListener( 'tap', x)
	end

	addMenuScreen()
--	CREATE display objects and add them to 'group' here.
--	Example use-case: Restore 'group' from previously saved state.

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	function x() 
		local options =
		{
		effect = "slideUp",
		time = 800,
		}
		storyboard.gotoScene( "playscreen", options)
	end
	
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end
-- Called when scene is about to move offscreen:

function scene:exitScene( event )
	
--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
end

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

return scene