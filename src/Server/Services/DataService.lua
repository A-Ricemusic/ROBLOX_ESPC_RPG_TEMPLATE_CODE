local DataStoreService = game:GetService("DataStoreService")
-- Data Service
-- Username
-- October 5, 2022



local DataService = {Client = {}}


function DataService:Start()

local GameConfig = self.Shared.Config.GameConfigModule
local NotifyEvent = self.Modules.NotifyEventModule
DataStoreService = game:GetService("DataStoreService")
local Stats = DataStoreService:GetDataStore("StatsDS")
local LoadDataModule = self.Modules.LoadDataModule
local SaveDataModule = self.Modules.SaveDataModule

game.Players.PlayerAdded:Connect(function(plr)
	local CanSave = true
	LoadDataModule.LoadStats(plr)
	repeat task.wait() until plr:FindFirstChild("DataLoaded")~=nil

	game.Players.PlayerRemoving:Connect(function(plr2)
		if plr.Name == plr2.Name then
			CanSave = false
		end
	end)

	
	while true do
		task.wait(60*5)
		if CanSave == true then
			print(plr.Name .. "'s Data Successfully Saved")
			SaveDataModule.SaveStats(plr)
		elseif CanSave == false then
			return
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	if plr:FindFirstChild("DataLoaded") then
		SaveDataModule.SaveStats(plr)
	end
end)

local ServerTimeout = 5
game:BindToClose(function() 
	for _,v in pairs(game.Players:GetPlayers()) do
		if (v~=nil) then
			if v:FindFirstChild("DataLoaded") then
				SaveDataModule.SaveStats(v)
			end
		end
	end
	task.wait(ServerTimeout) 
end)
	
end


function DataService:Init()
	
end


return DataService