---@class CardConfig
local CardConfig = {}

CardConfig.CardInfo = 
{
    ------------------------------------------------------升级卡-------------------------------------------------------
    [101] = {
        Points = 1;
        Icon = "";
        Name = "增加体力";
        Description = "每级增加20的生命值";
        BuffID = 101;
        Params = {
            IncreaseHP = 20;
        };
    };
    [102] = {
        Points = 1;
        Icon = "";
        Name = "爆破鬼才";
        Description = "每级增加10%燃烧、爆炸伤害";
        BuffID = 102;
        Params = {
            IncreaseDamage = 0.1;
        };
    };
    [103] = {
        Points = 1;
        Icon = "";
        Name = "爆头宗师";
        Description = "每级+5%爆头伤害";
        BuffID = 103;
        Params = {
            IncreaseDamage = 0.05;
        };
    };
    [104] = {
        Points = 1;
        Icon = "";
        Name = "弹药倾泻";
        Description = "每级+5%的攻击速度";
        BuffID = 104;
        Params = {
            IncreaseSpeed = 0.05;
        };
    };
    [105] = {
        Points = 1;
        Icon = "";
        Name = "进阶火力";
        Description = "每级+2.5%的武器攻击力";
        BuffID = 105;
        Params = {
            IncreaseAttack = 0.025;
        };
    };
    [106] = {
        Points = 1;
        Icon = "";
        Name = "命中治疗";
        Description = "每级+10%吸血";
        BuffID = 106;
        Params = {
            IncreaseBloodsucking = 0.1;
        };
    };


    ------------------------------------------------------激活卡-------------------------------------------------------
    [1001] = {
        Points = 2;
        Icon = "";
        Name = "紧急避险";
        Description = "受到伤害后，立马增加30%移速，持续3s";
        BuffID = 1001;
        Params = {
            IncreaseSpeed = 0.3;
            Duration = 3;
        };
    };
    [1002] = {
        Points = 2;
        Icon = "";
        Name = "短引线";
        Description = "手雷的引爆时间缩短50%";
        BuffID = 1002;
        Params = {
            ShortenTime = 0.5;
        };
    };
    [1003] = {
        Points = 2;
        Icon = "";
        Name = "雾君";
        Description = "开局获得4个烟雾弹";
        BuffID = 1003;
        Params = {
            Count = 4;
        };
    };
    [1004] = {
        Points = 2;
        Icon = "";
        Name = "赌一把";
        Description = "局内获得一个一次性的技能，使用后将你的当前生命值改为1~200随机一个数";
        BuffID = 1004;
        Params = {
            HPMin = 1;
            HPMax = 200;
        };
    };
    [1005] = {
        Points = 2;
        Icon = "";
        Name = "机械飞升";
        Description = "开局失去50点生命值，但是获得50%减伤";
        BuffID = 1005;
        Params = {
            LoseHP = 50;
            ReduceInjuredValue = 0.5;
        };
    };
    [1006] = {
        Points = 2;
        Icon = "";
        Name = "微型弹夹";
        Description = "弹夹容量减少50%，换弹时间减少60%";
        BuffID = 1006;
        Params = {
            ReduceCapacity = 0.5;
            ReduceReloadTime = 0.6;
        };
    };
    [1007] = {
        Points = 3;
        Icon = "";
        Name = "冰君";
        Description = "造成伤害使对方减速30%";
        BuffID = 1007;
        Params = {
            ReduceSpeed = 0.3;
        };
    };
    [1008] = {
        Points = 3;
        Icon = "";
        Name = "第一枪";
        Description = "换弹后，弹夹内的第一发子弹伤害提升30%";
        BuffID = 1008;
        Params = {
            IncreaseDamage = 0.3;
        };
    };
    [1009] = {
        Points = 3;
        Icon = "";
        Name = "近战之王";
        Description = "对距离8m内的敌人造成伤害提高10%";
        BuffID = 1009;
        Params = {
            Distance = 800;
            IncreaseDamage = 0.1;
        };
    };
    [1010] = {
        Points = 3;
        Icon = "";
        Name = "狙击之王";
        Description = "对距离8m外的敌人造成伤害提高10%";
        BuffID = 1010;
        Params = {
            Distance = 800;
            IncreaseDamage = 0.1;
        };
    };
    [1011] = {
        Points = 3;
        Icon = "";
        Name = "雷君";
        Description = "每次命中敌方额外电击一次，造成10点伤害";
        BuffID = 1011;
        Params = {
            IncreaseDamage = 10;
        };
    };
    [1012] = {
        Points = 3;
        Icon = "";
        Name = "死者复生";
        Description = "死亡后会立刻变成一个150HP的仿生人，仿生人被打死才算彻底死亡";
        BuffID = 1012;
        Params = {
            HP = 150;
        };
    };
    [1013] = {
        Points = 3;
        Icon = "";
        Name = "禁止医疗";
        Description = "敌方本回合禁止任何回复血量";
        BuffID = 1013;
        Params = {
        };
    };
    [1014] = {
        Points = 4;
        Icon = "";
        Name = "艺术就是爆炸";
        Description = "开局获得4个手雷，手雷的爆炸范围提升10%";
        BuffID = 1014;
        Params = {
            Count = 4;
            IncreaseRange = 0.1;
        };
    };
    [1015] = {
        Points = 4;
        Icon = "";
        Name = "狂怒";
        Description = "每失去1点生命值，增加1%伤害";
        BuffID = 1015;
        Params = {
            LoseHP = 1;
            IncreaseDamage = 0.01;
        };
    };
    [1016] = {
        Points = 4;
        Icon = "";
        Name = "火君";
        Description = "免疫燃烧伤害，开局获得4个燃烧瓶";
        BuffID = 1016;
        Params = {
            Count = 4;
        };
    };
    [1017] = {
        Points = 5;
        Icon = "";
        Name = "无限火力";
        Description = "无需换弹，无限子弹";
        BuffID = 1017;
        Params = {
        };
    };
    [1018] = {
        Points = 5;
        Icon = "";
        Name = "鹰眼";
        Description = "本局显示敌方位置（透视）";
        BuffID = 1018;
        Params = {
        };
    };
}

CardConfig.RoundCardPool = 
{
    [1] = {
        [101] = 10;
        [102] = 20;
        [103] = 10;
        [104] = 10;
        [1001] = 20;
        [1002] = 20;
        [1003] = 40;
        [1004] = 20;
    }
}

return CardConfig