--[[
	Made by:
		Danrich123
	
	Collects quest data and stuff
--]]


local QaCSettings = require(game.ReplicatedStorage.Aero.Shared.Config.QuestConfigModule)
local basicGrammar = QaCSettings.BasicGrammar

local QuestModule = {}
local questKeyWords = 
{
	Rewards = true;
	CanRepeat = true;
}
QuestModule.questKeyWords = questKeyWords

local objectiveKeyWords =
{
	Amount = true;
	Type = true;
	Description = true;
	TakeItem = true;
}
QuestModule.objectiveKeyWords = objectiveKeyWords

local legalTypes = 
{
	Kill = true;
	Retrieve = true;
	Chat = true;
	
	PetKill = true;
	Quest = true;
	Place = true;
}

local pluralEndings = 
{
	us = "i";
	s = "es";
	um = "a";
	f = "ves";
}


local function grammarify(thing,amount)
	if not basicGrammar then return thing end
	local result = thing
	
	if amount > 1 then
		local did = false
		
		for singular,plural in pairs(pluralEndings) do
			if thing:sub(-(#singular),#thing) == singular then
				result = thing:sub(1,-(#singular + 1)) .. plural
				did = true
				break
			end
		end
		
		if not did then
			result = thing .. "s"
		end
	end
	
	return result
end


function QuestModule.getQuestData(quest)
	local data = {Objectives = {};Rewards = {};}
	
	for _, objective in ipairs(quest:GetChildren()) do
		if not questKeyWords[objective.Name] then
			local objectiveData = {Target = {}}
			
			for _, information in ipairs(objective:GetChildren()) do
				if not objectiveKeyWords[information.Name] then
					table.insert(objectiveData.Target, information.Name)
				end
			end
			objectiveData.Amount = math.ceil(objective.Amount.Value)
			objectiveData.Type = (legalTypes[objective.Type.Value] and objective.Type.Value) or "Kill"
			objectiveData.TakeItem = (objective:FindFirstChild("TakeItem") and true) or false
			
			local petType = objective.Type:FindFirstChild("PetType")
			if petType then
				objectiveData.PetType = petType.Value
			end
			
			if objective:FindFirstChild("Description") then
				objectiveData.Description = objective.Description.Value
			else
				if objectiveData.Type == "Kill" then
					objectiveData.Description = "Kill " .. objectiveData.Amount .. " " .. grammarify(objectiveData.Target[1], objectiveData.Amount)
				elseif objectiveData.Type == "Retrieve" then
					objectiveData.Description = "Retrieve " .. objectiveData.Amount .. " " .. grammarify(objectiveData.Target[1], objectiveData.Amount)
				elseif objectiveData.Type == "Quest" then
					local addon = ""
					if objectiveData.Amount > 1 then
						addon = " " .. tostring(objectiveData.Amount) .. " times"
					end
					
					objectiveData.Description = "Complete '" .. objectiveData.Target[1] .."'" .. addon
				elseif objectiveData.Type == "PetKill" then
					local addon = " with a pet"
					if objectiveData.PetType then
						addon = " with a " .. objectiveData.PetType
					end
					
					objectiveData.Description = "Kill " .. objectiveData.Amount .. " " .. grammarify(objectiveData.Target[1], objectiveData.Amount) .. addon
				elseif (objectiveData.Type == "Chat") or (objectiveData.Type == "Place") then
					warn("You need to add a description for "..quest.Name .. ".")
					objectiveData.Description = "you need to manually add this"
				end
			end
			
			data.Objectives[objective.Name] = objectiveData
		end
	end
	
	if quest:FindFirstChild("CanRepeat") then
		data.CanRepeat = quest.CanRepeat.Value
	else
		data.CanRepeat = false
	end
	
	for _,thing in pairs(quest.Rewards:GetChildren()) do
		if (thing.ClassName == "IntValue") or (thing.ClassName == "NumberValue") then
			local t = {}
			t.value = thing.Value
			data.Rewards[thing.Name] = t
		else
			local t = {}
			t.isPet = thing:FindFirstChild("IsPet")
			data.Rewards[thing.Name] = t
		end
	end
	
	
	return data
end


return QuestModule