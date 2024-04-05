-- 定义按键常量
local CHANGE_EXTEND_SKILL_BTN = {'n'}       -- 切换额外上端技能栏按键
local BACK_SKILL_KEY_TABLE = {'tilde'}      -- 切换技能栏1按键
local CANCEL_SUMMON_PET = {'y'}             -- 取消召唤宠物按键
local PET_SKILL_1 = {'lbracket'}            -- 宠物技能1按键
local PET_SKILL_2 = {'rbracket'}            -- 宠物技能2按键
local PET_FRIEND_1 = {'semicolon'}          -- 宠物好友栏1号

--[[
    召唤宠物状态
    @currentSkillIndex      当前在第几栏
    @currentPetIndex        当前在第几只
]] 
function PetGroupStatus(currentSkillIndex, currentPetIndex)
    local o = {};
    o.currentSkillIndex = currentSkillIndex or 1;
    o.currentPetIndex = currentPetIndex or 1;
    return o
end

--[[
    宠物组设置
    @skillKeyTable      切换技能栏按键
    @petKeyTable        本组宠物按键
    @isChangeExtend     是否切换右侧技能栏，默认不切换（false）
    @waitSleep          召唤宠物后等待时间，默认500ms
    @holdSummon         是否取消（驻留）召唤，默认取消（false）
    @pluginFn           流程结束后使用的插件（需自定义）
]]
function PetGroupCfg(skillKeyTable, petKeyTable, isChangeExtend, waitSleep, holdSummon, pluginFn)
    local o = {}
    o.skillKeyTable = skillKeyTable
    o.petKeyTable = petKeyTable
    o.isChangeExtend = isChangeExtend or false
    o.waitSleep = waitSleep or 500
    o.holdSummon = holdSummon or false
    o.pluginFn = pluginFn or nil
    return o
end

-- 途安插件，召唤后使用宠物技能栏1
function TuanPlugin()
    PressKeyCfg(PET_SKILL_1)
end

-- 通用插件，召唤宠物后使用宠物技能栏1，并取消召唤
function PetSkillCancelPlugin()
    PressKeyCfg(PET_SKILL_1)
    Sleep(500)
    PressKeyCfg(CANCEL_SUMMON_PET)
end

-- 通用插件，召唤宠物后召唤好友1，并取消召唤
function PetFriendSummon()
    PressKeyCfg(PET_FRIEND_1)
    Sleep(500)
    PressKeyCfg(CANCEL_SUMMON_PET)
end

-- 狐狸插件，召唤后使用宠物技能栏1，并在鼠标位置点击后取消召唤
function FoxPlugin()
    PressKeyCfg(PET_SKILL_1)
    Sleep(800)
    PressAndReleaseMouseButton(1);
    Sleep(400);
    PressKeyCfg(CANCEL_SUMMON_PET)
end

-- 按键或按组合键
function PressKeyCfg(keyTable, sleepTimeout)
    local s
    if(nil == sleepTimeout) then
        s = 1
    else
        s = sleepTimeout
    end
    if (type(keyTable) == 'table') then
        for i, v in ipairs(keyTable) do
            PressKey(v)
        end
        Sleep(s)
        for i, v in ipairs(keyTable) do
            ReleaseKey(v)
        end
    else 
        PressKey(keyTable)
        Sleep(s)
        ReleaseKey(keyTable)
    end
end

