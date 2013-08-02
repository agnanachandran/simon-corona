----------------------------------------------------------------------------------
--
-- difficulty.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local onEasyTap
local onMediumTap
local onHardTap
local onInsaneTap
local onEasyTapEnd
local onMediumTapEnd
local onHardTapEnd
local onInsaneTapEnd
----------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local transitionTime = 300
	local group = self.view

	local function onEasyTap( event )
		local phase = event.phase
		local target = event.target
		if ( "ended" == phase ) then
			onEasyTapEnd()
	end
	return true
end
	local function onMediumTap( event )
		local phase = event.phase
		local target = event.target
		if ( "ended" == phase ) then
			onMediumTapEnd()
	end
	return true
end
	local function onHardTap( event )
		local phase = event.phase
		local target = event.target
		if ( "ended" == phase ) then
			onHardTapEnd()
	end
	return true
end
	local function onInsaneTap( event )
		local phase = event.phase
		local target = event.target
		if ( "ended" == phase ) then
			onInsaneTapEnd()
	end
	return true
end

easyButton = widget.newButton
{
	top = 250,
	label = "Easy",
	labelAlign = "center",
	fontSize = 30,
	labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
	onEvent = onEasyTap
}

easyButton.baseLabel = "Easy"
easyButton.x = centerX
easyButton.alpha = 0
transition.to( easyButton, { time = transitionTime, alpha = 1 } )

mediumButton = widget.newButton
{
	top = 300,
	label = "Medium",
	labelAlign = "center",
	fontSize = 30,
	labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
	onEvent = onEasyTap
}

mediumButton.baseLabel = "Medium"
mediumButton.x = centerX
mediumButton.alpha = 0
transition.to( mediumButton, { time = transitionTime, alpha = 1 } )

hardButton = widget.newButton
{
	top = 350,
	label = "Hard",
	labelAlign = "center",
	fontSize = 30,
	labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
	onEvent = onEasyTap
}

hardButton.baseLabel = "Hard"
hardButton.x = centerX
hardButton.alpha = 0
transition.to( hardButton, { time = transitionTime, alpha = 1 } )

insaneButton = widget.newButton
{
	top = 400,
	label = "Insane",
	labelAlign = "center",
	fontSize = 30,
	labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
	onEvent = onEasyTap
}

insaneButton.baseLabel = "Insane"
insaneButton.x = centerX
insaneButton.alpha = 0
transition.to( insaneButton, { time = transitionTime, alpha = 1 } )

group:insert(easyButton)
group:insert(mediumButton)
group:insert(hardButton)
group:insert(insaneButton)
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
function onEasyTapEnd()
	local options = {
	effect = "slideLeft",
	time = 300,
	params = {difficulty = "easy"}
}
storyboard.gotoScene( 'playscreen', options )
end
function onMediumTapEnd()
	local options = 
	{
	effect = "slideLeft",
	time = 300,
	params = {difficulty = "medium"}
}
storyboard.gotoScene( 'playscreen', options )
end
function onHardTapEnd()
	local options = 
	{
	effect = "slideLeft",
	time = 300,
	params = {difficulty = "hard"}
}
storyboard.gotoScene( 'playscreen', options )
end
function onInsaneTapEnd()
	local options = 
	{
	effect = "slideLeft",
	time = 300,
	params = {difficulty = "insane"}
}
storyboard.gotoScene( 'playscreen', options )
end
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