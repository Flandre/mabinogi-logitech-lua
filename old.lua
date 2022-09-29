--[[
function OnEvent(event, arg)
    OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")
end
--]] -- 按键设置类 保存宠物对应的技能栏和按键--
Skills = {
    skill = "", -- 技能栏快捷键
    backSkill = "num1", -- 默认技能栏
    petKeys = {}, -- 技能栏上宠物对应的按键[1~=]
    waitSleep = 500
}

function getn(x)
    local len = 0
    for i in pairs(x) do len = len + 1 end
    return len
end

function Skills:new(skill, backSkill, petKeys, waitSleep)
    local o = {};
    setmetatable(o, self);
    o.skill = skill;
    o.backSkill = backSkill;
    o.petKeys = petKeys;
    o.waitSleep = waitSleep;
    return o;
end

-- 当前宠物索引及技能栏索引
CurrentIds = {currentSkillIndex = 1, currentPetIndex = 1}

function CurrentIds:new(currentSkillIndex, currentPetIndex)
    local o = {};
    setmetatable(o, self);
    o.currentSkillIndex = currentSkillIndex;
    o.currentPetIndex = currentPetIndex;
    return o
end
-- 古龙
G5CurrentIds = CurrentIds:new(1, 1)
G5Skills = {
    Skills:new("num5", "numperiod",
               {"5", "6", "7", "8", "9", "0", "minus", "equal"}, 550),
    Skills:new("num6", "numperiod",
               {"5", "6", "7", "8", "9", "0", "minus", "equal"}, 550)
}
-- currentIds 记录当前宠物所在的技能栏以及键位
-- skills 技能栏集合
-- isChange2 是否切换到扩展技能栏2 默认true
-- 召唤古龙

function DragonCallNext(currentIds, skills, isChange2)
    OutputLogMessage("skillslength = %s  ", #skills);
    OutputLogMessage("currentSkillIndex = %s  ", currentIds.currentSkillIndex);

    skill = skills[currentIds.currentSkillIndex];
    pets = skill.petKeys;
    pet = pets[currentIds.currentPetIndex];
    OutputLogMessage("pet = %s", (currentIds.currentPetIndex));
    -- 召唤前先取消宠物 
    PressKey("y");
    ReleaseKey("y");
    Sleep(100)

    PressKey(skill.skill);
    ReleaseKey(skill.skill);
    -- 召唤宠物
    PressKey(pet);
    ReleaseKey(pet);
    -- Sleep(100)
    -- 切换回默认技能栏
    PressKey(skill.backSkill);
    ReleaseKey(skill.backSkill);

    Sleep(550)
    PressKey("y");
    ReleaseKey("y");
    Sleep(100)
    -- 更新技能栏以及宠物键位
    if (currentIds.currentPetIndex < #pets) then
        currentIds.currentPetIndex = currentIds.currentPetIndex + 1;
    else
        currentIds.currentSkillIndex = currentIds.currentSkillIndex + 1;
        currentIds.currentPetIndex = 1;
    end
    if (currentIds.currentSkillIndex > #skills) then
        currentIds.currentSkillIndex = 1;
        currentIds.currentPetIndex = 1;
    end
    return currentIds;
end
function OnEvent(event, arg)
    -- G5
    -- 一次召唤4个 
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 5) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
        G5CurrentIds = DragonCallNext(G5CurrentIds, G5Skills, true)
        Sleep(50)
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
        G5CurrentIds = DragonCallNext(G5CurrentIds, G5Skills, true)
        Sleep(50)
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
        G5CurrentIds = DragonCallNext(G5CurrentIds, G5Skills, true)
        Sleep(50)
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
        G5CurrentIds = DragonCallNext(G5CurrentIds, G5Skills, true)
    end
end
