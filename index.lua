local CHANGE_EXTEND_SKILL_BTN = {'lctrl', 'v'} 
local BACK_SKILL_KEY_TABLE = {'numperiod'}
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

function SummonPetLoop(petGroupStatus, petGroupCfgs)
    OutputLogMessage("===== start summon pet =====\n")
    OutputLogMessage("petGroupCfgs length = %s\n", #petGroupCfgs)
    OutputLogMessage("current skill index = %s\n", petGroupStatus.currentSkillIndex)
    OutputLogMessage("current pet index = %s\n", petGroupStatus.currentPetIndex)
    
    target = petGroupCfgs[petGroupStatus.currentSkillIndex]
    pets = target.petKeyTable
    pet = pets[PetGroupStatus.currentPetIndex]
    
    PressKeyCfg(CANCEL_SUMMON_PET)
    sleep(100)
    
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    
    PressKeyCfg(target.skillKeyTable)
    PressKeyCfg(pet)
    
    PressKeyCfg(BACK_SKILL_KEY_TABLE)
    
    if (target.isChangeExtend) then
        PressKeyCfg(CHANGE_EXTEND_SKILL_BTN)
    end
    
    sleep(target.waitSleep)
    
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
    return petGroupStatus
    OutputLogMessage("===== end summon pet =====\n")
end

-- register key group
G5Status = PetGroupStatus(1, 1)
G5Config = PetGroupCfg("num5", {"5", "6", "7", "8", "9", "0", "minus", "equal"}, false, 550)


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
        G5Status = SummonPetLoop(G5Status, G5Config)
        Sleep(50)
        G5Status = SummonPetLoop(G5Status, G5Config)
        Sleep(50)
        G5Status = SummonPetLoop(G5Status, G5Config)
        Sleep(50)
        G5Status = SummonPetLoop(G5Status, G5Config)
        Sleep(50)
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