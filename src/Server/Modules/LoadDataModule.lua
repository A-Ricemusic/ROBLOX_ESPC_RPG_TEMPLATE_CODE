-- Load Data Module
-- Username
-- October 5, 2022



local LoadDataModule = {}




local serv = game:GetService("DataStoreService")
local Stats = serv:GetDataStore("StatsDS")
local Tools = serv:GetDataStore("ToolsDS")



function LoadDataModule:LoadData(Player,Level,Exp,Gold,Sword,Rank,CheckpointData)
	local GetData = Stats:GetAsync(Player.UserId)
	if GetData then
		Level.Value = GetData[1]
		Exp.Value = GetData[2]
		Gold.Value = GetData[3]
		Sword.Value = GetData[4]
		Rank.Value = GetData[5]
		local CheckpointDataName= GetData[6]
		if CheckpointDataName ==nil then return end
		local Checkpoints = workspace.Checkpoints:GetChildren()
		for _,ck in pairs(Checkpoints) do
				if ck.Name == CheckpointDataName then
					CheckpointData.Value = ck
					return CheckpointData.Value
					
				end
		end
		if CheckpointData.Value == nil then
			local CollectionService = game:GetService("CollectionService")
			local Start = CollectionService:GetTagged("Start")
			CheckpointData.Value = Start[1]
		end
	else
		Level.Value = 1
		Exp.Value = 0
		Gold.Value = 0
		Sword.Value = ""
		Rank.Value = ""
	local CollectionService = game:GetService("CollectionService")
	local Start = CollectionService:GetTagged("Start")
	CheckpointData.Value = Start[1]
	end
	local ActualTools = {}
	local QuestItems = game.ReplicatedStorage.QuestItems
	if (Tools:GetAsync(Player.UserId)) then
		for _,v in pairs(Tools:GetAsync(Player.UserId)) do
			if QuestItems:FindFirstChild(v) then
				table.insert(ActualTools, v)
			end
		end
		for _,v in pairs(ActualTools) do
			QuestItems:FindFirstChild(v):Clone().Parent = Player:WaitForChild("StarterGear")
			QuestItems:FindFirstChild(v):Clone().Parent = Player:WaitForChild("Backpack")
		end
	end
	local DataLoadBoolean = Instance.new("BoolValue")
	DataLoadBoolean.Name = "DataLoaded"
	DataLoadBoolean.Parent = Player
end

function LoadDataModule.LoadStats(Player)
	local CanAutoSave = true
	local lstats = Instance.new("Folder",Player)
	lstats.Name = "leaderstats"

	local Level = Instance.new("IntConstrainedValue",lstats)
	Level.Name = "Level"
	Level.MaxValue = 1000
	Level.MinValue = 1

	local Exp = Instance.new("IntConstrainedValue",lstats)
	Exp.Name = "XP"
	Exp.MaxValue = 1000000000000
	Exp.MinValue = 0

	local Gold = Instance.new("IntConstrainedValue",lstats)
	Gold.Name = "Gold"
	Gold.MaxValue = 1000000000000
	Gold.MinValue = 0

	local Sword = Instance.new("StringValue",lstats)
	Sword.Name = "Sword"

	local Rank = Instance.new("StringValue",Sword)
	Rank.Name = "Rank"

	local cdFolder = game:GetService("ServerStorage"):FindFirstChild("CheckpointData")
	local CheckpointData = Instance.new("ObjectValue",cdFolder)
	CheckpointData.Name = Player.UserId
	
	pcall(function()
		LoadDataModule:LoadData(Player,Level,Exp,Gold,Sword,Rank,CheckpointData)
	end)
			
	task.wait(1)
	print(Sword.Value)
	print(Rank.Value)
	local WeaponsService = require(game.ServerStorage.Aero.Services.WeaponsService)
	WeaponsService.Client:SwordSetUp(Player,Sword.Value,Rank.Value)

end


return LoadDataModule