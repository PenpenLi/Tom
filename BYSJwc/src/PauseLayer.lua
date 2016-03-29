
PauseLayer = class("PauseLayer", function()
    return cc.LayerColor:create(cc.c4b(162,162,162,128))
end)

function PauseLayer:create()
    local layer = PauseLayer.new()
    layer:init()
    return layer
end

function PauseLayer:init()
    self:addBtn()
    self:addTouch()
end

function PauseLayer:addBtn()
    local function resumeGame()
        self:resumeGame()
    end
    local function exitGame()
        self:exit()
    end

    local title = cc.Label:createWithSystemFont("继续", "Arial", 21)
    local bg = cc.Scale9Sprite:create("UI.png")
    local button = cc.ControlButton:create(title, bg)
    self:addChild(button)
    button:setTag(100)
    button:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2)
    button:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    button:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    button:registerControlEventHandler(resumeGame, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local exitTitle = cc.Label:createWithSystemFont("退出", "Arial", 21)
    local exitBg = cc.Scale9Sprite:create("UI.png")
    local exitButton = cc.ControlButton:create(exitTitle, exitBg)
    self:addChild(exitButton)
    exitButton:setTag(101)
    exitButton:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 60)
    exitButton:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    exitButton:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    exitButton:registerControlEventHandler(exitGame, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)
end

function PauseLayer:addTouch()
    local function onTouchBegan()
        return true
    end
    
    -- 注册单点触摸
    local dispatcher = self:getEventDispatcher()
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    dispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

-- 继续游戏
function PauseLayer:resumeGame()
    self:getParent():resumeGame()
    self:removeFromParent()
end

function PauseLayer:exit()
    -- os.exit(0)
    cc.Director:getInstance():endToLua()
end