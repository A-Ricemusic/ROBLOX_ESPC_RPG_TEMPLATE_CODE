-- On Start Creations Service
-- Username
-- October 5, 2022



local OnStartCreationsService = {Client = {}}


function OnStartCreationsService:Start()
    local FxFolder = Instance.new("Folder",workspace)
    FxFolder.Name = "Fx"
    local DebrisHolder = Instance.new("Folder",game.Workspace)
    DebrisHolder.Name = "DebrisHolder"
    DebrisHolder.Parent = workspace
    local PlayerHolder = Instance.new("Folder")
	PlayerHolder.Name = "PlayerHolder"
	PlayerHolder.Parent = workspace
	
end


function OnStartCreationsService:Init()
	
end


return OnStartCreationsService