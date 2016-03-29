--[[
BirdPlan
]]

local arr = {}
    local name = nil
    for i = 1, 13 do 
        if i <= 9 then
            name = string.format("hxl0%d.png", i)
        else
            name = string.format("hxl%d.png",i)
        end
        print(name)
        
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(name)
        table.insert(arr, frame)
    end
    
local animation = cc.Animation:createWithSpriteFrames(arr)
animation:setDelayPerUnit(0.1)
animation:setRestoreOriginalFrame(true)
cc.AnimationCache:getInstance():addAnimation(animation, "BirdPlanAnimation")

local leftBulletFlag = false
local rightBulletFlag = false
local leftBulletPosition = -20
local RightBulletPosition = 20

local birdFather = nil

initPicAndBullet = function(parents) 
    parents.bulleSpeed = 700
    parents.delayTime = 0.1
	birdFather = parents
    parents:stopAllActions()
	initPic(parents)
end

function initPic(parents)
	local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("hxl01.png")
	parents:setSpriteFrame(frame)
    parents:setPosition(cc.p(WIN_SIZE.width / 2, 60))
    parents.size = parents:getContentSize()

    local birdAnimation = cc.AnimationCache:getInstance():getAnimation("BirdPlanAnimation")
    parents:runAction(cc.RepeatForever:create(cc.Animate:create(birdAnimation)))
    parents:setScale(0.5)

    parents.canBeAttack = false
    local function canAttack(node, tab)
        parents.canBeAttack = true 
    end

    local blink = cc.Blink:create(2, 6) --闪烁
    local func = cc.CallFunc:create(canAttack)
    parents:runAction(cc.Sequence:create(blink, func))
    
    --射击子弹
    local function shoot()

        if leftBulletPosition == 20 then
            leftBulletFlag = false
        end
        if leftBulletPosition == -20 then
            leftBulletFlag = true
        end

        if leftBulletFlag == false then
            leftBulletPosition = leftBulletPosition - 2
        elseif leftBulletFlag == true then
            leftBulletPosition = leftBulletPosition + 2
        end 
        
        if RightBulletPosition == - 20 then
            rightBulletFlag = true
        end
        if RightBulletPosition == 20 then
            rightBulletFlag = false
        end

        if rightBulletFlag == false then
            RightBulletPosition = RightBulletPosition - 2
        elseif rightBulletFlag == true then
            RightBulletPosition = RightBulletPosition + 2
        end

        Birdshoot() 
    end
    schedule(parents, shoot, parents.delayTime)

    -- parents:setRing(3)
    parents:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(parents.size.width*0.5, 
        parents.size.height*0.5)))
    -- self:setPhysicsBody(cc.PhysicsBody:createCircle(self:getContentSize().width / 2))
    parents:getPhysicsBody():setCategoryBitmask(PLANE_CATEGORY_MASK)
    parents:getPhysicsBody():setCollisionBitmask(PLANE_COLLISION_MASK)
    parents:getPhysicsBody():setContactTestBitmask(PLANE_CONTACTTEST_MASK)
end

function Birdshoot()

    local bulletNameL = enemyBulletConfig[9].nameOfpic
    local bulletNameR = enemyBulletConfig[10].nameOfpic
    local bulletNameM = enemyBulletConfig[11].nameOfpic

	local pos = cc.p(birdFather:getPosition())
    local size = birdFather.size
    
    -- 左子弹
    local bullet_a = Bullet:create(birdFather.bulleSpeed, bulletNameL, 1, PLANE_BULLET_TYPE)
    if nil ~= bullet_a then
        table.insert(play_bullet, bullet_a)
        --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
        birdFather:getParent():addChild(bullet_a, 2, 901)
        bullet_a:setPosition(cc.p(pos.x + leftBulletPosition, pos.y + 5 + size.height * 0.3))
        bullet_a:setScale(0.3)
        -- bullet_a:setRotation(45)
    end

    --中间的子弹
    local bullet_c = Bullet:create(birdFather.bulleSpeed, bulletNameM, 1, PLANE_BULLET_TYPE)
    if nil ~= bullet_c then
        table.insert(play_bullet, bullet_c)
        birdFather:getParent():addChild(bullet_c, 2, 901)
        bullet_c:setPosition(cc.p(pos.x, pos.y + 5 + size.height * 0.3))
        bullet_c:setScale(0.3)
        -- bullet_b:setRotation(45)
    end

    -- 右子弹
    local bullet_b = Bullet:create(birdFather.bulleSpeed, bulletNameR, 1, PLANE_BULLET_TYPE)
    if nil ~= bullet_b then
        table.insert(play_bullet, bullet_b)
        birdFather:getParent():addChild(bullet_b, 2, 901)
        bullet_b:setPosition(cc.p(pos.x + RightBulletPosition, pos.y + 5 + size.height * 0.3))
        bullet_b:setScale(0.3)
        -- bullet_b:setRotation(45)
    end
end