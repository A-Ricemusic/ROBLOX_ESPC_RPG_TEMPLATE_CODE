-- Save Data Module
-- Username
-- October 5, 2022



local SaveDataModule = {}



local serv = game:GetService("DataStoreService")
local Stats = serv:GetDataStore("StatsDS")
local Tools = serv:GetDataStore("ToolsDS")

function SaveDataModule.GetCheckpointData(plr)
	local checkpointData = game:GetService("ServerStorage"):WaitForChild("CheckpointData")
	local playerCheckpointData = checkpointData:GetChildren()
	local data 
	for _,d in pairs(playerCheckpointData) do
		if d.Name == tostring(plr.UserId) then
			data = d.Value
			print(data)
			return data
		end
	end
end


function SaveDataModule.SaveStats(plr)
	local lstats = plr:FindFirstChild("leaderstats")
	if (lstats~=nil) then
		local Level = lstats:FindFirstChild("Level")
		local Exp = lstats:FindFirstChild("XP")
		local Gold = lstats:FindFirstChild("Gold")
		local Sword = lstats:FindFirstChild("Sword")
		local Rank = Sword:FindFirstChild("Rank")
		local Checkpointdata = SaveDataModule.GetCheckpointData(plr)
		if (Level~=nil) and (Exp~=nil) and 
		(Gold~=nil) and ( Sword~=nil) and (Rank ~= nil) and (Checkpointdata ~= nil) then
			Stats:SetAsync(plr.UserId,{Level.Value,Exp.Value,Gold.Value,Sword.Value,Rank.Value,Checkpointdata.Name})
		end
	end

	local ActualTools = {}
	local SG = plr:WaitForChild("StarterGear")
	for _,v in pairs(SG:GetChildren()) do
		table.insert(ActualTools, v.Name)
	end
	if ActualTools[1] then
		Tools:SetAsync(plr.UserId,ActualTools)
	end
end


return SaveDataModule