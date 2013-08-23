----------------------------------------------------------------------------------
--
-- gameover.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local device = require( "device")
local ads = require( "ads" )
local scene = storyboard.newScene()


----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

-- The name of the ad provider.
local provider = "admob"

-- Your application ID
local appID = "YOUR_APPLICATION_ID_HERE"


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

local centerX = display.contentCenterX
local leftAlign = centerX - 0.3 * display.contentWidth
local centerY = display.contentCenterY
local borderbg
local gameOverTitle
local gameoverTexts = {gameoverText1,gameoverText2, gameoverText3, gameoverText4, gameoverText5, gameoverText6, gameoverText7}
local restartButton
----------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function timeInMins( secs ) 
	if secs <= 59 then
		if secs <= 9 then
			return "0:0" .. secs
		end
		return "0:" .. secs
	end
	return math.floor(secs/60) .. ":" .. secs % 60
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	local params = event.params

	local scaleSize = 0.2
	restartButton = display.newImage('res/restart.png')
	restartButton.alpha = 0
	restartButton.x = 0.12*display.contentWidth
	restartButton.y = 0.1*display.contentHeight

	restartButton:scale(scaleSize,scaleSize)

	borderbg = display.newImage('res/borderbg.png')
	borderbg.alpha = 0
	borderbg.x = centerX
	borderbg.y = centerY
	borderbg:scale(0.8, 0.8)

	gameoverTitle = display.newText( "Game Over", 0, 0, "Glametrix", 32 )
	gameoverTitle.alpha = 0
	gameoverTitle.x = centerX
	gameoverTitle.y = 0.1 * display.contentHeight
	gameoverTitle:setTextColor(255, 0, 0)


	gameoverText1 = display.newText("Score: " .. params.finalScore, 0, 0, "Glametrix", 26)
	gameoverText1:setReferencePoint(display.CenterLeftReferencePoint)
	gameoverText1.x = leftAlign
	gameoverText1.y = 0.2 * display.contentHeight

	gameoverText2 = display.newText("Round: " .. params.finalRound, 0, 0, "Glametrix", 26)
	gameoverText2:setReferencePoint(display.CenterLeftReferencePoint)
	gameoverText2.x = leftAlign
	gameoverText2.y = 0.30 * display.contentHeight

	gameoverText3 = display.newText("Time played: " .. timeInMins( params.finalTime ), 0, 0, "Glametrix", 22)
	gameoverText3:setReferencePoint(display.CenterLeftReferencePoint)
	gameoverText3.x = leftAlign
	gameoverText3.y = 0.40 * display.contentHeight

	gameoverText4 = display.newText("SDK and Lua.", 0, 0, "Glametrix", 22)
	gameoverText4:setReferencePoint(display.CenterLeftReferencePoint)
	gameoverText4.x = leftAlign
	gameoverText4.y = 0.45 * display.contentHeight

	gameoverText5 = display.newText("", 0, 0, "Glametrix", 22)
	gameoverText5.x = leftAlign
	gameoverText5.y = 0.5 * display.contentHeight

	gameoverText6 = display.newText("Your job is to repeat the", 0, 0, "Glametrix", 22)
	gameoverText6.x = leftAlign
	gameoverText6.y = 0.6 * display.contentHeight

	gameoverText7 = display.newText("pattern. It will successively", 0, 0, "Glametrix", 22)
	gameoverText7.x = leftAlign
	gameoverText7.y = 0.70 * display.contentHeight

	gameoverTexts = {gameoverText1,gameoverText2, gameoverText3, gameoverText4, gameoverText5, gameoverText6, gameoverText7}
	
	for i=1, #gameoverTexts do 
		gameoverTexts[i].alpha = 0
		gameoverTexts[i]:setTextColor(255, 255, 255)
		transition.to( gameoverTexts[i], {time=1000, alpha=1} )
		group:insert( gameoverTexts[i] )
	end

	transition.to( borderbg, {time=1000, alpha=1})
	transition.to( restartButton, {time=1000, alpha=1})
	transition.to( gameoverTitle, {time=1000, alpha=1})

	group:insert(borderbg)
	group:insert(restartButton)
	group:insert(gameoverTitle)
	group:insert(gameoverText1)
	group:insert(gameoverText2)
	group:insert(gameoverText3)
	group:insert(gameoverText4)
	group:insert(gameoverText5)
	group:insert(gameoverText6)
	group:insert(gameoverText7)

	local function goBack( event )
		local effects =
		{
		effect = "fade",
		time = 300,
		}
		storyboard.gotoScene( "homescreen", effects )
		-- storyboard.removeScene( "playscreen" )
	end

	-- listeners
	restartButton:addEventListener('tap', goBack)

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