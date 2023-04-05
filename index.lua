local CHANGE_EXTEND_SKILL_BTN = {'n'} 
local BACK_SKILL_KEY_TABLE = {'tilde'}
local CANCEL_SUMMON_PET = {'y'}

function PetGroupStatus(currentSkillIndex, currentPetIndex)
    local o = {};
    o.currentSkillIndex = currentSkillIndex or 1;
    o.currentPetIndex = currentPetIndex or 1;
    return o
end

function PetGroupCfg(skillKeyTable, petKeyTable, isChangeExtend, waitSleep)
    local o = {}
    o.skillKeyTable = skillKeyTable
    o.petKeyTable = petKeyTable
    o.isChangeExtend = isChangeExtend or false
    o.waitSleep = waitSleep or 500
    return o
end

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
    OutputLogMessage("===== start summon pet =====\n")
    OutputLogMessage("petGroupCfgs length = %s\n", #petGroupCfgs)
    OutputLogMessage("current skill index = %s\n", petGroupStatus.currentSkillIndex)
    OutputLogMessage("current pet index = %s\n", petGroupStatus.currentPetIndex)
    OutputLogMessage("%s\n", petGroupCfgs[petGroupStatus.currentSkillIndex])
    
    local target = petGroupCfgs[petGroupStatus.currentSkillIndex]
    local pets = target.petKeyTable
    local pet = pets[petGroupStatus.currentPetIndex]
    
    PressKeyCfg(CANCEL_SUMMON_PET)
    Sleep(100)
    
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    
    PressKeyCfg(target.skillKeyTable)
    PressKeyCfg(pet)
    
    PressKeyCfg(BACK_SKILL_KEY_TABLE)
    
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    
    Sleep(target.waitSleep)
    
    PressKeyCfg(CANCEL_SUMMON_PET)
    
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
G5Status = PetGroupStatus(1, 1)
G5Configs = { 
    PetGroupCfg("num5", {"5", "6", "7", "8", "9", "0", "minus", "equal"}, false, 550),
    PetGroupCfg("num6", {"5", "6", "7", "8", "9", "0", "minus", "equal"}, false, 550) 
}

G7Status = PetGroupStatus(1, 1)
G7Configs = { 
    PetGroupCfg("b", {"1", "2", "3", "4", "5", "6", "7", "8"}, true, 550)
}

G8Status = PetGroupStatus(1, 1)
G8Configs = { 
    PetGroupCfg("t", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}, true, 550),
    PetGroupCfg("g", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus"}, true, 550),
}

G12Status = PetGroupStatus(1, 1)
G12Configs = { 
    PetGroupCfg("num5", {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}, true, 550)
}


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
        G5Status = SummonPetLoop(G5Status, G5Configs)
        Sleep(50)
        G5Status = SummonPetLoop(G5Status, G5Configs)
        Sleep(50)
        G5Status = SummonPetLoop(G5Status, G5Configs)
        Sleep(50)
        G5Status = SummonPetLoop(G5Status, G5Configs)
        Sleep(50)
    end
    -- G6
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 6) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 6 \n");
    end
    -- G7
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 7) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 7 \n");
        G7Status = SummonPetLoop(G7Status, G7Configs)
    end
    -- G8
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 8) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 8 \n");
        G8Status = SummonPetLoop(G8Status, G8Configs)
    end
    -- G9
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 9) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 9 \n");
    end
    -- G10
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 10) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 10 \n");
    end
    -- G11
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 11) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 11 \n");
    end
    -- G12
    if (event == "MOUSE_BUTTON_RELEASED" and arg == 12) then
        OutputLogMessage("in MOUSE_BUTTON_RELEASED 12 \n");
        G12Status = SummonPetLoop(G12Status, G12Configs)
    end
end