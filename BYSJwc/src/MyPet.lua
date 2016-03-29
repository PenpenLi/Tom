local petarr = {}
local petname = nil

for i = 1, 6 do 
    if i <= 9 then
        petname = string.format("mypet0%d.png", i)
    end  
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(petname)
    table.insert(petarr, frame)
end
    
local petanimation = cc.Animation:createWithSpriteFrames(petarr)
petanimation:setDelayPerUnit(0.1)
petanimation:setRestoreOriginalFrame(true)
cc.AnimationCache:getInstance():addAnimation(petanimation, "myPet")

local myPetFather = nil
local myPetFurFather = nil

myPetInitWithBull = function(parents, furParents) 
    myPetFather = parents
    myPetFurFather = furParents
    initMyPetPic(parents)
end

function initMyPetPic(parents)

    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("mypet01.png")
    parents:setSpriteFrame(frame)
    
    local myPetAnimation = cc.AnimationCache:getInstance():getAnimation("myPet")
    parents:runAction(cc.RepeatForever:create(cc.Animate:create(myPetAnimation)))
    
    --射击子弹
    local function shoot()
        myPetshoot()
    end
    --schedule(parents, shoot, myPetFurFather.delayTime)
end

function myPetshoot()
    local bulletSprite = Bullet:create(myPetFurFather.bulleSpeed, "zidan3.png", 1, PLANE_BULLET_TYPE)
    if nil ~= bulletSprite then
        table.insert(play_bullet, bulletSprite)
        --将gameLayer设为子弹的父亲节点，这样才好和飞机一起判断碰撞
        myPetFurFather:getParent():addChild(bulletSprite, 2, 901)

        cc.convertToWorldSpaceAR(nodePoint)
        local pos = cc.p(myPetFurFather:getPosition())
        local size = myPetFurFather:getContentSize()
        bulletSprite:setPosition(
            cc.pSub(myPetFurFather:convertToWorldSpaceAR(myPetFather:getPosition())), cc.p(0, 0))
        bulletSprite:setScale(0.2)
    end
end