-- Quest Service
-- Username
-- October 4, 2022





local QuestService = {Client = {}}


local dataStore = game:GetService("DataStoreService"):GetDataStore("Quests1423", "DEV_BUILD")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local quests = ReplicatedStorage.Quests
local QuestModule = require(ReplicatedStorage.Aero.Shared.QuestModule)
local QuestItems = ReplicatedStorage:FindFirstChild("QuestItems")
local savingLockdowns = {}

local function attempt(func)
	for i = 1,3 do
		local success,variable,variable2,variable3 = pcall(func)
		
		if success then
			return variable,variable2,variable3
		end
		task.wait(.1)
	end
	
	return "FAILURE"
end

local function getData(player)
	local data = attempt(function() return dataStore:GetAsync(tostring(player.UserId).."'s Stuff") end)
	
	if data then
		if data == "FAILURE" then
			savingLockdowns[player] = true
			return {Did = {};Do = {}}
		else
			savingLockdowns[player] = false
			return data
		end
	else
		savingLockdowns[player] = false
		--[[attempt(function()
			dataStore:SetAsync(tostring(player.UserId).."'s Stuff",{Did = {};Do = {}})
		end)--]]
		
		return {Did = {};Do = {}}
	end
end

local function setData(player)
	if not savingLockdowns[player] then
		local questing = player:WaitForChild("Questing")
		local quested = player:WaitForChild("Quested")
		
		local questingT = {}
		local questedT = {}
		
		for _,quest in pairs(questing:GetChildren()) do
			local questData = {}
			
			for _,objective in pairs(quest:GetChildren()) do
				questData[objective.Name] = objective.Value
			end
			questingT[quest.Name] = questData
		end
		
		for _,quest in pairs(quested:GetChildren()) do
			table.insert(questedT,quest.Name)
		end
		attempt(function()
			dataStore:SetAsync(tostring(player.UserId).."'s Stuff",{Do = questingT;Did = questedT})
		end)
	end
end


local function playerAdded(player)
	local questing = Instance.new("Folder")
	questing.Name = "Questing"
	
	local quested = Instance.new("Folder")
	quested.Name = "Quested"
	
	local questData = getData(player)
	
	do -- load
		for quest, data in pairs(questData.Do) do 
			local theActualQuestOkBugfix = quests:FindFirstChild(quest)
			if theActualQuestOkBugfix then
				local questFolder = Instance.new("Folder")
				local questifyData = QuestModule.getQuestData(theActualQuestOkBugfix)
				questFolder.Name = quest
				
				for objective,progress in pairs(data) do
					local objectiveData = questifyData.Objectives[objective]
					local value = Instance.new("NumberValue")
					value.Name = objective
					value.Value = progress
					
					local type = Instance.new("StringValue")
					type.Name = "Type"
					type.Value = objectiveData.Type
					if objectiveData.PetType then
						local petType = Instance.new("StringValue")
						petType.Name = "PetType"
						petType.Value = objectiveData.PetType
						petType.Parent = type
					end
					
					local max = Instance.new("IntValue")
					max.Name = "Max"
					max.Value = objectiveData.Amount
					
					local targets = Instance.new("Folder")
					targets.Name = "Targets"
					targets.Parent = value
					
					for _,target in pairs(objectiveData.Target) do
						local targetFolder = Instance.new("Folder")
						targetFolder.Name = target
						targetFolder.Parent = targets
					end
					
					type.Parent = value
					max.Parent = value
					targets.Parent = value
					
					value.Parent = questFolder
				end
				
				questFolder.Parent = questing
			end
		end
		
		for _, quest in pairs(questData.Did) do -- QUESTED
			local questFolder = Instance.new("Folder")
			questFolder.Name = quest
			questFolder.Parent = quested
		end
	end
	
	local function starterGearInit(starterGear)
		starterGear.ChildAdded:Connect(function(item)
			for _,quest in pairs(questing:GetChildren()) do
				for _,objective in pairs(quest:GetChildren()) do
					if objective.Type.Value == "Retrieve" then
						if objective.Targets:FindFirstChild(item.Name) then
							if objective.Max.Value > objective.Value then
								objective.Value = objective.Value + 1
							end
						end
					end
				end
			end
		end)
	end
	if player:FindFirstChild("StarterGear") then
		starterGearInit(player.StarterGear)
	else
		local connection; connection = player.ChildAdded:Connect(function(child)
			if child.ClassName == "StarterGear" then
				connection:Disconnect()
				starterGearInit(child)
			end
		end)
	end
	
	questing.Parent = player
	quested.Parent = player
	
	while player.Parent do
		task.wait(60)
		
		if not savingLockdowns[player] then
			setData(player)
		end
	end
