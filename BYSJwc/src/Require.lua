-- FileUtils
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
cc.FileUtils:getInstance():addSearchPath("src/plane")
cc.FileUtils:getInstance():addSearchPath("res/Font")
cc.FileUtils:getInstance():addSearchPath("res/Music")


-- addSpriteFramesWithFile -> addSpriteFrames
cc.SpriteFrameCache:getInstance():addSpriteFrames("bullet.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("Enemy.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("explosion.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("hxl_0.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("bysj_resorce1_0.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("bysj_plane_0.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("bysj_enemyplan_0.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("bysj_brid_0.plist")
cc.SpriteFrameCache:getInstance():addSpriteFrames("bysj_pet_0.plist")
-- Require
require("Cocos2d")

require("src/UITool")
require("src/Config")
require("src/MyPet")
require("src/plane/BirdPlan")
require("src/plane/FlyPlan")
require("src/plane/GoPlan")


require("src/AboutScene")
require("src/Bullet")
require("src/Effect")
require("src/EnemyInfo")
require("src/EnemyManager")
require("src/EnemySprite")
require("src/GameLayer")
require("src/GameOverScene")
require("src/GameScene")
require("src/Global")
require("src/HelloScene")
require("src/Helper")
require("src/Gift") --添加掉落物品
require("src/LoadingScene")
require("src/OptionsScene")
require("src/PauseLayer")
require("src/PlaneSprite")
require("src/PhysicsTest")
require("src/setGame")
require("src/setMusic")

