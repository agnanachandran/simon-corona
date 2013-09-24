----------------------------------------------------------------------------------
--
-- playscreen.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local device = require( "device" )
local GGScore = require( "GGScore")
local scene = storyboard.newScene()

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

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------
local wheel

local redPanel
local greenPanel
local bluePanel
local yellowPanel

local restartButton

local difficulty
local panelOnTime
local timeBetweenPanelChange
local score = 0
local currentPos = 1
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local sequence = {}
local scoreText
local scoreDisplay
local roundNumber
local updateGame
local timeSinceStartedGame
local xSpace = 0.22
local ySpace = 0.147
local xfirst = centerX - xSpace*display.contentWidth
local xsecond = centerX + xSpace*display.contentWidth
local yfirst = centerY - ySpace*display.contentHeight
local ysecond = centerY + ySpace*display.contentHeight

local board = GGScore:new( "best", true )
board:setDefaultName("Bob Sr.")
board:setDefaultScore(0)
board:setMaxNameLength(13)
board:setMaxScoreLength( 6 )

-- constants
SCORE_INCREMENT = 100
DEFAULT_ALPHA = 0.8
LIST_OF_TIMERS = {}

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	timeSinceStartedGame = system.getTimer()
	-- GLOBAL SPEAKER
	-- speakerButton = display.newImage('res/speaker_on.png')
	-- speakerButton:scale(0.08, 0.08)
	-- speakerButton.x = 0.1*display.contentWidth
	-- speakerButton.y = 0.92*display.contentHeight

	-- musicButton = display.newImage('res/music_on.png')
	-- musicButton:scale(0.1, 0.1)
	-- musicButton.x = 0.9*display.contentWidth
	-- musicButton.y = 0.92*display.contentHeight
	-- group:insert(speakerButton)
	-- group:insert(musicButton)

	scaleSize = 0.3

	-- Background wheel for 4 coloured panels
	wheel = display.newImage('res/wheel.png')
	wheel.x = 0.5*display.contentWidth
	wheel.y = 0.5*display.contentHeight
	wheel:scale(scaleSize, scaleSize)

	roundNumber = 1

	roundDisplay = display.newText( "Round: " .. roundNumber, 0, 0, "Glametrix", 29)
	roundDisplay:setTextColor(0, 0, 0) -- white
	roundDisplay.alpha = 1
	roundDisplay.x = 0.85*display.contentWidth
	roundDisplay.y = 0.08*display.contentHeight

	scoreText = display.newText( "Score:", 0, 0, "Let's go Digital", 25 )
	scoreText:setTextColor(255, 255, 255) -- white
	scoreText.alpha = 1
	scoreText.x = centerX
	scoreText.y = 0.42 * display.contentHeight

	scoreDisplay = display.newText( "00", 0, 0, "Let's go Digital", 38 )
	scoreDisplay:setTextColor(255, 255, 255) -- white
	scoreDisplay.alpha = 1
	scoreDisplay.x = centerX
	scoreDisplay.y = 0.50*display.contentHeight

	restartButton = display.newImage('res/restart.png')	
	restartButton.x = 0.1*display.contentWidth
	restartButton.y = 0.1*display.contentHeight

	restartButton:scale(scaleSize,scaleSize)

	function showDefaultPanels()
		redPanel = display.newImage('res/red1.png')
		bluePanel = display.newImage('res/blue2.png')
		yellowPanel = display.newImage('res/yellow3.png')
		greenPanel = display.newImage('res/green4.png')

		redPanel:scale(scaleSize,scaleSize)
		bluePanel:scale(scaleSize,scaleSize)
		yellowPanel:scale(scaleSize,scaleSize)
		greenPanel:scale(scaleSize,scaleSize)

		redPanel.alpha = DEFAULT_ALPHA
		bluePanel.alpha = DEFAULT_ALPHA
		yellowPanel.alpha = DEFAULT_ALPHA
		greenPanel.alpha = DEFAULT_ALPHA

		redPanel.x = xfirst
		redPanel.y = yfirst
		bluePanel.x = xsecond
		bluePanel.y = yfirst
		yellowPanel.x = xsecond
		yellowPanel.y = ysecond
		greenPanel.x = xfirst
		greenPanel.y = ysecond
	end

	showDefaultPanels()

	group:insert(wheel)
	group:insert(redPanel)
	group:insert(bluePanel)
	group:insert(yellowPanel)
	group:insert(greenPanel)
	group:insert(restartButton)
	group:insert(scoreText)
	group:insert(scoreDisplay)
	group:insert(roundDisplay)

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
	storyboard.returnTo = "homescreen"
	-- *** Possibly, but probably shouldn't, move to createScene instead (like it used to be)
	panels = { redPanel, bluePanel, yellowPanel, greenPanel }

	function addEventListeners()
		for i=1,#panels do
			panels[i]:addEventListener('tap', updateGame)
		end
	end

	function removeEventListeners()
		for i=1,#panels do
			panels[i]:removeEventListener('tap', updateGame)
		end
	end


	difficulty = event.params.difficulty
	if difficulty == "easy" then
		panelOnTime = 2000
		timeBetweenPanelChange = 50
	elseif difficulty == "medium" then
		panelOnTime = 1500
		timeBetweenPanelChange = 50
		-- Hard and insane have the same time delay.
	else
		panelOnTime = 500
		timeBetweenPanelChange = 50
	end

	local group = self.view
	local difficulty = event.params.difficulty

	local numPanels = #panels
	local isRight
	local alive = true
	panelSequenceCount = 0
	score = 0

	function actuallyFlashPanel(panelNumber, oldX, oldY)
		if panels[panelNumber] == redPanel then
				group:remove(redPanel)
				redPanel = display.newImage('res/red1_on.png')
				redPanel.x = oldX
				redPanel.y = oldY
				redPanel:scale(scaleSize, scaleSize)
				panels[panelNumber] = redPanel
				group:insert(redPanel)
			elseif panels[panelNumber] == bluePanel then
				group:remove(bluePanel)
				bluePanel = display.newImage('res/blue2_on.png')
				bluePanel.x = oldX
				bluePanel.y = oldY
				bluePanel:scale(scaleSize, scaleSize)
				panels[panelNumber] = bluePanel
				group:insert(bluePanel)
			elseif panels[panelNumber] == yellowPanel then
				group:remove(yellowPanel)
				yellowPanel = display.newImage('res/yellow3_on.png')
				yellowPanel.x = oldX
				yellowPanel.y = oldY
				yellowPanel:scale(scaleSize, scaleSize)
				panels[panelNumber] = yellowPanel
				group:insert(yellowPanel)
			elseif panels[panelNumber] == greenPanel then
				group:remove(greenPanel)
				greenPanel = display.newImage('res/green4_on.png')
				greenPanel.x = oldX
				greenPanel.y = oldY
				greenPanel:scale(scaleSize, scaleSize)
				panels[panelNumber] = greenPanel
				group:insert(greenPanel)
		end
	end

	function actuallyTurnOffPanel(panelNumber, oldX, oldY, turnOnPanelListener)
		if panels[panelNumber] == redPanel then
			group:remove(redPanel)
			redPanel = display.newImage('res/red1.png')
			redPanel.x = oldX
			redPanel.y = oldY
			redPanel.alpha = DEFAULT_ALPHA
			redPanel:scale(scaleSize, scaleSize)
			panels[panelNumber] = redPanel
			group:insert(redPanel)
		elseif panels[panelNumber] == bluePanel then
			group:remove(bluePanel)
			bluePanel = display.newImage('res/blue2.png')
			bluePanel.x = oldX
			bluePanel.y = oldY
			bluePanel.alpha = DEFAULT_ALPHA
			bluePanel:scale(scaleSize, scaleSize)
			panels[panelNumber] = bluePanel
			group:insert(bluePanel)
		elseif panels[panelNumber] == yellowPanel then
			group:remove(yellowPanel)
			yellowPanel = display.newImage('res/yellow3.png')
			yellowPanel.x = oldX
			yellowPanel.y = oldY
			yellowPanel.alpha = DEFAULT_ALPHA
			yellowPanel:scale(scaleSize, scaleSize)
			panels[panelNumber] = yellowPanel
			group:insert(yellowPanel)
		elseif panels[panelNumber] == greenPanel then
			group:remove(greenPanel)
			greenPanel = display.newImage('res/green4.png')
			greenPanel.x = oldX
			greenPanel.y = oldY
			greenPanel.alpha = DEFAULT_ALPHA
			greenPanel:scale(scaleSize, scaleSize)
			panels[panelNumber] = greenPanel
			group:insert(greenPanel)
		end
		if turnOnPanelListener then
			panels[panelNumber]:addEventListener('tap', updateGame)
		end

	end
	
	function flashPanel()
			panelNumber = sequence[panelSequenceCount]
			panelSequenceCount = panelSequenceCount + 1
			oldX = panels[panelNumber].x -- x-coord of panel
			oldY = panels[panelNumber].y -- y-coord of panel

			actuallyFlashPanel(panelNumber, oldX, oldY)

			function turnOffPanel()
				doAddPanelListener = false
				actuallyTurnOffPanel(panelNumber, oldX, oldY, doAddPanelListener)			

				if panelSequenceCount - 1 == #sequence then
					addEventListeners()
				end

			end

			LIST_OF_TIMERS[#LIST_OF_TIMERS + 1] = timer.performWithDelay(panelOnTime, turnOffPanel)
	end

	function playGame()
		table.insert( sequence, math.random( numPanels ) )

		-- insane mode = 2 panels added each round
		if difficulty == "insane" then
			table.insert( sequence, math.random( numPanels ) )
		end
		panelSequenceCount = 1

		-- Start flash sequence immediately, then start with delayed panels
		-- flashPanel()
		LIST_OF_TIMERS[#LIST_OF_TIMERS + 1] = timer.performWithDelay( panelOnTime * 2, flashPanel, #sequence)
	end

	function gameOver()
		secondsPlayed = math.floor((system.getTimer() - timeSinceStartedGame)/1000)
		board:add( roundNumber .. " " .. difficulty .. " " .. secondsPlayed, score )
		board:print()
		board:save()
		local options =
		{
			effect = "fade",
			time = 300,
			params = {gameDifficulty = difficulty, finalScore = score, finalRound = roundNumber, finalTime = secondsPlayed}
		}
		storyboard.gotoScene("gameover", options) -- change to gameover scene
	end

	function updateScore()
		score = score + SCORE_INCREMENT
		scoreDisplay.text = score
	end

	local function updateRoundNumber()
		roundNumber = roundNumber + 1
		roundDisplay.text = "Round: " .. roundNumber
	end

	function updateGame( event )
		local obj = event.target
		local function flashTappedPanel()
			currentPanelNumber = 0
			if panels[1] == obj then
				currentPanelNumber = 1
			elseif panels[2] == obj then
				currentPanelNumber = 2
			elseif panels[3] == obj then
				currentPanelNumber = 3
			else
				currentPanelNumber = 4
			end
			oldX = panels[currentPanelNumber].x -- x-coord of panel
			oldY = panels[currentPanelNumber].y -- y-coord of panel
			actuallyFlashPanel(currentPanelNumber, oldX, oldY)
			
			-- Lua closure necessary to pass in parameters to 'actuallyTurnOffPanel'
			local turnOffPanelClosure = function()
				if currentPos == #sequence then
					actuallyTurnOffPanel (currentPanelNumber, oldX, oldY, false)
				else
					actuallyTurnOffPanel (currentPanelNumber, oldX, oldY, true)
				end

				-- If we're at the end of the sequence, reset currentPos to 1, and remove event listeners immediately
				if currentPos == #sequence then
					currentPos = 1
					LIST_OF_TIMERS[#LIST_OF_TIMERS + 1] = timer.performWithDelay(1, removeEventListeners) -- necessary, must have a tiny delay for some unknown reason
					return playGame()
				else
					currentPos = currentPos + 1
				end
			end
			LIST_OF_TIMERS[#LIST_OF_TIMERS + 1] = timer.performWithDelay(100, turnOffPanelClosure)
		end

		-- If the panel tapped is the same as the one in the correct position, flash + turn off the panel and update the score/round numbers
		if panels[sequence[currentPos]] == obj then
			flashTappedPanel()
			updateScore()
			if currentPos == #sequence then
				updateRoundNumber()
			end
		-- Otherwise, game over :(
		else
			flashTappedPanel()
			gameOver()
			return true
		end

		return true
	end

	local function goBack( event )
		local effects =
		{
			effect = "slideRight",
			time = 750,
		}
		storyboard.gotoScene( "homescreen", effects )
	end

	restartButton:addEventListener('tap', goBack)
	-- start game loop
	playGame()

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	removeEventListeners()

	-- CANCEL ALL TIMERS
	for i=1,#LIST_OF_TIMERS do
		timer.cancel(LIST_OF_TIMERS[i])
	end

	storyboard.removeScene("playscreen")
	-- *** Solution to crashing bug: Reset all display objects? We need to stop the functions from running again.
	-- *** OR, we can disable the restart button/make the back button do nothing while the flashing sequence is being 'played'
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