end


do -- quest stuff :D
	--[[
		this does not stop exploiters from doings quests out of order
		exploiters can't make themselves automatically finish quests though
	--]]
	
	function QuestService.Client:DoQuest(player,questName)
		if typeof(questName) == "string" then
			local quest = quests:FindFirstChild(questName)
			local quested = player:FindFirstChild("Quested")
			
			if quest and quested then
				local data = QuestModule.getQuestData(quest)
				local passes = false
				
				if not player.Questing:FindFirstChild(questName) then
					if data.CanRepeat then
						passes = true
					elseif not player.Quested:FindFirstChild(questName) then
						passes = true
					end
				end
				
				if passes then
					local questFolder = Instance.new("Folder")
					questFolder.Name = questName
					
					for objectiveName, objectiveData in pairs(data.Objectives) do
						local objectiveValue = Instance.new("IntValue")
						objectiveValue.Name = objectiveName
						objectiveValue.Value = 0
						
						local type = Instance.new("StringValue")
						type.Name = "Type"
						type.Value = objectiveData.Type
						if objectiveData.PetType then
							local petType = Instance.new("StringValue")
							petType.Name = "PetType"
							petType.Value = objectiveData.PetType
							petType.Parent = type
						end
						
						local max = Instance.new("IntValue")
						max.Name = "Max"
						max.Value = objectiveData.Amount
						
						local targets = Instance.new("Folder")
						targets.Name = "Targets"
						targets.Parent = objectiveValue
						
						for _, target in pairs(objectiveData.Target) do
							local targetFolder = Instance.new("Folder")
							targetFolder.Name = target
							targetFolder.Parent = targets
							
							if objectiveData.Type == "Retrieve" then
								local amount = 0
								for _, tool in ipairs(player.StarterGear:GetChildren()) do
									if tool.Name == target then
										amount += 1
									end
								end
								
								if amount > 0 then
									objectiveValue.Value = math.min(objectiveData.Amount, objectiveValue.Value + amount)
								end
							elseif objectiveData.Type == "Quest" then
								local questMarker = quested:FindFirstChild(target)
								if questMarker and (objectiveValue.Value < objectiveData.Amount) then
									objectiveValue.Value += 1
								end
							end
						end
						
						type.Parent = objectiveValue
						max.Parent = objectiveValue
						targets.Parent = objectiveValue
						objectiveValue.Parent = questFolder
					end
					
					questFolder.Parent = player.Questing
				end
				
			end
		end
	end
	
	function QuestService.Client:CancelQuest(player, questName)
		if type(questName) == "string" then
			local questing = player:FindFirstChild("Questing")
			
			if questing then
				local quest = questing:FindFirstChild(questName)
				
				if quest then
					quest:Destroy()
				end
			end
		end
	end
	
	function QuestService.Client:CompleteQuest(player, questName)
		if type(questName) == "string" then
			local quest = quests:FindFirstChild(questName)
			local questing = player:FindFirstChild("Questing")
			local quested = player:FindFirstChild("Quested")
			
			if quest and questing and quested then -- so messy - d a n r i c h 1 2 3
				local pair = questing:FindFirstChild(questName)
				if not pair then return end
				
				local data = QuestModule.getQuestData(quest)
				local passed = true
				
				for objectiveName, objectiveData in pairs(data.Objectives) do
					if pair[objectiveName].Value < objectiveData.Amount then
						passed = false
						break
					end
				end
				
				if passed then
					pair:Destroy()
					
					local questMarker = quested:FindFirstChild(questName)
					if not questMarker then
						questMarker = Instance.new("IntValue")
						questMarker.Name = questName
						questMarker.Parent = player.Quested
					end
					questMarker.Value = questMarker.Value + 1
					
					-- increment quest-type quests
					for _, quest in pairs(player.Questing:GetChildren()) do
						for _, objective in pairs(quest:GetChildren()) do
							if objective.Type.Value == "Quest" then
								if objective.Targets:FindFirstChild(questName) then
									if objective.Max.Value > objective.Value then
										objective.Value = objective.Value + 1
									end
								end
							end
						end
					end
					
					-- retrieve quests
					for _, objective in pairs(data.Objectives) do
						if objective.Type == "Retrieve" then
							if objective.TakeItem then
								local itemsStolenFromThePlayer = 0
								
								for _,target in pairs(objective.Target) do
									local thing = player.StarterGear:FindFirstChild(target)
									local thing2 = player.Backpack:FindFirstChild(target)
									
									if thing and thing2 then
										thing:Destroy()
										thing2:Destroy()
										itemsStolenFromThePlayer = itemsStolenFromThePlayer + 1
										
										if itemsStolenFromThePlayer >= objective.Amount then
											break
										end
									end
								end
							end
						end
					end
					-- take their QuestItems ^
					
					for name, rewardData in pairs(data.Rewards) do
						local value = rewardData.value
						if (player.leaderstats:FindFirstChild(name)) and value then
							player.leaderstats[name].Value = player.leaderstats[name].Value + value
						else
							if rewardData.isPet then -- reward pet
								local pets = ReplicatedStorage:FindFirstChild("Pets")
								local petHelper = ReplicatedStorage:FindFirstChild("PetHelper")
								
								if pets and petHelper then
									local petObject = pets:FindFirstChild(name)
									petHelper = require(petHelper)
									
									if petObject then
										local petSettings = require(petObject.PetData)
										local petId = petHelper.generatePetId(player, petObject.Name)
										local pet = Instance.new("Folder")
										pet.Name = petId
										
										local type = Instance.new("StringValue")
										type.Name = "Type"
										type.Value = petObject.Name
										
										local lastDeath = Instance.new("NumberValue")
										lastDeath.Name = "LastDeath"
										lastDeath.Value = 0
										
										local health = Instance.new("IntValue")
										health.Name = "Health"
										health.Value = petSettings.MaxHealth
										
										local level = Instance.new("IntValue")
										level.Name = "Level"
										level.Value = 1
										
										local xp = Instance.new("IntValue")
										xp.Name = "XP"
										xp.Value = 0
										
										type.Parent = pet
										lastDeath.Parent = pet
										health.Parent = pet
										level.Parent = pet
										xp.Parent = pet
										pet.Parent = player.Pets
									end
								end
							else
								local item = QuestItems:FindFirstChild(name)
								
								if item then
									local clone, clone2 = item:Clone()
									local clone2 = clone:Clone()
									
									clone.Parent = player.Backpack
									clone2.Parent = player.StarterGear
								end
							end
						end
					end
				end
			end
		end
	end
	
	function QuestService.Client:ProceedChatQuest(player, chatName) -- secure with proximity checks?
		if type(chatName) == "string" then
			for _,quest in pairs(player.Questing:GetChildren()) do
				for _,objective in pairs(quest:GetChildren()) do
					if objective.Type.Value == "Chat" then
						if objective.Targets:FindFirstChild(chatName) then
							if objective.Max.Value > objective.Value then
								objective.Value = objective.Value + 1
							end
						end
					end
				end
				
			end
		end
		
	end
	
	function QuestService.Client:TeleportPlayerByChat(player, teleportObject)
		local character = player.Character
		if character and (typeof(teleportObject) == "Instance") and player:FindFirstChild("Questing") and player:FindFirstChild("Quested") then
			-- check if the teleportObject is valid
			local parent = teleportObject.Parent
			
			repeat
				if parent:IsA("StringValue") then
					if parent.Name == "IfComplete" then
						if (not player.Questing:FindFirstChild(parent.Value)) and (not player.Quested:FindFirstChild(parent.Value)) then
							return
						end
					elseif parent.Name == "IfQuesting" then
						if not player.Questing:FindFirstChild(parent.Value) then
							return
						end
					elseif parent.Name == "IfQuested" then
						if not player.Quested:FindFirstChild(parent.Value) then
							return
						end
					end
				end
				
				parent = parent.Parent
				if not parent then
					return
				end
			until (((parent.ClassName == "Folder") or (parent.ClassName == "Configuration") or (parent.ClassName == "Model")) and (parent.Name == "Chat"))
			
			-- teleport stuff
			if teleportObject:IsA("Vector3Value") then
				character:SetPrimaryPartCFrame(CFrame.new(teleportObject.Value + Vector3.new(0, 2, 0)))
			elseif teleportObject:IsA("ObjectValue") then
				if (teleportObject.Value) and (teleportObject.Value:IsA("BasePart")) then
					character:SetPrimaryPartCFrame(CFrame.new(teleportObject.Value.Position + Vector3.new(0, 2, 0)))
				end
			end
		end
	end
