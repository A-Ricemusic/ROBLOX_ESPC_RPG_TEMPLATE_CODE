-- Checkpoint Service
-- Username
-- October 16, 2022



local CheckpointService = {Client = {}}

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local Save = require(game.ServerStorage.Aero.Modules.SaveDataModule)
local Debounce = true
local function MakeCheckpoint(checkpoint)
    
local function onTouched(hit)
	if hit and hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid") then
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		local checkpointData = ServerStorage:FindFirstChild("CheckpointData")
		if not checkpointData then
			checkpointData = Instance.new("Folder")
			checkpointData.Name = "CheckpointData"
			checkpointData.Parent = ServerStorage
		end
		
		local userIdString = tostring(player.UserId)
		local checkpointValue = checkpointData:FindFirstChild(userIdString)
		if not checkpointValue then
			checkpointValue = Instance.new("ObjectValue")
			checkpointValue.Name = userIdString
			checkpointValue.Parent = checkpointData
		end
		
		checkpointValue.Value = checkpoint
        if Debounce then
            Debounce = false
        Save.SaveStats(player)
            task.wait(5)
            Debounce = true
        end
       
	end
end
checkpoint.Touched:Connect(onTouched)
end

function CheckpointService:movePlayer(player)
        task.wait(3)
        local character = player.Character
        local storedCheckpoint = ServerStorage.CheckpointData[player.UserId].Value
        if storedCheckpoint == nil then
            local Start = CollectionService:GetTagged("Start")
            storedCheckpoint = Start[1]
        end
        character:MoveTo(storedCheckpoint.Position + Vector3.new(math.random(-4, 4), 4, math.random(-4, 4)))    
end



function CheckpointService:Start()
    local maid = self.Shared.Maid
    local Players = game.Players
    maid.Plr =  Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
        CheckpointService:movePlayer(player)
    end)
    end)
    Players.PlayerRemoving:Connect(function(player)
        maid:Destroy()
    end)
    local Checkpoints = CollectionService:GetTagged("Checkpoint")
        for _, checkpoint in pairs(Checkpoints) do
            MakeCheckpoint(checkpoint)
        end
    
end


function CheckpointService:Init()
	
end


return CheckpointService