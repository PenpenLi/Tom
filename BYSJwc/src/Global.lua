
Global = class("Global","")
Global.audioState = true
Global.life = 3
Global.score = 0
Global.highScore = 0
Global.enemies = {}
Global.enemyTypes = {}

local _global = Global
_global = nil
function Global:getInstance()
    if nil == _global then
        _global = Global.new()
        _global:init()
    end
    return _global
end

function Global:init()
    -- 敌人信息
    local temp = EnemyInfo.new()
    temp.showTime = 3
    temp.types = {1, 2, 3}
    table.insert(self.enemies, temp)
    
    temp = EnemyInfo.new()
    temp.showTime = 5
    temp.types = {4, 5, 6}
    table.insert(self.enemies, temp)

    -- 敌人类型
    local temp2 = EnemyType.new()
    temp2.type = 1
    temp2.power = 0.5
    temp2.textureName = enemyBulletConfig[temp2.type].nameOfpic
    temp2.bulletType = enemyBulletConfig[temp2.type].nameOfBullet
    temp2.HP = 3
    temp2.moveType = 1
    temp2.scoreValue = 5
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 2
    temp2.power = 0.6
    temp2.textureName = enemyBulletConfig[temp2.type].nameOfpic
    temp2.bulletType = enemyBulletConfig[temp2.type].nameOfBullet
    temp2.HP = 5
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 3
    temp2.power = 0.7
    temp2.textureName = enemyBulletConfig[temp2.type].nameOfpic
    temp2.bulletType = enemyBulletConfig[temp2.type].nameOfBullet
    temp2.HP = 8
    temp2.moveType = 3
    temp2.scoreValue = 20
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 4
    temp2.power = 0.8
    temp2.textureName = enemyBulletConfig[temp2.type].nameOfpic
    temp2.bulletType = enemyBulletConfig[temp2.type].nameOfBullet
    temp2.HP = 13
    temp2.moveType = 4
    temp2.scoreValue = 30
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 5
    temp2.power = 0.9
    temp2.textureName = enemyBulletConfig[temp2.type].nameOfpic
    temp2.bulletType = enemyBulletConfig[temp2.type].nameOfBullet
    temp2.HP = 21
    temp2.moveType = 3
    temp2.scoreValue = 50
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 6
    temp2.power = 1.0
    temp2.textureName = enemyBulletConfig[temp2.type].nameOfpic
    temp2.bulletType = enemyBulletConfig[temp2.type].nameOfBullet
    temp2.HP = 34
    temp2.moveType = 2
    temp2.scoreValue = 100
    table.insert(self.enemyTypes, temp2)
    
-- 掉落物品
    temp2 = EnemyType.new()
    temp2.type = 7
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = "" 
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 8
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 9
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 10
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 11
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 12
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 13
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)

    temp2 = EnemyType.new()
    temp2.type = 14
    temp2.power = 1.0
    temp2.textureName = GiftPicConfig[temp2.type].GiftPicName
    temp2.bulletType = ""
    temp2.HP = 1
    temp2.moveType = 4
    temp2.scoreValue = 10
    table.insert(self.enemyTypes, temp2)
end

-- 设置声音
function Global:setAudioState(state)
    self.audioState = state
end
function Global:getAudioState()
    return self.audioState
end

-- 设置生命值
function Global:setLifeCount()
    self.life = self.life - 1
end
function Global:getLifeCount()
    return self.life
end

-- 设置分数
function Global:setScore(dt)
    self.score = self.score + dt
end
function Global:getScore()
    return self.score
end

-- 历史分数
function Global:setHighScore(score)
    cc.UserDefault:getInstance():setIntegerForKey("score", score)
    cc.UserDefault:getInstance():flush()
    self.highScore = score
end
function Global:getHighScore()
    self.highScore = cc.UserDefault:getInstance():getIntegerForKey("score")
    return self.highScore
end

function Global:getEnemise()
    return self.enemies
end
function Global:getEnemyType()
    return self.enemyTypes
end

-- 重置游戏
function Global:resetGame()
    -- 重置生命值、分数
    self.life = 3
    self.score = 0

    play_bullet = {}
    enemy_bullet = {}
    enemy_items = {}
end

-- 退出游戏,释放资源
function Global:ExitGame()
    play_bullet = nil
    enemy_bullet = nil
    enemy_items = nil
end

