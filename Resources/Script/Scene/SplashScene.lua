require("Script/Scene/MainMenuScene")
require "AudioEngine" 

local visibleSize = CCDirector:getInstance():getVisibleSize()	
local origin = CCDirector:getInstance():getVisibleOrigin()

local function createBackLayer()
	local backLayer = CCLayer:create()

	local frameWidth = 712
    local frameHeight = 1024

	local textureSplash = CCTextureCache:getInstance():addImage("imgs/splash_bg.png")


	rect = CCRect(0, 0, frameWidth, frameHeight)
    local splashFrame = CCSpriteFrame:createWithTexture(textureSplash, rect)

    local splashSprite = CCSprite:createWithSpriteFrame(splashFrame)
	splashSprite:setPosition(visibleSize.width / 2, visibleSize.height / 2)

	--set scale
	splashSprite:setScaleX(visibleSize.width/frameWidth)

	backLayer:addChild(splashSprite)

	--add text info
	local testLabel = CCLabelTTF:create("Press Screen", "Arial", 30)
	local arrayOfActions = CCArray:create()			
	local scale1 = CCScaleTo:create(1.5, 1.2)
	local scale2 = CCScaleTo:create(1.5, 1)			

	arrayOfActions:addObject(scale1)
	arrayOfActions:addObject(scale2)

	local sequence = CCSequence:create(arrayOfActions)

	local repeatFunc = CCRepeatForever:create(sequence)
	testLabel:runAction(repeatFunc)

	testLabel:setPosition(ccp(visibleSize.width / 2, 130))
	backLayer:addChild(testLabel)

    -- handing touch events
    local touchBeginPoint = nil

    local function onTouchBegan(x, y)
		CCLuaLog("touch began...")
		CCDirector:getInstance():replaceScene(CreateMenuScene())
        touchBeginPoint = {x = x, y = y}
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onTouch(eventType, x, y)
        if eventType == "began" then   
            return onTouchBegan(x, y)
        end
    end

    backLayer:registerScriptTouchHandler(onTouch)
    backLayer:setTouchEnabled(true)

	return backLayer
end

-- create main menu
function CreateSplashScene()
   
	local scene = CCScene:create()
	scene:addChild(createBackLayer())

	local bgMusicPath = CCFileUtils:getInstance():fullPathForFilename("Sound/login.wav")
    AudioEngine.playMusic(bgMusicPath, true)

    return scene
end