
EnemyManager = class("EnemyManager", function()
    return cc.Node:create()
end)
EnemyManager.enemies = nil
EnemyManager.enemyTypes = nil
EnemyManager.gameLayer = nil

function EnemyManager:create(gamelayer)
    local manager = EnemyManager.new()
    manager:init(gamelayer)
    return manager
end

function EnemyManager:init(gamelayer)
    self.gameLayer = gamelayer
    self.enemies = Global:getInstance():getEnemise() --敌机大种类
    self.enemyTypes = Global:getInstance():getEnemyType() --敌机小种类
end

-- 刷新敌人
function EnemyManager:updateEnemy(dt)
    -- 如果全局爆炸，先不更新飞机,等待一个延时效果
    if haveGlobalExplode == true then 
        return
    end
    -- 最多 enemyNumber 个, enemyNumber在配置表中定义
    local NumberEnemyItem = 0
    for _, _ in pairs(enemy_items) do
        NumberEnemyItem = NumberEnemyItem + 1
    end
    if self.enemies == nil or NumberEnemyItem >= enemyNumber then
        return
    end

    for _, enemy in pairs(self.enemies) do
        if enemy.showType == "Repeat" then
            -- 每隔 2 时间,添加一个敌人
            if dt % 2 == 0 then
                local j = math.ceil(math.random() * 3)
                self:addEnemy(enemy.types[j])
            end
        end
    end

    if dt % 5 == 0 then
        local s = math.ceil(math.random() * 8) + 6
        self:addGift(s)
    end
end

-- 添加敌人
function EnemyManager:addEnemy(type)
    -- 按类型创建敌机
    local enemy = EnemySprite:create(self.enemyTypes[type])
    
    -- 设置位置
    local pos = cc.p(80 + 160 * math.random(), WIN_SIZE.height)
    enemy:setPosition(pos)

    -- 敌人移动轨迹
    local offset = nil
    local a0, a1, delay = nil, nil, nil
    local func = nil 
    local tempaction = nil
    
    local function repeatAction0(sender)
        self:repeatAction0(sender)
    end
    local function repeatAction1(sender)
        self:repeatAction1(sender)
    end
    local function repeatAction2(sender)
        self:repeatAction2(sender)
    end
    
    if enemy.moveType == 1 then
        -- 一直跟着飞机移动
        if nil ~= self.gameLayer:getShip() then 
            offset = cc.p(self.gameLayer:getShip():getPosition())
        else 
            offset = cc.p( WIN_SIZE.width / 2, 60)
        end
        local func = cc.CallFunc:create(repeatAction0)
        tempaction = cc.Sequence:create(cc.MoveTo:create(2.0, offset), func)
    elseif enemy.moveType == 2 then
        -- 圆周运动
        a0 = cc.MoveTo:create(1.0, cc.p(WIN_SIZE.width/2, WIN_SIZE.height-100))
        delay = cc.DelayTime:create(2.0)
        func = cc.CallFunc:create(repeatAction1)
        tempaction = cc.Sequence:create(a0, func)
    elseif enemy.moveType == 3 then
        -- 左右重复移动
        offset = cc.p(0, -100 - 200 * math.random())
        a0 = cc.MoveBy:create(1.0, offset)
        a1 = cc.MoveBy:create(1.0, cc.p(-80 * math.random(), 0))
        func = cc.CallFunc:create(repeatAction2)
        tempaction = cc.Sequence:create(a0, a1, func)
    elseif enemy.moveType == 4 then
        -- 向下移动
        local newX = 300
        if enemy:getPositionX() > WIN_SIZE.width /2 then
            newX = -300
        end
        a0 = cc.MoveBy:create(4, cc.p(newX, -100))
        a1 = cc.MoveBy:create(4, cc.p(-newX, -100))
        tempaction = cc.Sequence:create(a0, a1)
    end

    -- 加到游戏层中
    table.insert(enemy_items, enemy)
    self.gameLayer:addChild(enemy, enemy.moveType + 1000, 1002)
    enemy:runAction(tempaction)
end

