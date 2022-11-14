Skills = {
    skill = "", 
    backSkill ="", 
    petKeys = {}, 
    waitSleep = 500 
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

CurrentIds = {
    currentSkillIndex = 1,
    currentPetIndex = 1,
    closeStatus = true 
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
G2CurrentIds = CurrentIds:new(1,1)
G2Skills = {
            Skills:new("4","tilde",{"1","2","3","4","5","6","7","8","9","0"},450),
            Skills:new("5","tilde",{"1"},450),
            Skills:new("6","tilde",{"2","3","4","5","6","7","8","9","0","minus","equal"},450),
            Skills:new("7","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},450),
            Skills:new("2","tilde",{"equal"},450),
}
--羊云
G3CurrentIds = CurrentIds:new(1,1)
G3Skills = {
            Skills:new("3","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},450),
            Skills:new("4","tilde",{"minus","equal"},450),
            Skills:new("5","tilde",{"2","3","4","5","6","7","8","9","0","minus","equal"},450),
}
--小鹿男狄娜希
G1CurrentIds = CurrentIds:new(1,1)
G1Skills = {
            Skills:new("8","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550),
}
--古龙
G5CurrentIds = CurrentIds:new(1,1)
G5Skills = {
            Skills:new("2","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550),
            Skills:new("3","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},550),
            Skills:new("4","tilde",{"1","2","3","4","5","6","7","8","9","0","minus"},550),
}
--雷獸
G4CurrentIds = CurrentIds:new(1,1)
G4Skills = {
            Skills:new("6","tilde",{"1","2","3","4","5","6"},550)
}

--凤凰
G7CurrentIds = CurrentIds:new(1,1)
G7Skills = {
            Skills:new("6","tilde",{"7","8","9","0","minus","equal"},550),
}

--古龙鬼泣
G6CurrentIds = CurrentIds:new(1,1)
G6Skills = {
            Skills:new("2","tilde",{"1","2","3","4","5","6","7","8","9"},550),
}



function OnEvent(event, arg)

    
    OutputLogMessage("event = %s, arg = %s\n", event, arg);
    --G1
    if (event == "G_RELEASED" and arg == 1) then
            OutputLogMessage("in G_RELEASED 1 \n");
            G1CurrentIds=DragonCallNext(G1CurrentIds,G1Skills,true,true)
    end
    --G2
    if (event == "G_RELEASED" and arg ==2) then
            OutputLogMessage("in G_RELEASED  2 \n");
            G2CurrentIds=DragonCallNext(G2CurrentIds,G2Skills,true,true)
    end
    --G3
    if (event == "G_RELEASED"and arg == 3) then
            OutputLogMessage("in G_RELEASED 3 \n");
            G3CurrentIds=DragonCallNext(G3CurrentIds,G3Skills,true,true)
    end
    --G8
    if (event == "G_RELEASED" and arg == 8) then
            OutputLogMessage("in G_RELEASED 8 \n");
            G8CurrentIds=DragonCallNext(G8CurrentIds,G8Skills,true,true)
    end
    --G7
    if (event == "G_RELEASED" and arg == 7) then
            OutputLogMessage("in G_RELEASED 7 \n");
            G7CurrentIds=FH(G7CurrentIds,G7Skills,false,true)
    end
    --G5
    if (event == "G_RELEASED" and arg == 5) then
            OutputLogMessage("in G_RELEASED 5 ");
            G5CurrentIds=DragonCallNext(G5CurrentIds,G5Skills,false,true)
    end
    --G4
    if (event == "G_RELEASED" and arg == 4) then
            OutputLogMessage("in G_RELEASED 4 \n");
            G4CurrentIds=DragonCallNext(G4CurrentIds,G4Skills,false,true)
    end
    --G11
    if (event == "G_RELEASED" and arg == 11) then
            OutputLogMessage("in G_RELEASED 11 \n");
           
    end
    --G10
    if (event == "G_RELEASED" and arg == 10) then
            OutputLogMessage("in G_RELEASED 10 \n");
    end
    --G9
    if (event == "G_RELEASED" and arg == 9) then
            OutputLogMessage("in G_RELEASED 8 \n");
            G9CurrentIds=DragonCallNext(G9CurrentIds,G9Skills,true,true)
    end
    --G6
    if (event == "G_RELEASED" and arg == 6) then  
            OutputLogMessage("in G_RELEASED 6 \n");
            G6CurrentIds=GQ(G6CurrentIds,G6Skills,true)
    end
end


table.getn = function(args) local n = 0 
if args then 
n = #args 
end 
return n 
end

function DragonCallNext(currentIds,skills,isChange2,isColse)
    OutputLogMessage("skillslength = %s  ",table.getn(skills));
    OutputLogMessage("currentSkillIndex = %s  ",currentIds.currentSkillIndex);

    if (currentIds.closeStatus == false) then
            PressKey(skill.backSkill);
            ReleaseKey(skill.backSkill);
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
    if(skill.skill == "4" or skill.skill == "3" or skill.skill == "2" or skill.skill == "5"or skill.skill == "6"or skill.skill == "7"or skill.skill == "8") then
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
    if(skill.skill == "4" or skill.skill == "3" or skill.skill == "2" or skill.skill == "5"or skill.skill == "6"or skill.skill == "7"or skill.skill == "8") then
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
    PressKey("rbracket");
    ReleaseKey("rbracket");
    Sleep(400);
    PressKey("lctrl","lshift")
    Sleep(100);
    PressKey("e");
    Sleep(100);
    ReleaseKey("e");
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

---凤凰复活--
function FH(currentIds,skills,isChange2)
           
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
    if(skill.skill == "4" or skill.skill == "3" or skill.skill == "2" or skill.skill == "5"or skill.skill == "6"or skill.skill == "7"or skill.skill == "8") then
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

    --使用复活
    Sleep(600);
    PressKey("rbracket");
    ReleaseKey("rbracket");
    Sleep(400);
     
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