end

game.Players.PlayerAdded:Connect(playerAdded)
for _,player in pairs(game.Players:GetPlayers()) do
	coroutine.create(coroutine.resume(playerAdded,player))
end

game.Players.PlayerRemoving:Connect(function(player)
	if not savingLockdowns[player] then
		setData(player)
	end
end)

do -- place quests
	-- pyramid :(
	
	for _, quest in ipairs(quests:GetChildren()) do
		for _, objective in ipairs(quest:GetChildren()) do
			if not QuestModule.questKeyWords[objective.Name] then
				if objective.Type.Value == "Place" then
					for _, place in ipairs(objective:GetChildren()) do
						if place.ClassName == "ObjectValue" then
							if place.Value:IsA("BasePart") then
								place.Value.Touched:Connect(function(hit)
									local player = players:GetPlayerFromCharacter(hit.Parent)
									
									if player then
										local questing = player:FindFirstChild("Questing")
		
										if questing then
											for _, theirQuest in ipairs(questing:GetChildren()) do
												if theirQuest.Name == quest.Name then
													for _, theirObjective in ipairs(theirQuest:GetChildren()) do
														if theirObjective.Name ~= objective.Name then continue end
														if theirObjective.Max.Value <= theirObjective.Value then continue end
														
														if (theirObjective.Type.Value == "Place") and theirObjective.Targets:FindFirstChild(place.Name) then
															theirObjective.Value += 1
														end
													end
												end
											end
										end
									end
								end)
							else
								warn(tostring(place.Value) .. " cannot be touched! It's not a BasePart.")
							end
						end
					end
				end
			end
		end
	end
--make QuestItems

local QuestItems = game:GetService("CollectionService"):GetTagged("QuestItem")

for _, item in pairs(QuestItems) do
	local proximityPrompt = item:FindFirstChild("ProximityPrompt")
	proximityPrompt.ActionText = item.Name
	proximityPrompt.Enabled = true
	proximityPrompt.Triggered:Connect(function(plr)
	proximityPrompt.Enabled = false
	local questItem = game.ReplicatedStorage.QuestItems:FindFirstChild(item.Name)
	local clone =questItem:Clone()
	clone.Parent = plr:FindFirstChild("StarterGear")
	local Debris = game:GetService("Debris")
		Debris:AddItem(clone,20)
	task.wait(5)
	proximityPrompt.Enabled = true
end)

	

end


end


return QuestService