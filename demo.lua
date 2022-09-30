----------------
--   洛奇宏 宠物召唤   --
---------------

--按键设置类 保存宠物对应的技能栏和按键--
Skills = {
    skill = "", --技能栏快捷键
    backSkill ="", --默认技能栏
    petKeys = {}, --技能栏上宠物对应的按键[1~=]
    waitSleep = 500 --宠物召唤后停留500毫秒后取消召唤，该值为默认值
}
function Skills:new(skill,backSkill,petKeys,waitSleep)
    local o = {};
    setmetatable(o, self);
    o.skill = skill;
    o.backSkill = backSkill;
    o.petKeys = petKeys;
    o.waitSleep = waitSleep;
    return o;
end

--当前宠物索引及技能栏索引,用来计算宠物的循环周期
CurrentIds = {
    currentSkillIndex = 2,
    currentPetIndex = 1,
    closeStatus = true  --宠物关闭状态,手动关闭宠物时使用
}

function CurrentIds:new(currentSkillIndex,currentPetIndex)
    local o = {};
    setmetatable(o, self);
    o.currentSkillIndex = currentSkillIndex;
    o.currentPetIndex = currentPetIndex;
    return o
end


--宠物索引
--冰龙
G9CurrentIds = CurrentIds:new(1,1)
G9Skills = {
            Skills:new("semicolon","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},450)
}
--束缚冰冻宠物
G8CurrentIds = CurrentIds:new(1,1)
G8Skills = {
            Skills:new("4","tilde",{"1","2","3","4","5","6","7"},550)
}
--僵尸
--G7CurrentIds = CurrentIds:new(1,1)
--G7Skills = {
            --Skills:new("rbracket","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550)
--}
--古青龙
G5CurrentIds = CurrentIds:new(1,1)
G5Skills = {
            Skills:new("2","tilde",{"1","2","3","4","5","6","7"},550)--,
            --Skills:new("quote","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550),
            --Skills:new("4","tilde",{"6","7","8","9","0","minus","equal"},550)
}
--其他宠物
G4CurrentIds = CurrentIds:new(1,1)
G4Skills = {
            Skills:new("3","tilde",{"1","2","3","4","5","6","7","8","9"},550)
}

--古龙鬼泣
G6CurrentIds = CurrentIds:new(1,1)
G6Skills = {
            Skills:new("semicolon","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550),
            Skills:new("quote","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550),
            Skills:new("4","tilde",{"6","7","8","9","0","minus","equal"},550)
}


--G键事件函数
function OnEvent(event, arg)

    
    OutputLogMessage("event = %s, arg = %s\n", event, arg);
    --G1
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 1) then
            --OutputLogMessage("in MOUSE_BUTTON_RELEASED 1 \n");
    end
    --G2
    if (event == "MOUSE_BUTTON_RELEASED" and arg ==2) then
            --OutputLogMessage("in MOUSE_BUTTON_RELEASED 2 \n");
    end
    --G3
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 3) then
            --OutputLogMessage("in MOUSE_BUTTON_RELEASED 3 \n");
    end
    --G8
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 8) then
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 8 \n");
            G8CurrentIds=DragonCallNext(G8CurrentIds,G8Skills,true,true)
    end
    --G7
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 7) then
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 7 \n");
            G7CurrentIds=DragonCallNext(G7CurrentIds,G7Skills,true,true)
    end
    --G5
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 5) then
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 ");
            --
            G5CurrentIds=DragonCallNext(G5CurrentIds,G5Skills,true,true)
    end
    --G4
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 4) then
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 4 \n");
            G4CurrentIds=DragonCallNext(G4CurrentIds,G4Skills,true,true)
    end
    --G11
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 11) then
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 11 \n");
           
    end
    --G10
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 10) then
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 10 \n");
    end
    --G9
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 9) then
    OutputLogMessage("in MOUSE_BUTTON_RELEASED 8 \n");
            G9CurrentIds=DragonCallNext(G9CurrentIds,G9Skills,true,true)
    end
    --G6
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 6) then  
            OutputLogMessage("in MOUSE_BUTTON_RELEASED 6 \n");
            G6CurrentIds=GQ(G6CurrentIds,G6Skills,true)
    end
end



-----------------------------------------------------------------------------------------
--currentIds 记录当前宠物所在的技能栏以及键位
--skills 技能栏集合
--isChange2 是否切换到扩展技能栏2 默认true
--isColse 是否取消宠物 默认true ，如果需要手动取消宠物请设置为false，重复按G键为取消
--召唤古龙
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


---鬼泣释放--
function GQ(currentIds,skills,isChange2)
           
    skill = skills[currentIds.currentSkillIndex];
    pets = skill.petKeys;
    pet = pets[currentIds.currentPetIndex];
    OutputLogMessage("pet = %s",(currentIds.currentPetIndex));
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
    if(skill.skill == "4" or skill.skill == "3") then
            PressKey("lalt");
            PressKey(skill.skill);
            ReleaseKey("lalt");
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
    PressKey("lalt");
    PressKey(skill.backSkill);
    ReleaseKey("lalt");
    ReleaseKey(skill.backSkill);

    if(isChange2 == true) then
            PressKey("lalt");
            PressKey("v");
            ReleaseKey("lalt");
            ReleaseKey("v");
    end

    --使用鬼泣
    Sleep(600);
    PressKey("f12");
    ReleaseKey("f12");
    Sleep(400);
    PressKey("lctrl","lshift");

    Sleep(900);
    ReleaseKey("lctrl","lshift");
     
    --取消宠物
    PressKey(skill.backSkill);
    ReleaseKey(skill.backSkill);
     
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
    return currentIds;
end