----------------------------------------------------------------------------------
--
-- gamecredits.lua
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

	creditsText1 = display.newText("Created by", 0, 0, "Glametrix", 26)
	creditsText1.alpha = 0
	creditsText1.x = centerX
	creditsText1.y = 0.2 * display.contentHeight
	creditsText1:setTextColor(255, 255, 255)

	creditsText2 = display.newText("Anojh Gnanachandran ", 0, 0, "Glametrix", 26)
	creditsText2.alpha = 0
	creditsText2.x = centerX
	creditsText2.y = 0.25 * display.contentHeight
	creditsText2:setTextColor(255, 255, 255)

	creditsText3 = display.newText("Created with the Corona", 0, 0, "Glametrix", 22)
	creditsText3.alpha = 0
	creditsText3.x = centerX
	creditsText3.y = 0.35 * display.contentHeight
	creditsText3:setTextColor(255, 255, 255)

	creditsText4 = display.newText("SDK and Lua.", 0, 0, "Glametrix", 22)
	creditsText4.alpha = 0
	creditsText4.x = centerX
	creditsText4.y = 0.40 * display.contentHeight
	creditsText4:setTextColor(255, 255, 255)

	creditsText5 = display.newText("", 0, 0, "Glametrix", 22)
	creditsText5.alpha = 0
	creditsText5.x = centerX
	creditsText5.y = 0.45 * display.contentHeight
	creditsText5:setTextColor(255, 255, 255)

	creditsText6 = display.newText("If you like this", 0, 0, "Glametrix", 22)
	creditsText6.alpha = 0
	creditsText6.x = centerX
	creditsText6.y = 0.55 * display.contentHeight
	creditsText6:setTextColor(255, 255, 255)

	creditsText7 = display.newText("game, consider buying the ", 0, 0, "Glametrix", 22)
	creditsText7.alpha = 0
	creditsText7.x = centerX
	creditsText7.y = 0.60 * display.contentHeight
	creditsText7:setTextColor(255, 255, 255)

	creditsText8 = display.newText("ad-free version or tapping ", 0, 0, "Glametrix", 22)
	creditsText8.alpha = 0
	creditsText8.x = centerX
	creditsText8.y = 0.65 * display.contentHeight
	creditsText8:setTextColor(255, 255, 255)

	creditsText9 = display.newText("any of the ads.", 0, 0, "Glametrix", 22)
	creditsText9.alpha = 0
	creditsText9.x = centerX
	creditsText9.y = 0.70 * display.contentHeight
	creditsText9:setTextColor(255, 255, 255)

	creditsText10 = display.newText("Thank you!", 0, 0, "Glametrix", 22)
	creditsText10.alpha = 0
	creditsText10.x = centerX
	creditsText10.y = 0.75 * display.contentHeight
	creditsText10:setTextColor(255, 255, 255)

	transition.to( borderbg, {time=1000, alpha=1})
	transition.to( restartButton, {time=1000, alpha=1})
	transition.to( creditsTitle, {time=1000, alpha=1})
	transition.to( creditsText1, {time=1000, alpha=1})
	transition.to( creditsText2, {time=1000, alpha=1})
	transition.to( creditsText3, {time=1000, alpha=1})
	transition.to( creditsText4, {time=1000, alpha=1})
	transition.to( creditsText5, {time=1000, alpha=1})
	transition.to( creditsText6, {time=1000, alpha=1})
	transition.to( creditsText7, {time=1000, alpha=1})
	transition.to( creditsText8, {time=1000, alpha=1})
	transition.to( creditsText9, {time=1000, alpha=1})
	transition.to( creditsText10, {time=1000, alpha=1})

	group:insert(borderbg)
	group:insert(restartButton)
	group:insert(creditsTitle)
	group:insert(creditsText1)
	group:insert(creditsText2)
	group:insert(creditsText3)
	group:insert(creditsText4)
	group:insert(creditsText5)
	group:insert(creditsText6)
	group:insert(creditsText7)
	group:insert(creditsText8)
	group:insert(creditsText9)
	group:insert(creditsText10)

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