
local goFather = nil
initGoPicAndBullet = function(parents, PicName) 
    goFather = parents
    parents:stopAllActions()
    initGoPic(parents, PicName)
end

function init2GoPic(parents, PicName)
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(PicName)
    parents:setSpriteFrame(frame)
end

function initGoPic(parents, PicName)
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(PicName)
    parents:setSpriteFrame(frame)
    parents:setPosition(cc.p(WIN_SIZE.width / 2, 60))
    parents.size = parents:getContentSize()
    parents:setScale(0.5)

    addMypet(parents)

    local particle1 = cc.ParticleFire:create()
    parents:addChild(particle1)
    particle1:setScaleX(0.15)
    particle1:setScaleY(0.25)
    particle1:setRotation(180)
    particle1:setPosition(cc.p(parents:getPositionX() / 2 -2,
     parents:getPositionY() - parents.size.height / 2))

    local particle2 = cc.ParticleFire:create()
    parents:addChild(particle2)
    particle2:setScaleX(0.15)
    particle2:setScaleY(0.25)
    particle2:setRotation(180)
    particle2:setPosition(cc.p(parents:getPositionX() / 2 - 25,
    parents:getPositionY() - parents.size.height / 2))
    
    parents.canBeAttack = false
    local function canAttack(node, tab)
        parents.canBeAttack = true 
        self:removeChildByTag(999)
    end

    local blink = cc.Blink:create(2, 6) --闪烁
    local func = cc.CallFunc:create(canAttack)
    parents:runAction(cc.Sequence:create(blink, func))
    
    --射击子弹
    local function setShoot()
        goShoot()
    end
    schedule(parents, setShoot, parents.delayTime)

    parents:setRing(3)
    parents:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(parents.size.width*0.5, 
        parents.size.height*0.5)))
    parents:getPhysicsBody():setCategoryBitmask(PLANE_CATEGORY_MASK)
    parents:getPhysicsBody():setCollisionBitmask(PLANE_COLLISION_MASK)
    parents:getPhysicsBody():setContactTestBitmask(PLANE_CONTACTTEST_MASK)
end

function addMypet(parents)
    local frameLeft = cc.SpriteFrameCache:getInstance():getSpriteFrame("mypet01.png")
    local petLeft = cc.Sprite:create()
    petLeft:setSpriteFrame(frameLeft)
    parents:addChild(petLeft, 10, 1314)

    local size = parents:getContentSize()
    petLeft:setAnchorPoint(cc.p(0.5, 0.5))
    petLeft:setPosition(cc.p(size.width / 4 * -1, size.height / 2 - 15))
    myPetInitWithBull(petLeft, parents)


    local frameRight = cc.SpriteFrameCache:getInstance():getSpriteFrame("mypet01.png")
    local petRight = cc.Sprite:create()
    petRight:setSpriteFrame(frameRight)
    parents:addChild(petRight, 10, 1314)

    petRight:setAnchorPoint(cc.p(0.5, 0.5))
    petRight:setPosition(cc.p(size.width / 4 * 5 , size.height / 2 - 15))
    myPetInitWithBull(petRight, parents)
end

