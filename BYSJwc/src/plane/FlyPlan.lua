
local flyFather = nil
initFlyPicAndBullet = function(parents, PicName) 
    flyFather = parents
    parents:stopAllActions()
    initFlyPic(parents, PicName, type, bulletIndex, bulletIndex2)
end

function init2FlyPic(parents, PicName)
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(PicName)
    parents:setSpriteFrame(frame)
end

function initFlyPic(parents, PicName)
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(PicName)
    parents:setSpriteFrame(frame)
    parents:setPosition(cc.p(WIN_SIZE.width / 2, 60))
    parents.size = parents:getContentSize()
    parents:setScale(0.5)
 
    -- 闪烁不死之身
    local ghostShipFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(PicName)
    local ghostShip = cc.Sprite:create()
    parents:addChild(ghostShip, 10, 999)
    ghostShip:setSpriteFrame(ghostShipFrame)
    ghostShip:setScale(6)
    ghostShip:setPosition(cc.p(parents.size.width / 2, 12))
    ghostShip:runAction(cc.ScaleTo:create(2, 1, 1))
    ghostShip:setBlendFunc(GL_SRC_ALPHA, GL_ONE)
    
    parents.canBeAttack = false
    parents.hasRing = true
    local function canAttack(node, tab)
        parents.canBeAttack = true
        parents.hasRing = false 
        parents:removeChildByTag(999)
    end

    local blink = cc.Blink:create(2, 6) --闪烁
    local func = cc.CallFunc:create(canAttack)
    parents:runAction(cc.Sequence:create(blink, func))

    
    --射击子弹
    local function setShoot()
        flyShoot()
    end
    schedule(parents, setShoot, parents.delayTime)
    parents:setRing(3)

    parents:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(parents.size.width * 0.5, 
        parents.size.height * 0.5)))
    parents:getPhysicsBody():setCategoryBitmask(PLANE_CATEGORY_MASK)
    parents:getPhysicsBody():setCollisionBitmask(PLANE_COLLISION_MASK)
    parents:getPhysicsBody():setContactTestBitmask(PLANE_CONTACTTEST_MASK)
    
end
--[[]
@bulletIndex, bulletIndex2 子弹名称
@type 类型
]]

function flyShoot()
    local bulletName = GiftPicConfig[getGiftIndexA].getPicName
    local bulletName2 = GiftPicConfig[getGiftIndexB].getPicName
    local bulletAScaleSize = enemyBulletConfig[GiftPicConfig[getGiftIndexA].type].sizeOfBullet
    local bulletBScaleSize = enemyBulletConfig[GiftPicConfig[getGiftIndexB].type].sizeOfBullet

    local pos = cc.p(flyFather:getPosition())
    local size = flyFather.size
    
    if planeTypeIndex == 1 then
    -- 类型1的飞机只有1个子弹
        local bulletSprite = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite then
            table.insert(play_bullet, bulletSprite)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite, 2, 901)
            bulletSprite:setPosition(cc.p(pos.x , pos.y + size.height / 2))
            bulletSprite:setScale(bulletAScaleSize)
        end
    elseif planeTypeIndex == 2 then
        local bulletSpriteLift = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSpriteLift then
            table.insert(play_bullet, bulletSpriteLift)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSpriteLift, 2, 901)
            bulletSpriteLift:setPosition(cc.p(pos.x - size.width*0.2 / 2 , pos.y + size.height / 2 - 5))
            bulletSpriteLift:setScale(bulletAScaleSize)
        end

        local bulletSpriteRight = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSpriteRight then
            table.insert(play_bullet, bulletSpriteRight)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSpriteRight, 2, 901)
            bulletSpriteRight:setPosition(cc.p(pos.x + size.width*0.2 / 2 , pos.y + size.height / 2 - 5))
            bulletSpriteRight:setScale(bulletAScaleSize)
        end
    elseif planeTypeIndex == 3 then
        local bulletSprite1 = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite1 then
            table.insert(play_bullet, bulletSprite1)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite1, 2, 901)
            bulletSprite1:setPosition(cc.p(pos.x - size.width*0.2 / 4 , pos.y + size.height / 2 - 5))
            bulletSprite1:setScale(bulletAScaleSize)
        end

        local bulletSprite2 = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite2 then
            table.insert(play_bullet, bulletSprite2)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite2, 2, 901)
            bulletSprite2:setPosition(cc.p(pos.x + size.width*0.2 / 4 , pos.y + size.height / 2 - 5))
            bulletSprite2:setScale(bulletAScaleSize)
        end

        local bulletSprite3 = Bullet:create(flyFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite3 then
            table.insert(play_bullet, bulletSprite3)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite3, 2, 901)
            bulletSprite3:setPosition(cc.p(pos.x - size.width*0.2 / 4 * 3 - 5 , pos.y + size.height / 2 - 20))
            bulletSprite3:setScale(bulletBScaleSize)
        end

        local bulletSprite4 = Bullet:create(flyFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite4 then
            table.insert(play_bullet, bulletSprite4)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite4, 2, 901)
            bulletSprite4:setPosition(cc.p(pos.x + size.width*0.2 / 4 * 3 + 8 , pos.y + size.height / 2 - 20))
            bulletSprite4:setScale(bulletBScaleSize)
        end
    elseif planeTypeIndex == 4 then
        local bulletSprite1 = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite1 then
            table.insert(play_bullet, bulletSprite1)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite1, 2, 901)
            bulletSprite1:setPosition(cc.p(pos.x - size.width*0.2 / 4 , pos.y + size.height / 2 - 5))
            bulletSprite1:setScale(bulletAScaleSize)
        end

        local bulletSprite2 = Bullet:create(flyFather.bulleSpeed, bulletName, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite2 then
            table.insert(play_bullet, bulletSprite2)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite2, 2, 901)
            bulletSprite2:setPosition(cc.p(pos.x + size.width*0.2 / 4 , pos.y + size.height / 2 - 5))
            bulletSprite2:setScale(bulletAScaleSize)
        end

        local bulletSprite3 = Bullet:create(flyFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite3 then
            table.insert(play_bullet, bulletSprite3)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite3, 2, 901)
            bulletSprite3:setPosition(cc.p(pos.x - size.width*0.2 / 4 * 3 - 2 , pos.y + size.height / 2 - 20))
            bulletSprite3:setScale(bulletBScaleSize)
        end

        local bulletSprite4 = Bullet:create(flyFather.bulleSpeed, bulletName2, 1, PLANE_BULLET_TYPE)
        if nil ~= bulletSprite4 then
            table.insert(play_bullet, bulletSprite4)
            --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
            flyFather:getParent():addChild(bulletSprite4, 2, 901)
            bulletSprite4:setPosition(cc.p(pos.x + size.width*0.2 / 4 * 3 + 2 , pos.y + size.height / 2 - 20))
            bulletSprite4:setScale(bulletBScaleSize)
        end
    end
end


function FlyChangeBullet(parents, type, bulletIndex, bulletIndex2)
    parents:stopAction(setShoot)
    local function setShoot()
        flyShoot(type, bulletIndex, bulletIndex2)
    end
    schedule(parents, setShoot, parents.delayTime)
end