--添加掉落物品
--[[
Tag 为 520
]]
function EnemyManager:addGift(index)

    local giftSprite = Gift:create(index)
    -- 设置位置
    local pos = cc.p(80 + 160 * math.random(), WIN_SIZE.height)
    giftSprite:setPosition(pos)


    -- 敌人移动轨迹
    local offset = nil
    local a0, a1, delay = nil, nil, nil
    local func = nil 
    local tempaction = nil
    
    local function repeatAction0(sender)
        self:repeatAction0(sender)
    end
    local function repeatAction1(sender)
        self:repeatAction1(sender)
    end
    local function repeatAction2(sender)
        self:repeatAction2(sender)
    end

    if giftSprite.moveType == 1 then
        -- 一直跟着飞机移动
        if nil ~= self.gameLayer:getShip() then 
            offset = cc.p(self.gameLayer:getShip():getPosition())
        else 
            offset = cc.p( WIN_SIZE.width / 2, 60)
        end
        local func = cc.CallFunc:create(repeatAction0)
        tempaction = cc.Sequence:create(cc.MoveTo:create(2.0, offset), func)
    elseif giftSprite.moveType == 2 then
        -- 圆周运动
        a0 = cc.MoveTo:create(1.0, cc.p(WIN_SIZE.width/2, WIN_SIZE.height-100))
        delay = cc.DelayTime:create(2.0)
        func = cc.CallFunc:create(repeatAction1)
        tempaction = cc.Sequence:create(a0, func)
    elseif giftSprite.moveType == 3 then
        -- 左右重复移动
        offset = cc.p(0, -100 - 200 * math.random())
        a0 = cc.MoveBy:create(1.0, offset)
        a1 = cc.MoveBy:create(1.0, cc.p(-80 * math.random(), 0))
        func = cc.CallFunc:create(repeatAction2)
        tempaction = cc.Sequence:create(a0, a1, func)
    elseif giftSprite.moveType == 4 then
        -- 向下移动
        local newX = 300
        if giftSprite:getPositionX() > WIN_SIZE.width / 2 then
            newX = -300
        end
        a0 = cc.MoveBy:create(4, cc.p(newX, -150))
        a1 = cc.MoveBy:create(4, cc.p(-newX, -150))
        tempaction = cc.Sequence:create(a0, a1)
    end

    -- 加到游戏层中
    table.insert(enemy_items, giftSprite)
    self.gameLayer:addChild(giftSprite,  giftSprite.moveType + 1000, 520)
    giftSprite:runAction(tempaction)
end
-- 一直跟着
function EnemyManager:repeatAction0(sender)
    local offset = nil
    if nil ~= self.gameLayer:getShip() then 
        offset = cc.p(self.gameLayer:getShip():getPosition())
    else 
        offset = cc.p(WIN_SIZE.width/2, 60)
    end

    local function repeatAction0(sender)
        self:repeatAction0(sender)
    end

    local delay = cc.DelayTime:create(1.0)
    local mv = cc.MoveTo:create(2.0, offset)
    local func = cc.CallFunc:create(repeatAction0)
    sender:runAction(cc.Sequence:create(mv, delay, func))
end

-- 圆周运动,贝塞尔曲线
function EnemyManager:repeatAction1(sender)
    local sgn = 1
    if math.random(1, 2) == 2 then
        sgn = -1
    end
    
    local dt = 2.0 + 2.0 * math.random()
    local dx = 100 + 100 * math.random()
    local dy = 100 + 100 * math.random()

    local bezier = {
        cc.p(sgn * dx, 0),
        cc.p(sgn * dx, -dy),
        cc.p(0, -dy),
    }    
    local bezier2 = {
        cc.p((-sgn) * dx, 0),
        cc.p((-sgn) * dx, dy),
        cc.p(0, dy)
    }
    
    local b0 = cc.BezierBy:create(dt, bezier)
    local b1 = cc.BezierBy:create(dt, bezier2)
    local seq = cc.Sequence:create(b0, b1)
    sender:runAction(cc.RepeatForever:create(seq))
end

-- 左右运动
function EnemyManager:repeatAction2(sender)
    local mv = cc.MoveBy:create(1.0, cc.p(100 + 100 * math.random(), 0))
    local delay = cc.DelayTime:create(1.0)
    local seq = cc.Sequence:create(delay, mv, delay:clone(), mv:reverse())
    local act = cc.RepeatForever:create(seq)
    sender:runAction(act)
end

