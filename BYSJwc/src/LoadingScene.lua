
LoadingScene = class("LoadingScene", function ()
    return cc.Layer:create()
end)

function LoadingScene:createScene()
    local scene = cc.Scene:create()
    local layer = LoadingScene:create()
    scene:addChild(layer)
    return scene
end

function LoadingScene:create()
    local layer = LoadingScene.new()
    layer:init()
    return layer
end

function LoadingScene:init()
    self:loadingMusic()
    self:addBG()
    self:addBtn()
    self:addShip()
end

function LoadingScene:loadingMusic()
    -- preloadMusic
    if Global:getInstance():getAudioState() == true then
        -- playMusic
        cc.SimpleAudioEngine:getInstance():stopMusic()
        cc.SimpleAudioEngine:getInstance():playMusic("Music/loadMusic.mp3", true)
    else
        cc.SimpleAudioEngine:getInstance():stopMusic()
    end
end

function LoadingScene:addBG()
    -- 添加背景 tag = 1
    local bg = cc.Sprite:create("img_bg_logo.jpg")
    bg:setPosition(cc.p(WIN_SIZE.width / 2, WIN_SIZE.height / 2))
    self:addChild(bg, -1, 1)

    -- 添加logo tag = 2
    local logo = cc.Sprite:create("logo.png")
    logo:setPosition(cc.p(WIN_SIZE.width / 2, WIN_SIZE.height - 130))
    self:addChild(logo, 10, 2)
end

function LoadingScene:playButtonMusic(Tag)
    if Tag == 101 then
    else
        if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect("Music/click_button2.wav")
        end
    end 
end

function LoadingScene:addBtn()

    local buttonCallback = function(ref, button)
        if ref:getTag() == 101 then
            self:newGame()
            self:playButtonMusic(101)
        elseif ref:getTag() == 102 then
            self:turnToSetGame()
            self:playButtonMusic(102)
        elseif ref:getTag() == 103 then
            self:turnToSetMusic()
            self:playButtonMusic(103)
        elseif ref:getTag() == 104 then
            self:exit()
            self:playButtonMusic(104)
        elseif ref:getTag() == 100 then
            --预留
            self:selectPlan()
            self:playButtonMusic(100)
        end
    end
    
    local happyTitle = cc.Label:createWithSystemFont("欢乐模式", "Arial", 21)
    local happybg = cc.Scale9Sprite:create("UI.png")
    local happyButton = cc.ControlButton:create(happyTitle, happybg)
    self:addChild(happyButton)
    happyButton:setTag(101)
    happyButton:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 30)
    happyButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    happyButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    happyButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local bgtitle = cc.Label:createWithSystemFont("战舰选择", "Arial", 21)
    local bgSprite = cc.Scale9Sprite:create("UI.png")
    local limitButton = cc.ControlButton:create(bgtitle, bgSprite)
    limitButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    limitButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    self:addChild(limitButton)
    limitButton:setTag(100)
    limitButton:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 - 70)
    limitButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local aboutTitle = cc.Label:createWithSystemFont("游戏设置", "Arial", 21)
    local aboutSprite = cc.Scale9Sprite:create("UI.png")
    local aboutButton = cc.ControlButton:create(aboutTitle, aboutSprite)
    self:addChild(aboutButton)
    aboutButton:setTag(102)
    aboutButton:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 - 110)
    aboutButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    aboutButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    aboutButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local setTitle = cc.Label:createWithSystemFont("游戏声音", "Arial", 21)
    local setSprite = cc.Scale9Sprite:create("UI.png")
    local setButton = cc.ControlButton:create(setTitle, setSprite)
    self:addChild(setButton)
    setButton:setTag(103)
    setButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    setButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    setButton:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 - 150)
    setButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local exitTitle = cc.Label:createWithSystemFont("退出游戏", "Arial", 21)
    local exitSprite = cc.Scale9Sprite:create("UI.png")
    local exitButton = cc.ControlButton:create(exitTitle, exitSprite)
    self:addChild(exitButton)
    exitButton:setTag(104)
    exitButton:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 190)
    exitButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    exitButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    exitButton:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)


end

function LoadingScene:addShip()
    -- 飞机随机运动
    local ship = cc.Sprite:create("ship01.png", cc.rect(0, 45, 60, 38))
    ship:setPosition(cc.p(0, WIN_SIZE.height + 100))
    self:addChild(ship, 0, 10)

    local function updateShip()
        if ship:getPositionY() > WIN_SIZE.height then
           ship:stopAllActions()
           ship:setPosition(math.random() * WIN_SIZE.width * 2, 0)
           local moveTo = cc.MoveTo:create(
               math.ceil(4.0*math.random() + 1.0),
               cc.p(math.random() * WIN_SIZE.width * 2.0, WIN_SIZE.height + 100))
           ship:runAction(moveTo)
        end
    end
    schedule(self, updateShip, 0)
end

-- 新游戏
function LoadingScene:newGame()
    local function toGame() 
        self:turnToGame()
    end
    local callback = cc.CallFunc:create(toGame)
    Effect:getInstance():flareEffect(self, callback)
end

function LoadingScene:selectPlan()
    local setPlan = AboutScene:createScene()
    local toSetPlan = cc.TransitionPageTurn:create(0.5, setPlan, false)
    cc.Director:getInstance():replaceScene(toSetPlan)
end

function LoadingScene:turnToGame()
    local gameScene = GameScene:createScene()
    cc.Director:getInstance():replaceScene(gameScene)
end

-- 跳转到关于界面
function LoadingScene:turnToSetGame()
    local setGameScene = SetGame:createScene()
    local toSetGame = cc.TransitionPageTurn:create(0.5, setGameScene, false)
    cc.Director:getInstance():replaceScene(toSetGame)
end

-- 跳转到设置界面
function LoadingScene:turnToSetMusic()
    local optionsScene = SetMusic:createScene()
    local toOption = cc.TransitionPageTurn:create(0.5, optionsScene, false)
    cc.Director:getInstance():replaceScene(toOption)
end

-- 退出程序
function LoadingScene:exit()
    -- os.exit(0)
    cc.Director:getInstance():endToLua()
end
