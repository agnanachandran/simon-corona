-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )

local storyboard = require "storyboard"

-- load scenetemplate.lua
storyboard.gotoScene( "homesceen" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):