
HelloScene = class("HelloScene", function ()
    return cc.Layer:create()
end)

function HelloScene:create()
    local layer = HelloScene.new()
    layer:init()
    return layer
end

function HelloScene:createScene()
    local scene = cc.Scene:create()
    local layer = HelloScene:create()
    scene:addChild(layer)
    return scene
end

function HelloScene:init()
    local sp = cc.Sprite:create("img_bg_logo.jpg")
    sp:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2)
    self:addChild(sp)
    
    -- 数据加载
    local progressTo = cc.ProgressTo:create(2, 100)
    local loadSprite = cc.Sprite:create("loadingbar.png")
    local pro = cc.ProgressTimer:create(loadSprite)
    self:addChild(pro)
    pro:setPosition(WIN_SIZE.width / 2, WIN_SIZE.height / 2 - 100)
    pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    pro:setBarChangeRate(ccp(1, 0))
    pro:setMidpoint(ccp(0, 0))
    pro:runAction(progressTo)

    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[100])
    end

    local proLabel = cc.Label:createWithSystemFont("加载，请稍后...", "Arial", 14)
    self:addChild(proLabel)
    proLabel:setPosition(WIN_SIZE.width / 2 , WIN_SIZE.height / 2 - 120)
    proLabel:setColor(cc.White)

    local callback = function()
        pro:setVisible(false)
        proLabel:setVisible(false)
    end
    local callfunc = cc.CallFunc:create(callback)

    local function turnToLoadingScene(node, tab)
        local loadingScene = LoadingScene:createScene()
        local tt = cc.TransitionFade:create(0.1, loadingScene)
        cc.Director:getInstance():replaceScene(loadingScene)
    end
    local acin = cc.FadeIn:create(2)
    local acout = cc.FadeOut:create(1)
    local turn = cc.CallFunc:create(turnToLoadingScene, {x = 1, y = 1})
    local act = cc.Sequence:create(acin, callfunc, acout, turn)
    sp:runAction(act)

end

