local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()

-- imports
require( "tilebg" )

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

local score = 0
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local background = tileBG('res/bg.png', 27, 15)
local addMenuScreen
local menuScreen
local showStart
local showInstructions
local showSettings
local showCredits
local titleText
local startGameButton
local instructionsText
local showDifficulty
local showInstructionsText
local showSettingsText
local showCreditsText
--  Code outside of listener functions (below) will only be executed once,
--  unless storyboard.removeScene() is called.

-- Called when the scene's view does not exist:
function scene:createScene( event )
    -- local tab = { titleText, startGameText, instructionsText, settingsText, creditsText }
    -- for x in ipairs(tab) do
    --  x.alpha = 0
    --  x.x = centerX
    --  x:setTextColor(0, 0, 0)
    -- end

    local transitionTime = 300

    local group = self.view

    local scaleSize = 0.15

    -- Background wheel for 4 coloured panels
    wheel = display.newImage('res/wheel.png')
    wheel.x = 0.5*display.contentWidth
    wheel.y = 0.2*display.contentHeight
    wheel:scale(scaleSize, scaleSize)

    redSquare = display.newImage('res/red1.png')
    blueSquare = display.newImage('res/blue2.png')
    yellowSquare = display.newImage('res/yellow3.png')
    greenSquare = display.newImage('res/green4.png')

    redSquare:scale(scaleSize,scaleSize)
    greenSquare:scale(scaleSize,scaleSize)
    blueSquare:scale(scaleSize,scaleSize)
    yellowSquare:scale(scaleSize,scaleSize)

    local spaceApart = 0.12
    upCenterY = 0.3*centerY
    local xfirst = centerX - spaceApart*display.contentWidth
    local xsecond = centerX + spaceApart*display.contentWidth
    local yfirst = upCenterY - 0.025*display.contentHeight
    local ysecond = upCenterY + 0.115*display.contentHeight
    redSquare.x = xfirst
    redSquare.y = yfirst
    greenSquare.x = xfirst
    greenSquare.y = ysecond
    blueSquare.x = xsecond
    blueSquare.y = yfirst
    yellowSquare.x = xsecond
    yellowSquare.y = ysecond

    group:insert(wheel)
    group:insert(blueSquare)
    group:insert(redSquare)
    group:insert(greenSquare)
    group:insert(yellowSquare)
    function addMenuScreen()
        titleText = display.newText( "Simon", 0, 0, "Helvetica", 30 )
        titleText.alpha = 0
        titleText.x = centerX
        titleText.y = 200
        titleText:setTextColor(0, 0, 0)
        group:insert(titleText)
        transition.to( titleText, { time = 300, alpha = 1, onComplete = showStart } )
    end

    -- START FUNCTION
    function showStart()

        local function onStartTap( event )
            local phase = event.phase
            local target = event.target
            if ( "ended" == phase ) then
                showDifficulty()
            end
            return true
        end

        startGameButton = widget.newButton
        {
            top = 250,
            label = "Play",
            labelAlign = "center",
            fontSize = 30,
            labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
            onEvent = onStartTap
        }

        startGameButton.baseLabel = "Play"
        startGameButton.x = centerX
        startGameButton.alpha = 0

        group:insert(startGameButton)
        transition.to( startGameButton, { time = transitionTime, alpha = 1, onComplete = showInstructions } )
    end

    function showInstructions()

        local function onInstructionsTap( event )
            local phase = event.phase
            local target = event.target
            if ( "ended" == phase ) then
                showInstructionsText()
            end
            return true
        end

        instructionsButton = widget.newButton
        {
            top = 310,
            label = "Instructions",
            labelAlign = "center",
            fontSize = 30,
            labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
            onEvent = onInstructionsTap
        }
        instructionsButton.baseLabel = "Instructions"
        instructionsButton.x = centerX
        instructionsButton.alpha = 0

        group:insert(instructionsButton)
        transition.to( instructionsButton, { time = transitionTime, alpha = 1, onComplete = showSettings } )
    end

    function showSettings()

        local function onSettingsTap( event )
            local phase = event.phase
            local target = event.target
            if ( "ended" == phase ) then
                showSettingsText()
            end
            return true
        end

        settingsButton = widget.newButton
        {
            top = 370,
            label = "Settings",
            labelAlign = "center",
            fontSize = 30,
            labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
            onEvent = onSettingsTap
        }
        settingsButton.baseLabel = "Settings"
        settingsButton.x = centerX
        settingsButton.alpha = 0

        group:insert(settingsButton)
        transition.to( settingsButton, { time = transitionTime, alpha = 1, onComplete = showCredits} )
    end

    function showCredits()

        local function onCreditsTap( event )
            local phase = event.phase
            local target = event.target
            if ( "ended" == phase ) then
                showCreditsText()
            end
            return true
        end

        creditsButton = widget.newButton
        {
            top = 430,
            label = "Credits",
            labelAlign = "center",
            fontSize = 30,
            labelColor = { default = {59, 89, 152}, over = {69, 99, 162} },
            onEvent = onSettingsTap
        }
        creditsButton.baseLabel = "Credits"
        creditsButton.x = centerX
        creditsButton.alpha = 0

        group:insert(creditsButton)
        transition.to( creditsButton, { time = transitionTime, alpha = 1} )
    end

    addMenuScreen()
    --  CREATE display objects and add them to 'group' here.
    --  Example use-case: Restore 'group' from previously saved state.

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    storyboard.removeScene("playscreen")
    function showDifficulty() 
        local options =
        {
            effect = "slideLeft",
            time = 300,
        }
        storyboard.gotoScene( "difficulty", options)
    end

    function showInstructionsText()
        -- local effects =
        -- {
        -- effect = "slideLeft",
        -- time = 300,
        -- }
        -- storyboard.gotoScene( "playscreen", effects)
    end

    function showSettingsText()
        -- local effects =
        -- {
        -- effect = "slideLeft",
        -- time = 300,
        -- }
        -- storyboard.gotoScene( "playscreen", effects)
    end

    function showCreditsText()
        -- local effects =
        -- {
        -- effect = "slideLeft",
        -- time = 300,
        -- }
        -- storyboard.gotoScene( "playscreen", effects)
    end

    --  INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end
-- Called when scene is about to move offscreen:

function scene:exitScene( event )

    --  INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )

    --  INSERT code here (e.g. remove listeners, widgets, save state, etc.)

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

