Gift = class("Gift", function()
    return cc.Sprite:create()
end)

Gift.type = nil
Gift.HP = nil
Gift.power = nil
Gift.textureName = nil
Gift.scoreValue = nil

function Gift:create(index)
    local curGiftSprite = Gift.new()
    curGiftSprite:init(index)
    return curGiftSprite
end

--[[
掉落类物品，Globl从7 - 14 有7种。

]]
function Gift:init(index)
    self.enemyTypes = Global:getInstance():getEnemyType()
    local curGiftType = self.enemyTypes[index]
    self.type = curGiftType.type
    self.HP = curGiftType.HP
    self.power = curGiftType.power
    self.textureName = curGiftType.textureName
    self.scoreValue = curGiftType.scoreValue
    self.moveType = curGiftType.moveType
    self.sizeOfScale = GiftPicConfig[self.type].sizeOfScale

    self.active = true
    self.speed = 220

    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(self.textureName)
    self:setSpriteFrame(frame)

    self:setScale(self.sizeOfScale)
    self.size = self:getContentSize()
    self:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(self.size.width * self.sizeOfScale, 
        self.size.height * self.sizeOfScale)))
    self:getPhysicsBody():setCategoryBitmask(ENEMY_CATEGORY_MASK)
    self:getPhysicsBody():setCollisionBitmask(ENEMY_COLLISION_MASK)
    self:getPhysicsBody():setContactTestBitmask(ENEMY_CONTACTTEST_MASK)
end

function Gift:setHp()
    self.HP = -1
    self.active = false
end

function Gift:destroy()
    local giftNumber = math.ceil(math.random() * 5) + 400
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect(configMusic[giftNumber])
    end

    -- 爆炸+闪烁特效
    Effect:getInstance():explode(self:getParent(), cc.p(self:getPosition()), self.power)
    Effect:getInstance():spark(self:getParent(), cc.p(self:getPosition()), self.power * 3.0, 0.7)

    -- 得分
    Global:getInstance():setScore(self.scoreValue)

    -- 移除
    for _, v in pairs(enemy_items) do
        if v == self then
            table.remove(enemy_items, _)
        end
    end
    self:removeFromParent()
end

function Gift:isActive()
    return self.active
end

function Gift:getGiftType()
    return self.type
end

