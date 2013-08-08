----------------------------------------------------------------------------------
--
-- credits.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local device = require( "device")
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------
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
local centerY = display.contentCenterY
local borderbg
local creditsTitle
local creditsText
local restartButton
----------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

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

	creditsTitle = display.newText( "Credits", 0, 0, "Glametrix", 32 )
	creditsTitle.alpha = 0
	creditsTitle.x = centerX
	creditsTitle.y = 0.1 * display.contentHeight
	creditsTitle:setTextColor(255, 0, 0)

	instructionsText1 = display.newText("Created by", 0, 0, "Glametrix", 26)
	instructionsText1.alpha = 0
	instructionsText1.x = centerX
	instructionsText1.y = 0.2 * display.contentHeight
	instructionsText1:setTextColor(255, 255, 255)

	instructionsText2 = display.newText("Anojh Gnanachandran ", 0, 0, "Glametrix", 26)
	instructionsText2.alpha = 0
	instructionsText2.x = centerX
	instructionsText2.y = 0.25 * display.contentHeight
	instructionsText2:setTextColor(255, 255, 255)

	instructionsText3 = display.newText("Created with the Corona", 0, 0, "Glametrix", 22)
	instructionsText3.alpha = 0
	instructionsText3.x = centerX
	instructionsText3.y = 0.35 * display.contentHeight
	instructionsText3:setTextColor(255, 255, 255)

	instructionsText4 = display.newText("SDK and Lua.", 0, 0, "Glametrix", 22)
	instructionsText4.alpha = 0
	instructionsText4.x = centerX
	instructionsText4.y = 0.40 * display.contentHeight
	instructionsText4:setTextColor(255, 255, 255)

	instructionsText5 = display.newText("", 0, 0, "Glametrix", 22)
	instructionsText5.alpha = 0
	instructionsText5.x = centerX
	instructionsText5.y = 0.45 * display.contentHeight
	instructionsText5:setTextColor(255, 255, 255)

	instructionsText6 = display.newText("Your job is to repeat the", 0, 0, "Glametrix", 22)
	instructionsText6.alpha = 0
	instructionsText6.x = centerX
	instructionsText6.y = 0.55 * display.contentHeight
	instructionsText6:setTextColor(255, 255, 255)

	instructionsText7 = display.newText("pattern. It will successively", 0, 0, "Glametrix", 22)
	instructionsText7.alpha = 0
	instructionsText7.x = centerX
	instructionsText7.y = 0.60 * display.contentHeight
	instructionsText7:setTextColor(255, 255, 255)

	instructionsText8 = display.newText("increase in size after", 0, 0, "Glametrix", 22)
	instructionsText8.alpha = 0
	instructionsText8.x = centerX
	instructionsText8.y = 0.65 * display.contentHeight
	instructionsText8:setTextColor(255, 255, 255)

	instructionsText9 = display.newText("each round. Make one wrong", 0, 0, "Glametrix", 22)
	instructionsText9.alpha = 0
	instructionsText9.x = centerX
	instructionsText9.y = 0.70 * display.contentHeight
	instructionsText9:setTextColor(255, 255, 255)

	instructionsText10 = display.newText("move and it's game over.", 0, 0, "Glametrix", 22)
	instructionsText10.alpha = 0
	instructionsText10.x = centerX
	instructionsText10.y = 0.75 * display.contentHeight
	instructionsText10:setTextColor(255, 255, 255)

	instructionsText11 = display.newText("Good luck!", 0, 0, "Glametrix", 22)
	instructionsText11.alpha = 0
	instructionsText11.x = centerX
	instructionsText11.y = 0.85 * display.contentHeight
	instructionsText11:setTextColor(255, 255, 255)

	transition.to( borderbg, {time=1000, alpha=1})
	transition.to( restartButton, {time=1000, alpha=1})
	transition.to( creditsTitle, {time=1000, alpha=1})
	transition.to( instructionsText1, {time=1000, alpha=1})
	transition.to( instructionsText2, {time=1000, alpha=1})
	transition.to( instructionsText3, {time=1000, alpha=1})
	transition.to( instructionsText4, {time=1000, alpha=1})
	transition.to( instructionsText5, {time=1000, alpha=1})
	transition.to( instructionsText6, {time=1000, alpha=1})
	transition.to( instructionsText7, {time=1000, alpha=1})
	transition.to( instructionsText8, {time=1000, alpha=1})
	transition.to( instructionsText9, {time=1000, alpha=1})
	transition.to( instructionsText10, {time=1000, alpha=1})
	transition.to( instructionsText11, {time=1000, alpha=1})
	group:insert(borderbg)
	group:insert(restartButton)
	group:insert(creditsTitle)
	group:insert(instructionsText1)
	group:insert(instructionsText2)
	group:insert(instructionsText3)
	group:insert(instructionsText4)
	group:insert(instructionsText5)
	group:insert(instructionsText6)
	group:insert(instructionsText7)
	group:insert(instructionsText8)
	group:insert(instructionsText9)
	group:insert(instructionsText10)
	group:insert(instructionsText11)

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