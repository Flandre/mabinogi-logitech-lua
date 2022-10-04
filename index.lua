-- 定义按键常量
local CHANGE_EXTEND_SKILL_BTN = {'lctrl', 'v'} -- 定义切换附加技能快捷键
local BACK_SKILL_KEY_TABLE = {'numperiod'} -- 定义返回主要技能快捷键
local CANCEL_SUMMON_PET = {'y'} -- 定义取消宠物技能快捷键

-- 定义宠物技能状态 
function PetGroupStatus(currentSkillIndex, currentPetIndex)
    local o = {};
    o.currentSkillIndex = currentSkillIndex or 1;
    o.currentPetIndex = currentPetIndex or 1;
    return o
end

-- 定义宠物技能按键
function PetGroupCfg(skillKeyTable, petKeyTable, isChangeExtend, waitSleep)
    local o = {}
    o.skillKeyTable = skillKeyTable
    o.petKeyTable = petKeyTable
    o.isChangeExtend = isChangeExtend or false
    o.waitSleep = waitSleep or 500
    return o
end

-- 组合键按键
function PressKeyCfg(keyTable, sleep)
    s = sleep or 10
    if (type(keyTable) == 'table') then
        for i, v in ipairs(keyTable) do
            PressKey(keyTable)
        end
        sleep(s)
        for i, v in ipairs(keyTable) do
            ReleaseKey(keyTable)
        end
    else 
        PressKey(keyTable)
        sleep(s)
        ReleaseKey(keyTable)
    end
end

-- 循环召唤宠物
function SummonPetLoop(petGroupStatus, petGroupCfgs)
    OutputLogMessage("===== start summon pet =====\n")
    OutputLogMessage("petGroupCfgs length = %s\n", #petGroupCfgs)
    OutputLogMessage("current skill index = %s\n", petGroupStatus.currentSkillIndex)
    OutputLogMessage("current pet index = %s\n", petGroupStatus.currentPetIndex)
    -- 开始循环召唤宠物
    target = petGroupCfgs[petGroupStatus.currentSkillIndex]
    pets = target.petKeyTable
    pet = pets[PetGroupStatus.currentPetIndex]
    -- 召唤前先取消宠物
    PressKeyCfg(CANCEL_SUMMON_PET)
    sleep(100)
    -- 如果需要切换到附加技能栏，先切换到附加技能栏
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    -- 切换到宠物技能栏
    PressKeyCfg(target.skillKeyTable)
    PressKeyCfg(pet)
    -- 切换回默认技能栏
    PressKeyCfg(BACK_SKILL_KEY_TABLE)
    -- 如果切换到附加技能栏，则切换回来
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    -- 宠物延时
    sleep(target.waitSleep)
    -- 取消召唤宠物
    PressKeyCfg(CANCEL_SUMMON_PET
    --更新技能栏以及宠物键位
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
    return petGroupStatus
    OutputLogMessage("===== end summon pet =====\n")
end

-- G键事件函数
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
    end
    -- G4
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 4) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 4 \n");
    end
    -- G5
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 5) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
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
    end
    -- G9
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 9) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 9 \n");
    end
end