
GameOverScene = class("GameOverScene", function()
    return cc.Layer:create()
end)

function GameOverScene:createScene()
    local scene = cc.Scene:create()
    local layer = GameOverScene:create()
    scene:addChild(layer)
    return scene
end

function GameOverScene:create()
    local layer = GameOverScene.new()
    layer:init()
    return layer
end

function GameOverScene:init()
    self:loadingMusic()
    self:addBG()
    self:addBtn()
end

-- 背景音乐
function GameOverScene:loadingMusic()
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():stopMusic()
        cc.SimpleAudioEngine:getInstance():playMusic("Music/gameover.ogg")
    else
        cc.SimpleAudioEngine:getInstance():stopMusic()
    end
end

-- 添加背景
function GameOverScene:addBG()
    -- 背景图片
    local bg = cc.Sprite:create("img_bg_logo.jpg")
    bg:setPosition(cc.p(WIN_SIZE.width / 2, WIN_SIZE.height / 2))
    self:addChild(bg, -1)

    -- logo
    local logo = cc.Sprite:create("gameOver.png")
    logo:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height/2 + 150))
    self:addChild(logo, 10)
    
    -- 分数
    local highScore = Global:getInstance():getHighScore()
    local score = Global:getInstance():getScore()
    local showNewMark = false
    
    -- 新纪录
    if score > highScore then
        Global:getInstance():setHighScore(score)
        highScore = score
        showNewMark = true
    end
    
    local lbHighScore = cc.Label:createWithBMFont("res/Font/bitmapFontTest.fnt", ("HighScore : " .. highScore))
    local lbScore = cc.Label:createWithBMFont("res/Font/bitmapFontTest.fnt",     ("Score        : " .. score))
    lbHighScore:setAnchorPoint(cc.p(0, 0))
    lbScore:setAnchorPoint(cc.p(0, 0))
    lbHighScore:setPosition(cc.p(WIN_SIZE.width / 2 - 100, WIN_SIZE.height / 2 + 50))
    lbScore:setPosition(cc.p(WIN_SIZE.width / 2 - 100, WIN_SIZE.height / 2))
    lbHighScore:setScale(0.5)
    lbScore:setScale(0.5)
    self:addChild(lbHighScore)
    self:addChild(lbScore)

    if showNewMark == true then
        local newMark = cc.Label:createWithSystemFont("新纪录!", "Arial", 20)
        newMark:setColor(cc.c3b(255, 0, 255))
        newMark:setRotation(-45)
        newMark:setPosition(lbHighScore:getPositionX() - 10, lbHighScore:getPositionY() + 30)
        self:addChild(newMark)
        local fadeIn = cc.FadeTo:create(1.0, 100)
        local delay = cc.DelayTime:create(0.5)
        local fadeOut = cc.FadeTo:create(1.0, 255)
        local seq = cc.Sequence:create(fadeIn, fadeOut, delay)
        local act = cc.RepeatForever:create(seq)
        newMark:runAction(act)
    end 
end

-- 添加按钮
function GameOverScene:addBtn()
    local function callback(ref, button)
        if ref:getTag() == 101 then
            self:turnToGameScene()
        else
            self:turnToLoadingScene()
        end
    end
    
    local restartTitle = cc.Label:createWithSystemFont("再玩一次", "Arial", 21)
    local restartbg = cc.Scale9Sprite:create("UI.png")
    restartButton = cc.ControlButton:create(restartTitle, restartbg)
    self:addChild(restartButton)
    restartButton:setTag(101)
    restartButton:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 70)
    restartButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    restartButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    restartButton:registerControlEventHandler(callback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local returnTitle = cc.Label:createWithSystemFont("返回菜单", "Arial", 21)
    local returnbg = cc.Scale9Sprite:create("UI.png")
    returnButton = cc.ControlButton:create(returnTitle, returnbg)
    self:addChild(returnButton)
    returnButton:setTag(102)
    returnButton:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 110)
    returnButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    returnButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    returnButton:registerControlEventHandler(callback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)
end

-- 重新游戏
function GameOverScene:turnToGameScene()
    local scene = GameScene:createScene()
    local transitionFrade = cc.TransitionFade:create(1.0, scene)
    cc.Director:getInstance():replaceScene(transitionFrade)
end

-- 返回主界面
function GameOverScene:turnToLoadingScene()
    local scene = LoadingScene:createScene()
    local transitionFrade = cc.TransitionFade:create(1.0, scene)
    cc.Director:getInstance():replaceScene(transitionFrade)
end
    
