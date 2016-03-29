--[[
	配置文件
]]

-- 颜色封装
cc.Blue = cc.c3b(25,24,244)
cc.Red = cc.c3b(255, 33, 34)
cc.White = cc.c3b(255, 0, 0) --cc.c3b(162,162,162)
cc.WhiteGary = cc.c4b(162, 162, 162, 128)

-- background random
backgroundSprite = {
	[1] = "img_bg_level_1.jpg",
	[2] = "img_bg_level_2.jpg",
	[3] = "img_bg_level_3.jpg",
	[4] = "img_bg_level_4.jpg",
	[5] = "img_bg_level_5.jpg",
}


shipPower = 4 --主机战斗力
shipBullSpeed = 400 -- 主机子弹速度
MAXShipBullSpeed = 700
shipHP = 10 --主机血量
GlobalShip = nil -- 全局主机

enemyPower = 1 --敌机战斗力
enemyNumber = 10 --敌机数量


play_bullet = {}    -- 玩家子弹
enemy_bullet = {}   -- 敌人子弹
enemy_items = {}    -- 敌人集合

haveGlobalExplode = false --是否全局爆炸

selectPlanIndex = 2 -- 默认是第一台战舰
planeTypeIndex = 4  -- 某一战舰的第x种类型,随着经验值，进化

--[[
主飞机最多使用2种子弹
GiftPicConfig
]]

getGiftIndexA = 7
getGiftIndexB = 8

selectPlanConfig = {
	[104] = "3.jpg",
	[105] = "4.jpg",
	[106] = "6.jpg",
}

configMusic = {
	--按钮声音
	[1] = "Music/click_button.mp3", --按钮音乐1
	[2] = "Music/click_button2.wav",--按钮音乐2

	--背景音乐
	[100] = "Music/loading.ogg", 		  --游戏加载声音
	[101] = "Music/loadMusic.mp3",        -- 背景音乐1
	[102] = "Music/brid_bg_music.mp3",    -- 背景音乐2
	[103] = "Music/bgmusic.ogg",		  -- 背景音乐3
	[104] = "Music/bgm_dfzhandou.ogg",    -- 战斗背景音1
	[105] = "Music/bgMusic.mp3",          -- 战斗背景音2
	[106] = "Music/gameover.ogg", 		  -- gameover
	[120] = "Music/effcet_vo_readygo.ogg", --ready go

    --爆炸音
	[201] = "Music/explodeEffect.mp3", -- 敌机爆炸声音
	[202] = "Music/shipDestroyEffect.mp3",--主角飞机爆炸声音

	--特效音
	[301] = "Music/effcet_vo_zhajihepijiu.ogg", --下雪天，怎么能没有炸鸡和啤酒
	[302] = "Music/buttonEffet.mp3", --开始游戏时，炫光加载的背景音乐

	--物品掉落
	[401] = "Music/effcet_vo_nice.ogg", -- nice
	[402] = "Music/effcet_vo_wooo.ogg",
	[403] = "Music/effcet_vo_great.ogg", -- great
	[404] = "Music/effcet_vo_exeellent.ogg", -- exeellent
	[405] = "Music/effcet_vo_cool.ogg", -- cool

	--血量不足
	[501] = "Music/xiawoyitiao.ogg",

	--选择难度
	[601] = "Music/meiyouduishouzhenwuliaoa.ogg", --没有对手真无聊啊
	[602] = "Music/wudijiushijimo.ogg", --无敌就是寂寞
	[603] = "Music/ciyuwoliliangba.ogg", --赐予我力量吧
	[604] = "Music/wudijiushijimo.ogg", --发动机已经启动

	--选择战舰
	[701] = "Music/effcet_vo_bashengmingtuofuyuwo.ogg", --来吧命运中的战士
	[702] = "Music/effcet_vo_fadongjiqidong.ogg", --发动机已经启动
	[703] = "Music/effcet_vo_rangtiankongranshao.ogg",--让天空燃烧吧
}

--光环
ringEffect = {
	--激光光环
	[1] = {
		["name"] = "res/wsparticle_c_electric.png",
		["scaleSize"] = 0.51,
		["rotatedFlag"] = true,
		["scaleFlag"] = false,
	},
	--鱼鳞光环
	[2] = {
		["name"] = "res/wsparticle_pengzhang.png",
		["scaleSize"] = 0.25,
		["rotatedFlag"] = true,
		["scaleFlag"] = false,
	},
	--膨胀光环
	[3] = {
		["name"] = "res/wsparticle_pengzhang_quan.png",
		["scaleSize"] = 0.35,
		["rotatedFlag"] = false,
		["scaleFlag"] = true,
	},
}