function SummonPetLoop(petGroupStatus, petGroupCfgs)
    --[[
    -- 输出状态log
    OutputLogMessage("===== start summon pet =====\n")
    OutputLogMessage("petGroupCfgs length = %s\n", #petGroupCfgs)
    OutputLogMessage("current skill index = %s\n", petGroupStatus.currentSkillIndex)
    OutputLogMessage("current pet index = %s\n", petGroupStatus.currentPetIndex)
    OutputLogMessage("%s\n", petGroupCfgs[petGroupStatus.currentSkillIndex])
    ]]--
    
    -- 获取当前宠物组
    local target = petGroupCfgs[petGroupStatus.currentSkillIndex]
    -- 获取当前宠物组中所有宠物的按键
    local pets = target.petKeyTable
    -- 获取当前宠物按键
    local pet = pets[petGroupStatus.currentPetIndex]
    -- 召唤前先取消当前宠物
    PressKeyCfg(CANCEL_SUMMON_PET)
    Sleep(100)
    -- 如果需切换额外上端技能栏，则进行切换
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    
    -- 切换技能栏
    PressKeyCfg(target.skillKeyTable)
    -- 召唤宠物
    PressKeyCfg(pet)
    -- 切回技能栏1
    PressKeyCfg(BACK_SKILL_KEY_TABLE)
    
    -- 如果已切换额外上端技能栏，则切换回原来的上端技能栏
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    -- 等待
    Sleep(target.waitSleep)

    if (target.pluginFn) then
        target.pluginFn()
    end
    -- 如果需要取消召唤宠物，则取消召唤
    OutputLogMessage("hold = %s\n", target.holdSummon)
    if (not target.holdSummon) then
        PressKeyCfg(CANCEL_SUMMON_PET)
    end
    
    -- 更新宠物状态
    if(petGroupStatus.currentPetIndex < #pets) then
        petGroupStatus.currentPetIndex = petGroupStatus.currentPetIndex + 1
    else
        petGroupStatus.currentSkillIndex = petGroupStatus.currentSkillIndex + 1
        petGroupStatus.currentPetIndex = 1
    end
    if(petGroupStatus.currentSkillIndex > #petGroupCfgs) then
        petGroupStatus.currentSkillIndex = 1;
        petGroupStatus.currentPetIndex = 1;
    end
    
    return petGroupStatus;
end

-- register key group
--[[G5Status = PetGroupStatus(1, 1)
G5Configs = { 
    PetGroupCfg("num5", {"5", "6", "7", "8", "9", "0", "minus", "equal"}, false, 550),
    PetGroupCfg("num6", {"5", "6", "7", "8", "9", "0", "minus", "equal"}, false, 550) 
}]]--

-- 狄娜希
DiNaXiStatus = PetGroupStatus(1, 1)
DiNaXiConfigs = { 
    PetGroupCfg("num7", {"7", "8", "9", "0", "minus", "equal"}, true, 550)
}

-- 骨龙/青龙
GuLongStatus = PetGroupStatus(1, 1)
GuLongConfigs = { 
    PetGroupCfg("t", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}, true, 550, true, PetFriendSummon),
    PetGroupCfg("g", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}, true, 550, true, PetFriendSummon),
}

-- 鲸鱼回血
JingYuStatus = PetGroupStatus(1, 1)
JingYuConfigs = { 
    PetGroupCfg("num8", {"6", "7", "8"}, true, 550, true, PetSkillCancelPlugin)
}

-- 羊云/小鹿男/小鬼摩托
YangYunStatus = PetGroupStatus(1, 1)
YangYunConfigs = { 
    PetGroupCfg("num5", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}, true, 550),
    PetGroupCfg("num6", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}, true, 550),
    PetGroupCfg("num7", {"1", "2", "3", "4", "5", "6"}, true, 550)
}

-- 卡丁车
KaDingCheStatus = PetGroupStatus(1, 1)
KaDingCheConfigs = { 
    PetGroupCfg("b", {"1", "2", "3", "4", "5", "6", "7", "8"}, true, 550)
}
-- 凤凰复活
FengHuangStatus = PetGroupStatus(1, 1)
FengHuangConfigs = { 
    PetGroupCfg("num5", {"6", "7", "8", "9", "0", "minus", "equal"}, false, 550, true, PetSkillCancelPlugin)
}

-- 柯基
KeJiStatus = PetGroupStatus(1, 1)
KeJiConfigs = { 
    PetGroupCfg("num6", {"9", "0", "minus", "equal"}, false, 550)
}

