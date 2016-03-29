
SetGame = class("SetGame", function()
    return cc.Layer:create()
end)

function SetGame:createScene()
    local scene = cc.Scene:create()
    local layer = SetGame:create()
    scene:addChild(layer)
    return scene
end

function SetGame:create()
    local layer = SetGame.new()
    layer:init()
    return layer
end

function SetGame:init()

    -- 背景
    local bg = cc.Sprite:create("img_bg_logo.jpg")
    bg:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height/2))
    self:addChild(bg, 0, 1)

    -- 标题
    local title = cc.Label:createWithSystemFont("难度选择", "Arial", 24)
    title:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height - 120))
    self:addChild(title)
    title:setColor(cc.Red)


    local buttonCallback = function(ref, button)
        if ref:getTag() == 1001 then
            self:setEasyGame()
        elseif ref:getTag() == 1002 then
            self:setMiddleGame()
        elseif ref:getTag() == 1003 then
            self:setHardGame()
        end  
    end
    --简单难度
    local sampleTitle = cc.Label:createWithSystemFont("新手上路", "Arial", 21)
    local sampleSprite = cc.Scale9Sprite:create("UI.png")
    local sampleButton = cc.ControlButton:create(sampleTitle, sampleSprite)
    self:addChild(sampleButton)
    sampleButton:setTag(1001)
    sampleButton:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 )
    sampleButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_NORMAL)
    sampleButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_HIGH_LIGHTED)
    sampleButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local middleTitle = cc.Label:createWithSystemFont("进阶模式", "Arial", 21)
    local middleSprite = cc.Scale9Sprite:create("UI.png")
    local middleButton = cc.ControlButton:create(middleTitle, middleSprite)
    self:addChild(middleButton)
    middleButton:setTag(1002)
    middleButton:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 - 40)
    middleButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_NORMAL)
    middleButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_HIGH_LIGHTED)
    middleButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local hardTitle = cc.Label:createWithSystemFont("终极一战", "Arial", 21)
    local hardSprite = cc.Scale9Sprite:create("UI.png")
    local hardButton = cc.ControlButton:create(hardTitle, hardSprite)
    self:addChild(hardButton)
    hardButton:setTag(1003)
    hardButton:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 - 80)
    hardButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_NORMAL)
    hardButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_HIGH_LIGHTED)
    hardButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)
    -- 内容
    --[[
    local about = cc.Label:createWithSystemFont(
        "游戏名字：     欢乐飞机之战\n\n\n开发者：  芷水\n\n\n\n湖南城市学院", 
        "Arial", 18, cc.size(WIN_SIZE.width, 320), 
        cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    about:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height/2))
    self:addChild(about)
    about:setColor(cc.Red)
    ]]
    -- 返回菜单
    local function turnToLoadingScene()
        if Global:getInstance():getAudioState() == true then
            cc.SimpleAudioEngine:getInstance():playEffect("Music/click_button2.wav")
        end
        self:turnToLoadingScene()
    end

    local backlb = cc.Label:createWithBMFont("Font/bitmapFontTest.fnt", "Go Back")
    local pback = cc.MenuItemLabel:create(backlb)
    pback:setScale(0.6)
    pback:registerScriptTapHandler(turnToLoadingScene)

    local pmenu = cc.Menu:create(pback)
    pmenu:setPosition(WIN_SIZE.width/2, 50)
    self:addChild(pmenu)

    -- 按钮闪动Action
    local fadeIn = cc.FadeTo:create(1.0, 255)
    local delay = cc.DelayTime:create(0.5)
    local fadeOut = cc.FadeTo:create(1.0, 50)
    local seq = cc.Sequence:create(fadeIn, delay, fadeOut)
    local act = cc.RepeatForever:create(seq)
    pback:runAction(act)
end

-- 返回菜单
function SetGame:turnToLoadingScene()
    local loadingScene = LoadingScene:createScene()
    local tt = cc.TransitionPageTurn:create(0.5, loadingScene, true)
    cc.Director:getInstance():replaceScene(tt)
end

function SetGame:setEasyGame()

    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[601])
    end
    shipPower = 4

    enemyPower = 1

    enemyNumber = 6
end

function SetGame:setMiddleGame()
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[604])
    end
    shipPower = 3

    enemyPower = 2

    enemyNumber = 10
end

function SetGame:setHardGame()
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[603])
    end
    shipPower = 1

    enemyPower = 2

    enemyNumber = 50
end