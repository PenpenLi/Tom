--[[
主飞机信息
]]
PlaneSprite = class("PlaneSprite", function()
    return cc.Sprite:create()
end)
PlaneSprite.active = nil --是否存活
PlaneSprite.canBeAttack = nil -- 是否能被攻击
PlaneSprite.HP = nil -- 血量
PlaneSprite.power = nil -- 爆炸范围
PlaneSprite.speed = nil -- 速度，未使用
PlaneSprite.bulleSpeed = nil -- 子弹速度
PlaneSprite.bulletPowerValue = nil -- 子弹攻击力,此处已经被全局的代替，为后期添加内容做准备
PlaneSprite.delayTime = nil --延迟时间
PlaneSprite.size = nil -- 飞机大小
PlaneSprite.hasRing = nil -- 是否拥有光环
PlaneSprite.beginRingTime = nil

function PlaneSprite:ctor()
    self.active = true
    self.canBeAttack = false
    self.HP = shipHP
    self.power = 1.0
    self.speed = 220 --未使用
    self.bulleSpeed = shipBullSpeed --900
    self.bulletPowerValue = 1
    self.delayTime = 0.3
    self.hasRing = false
    self.beginRingTime = nil
end

function PlaneSprite:create()
    local plane = PlaneSprite.new()
    plane:init()
    GlobalShip = plane
    return plane
end

function PlaneSprite:init()
    -- initPicAndBullet(self)
    if selectPlanIndex == 1 then -- 天使逆袭战舰
        initFlyPicAndBullet(self, planeOfConfig[selectPlanIndex][planeTypeIndex], planeTypeIndex, 
            getGiftIndexA, getGiftIndexB )

    elseif selectPlanIndex == 2 then -- 雷霆战机
        initGoPicAndBullet(self, planeOfConfig[selectPlanIndex][planeTypeIndex], planeTypeIndex, 
            getGiftIndexA, getGiftIndexB)

    elseif selectPlanIndex == 3 then -- 凤凰传说
        initPicAndBullet(self)
    end
end

-- 射出子弹
function PlaneSprite:shoot()
    local pos = cc.p(self:getPosition())
    local size = self.size
    
    -- 左子弹
    local bullet_a = Bullet:create(self.bulleSpeed, "aixintao2.png", 1, PLANE_BULLET_TYPE)
    if nil ~= bullet_a then
        table.insert(play_bullet, bullet_a)
        --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
        self:getParent():addChild(bullet_a, 2, 901)
        bullet_a:setPosition(cc.p(pos.x - 13, pos.y + 5 + size.height * 0.3))
        bullet_a:setScale(0.2)
        bullet_a:setRotation(45)
    end
    -- 右子弹
    local bullet_b = Bullet:create(self.bulleSpeed, "aixintao2.png", 1, PLANE_BULLET_TYPE)
    if nil ~= bullet_b then
        table.insert(play_bullet, bullet_b)
        self:getParent():addChild(bullet_b, 2, 901)
        bullet_b:setPosition(cc.p(pos.x + 13, pos.y + 5 + size.height * 0.3))
        bullet_b:setScale(0.2)
        bullet_b:setRotation(45)
    end
end

-- 设置光环
function PlaneSprite:setRing(ringNumber)

    -- if self.hasRing == true then 
    --     return
    -- end
    self.canBeAttack = false
    self.hasRing = true
    -- self.beginRingTime = GameLayer:getGameTime()
    local planeSize = self:getContentSize()
    local ringSprite = cc.Sprite:create(ringEffect[ringNumber].name)
    self:addChild(ringSprite)
    ringSprite:setPosition(cc.p(planeSize.width / 2, planeSize.height / 2))
    ringSprite:setAnchorPoint(cc.p(0.5, 0.5))

    local ringCallFunc = function()
        self.canBeAttack = true
        self.hasRing = false
    end

    local number = 80
    local rotateNumber = 0
    local flag = false
    local scaleToNumber = 1.0

    local ringFadeIn = cc.FadeIn:create(0.05)
    local ringFadeOut = cc.FadeOut:create(0.05)
    local ringSequence = cc.Sequence:create(ringFadeIn, ringFadeOut)
    local ringRepeat = cc.Repeat:create(ringSequence, 50)

    local ringSequence2 = cc.Sequence:create(ringRepeat, cc.CallFunc:create(ringCallFunc))
    ringSprite:runAction(ringSequence2)
end

function PlaneSprite:destroy()
    -- 播放音效
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect("Music/shipDestroyEffect.mp3")
    end

    -- 爆炸特效
    Effect:getInstance():explode(self:getParent(), cc.p(self:getPosition()), self.power)

    -- 更新生命值
    Global:getInstance():setLifeCount()

    -- 移除
    self:removeFromParent()
end
 
-- 扣血
function PlaneSprite:hurt(damageValue)
    if self.canBeAttack == true then
        self.HP = self.HP - damageValue
        if self.HP <= 0 then
            self.active = false
        end
    end   
end

-- 是否可以攻击
function PlaneSprite:isCanAttack()
    return self.canBeAttack
end

-- 是否活着
function PlaneSprite:isActive()
    return self.active
end

function PlaneSprite:getBeginRingTime()
    return self.beginRingTime
end

function PlaneSprite:getHasRing()
    return self.hasRing
end

-- function PlaneSprite:setRingFalse()
--     self.hasRing = false
--     self.beginRingTime = false
--     self.canBeAttack = true
-- end