-- 猫
MaoStatus = PetGroupStatus(1, 1)
MaoConfigs = { 
    PetGroupCfg("g", {"minus", "equal"}, true, 550)
}

-- 途安
TuAnStatus = PetGroupStatus(1, 1)
TuAnConfigs = { 
    PetGroupCfg("num8", {"9", "0", "minus", "equal"}, true, 450, true, TuanPlugin)
}

-- 狐克斯buff
HuKeSiStatus = PetGroupStatus(1, 1)
HuKeSiConfigs = { 
    PetGroupCfg("num8", {"1", "2", "3", "4", "5"}, true, 550, true, FoxPlugin)
}

--[[
G600布局
-- 左侧
    G11 G14 G17 G20
    G10 G13 G16 G19
    G9 G12 G15 G18
-- 正面
    
    G1x  G4  G3x  G5  G2x
    主键    中键     次键
            G8
            G7
==========================================
G604布局
-- 左侧
    G9 G8 G7
    G6 G5 G4
-- 正面
    G11
    G10  G1  G12  G3  G13  G2
        主键     中键      次键
==========================================
G502布局
-- 左侧
    G6  G5  G4
-- 正面
    G8
    G7  G1  G11  G3  G10  G2
        主键     中键      次键
                 G9
]]

function OnEvent(event, arg)    
    OutputLogMessage("event = %s, arg = %s\n", event, arg);
    -- G1
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 1) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 1 \n");
    end
    -- G2
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 2) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 2 \n");
    end
    -- G3
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 3) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 3 \n");
        -- G3Status = SummonPetLoop(G3Status, G3Configs)
    end
    -- G4
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 4) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 4 \n");
        TuAnStatus = SummonPetLoop(TuAnStatus, TuAnConfigs)
    end
    -- G5
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 5) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
        HuKeSiStatus = SummonPetLoop(HuKeSiStatus, HuKeSiConfigs)
    end
    -- G6
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 6) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 6 \n");
    end
    -- G7
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 7) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 7 \n");
    end
    -- G8
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 8) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 8 \n");
        -- G8Status = SummonPetLoop(G8Status, G8Configs)
    end
    -- G9
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 9) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 9 \n");
        FengHuangStatus = SummonPetLoop(FengHuangStatus, FengHuangConfigs)
    end
    -- G10
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 10) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 10 \n");
    end
    -- G11
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 11) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 11 \n");
        -- G11Status = SummonPetLoop(G11Status, G11Configs)
        -- Sleep(50)
        -- G11Status = SummonPetLoop(G11Status, G11Configs)
        -- Sleep(50)
    end
    -- G12
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 12) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 12 \n");
        JingYuStatus = SummonPetLoop(JingYuStatus, JingYuConfigs)
    end
    -- G13
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 13) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 13 \n");
        DiNaXiStatus = SummonPetLoop(DiNaXiStatus, DiNaXiConfigs)
    end
    -- G14
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 14) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 14 \n");
    end
    -- G15
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 15) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 15 \n");
        GuLongStatus = SummonPetLoop(GuLongStatus, GuLongConfigs)
    end
    -- G16
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 16) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 16 \n");
        KaDingCheStatus = SummonPetLoop(KaDingCheStatus, KaDingCheConfigs)
    end
    -- G17
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 17) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 17 \n");
        KeJiStatus = SummonPetLoop(KeJiStatus, KeJiConfigs)
        Sleep(50)
        KeJiStatus = SummonPetLoop(KeJiStatus, KeJiConfigs)
        Sleep(50)
    end
    -- G18
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 18) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 18 \n");
    end
    -- G19
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 19) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 19 \n");
        YangYunStatus = SummonPetLoop(YangYunStatus, YangYunConfigs)
    end
    -- G20
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 20) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 20 \n");
        MaoStatus = SummonPetLoop(MaoStatus, MaoConfigs)
    end
end