
GameLayer = class("GameLayer", function()
    return cc.Layer:create()
end)
GameLayer.stateGamePlaying = 0
GameLayer.stateGameOver = 1

GameLayer.gameState = nil
GameLayer.gameTime = nil                -- 游戏进行时间
GameLayer.lbScore = nil                 -- 分数
GameLayer.lbLifeCount = nil             -- 显示生命值
GameLayer.sliderLife = nil              -- 生命条

GameLayer.ship = nil                    -- 飞机
GameLayer.enemyManager = nil            -- 敌机管理

function GameLayer:create()
    local layer = GameLayer.new()
    layer:init()
    return layer
end

function GameLayer:init()
    self:loadingMusic() -- 背景音乐
    self:addBG()        -- 初始化背景
    self:moveBG()       -- 背景移动
    self:addParticleOfRain() -- 添加粒子系统背景
    self:addBtn()       -- 游戏暂停按钮
    self:addSchedule()  -- 更新
    self:addTouch()     -- 触摸
    self:addContact()   -- 碰撞检测
    
    Global:getInstance():resetGame()    -- 初始化全局变量
    self:initplaneTypeIndex()           -- 初始化游戏战舰x类型的第一种 
    self:initGameState()                -- 初始化游戏数据状态
    self:initShip()                     -- 初始化主机
    self:initEnemy()                    -- 初始化敌机
    self.flagA = false                  -- 同种类型飞机切换
    self.flagB = false
    self.flagC = false 
end

-- 播放音乐
function GameLayer:loadingMusic()
    if Global:getInstance():getAudioState() == true then
        -- playMusic
        cc.SimpleAudioEngine:getInstance():stopMusic()
        cc.SimpleAudioEngine:getInstance():playMusic("Music/bgMusic.mp3", true)
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[120])
    else
        cc.SimpleAudioEngine:getInstance():stopMusic()
    end
end

-- 添加背景
function GameLayer:addBG()
    local number = math.ceil(math.random()*5)
    self.bg1 = cc.Sprite:create(backgroundSprite[number])
    self.bg2 = cc.Sprite:create(backgroundSprite[number])
    
    self.bg1:setAnchorPoint(cc.p(0, 0))
    self.bg2:setAnchorPoint(cc.p(0, 0))
    self.bg1:setPosition(0, 0)
    self.bg2:setPosition(0, self.bg1:getContentSize().height)
    self:addChild(self.bg1, -10)
    self:addChild(self.bg2, -10)
end

-- 背景滚动
function GameLayer:moveBG()
    local height = self.bg1:getContentSize().height
    local function updateBG()
        self.bg1:setPositionY(self.bg1:getPositionY() - 1)
        self.bg2:setPositionY(self.bg1:getPositionY() + height)
        if self.bg1:getPositionY() <= -height then
            self.bg1, self.bg2 = self.bg2, self.bg1
            self.bg2:setPositionY(WIN_SIZE.height)
        end
    end
    schedule(self, updateBG, 0)
end

function GameLayer:addParticleOfRain()
    local particleRain = cc.ParticleRain:create()
    -- particleRain:setScale()
    self:addChild(particleRain)
    particleRain:setPosition(cc.p(WIN_SIZE.width / 2, WIN_SIZE.height))
end

-- 添加按钮
function GameLayer:addBtn()
    local function PauseGame()
        self:PauseGame()
    end
    local pause = cc.MenuItemImage:create("pause.png", "pause.png")
    pause:setAnchorPoint(cc.p(1, 0))
    pause:setPosition(cc.p(WIN_SIZE.width, 0))
    pause:registerScriptTapHandler(PauseGame)
    
    local menu = cc.Menu:create(pause)
    menu:setPosition(cc.p(0, 0))
    self:addChild(menu, 1, 10)
end

-- 游戏暂停
function GameLayer:PauseGame()
    cc.Director:getInstance():pause()
    cc.SimpleAudioEngine:getInstance():pauseMusic()
    cc.SimpleAudioEngine:getInstance():pauseAllEffects()
    
    local pauseLayer = PauseLayer:create()
    self:addChild(pauseLayer, 9999)
end

-- 游戏继续
function GameLayer:resumeGame()
    cc.Director:getInstance():resume()
    cc.SimpleAudioEngine:getInstance():resumeMusic()
    cc.SimpleAudioEngine:getInstance():resumeAllEffects()
end

-- 更新
function GameLayer:addSchedule()
    -- 更新UI
    local function updateGame() 
        self:updateGame()
    end
    schedule(self, updateGame, 0)

    -- 更新时间
    local function updateTime()
        self:updateTime()
    end
    schedule(self, updateTime, 1)
end

-- 触摸事件
function GameLayer:addTouch()
    -- 触屏开始
    local function onTouchBegan(touch, event)
        --print("touchBegan")
        return true
    end

    -- 触屏移动
    local function onTouchMoved(touch, event)
        -- print("touchMoved")
        if self.gameState == self.stateGamePlaying then
            if nil ~= self.ship then
                local pos = touch:getDelta()
                local currentPos = cc.p(self.ship:getPosition())
                currentPos = cc.pAdd(currentPos, pos)
                currentPos = cc.pGetClampPoint(currentPos, cc.p(0, 0), cc.p(WIN_SIZE.width, WIN_SIZE.height))
                self.ship:setPosition(currentPos)
            end
        end
    end

    -- 触屏结束
    local function onTouchEnded(touch, event)
        -- print("touchEnded")
    end

    -- 注册单点触摸
    local dispatcher = self:getEventDispatcher()
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    dispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function GameLayer:initplaneTypeIndex()
    planeTypeIndex = 1
end

-- 初始化游戏数据状态
function GameLayer:initGameState()
    -- 游戏状态
    self.gameState = self.stateGamePlaying

    -- 游戏时间
    self.gameTime = 0

    -- 分数
    self.lbScore = cc.Label:createWithBMFont("Font/arial-14.fnt", "Score:000000")
    self.lbScore:setColor(cc.Blue)
    self.lbScore:setAnchorPoint(cc.p(0, 0))
    self.lbScore:setPosition(WIN_SIZE.width - 100, WIN_SIZE.height - 30)
    self.lbScore:setAlignment(cc.TEXT_ALIGNMENT_RIGHT)
    self:addChild(self.lbScore, 1000)

    -- 飞机生命图片
    local life = cc.Sprite:create("ship01.png", cc.rect(0, 0, 60, 38))
    life:setScale(0.6)
    life:setPosition(cc.p(30, WIN_SIZE.height - 23))
    self:addChild(life, 1000)
    -- 飞机生命值
    self.lbLifeCount = cc.Label:createWithSystemFont(Global:getInstance():getLifeCount(), "Arial", 20)
    self.lbLifeCount:setPosition(cc.p(60, WIN_SIZE.height - 20))
    self.lbLifeCount:setColor(cc.White)
    self:addChild(self.lbLifeCount, 1000)
    -- 飞机生命条
    self.sliderLife = cc.ControlSlider:create("slider_red.png", "slider_gray.png", "slider_thumb.png")
    self.sliderLife:setPosition(cc.p(30 + self.sliderLife:getContentSize().width, WIN_SIZE.height-23))
    self:addChild(self.sliderLife, 1000)
    self.sliderLife:setMinimumValue(0.0)
    self.sliderLife:setMaximumValue(100.0)
end

-- 初始化主机
function GameLayer:initShip()
    self.ship = PlaneSprite:create()
    self:addChild(self.ship, 2002, 1001) --tag 1001 ,子弹 901
end

-- 初始化敌机
function GameLayer:initEnemy()
    self.enemyManager = EnemyManager:create(self) -- tag 1002, 子弹 902 
    -- 不加入层中，好像就调用不了enemyManager的方法
    self:addChild(self.enemyManager)
end

-- 更新时间
function GameLayer:updateTime()
    if self.gameState == self.stateGamePlaying then
        self.gameTime = self.gameTime + 1
        self.enemyManager:updateEnemy(self.gameTime)
    end
end

-- 更新游戏
function GameLayer:updateGame()
    if self.gameState == self.stateGamePlaying then
        -- self:checkIsCollide()       -- 碰撞检测
        self:removeInactiveUnit()   -- 移除不活跃的元素
        self:checkIsReborn()        -- 战机重生,或游戏结束
        self:updateUI()             -- 刷新界面
    end
end

---- 判断a和b是否碰撞
--function GameLayer:collide(a, b)
--    if nil == a or nil == b then
--        return false
--    end
--    local rect1 = a:collideRect()
--    local rect2 = b:collideRect()
--    return cc.rectIntersectsRect(rect1,rect2)
--end
--
--
---- 碰撞检测
--function GameLayer:checkIsCollide()
--    -- 遍历敌人
--    for _,enemy in pairs(enemy_items) do
--        -- 遍历主角的子弹
--        for __,bullet in pairs(play_bullet) do
--            -- 碰撞检测(敌人,子弹)
--            if self:collide(enemy, bullet) == true then
--                enemy:hurt(1)
--                bullet:hurt(1)
--            end
--        end
--        -- 主角和敌人是否碰撞
--        if self.ship:isActive() == true then
--            if self:collide(enemy, self.ship) == true then 
--                enemy:hurt(1)
--                self.ship:hurt(1)
--            end
--        end
--    end
--
--    -- 遍历敌人的子弹
--    for _,bullet in pairs(enemy_bullet) do 
--        if bullet:isActive() == true then
--            if self:collide(bullet, self.ship) then
--                bullet:hurt(1)
--                self.ship:hurt(1)
--            end
--        else 
--            break
--        end
--    end
--end

