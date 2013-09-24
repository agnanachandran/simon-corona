-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )
local storyboard = require "storyboard"



-- load scenetemplate.lua
storyboard.gotoScene( "homescreen" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
local function onKeyEvent( event )

	local phase = event.phase
	local keyName = event.keyName
	print( event.phase, event.keyName )

	if ( "back" == keyName and phase == "up" ) then
		if ( storyboard.currentScene == "homescreen" ) then
			native.requestExit()
		else
			local lastScene = storyboard.returnTo
			print( "previous scene", lastScene )
			if ( lastScene ) then
				storyboard.gotoScene( lastScene, { effect="crossFade", time=500 } )
			else
				native.requestExit()
			end
		end
	end
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )