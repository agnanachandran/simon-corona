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
local GGScore = require("GGScore")
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
local scoreText
local roundText
local timePlayedText
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

	leftOverSecs = secs % 60
	if leftOverSecs <= 9 then
		return math.floor(secs/60) .. ":0" .. leftOverSecs
	end
	return math.floor(secs/60) .. ":" .. leftOverSecs
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
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

	scoreText = display.newText("", 0, 0, "Glametrix", 26)
	roundText = display.newText("", 0, 0, "Glametrix", 26)
	timePlayedText = display.newText("", 0, 0, "Glametrix", 26)

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
	local group = self.view
	params = event.params
	local TRANSPARENT_TIME = 500
	local board = GGScore:new( "best", true )
	board:load()

	local widget = require( "widget" )
	local scores = board:getScores()


	scoreText.text = "Score: " .. params.finalScore
	scoreText:setReferencePoint(display.CenterLeftReferencePoint)
	scoreText.x = leftAlign
	scoreText.y = 0.2 * display.contentHeight

	roundText.text = "Round: " .. params.finalRound
	roundText:setReferencePoint(display.CenterLeftReferencePoint)
	roundText.x = leftAlign
	roundText.y = 0.30 * display.contentHeight

	timePlayedText.text = "Time played: " .. timeInMins( params.finalTime )
	timePlayedText:setReferencePoint(display.CenterLeftReferencePoint)
	timePlayedText.x = leftAlign
	timePlayedText.y = 0.40 * display.contentHeight

	gameoverTexts = {scoreText, roundText, timePlayedText}
	for i=1, #gameoverTexts do
		gameoverTexts[i].alpha = 0
		gameoverTexts[i]:setTextColor(255, 255, 255)
		transition.to( gameoverTexts[i], {time=TRANSPARENT_TIME, alpha=1} )
	end

	transition.to( borderbg, {time=TRANSPARENT_TIME, alpha=1})
	transition.to( restartButton, {time=TRANSPARENT_TIME, alpha=1})
	transition.to( gameoverTitle, {time=TRANSPARENT_TIME, alpha=1})

local listOptions = 
{
    top = 0,
    height = 480
}

local list = widget.newTableView( listOptions )

-- onRender listener for the tableView
local function onRowRender( event )

	print ('poop')
    local row = event.target
    local rowGroup = event.view

    local number = display.newRetinaText( "#" .. event.index .. " - ", 12, 0, "Helvetica-Bold", 18 )
    number:setReferencePoint( display.CenterLeftReferencePoint )
    number.x = 15
    number.y = row.height * 0.5
    number:setTextColor( 0, 0, 0 )

    local name = display.newRetinaText( scores[ event.index ].name, 12, 0, "Helvetica-Bold", 18 )
    name:setReferencePoint( display.CenterLeftReferencePoint )
    name.x = number.x + number.contentWidth
    name.y = row.height * 0.5
    name:setTextColor( 0, 0, 0 )

    local score = display.newRetinaText( scores[ event.index ].value, 12, 0, "Helvetica-Bold", 18 )
    score:setReferencePoint( display.CenterLeftReferencePoint )
    score.x = display.contentWidth - score.contentWidth - 20
    score.y = row.height * 0.5
    score:setTextColor( 0, 0, 0 )

    rowGroup:insert( number )
    rowGroup:insert( name )
    rowGroup:insert( score )

end

print(#scores)
for i = 1, #scores, 1 do
    list:insertRow
    {
        onRender = onRowRender,
        height = 40
    }
end


	group:insert(borderbg)
	group:insert(restartButton)
	group:insert(gameoverTitle)
	group:insert(scoreText)
	group:insert(roundText)
	group:insert(timePlayedText)

--------------------------------------------------------------

--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)

-----------------------------------------------------------------------------
end
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	transition.to(scoreText, {time=300, alpha=0})
	transition.to(roundText, {time=300, alpha=0})
	transition.to(timePlayedText, {time=300, alpha=0})
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