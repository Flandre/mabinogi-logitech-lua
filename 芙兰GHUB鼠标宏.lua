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



G4CurrentIds = CurrentIds:new(1,1)
G4Skills = {
                Skills:new("num5","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},500),
				Skills:new("num6","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},500),
				Skills:new("num7","tilde",{"1","2","3","4","5","6"},500)
}

G5CurrentIds = CurrentIds:new(1,1)
G5Skills = {
				Skills:new("t","tilde",{"1","2","3","4","5","6","7","8","9","0","minus","equal"},500),
				Skills:new("g","tilde",{"1","2","3","4","5","6","7","8","9","0","minus"},500)
}	

G6CurrentIds = CurrentIds:new(1,1)
G6Skills = {
				Skills:new("b","tilde",{"0","minus","equal"},500)
}

G8CurrentIds = CurrentIds:new(1,1)
G8Skills = {
                Skills:new("b","tilde",{"1","2","3","4","5","6","7","8"},500)             
}

G9CurrentIds = CurrentIds:new(1,1)
G9Skills = {
                Skills:new("num8","tilde",{"6","7","8"},500)
}			

G12CurrentIds = CurrentIds:new(1,1)
G12Skills = {
				Skills:new("num8","tilde",{"9","0","minus","equal"},500)
}			

G13CurrentIds = CurrentIds:new(1,1)
G13Skills = {
                Skills:new("num8","tilde",{"1","2","3","4","5"},500)
}

function OnEvent(event, arg)

        
        OutputLogMessage("event = %s, arg = %s\n", event, arg);
        --G1
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 1) then 
                --OutputLogMessage("in MOUSE_BUTTON_RELEASED 1 \n");
			
        end
        --G2
        if (event == "MOUSE_BUTTON_RELEASED" and arg ==2) then 
                --Outp·1v3`v·utLogMessage("in MOUSE_BUTTON_RELEASED 2 \n");
			  
        end
        --G3
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 3) then 
                --OutputLogMessage("in MOUSE_BUTTON_RELEASED 3 \n"); 
		     
        end
		--G4
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 4) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 4 \n");
                G4CurrentIds=DragonCallNext(G4CurrentIds,G4Skills,true,true)
        end
		--G5
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 5) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 5 \n");
                G5CurrentIds=DragonCallNext(G5CurrentIds,G5Skills,true,true)
        end
		--G6
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 6) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 6 \n");
                G6CurrentIds=DragonCallNext(G6CurrentIds,G6Skills,true,false)
                PressAndReleaseKey("lbracket");
                Sleep(500);
                PressAndReleaseKey("y");
        end
		--G7
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 7) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 7 \n");
        end
        --G8
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 8) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 8 \n");
                G8CurrentIds=DragonCallNext(G8CurrentIds,G8Skills,true,false)
        end
        --G9 
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 9) then  
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 9 \n");
                G9CurrentIds=DragonCallNext(G9CurrentIds,G9Skills,true,false)
				PressAndReleaseKey("lbracket");
                Sleep(500);
                PressAndReleaseKey("y");
        end
        --G12
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 12) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 12 \n");
				G12CurrentIds=DragonCallNext(G12CurrentIds,G12Skills,true,false)
				PressAndReleaseKey("lbracket");
        end
        --G13
        if (event == "MOUSE_BUTTON_RELEASED" and arg == 13) then 
                OutputLogMessage("in MOUSE_BUTTON_RELEASED 13 \n");
                G13CurrentIds=DragonCallNext(G13CurrentIds,G13Skills,true,false)
				PressAndReleaseKey("lbracket");
                Sleep(800);
				PressAndReleaseMouseButton(1);
				Sleep(400);
				PressAndReleaseKey("y");
        end
        
        
end



-----------------------------------------------------------------------------------------
function DragonCallNext(currentIds,skills,isChange2,isColse)
        OutputLogMessage("skillslength = %s  ",#skills);
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

        PressKey(skill.backSkill);
        ReleaseKey(skill.backSkill);
        Sleep(100)
        if(isChange2 == true) then
                PressAndReleaseKey("n");
        end
        PressKey(skill.skill);
        ReleaseKey(skill.skill);
        PressKey(pet);
        ReleaseKey(pet);
        --Sleep(100)
        PressKey(skill.backSkill);
        ReleaseKey(skill.backSkill);
        if(isChange2 == true) then
                PressAndReleaseKey("n");
        end

        Sleep(skill.waitSleep)
        --Sleep(500)

        if(isColse == true) then
                PressKey(skill.backSkill);
                ReleaseKey(skill.backSkill);
        else
                currentIds.closeStatus = false
        end 
        --Sleep(300)
        
        if(currentIds.currentPetIndex < #pets) then
                currentIds.currentPetIndex = currentIds.currentPetIndex + 1; 
        else 
                currentIds.currentSkillIndex = currentIds.currentSkillIndex + 1; 
                currentIds.currentPetIndex = 1; 
        end
        if(currentIds.currentSkillIndex > #skills) then
                currentIds.currentSkillIndex = 1;
                currentIds.currentPetIndex = 1; 
        end
        end  
        return currentIds;
end