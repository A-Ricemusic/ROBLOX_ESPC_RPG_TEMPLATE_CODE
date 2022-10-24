-- Npc Manager Service
-- Username
-- September 28, 2022

local Animations = nil
local NpcManagerService = {Client = {}}


function NpcManagerService:Start()
    local NpcManager = self.Modules.NpcManagerModule 
    local NpcSoundManager = self.Modules.NpcSoundManagerModule
    local HealthManager = self.Modules.HealthManagerNpcModule

    local function MakeMob(figure)
        local BaseAnimations = game:GetService("ReplicatedStorage").Animations:FindFirstChild("Base"):Clone()
        local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
        local IsAnimations = game:GetService("ReplicatedStorage").Animations:FindFirstChild(figure.Name)
        if IsAnimations then
            Animations = IsAnimations:Clone()
            Animations.Name = "Animations"
            BaseAnimations:Destroy()
            else
            Animations = BaseAnimations
        end
        local EnemyAnimationsManagerClone = game.ReplicatedStorage.Aero.Shared.AnimateModule:Clone()
        Animations.Parent = EnemyAnimationsManagerClone
        EnemyAnimationsManagerClone.Parent = figure
        local EnemyAnimationsManager = require(figure.AnimateModule)
        NpcManager:NewMob(figure)
        NpcSoundManager:MakeSounds(figure)
        EnemyAnimationsManager:Animate(figure)
        HealthManager:Heal(figure)
        EnemyAnimationsManagerClone = nil
    end
	game.Workspace.DescendantAdded:Connect(function(Decendant)
		local IsMob = game:GetService('CollectionService'):HasTag(Decendant,"Mob")
        if IsMob then
			MakeMob(Decendant)
		end
	end)
end



return NpcManagerService