--[[
@bulletIndex 子弹名称
@type 类型
]]
function goShoot()

    local bulletName = GiftPicConfig[getGiftIndexA].getPicName
    local bulletName2 = GiftPicConfig[getGiftIndexB].getPicName
    local bulletAScaleSize = enemyBulletConfig[GiftPicConfig[getGiftIndexA].type].sizeOfBullet
    local bulletBScaleSize = enemyBulletConfig[GiftPicConfig[getGiftIndexB].type].sizeOfBullet

    local pos = cc.p(goFather:getPosition())
    local size = goFather.size
    
    if planeTypeIndex == 1 then
    -- 类型1的飞机只有1个子弹
        local bulletSprite = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite then
            table.insert(play_bullet, bulletSprite)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite, 2, 901)
            bulletSprite:setPosition(cc.p(pos.x , pos.y + size.height / 2))
            bulletSprite:setScale(bulletAScaleSize)
        end
    elseif planeTypeIndex == 2 then
        local bulletSpriteLift = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSpriteLift then
            table.insert(play_bullet, bulletSpriteLift)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSpriteLift, 2, 901)
            bulletSpriteLift:setPosition(cc.p(pos.x - size.width*0.2 / 2 , pos.y + size.height / 2 - 5))
            bulletSpriteLift:setScale(bulletAScaleSize)
        end

        local bulletSpriteRight = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSpriteRight then
            table.insert(play_bullet, bulletSpriteRight)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSpriteRight, 2, 901)
            bulletSpriteRight:setPosition(cc.p(pos.x + size.width*0.2 / 2 , pos.y + size.height / 2 - 5))
            bulletSpriteRight:setScale(bulletAScaleSize)
        end
    elseif planeTypeIndex == 3 then
        local bulletSprite1 = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite1 then
            table.insert(play_bullet, bulletSprite1)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite1, 2, 901)
            bulletSprite1:setPosition(cc.p(pos.x - size.width*0.2 / 4 , pos.y + size.height / 2 - 10))
            bulletSprite1:setScale(bulletAScaleSize)
        end

        local bulletSprite2 = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite2 then
            table.insert(play_bullet, bulletSprite2)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite2, 2, 901)
            bulletSprite2:setPosition(cc.p(pos.x + size.width*0.2 / 4 , pos.y + size.height / 2 - 10))
            bulletSprite2:setScale(bulletAScaleSize)
        end

        local bulletSprite3 = Bullet:create(goFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite3 then
            table.insert(play_bullet, bulletSprite3)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite3, 2, 901)
            bulletSprite3:setPosition(cc.p(pos.x - size.width*0.2 / 4 - 6, pos.y + size.height / 2 - 35))
            bulletSprite3:setScale(bulletBScaleSize)
        end

        local bulletSprite4 = Bullet:create(goFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite4 then
            table.insert(play_bullet, bulletSprite4)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite4, 2, 901)
            bulletSprite4:setPosition(cc.p(pos.x + size.width*0.2 / 4 + 6, pos.y + size.height / 2 - 35))
            bulletSprite4:setScale(bulletBScaleSize)
        end
    elseif planeTypeIndex == 4 then
         local bulletSprite1 = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite1 then
            table.insert(play_bullet, bulletSprite1)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite1, 2, 901)
            bulletSprite1:setPosition(cc.p(pos.x - size.width*0.2 / 4 , pos.y + size.height / 2 - 5))
            bulletSprite1:setScale(bulletAScaleSize)
        end

        local bulletSprite2 = Bullet:create(goFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite2 then
            table.insert(play_bullet, bulletSprite2)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite2, 2, 901)
            bulletSprite2:setPosition(cc.p(pos.x + size.width*0.2 / 4 , pos.y + size.height / 2 - 5))
            bulletSprite2:setScale(bulletAScaleSize)
        end

        local bulletSprite3 = Bullet:create(goFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite3 then
            table.insert(play_bullet, bulletSprite3)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite3, 2, 901)
            bulletSprite3:setPosition(cc.p(pos.x - size.width*0.2 / 4 * 3 - 2 , pos.y + size.height / 2 - 40))
            bulletSprite3:setScale(bulletBScaleSize)
        end

        local bulletSprite4 = Bullet:create(goFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite4 then
            table.insert(play_bullet, bulletSprite4)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            goFather:getParent():addChild(bulletSprite4, 2, 901)
            bulletSprite4:setPosition(cc.p(pos.x + size.width*0.2 / 4 * 3 + 3 , pos.y + size.height / 2 - 40))
            bulletSprite4:setScale(bulletBScaleSize)
        end
    end
end

function goChangeBullet(parents, type, bulletIndex, bulletIndex2)
    parents:stopAction(setShoot)
    local function setShoot()
        goShoot(type, bulletIndex, bulletIndex2)
    end
    schedule(parents, setShoot, parents.delayTime)
end