--敌机子弹配置 
enemyBulletConfig = {
	--普通子弹
	[1] = {
			["sizeOfScale"] = 0.55, --敌机缩放比例
			["sizeOfBullet"] = 1, --子弹缩放比例
			["nameOfBullet"] = "W2.png", --子弹资源名称
			["nameOfpic"] = "enemyplan1.png", --敌机资源名称
		},

	--普通子弹2
	[2] = {
			["sizeOfScale"] = 0.55, 
			["sizeOfBullet"] = 1,
			["nameOfBullet"] = "W1.png",
			["nameOfpic"] = "enemyplan2.png",
		},

	--激光子弹
	[3] = {
			["sizeOfScale"] = 0.6, 
			["sizeOfBullet"] = 0.15,
			["nameOfBullet"] = "jiguang1.png",
			["nameOfpic"] = "enemyplan3.png",
		},

	--子弹1
	[4] = {
			["sizeOfScale"] = 0.45,  
			["sizeOfBullet"] = 0.2,
			["nameOfBullet"] = "zidan1.png",
			["nameOfpic"] = "enemyplan4.png",
		},
	--导弹1
	[5] = {
			["sizeOfScale"] = 0.35, 
			["sizeOfBullet"] = 0.5,
			["nameOfBullet"] = "zidan2.png",
			["nameOfpic"] = "enemyplan5.png",
		},
	--导弹2（红色）
	[6] = {
			["sizeOfScale"] = 0.35, 
			["sizeOfBullet"] = 0.35,
			["nameOfBullet"] = "zidan3.png",
			["nameOfpic"] = "enemyplan6.png",
		},

	--导弹3 蓝色光流体
	[7] = {
			["sizeOfScale"] = 0.15, 
			["sizeOfBullet"] = 0.25,
			["nameOfBullet"] = "daodang.png",
			["nameOfpic"] = nil,
		},
	--导弹4 红色
	[8] = {
			["sizeOfScale"] = 0.35, 
			["sizeOfBullet"] = 0.35,
			["nameOfBullet"] = "daodang2.png",
			["nameOfpic"] = nil,
		},

	--凤凰左子弹（默认情况下）
	[9] = {
			["sizeOfScale"] = 0.35, 
			["sizeOfBullet"] = 0.3,
			["nameOfBullet"] = nil,
			["nameOfpic"] = "birdbullet02.png",
		},
	--凤凰右子弹(默认情况下)
	[10] = {
			["sizeOfScale"] = 0.35, 
			["sizeOfBullet"] = 0.3,
			["nameOfBullet"] = nil,
			["nameOfpic"] = "bridbullet03.png",
		},
	--凤凰中子弹(默认情况下)
	[11] = {
			["sizeOfScale"] = 0.35, 
			["sizeOfBullet"] = 0.3,
			["nameOfBullet"] = nil,
			["nameOfpic"] = "birdbullet01.png",
		},
}


GiftPicConfig ={
	--导弹2
	[7] = {
			["GiftPicName"] = "biandaodang2.png",
			["getPicName"] = "zidan2.png" ,
			["type"] = 5,
			["sizeOfScale"] = 0.5,
		},

	--激光
	[8] = {
			["GiftPicName"] = "bianjiguang.png",
			["getPicName"] = "jiguang1.png" ,
			["type"] = 3,
			["sizeOfScale"] = 0.7,
		},

	--导弹1
	[9] = {
			["GiftPicName"] = "biandaodang.png",
			["getPicName"] = "daodang2.png" ,
			["type"] = 8,
			["sizeOfScale"] = 0.7,
		},

	--加血
	[10] = {
			["GiftPicName"] = "jiaxue.png",
			["getPicName"] = nil ,
			["type"] = nil,
			["sizeOfScale"] = 0.5,
		},

	--光环
	[11] = {
			["GiftPicName"] = "guanghuan.png",
			["getPicName"] = {
				[1] = "wsparticle_c_electric.png",
				[2] = "wsparticle_pengzhang_quan",
				[3] = "wsparticle_boom01.png",
				[4] = "wsparticle_pengzhang.png",
			} ,
			["type"] = nil ,
			["sizeOfScale"] = 0.5,
		},

	--加攻速
	[12] = {
			["GiftPicName"] = "jiagongji1.png",
			["getPicName"] = nil ,
			["type"] = nil,
			["sizeOfScale"] = 0.5,
		},

	--导弹3
	[13] = {
			["GiftPicName"] = "daodang.png",
			["getPicName"] = "daodang.png" ,
			["type"] = 7,
			["sizeOfScale"] = 0.3,
		},

	--全局爆炸
	[14] = {
			["GiftPicName"] = "baozhao.png",
			["getPicName"] = nil ,
			["type"] = nil,
			["sizeOfScale"] = 0.5,
	}
}


planeOfConfig = {
	-- 天使逆袭战舰
	[1] = {
			[1] = "fly1.png",
			[2] = "fly2.png",
			[3] = "fly3.png",
			[4] = "fly4.png",
		},

	-- 雷霆战机
	[2] = {
			[1] = "go1.png",
			[2] = "go2.png",
			[3] = "go3.png",
			[4] = "go4.png",
		},

	-- 凤凰传说
	[3] = {

		},
}
