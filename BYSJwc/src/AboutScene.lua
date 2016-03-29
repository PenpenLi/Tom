
AboutScene = class("AboutScene", function()
    return cc.Layer:create()
end)

function AboutScene:createScene()
    local scene = cc.Scene:create()
    local layer = AboutScene:create()
    scene:addChild(layer)
    return scene
end

function AboutScene:create()
    local layer = AboutScene.new()
    layer:init()
    return layer
end

function AboutScene:init()

    -- 背景
    local bg = cc.Sprite:create("img_bg_logo.jpg")
    bg:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height/2))
    self:addChild(bg, 0, 1)

    self:toSelectPlan()
    --[[
    -- 标题
    local title = cc.Sprite:create("menuTitle.png", cc.rect(0, 36, 100, 34))
    title:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height-60))
    self:addChild(title)

    -- 内容
    local about = cc.Label:createWithSystemFont(
        "游戏名字：     欢乐飞机之战\n\n\n开发者：  芷水\n\n\n\n湖南城市学院", 
        "Arial", 18, cc.size(WIN_SIZE.width, 320), 
        cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    about:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height/2))
    self:addChild(about)
    about:setColor(cc.Blue)
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

function AboutScene:toSelectPlan()
    local selectSprite = cc.Sprite:create("3.jpg")
    self:addChild(selectSprite, 0, 2003)
    selectSprite:setPosition(cc.p(WIN_SIZE.width / 2, WIN_SIZE.height / 2 + 60))
    selectSprite:setScale(0.4)


    local buttonCallback = function(ref, button)
        if ref:getTag() == 104 then
            self:changePlanSprite(104)
            self:playButtonMusic(104)
        elseif ref:getTag() == 105 then
            self:changePlanSprite(105)
            self:playButtonMusic(105)
        elseif ref:getTag() == 106 then
            self:changePlanSprite(106)
            self:playButtonMusic(106)
        end
    end

    local label1 = cc.Label:createWithSystemFont("天使逆袭", "Arial", 21)
    local sprite1 = cc.Scale9Sprite:create("UI.png")
    local button1 = cc.ControlButton:create(label1, sprite1)
    self:addChild(button1)
    button1:setTag(104)
    button1:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 70)
    button1:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    button1:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    button1:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local label2 = cc.Label:createWithSystemFont("雷霆战机", "Arial", 21)
    local sprite2 = cc.Scale9Sprite:create("UI.png")
    local button2 = cc.ControlButton:create(label2, sprite2)
    self:addChild(button2)
    button2:setTag(105)
    button2:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 110)
    button2:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    button2:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    button2:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

    local label2 = cc.Label:createWithSystemFont("凤凰传说", "Arial", 21)
    local sprite2 = cc.Scale9Sprite:create("UI.png")
    local button2 = cc.ControlButton:create(label2, sprite2)
    self:addChild(button2)
    button2:setTag(106)
    button2:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 150)
    button2:setTitleColorForState(cc.Blue, cc.CONTROL_STATE_NORMAL)
    button2:setTitleColorForState(cc.Red, cc.CONTROL_STATE_HIGH_LIGHTED)
    button2:registerControlEventHandler(buttonCallback, cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE)

end

-- 返回菜单
function AboutScene:turnToLoadingScene()
    local loadingScene = LoadingScene:createScene()
    local tt = cc.TransitionPageTurn:create(0.5, loadingScene, true)
    cc.Director:getInstance():replaceScene(tt)
end

function AboutScene:playButtonMusic(tag)
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[tag + 597])
    end
end

function AboutScene:changePlanSprite(tag)
    local curSprite = self:getChildByTag(2003)
    curSprite:setTexture(selectPlanConfig[tag])
    selectPlanIndex = tag - 103
end