-- 移除不活跃的元素
function GameLayer:removeInactiveUnit()
    local children = self:getChildren()
    for _, units in pairs(children) do
        -- 如果是子弹,或者敌人
        local tag = units:getTag()
        if tag == 901 or tag == 902 or tag == 1002 or tag == 520 then
            if units:isActive() == false then   -- 如果不活跃,就销毁
                units:destroy()
            end
        end
    end

    -- 战机死亡
    if nil ~= self.ship then
        if self.ship:isActive() == false then
            self.ship:destroy()
            self.ship = nil
        end
    end
end

-- 战机重生,或游戏结束
function GameLayer:checkIsReborn()

    if Global:getInstance():getLifeCount() >= 0 then
        if self.ship == nil then
            self.ship = PlaneSprite:create()
            self:addChild(self.ship, 2002, 1001)
        end
    else
        self.gameState = self.stateGameOver
        self:gameOver()
    end
end

-- 刷新界面
function GameLayer:updateUI()
    -- 分数
    local score = Global:getInstance():getScore()
    local sc = string.format("Score:%06d", score)
    self.lbScore:setString(sc)
    self:changePlaneTypeIndex(score)

    -- 生命值
    self.lbLifeCount:setString(Global:getInstance():getLifeCount())

    -- 生命条
    if self.ship ~= nil then
        self.sliderLife:setValue(self.ship.HP * 10.0)
    else 
        self.sliderLife:setValue(0.0)
    end

    -- if nil ~= self.ship and self.ship:getHasRing() == true and 
    --     self.gameTime - self.ship:getBeginRingTime() >= 5 then
    --     self.ship:setRingFalse()
    -- end

end

-- 游戏结束
function GameLayer:gameOver()
    Global:getInstance():ExitGame()
    -- 结束画面
    local scene = GameOverScene:createScene()
    local tt = cc.TransitionCrossFade:create(1.0, scene)
    cc.Director:getInstance():replaceScene(tt)
end

-- 获取飞机
function GameLayer:getShip()
    return self.ship
end

function GameLayer:addContact()
    local function onContactBegin(contact)
        local a = contact:getShapeA():getBody():getNode()
        local b = contact:getShapeB():getBody():getNode()
        local tag1 = a:getTag()
        local tag2 = b:getTag()

        if a ~= nil and b ~= nil then

            if tag1 == 520 or tag2 == 520 then
                if tag1 == 520 then
                    if tag2 == 1001 then
                        a:setHp()
                        self:getGift(a)
                    end
                elseif tag2 == 520 then
                    if tag1 == 1001 then
                        b:setHp()
                        self:getGift(b)
                    end
                end
                return true
            end
            if tag1 == 1001 or tag1 == 901 then
                a:hurt(enemyPower)
                b:hurt(shipPower)
            elseif tag1 == 1002 or tag1 == 902 then
                a:hurt(shipPower)
                b:hurt(enemyPower)
            end
        end
        return true
    end
    
    local dispatcher = self:getEventDispatcher()
    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    dispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)
end

--[[
爆炸摧毁界面中所有敌机
]]

function GameLayer:destroyAllEnemys()

    haveGlobalExplode = true

    Effect:getInstance():destroyAllEnemys()

    local callFunc = function()
        haveGlobalExplode = false
    end
    local delay = cc.DelayTime:create(1.5)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callFunc))
    self:runAction(sequence)
    
end

function GameLayer:getGift(ref)
    local nowGiftType = ref:getGiftType()
    if nowGiftType == 14 then --全地图爆炸
        self:destroyAllEnemys()
    elseif nowGiftType == 10 then  --加血
        if self.ship.HP + 3 <= 10 then
            self.ship.HP = self.ship.HP + 3
        else
            self.ship.HP = 10
        end
    elseif nowGiftType == 11 then --光环
        self.ship:setRing(2)
    elseif nowGiftType == 7 or nowGiftType == 8 or nowGiftType == 9 or nowGiftType == 13 then
        getGiftIndexB = getGiftIndexA
        getGiftIndexA = nowGiftType
    end
end

function GameLayer:getGameTime()
    return self.gameTime
end

function GameLayer:updatePlane()
    if selectPlanIndex == 1 then
        init2GoPic(self.ship, planeOfConfig[selectPlanIndex][planeTypeIndex])
    elseif selectPlanIndex == 2 then
        init2FlyPic(self.ship, planeOfConfig[selectPlanIndex][planeTypeIndex])
    elseif selectPlanIndex == 3 then
    end
end

function GameLayer:changePlaneTypeIndex(score)
    if self.flagA == false and score >= 500 and score <= 1000 then
        planeTypeIndex = 2
        self:updatePlane()
        self.flagA = true
    elseif self.flagB == false and score >= 1001 and score <= 2000 then
        planeTypeIndex = 3
        self:updatePlane()
        self.flagB = true
    elseif self.flagC == false and score > 2000 then
        planeTypeIndex = 4
        self:updatePlane()
        self.flagC = true 
    end
end
