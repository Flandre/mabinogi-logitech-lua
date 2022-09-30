-- 定义宠物技能状态
function PetGroupStatus(currentSkillIndex, currentPetIndex)
    local o = {};
    o.currentSkillIndex = currentSkillIndex or 1;
    o.currentPetIndex = currentPetIndex or 1;
    return o
end

function PetGroupCfgs(skillKeyTable, backSkillKeyTable, isChangeExtend, changeExtendKeyTable, petKeyTable, waitSleep)
    local o = {}
    o.skillKeyTable = skillKeyTable
    o.backSkillKeyTable = backSkillKeyTable
    o.isChangeExtend = isChangeExtend or false
    o.changeExtendKeyTable = changeExtendKeyTable
    o.petKeyTable = petKeyTable
    o.waitSleep = waitSleep or 500
end


function DragonCallNext(currentIds,skills,isChange2,isColse)
    OutputLogMessage("skillslength = %s  ",table.getn(skills));
    OutputLogMessage("currentSkillIndex = %s  ",currentIds.currentSkillIndex);

    --手动关闭宠物模式时，判断当前是否没有关闭宠物 ，如果没有则执行关闭的流程
    if (currentIds.closeStatus == false) then
            PressKey(skill.backSkill);
            ReleaseKey(skill.backSkill);
            --取消宠物后标记关闭状态
            currentIds.closeStatus = true
    else
    
    skill = skills[currentIds.currentSkillIndex];
    pets = skill.petKeys;
    pet = pets[currentIds.currentPetIndex];
    OutputLogMessage("pet = %s \n",(currentIds.currentPetIndex));
    --召唤前先取消宠物
    PressKey(skill.backSkill);
    ReleaseKey(skill.backSkill);
    Sleep(100)
    if(isChange2 == true) then
            PressKey("lalt");
            PressKey("v");
            ReleaseKey("lalt");
            ReleaseKey("v");
    end
    --切换到技能栏
    if(skill.skill == "4" or skill.skill == "3" or skill.skill == "2") then
            PressKey("lctrl");
            PressKey(skill.skill);
            ReleaseKey("lctrl");
            ReleaseKey(skill.skill);
    else
            PressKey(skill.skill);
            ReleaseKey(skill.skill);
    end
    --召唤宠物
    PressKey(pet);
    ReleaseKey(pet);
    --Sleep(100)
    --切换回默认技能栏
  PressKey("lctrl");
    PressKey("1");
    ReleaseKey("lctrl");
    ReleaseKey("1");

    if(isChange2 == true) then
            PressKey("lalt");
            PressKey("v");
            ReleaseKey("lalt");
            ReleaseKey("v");
    end
    --此处设置延迟
    Sleep(skill.waitSleep)
    --Sleep(550)
    --取消宠物
    if(isColse == true) then
            PressKey(skill.backSkill);
            ReleaseKey(skill.backSkill);
    else
            --在手动关闭宠物的模式下 需要标记关闭状态为false
            currentIds.closeStatus = false
    end
    --Sleep(300)
    --更新技能栏以及宠物键位
    if(currentIds.currentPetIndex < table.getn(pets)) then
            currentIds.currentPetIndex = currentIds.currentPetIndex + 1;
    else
            currentIds.currentSkillIndex = currentIds.currentSkillIndex + 1;
            currentIds.currentPetIndex = 1;
    end
    if(currentIds.currentSkillIndex > table.getn(skills)) then
            currentIds.currentSkillIndex = 1;
            currentIds.currentPetIndex = 1;
    end
    end  
    return currentIds;
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