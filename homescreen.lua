local storyboard = require( "storyboard" )
local widget = require( "widget" )
local device = require( "device" )
local physics = require( "physics")
local scene = storyboard.newScene()

-- imports
require( "tilebg" )

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

local buttonScale = 0.5
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
local speakerButton
local musicButton

local stdFontSize = 22
-- Font defaults - Add to every file that uses fonts.
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
    physics.start()
    local transitionTime = 300

    local group = self.view

    -- GLOBAL SPEAKER
    speakerButton = display.newImage('res/speaker_on.png')
    speakerButton:scale(0.08, 0.08)
    speakerButton.x = 0.1*display.contentWidth
    speakerButton.y = 0.92*display.contentHeight

    musicButton = display.newImage('res/music_on.png')
    musicButton:scale(0.1, 0.1)
    musicButton.x = 0.9*display.contentWidth
    musicButton.y = 0.92*display.contentHeight
    group:insert(speakerButton)
    group:insert(musicButton)
    -- GLOBAL SPEAKER
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

    local spaceApart = 0.000001
    local upCenterY = 0.3*centerY
    local xfirst = centerX*1.008
    local xsecond = centerX*0.99
    local yfirst = upCenterY + 0.054*display.contentHeight
    local ysecond = upCenterY + 0.045*display.contentHeight

    wheel.alpha = 0
    redSquare.alpha = 0
    greenSquare.alpha = 0
    blueSquare.alpha = 0
    yellowSquare.alpha = 0

    local timeTillOpaque = 1000
    transition.to(wheel, { time=timeOpaque, alpha=1})
    transition.to(redSquare, { time=timeOpaque, alpha=1})
    transition.to(greenSquare, { time=timeOpaque, alpha=1})
    transition.to(blueSquare, { time=timeOpaque, alpha=1})
    transition.to(yellowSquare, { time=timeOpaque, alpha=1})

    redSquare:setReferencePoint(display.BottomRightReferencePoint)
    greenSquare:setReferencePoint(display.TopRightReferencePoint)
    blueSquare:setReferencePoint(display.BottomLeftReferencePoint)
    yellowSquare:setReferencePoint(display.TopLeftReferencePoint)

    redSquare.x = xfirst
    redSquare.y = yfirst
    greenSquare.x = xfirst
    greenSquare.y = ysecond
    blueSquare.x = xsecond
    blueSquare.y = yfirst
    yellowSquare.x = xsecond
    yellowSquare.y = ysecond

    -- local currAngle = 1

    -- local function moveWithAngle( angle )
    --     redSquare:translate(math.cos(math.rad(angle))*redSquare.contentWidth, 0)
    --     redSquare:rotate(angle)
    --     currAngle = currAngle + 1
    -- end
    -- timer.performWithDelay( 200, moveWithAngle(currAngle), 5)
    group:insert(wheel)
    group:insert(blueSquare)
    group:insert(redSquare)
    group:insert(greenSquare)
    group:insert(yellowSquare)

    function addMenuScreen()
        titleText = display.newText( "SIMON", 0, 0, "Glametrix", 36 )
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
            top = 0.55 * display.contentHeight,
            label = "Play",
            labelAlign = "center",
            defaultFile = 'res/blue_button.png',
            overFile = 'res/blue_button_over.png',
            font = font.normal,
            fontSize = stdFontSize,
            labelColor = { default = {255, 255, 255}, over = {245, 245, 245} },
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
            top = 0.65*display.contentHeight,
            label = "Instructions",
            labelAlign = "center",
            defaultFile = 'res/red_button.png',
            overFile = 'res/red_button_over.png',
            fontSize = stdFontSize,
            labelColor = { default = {255, 255, 255}, over = {245, 245, 245} },
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
            top = 0.75*display.contentHeight,
            label = "Settings",
            labelAlign = "center",
            defaultFile = 'res/green_button.png',
            overFile = 'res/green_button_over.png',
            fontSize = stdFontSize,
            labelColor = { default = {255, 255, 255}, over = {245, 245, 245} },
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
            top = 0.85*display.contentHeight,
            label = "Credits",
            labelAlign = "center",
            defaultFile = 'res/yellow_button.png',
            overFile = 'res/yellow_button_over.png',
            fontSize = stdFontSize,
            labelColor = { default = {255, 255, 255}, over = {245, 245, 245} },
            onEvent = onCreditsTap
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
        local effects =
        {
        effect = "fade",
        time = 300,
        }
        storyboard.gotoScene( "instructions", effects)
    end

    function showSettingsText()
        local effects =
        {
        effect = "fade",
        time = 300,
        }
        storyboard.gotoScene( "settings", effects)
    end

    function showCreditsText()
        local effects =
        {
        effect = "fade",
        time = 300,
        }
        storyboard.gotoScene( "gamecredits", effects)
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

