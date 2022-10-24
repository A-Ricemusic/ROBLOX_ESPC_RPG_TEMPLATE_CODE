-- Ability Controller
-- Username
-- October 8, 2022



local AbilityController = {}


function AbilityController:Start()
    local AbilityService = self.Services.AbilityService
    function AbilityController.Ability(WeaponConfig,Rank)
        if WeaponConfig.AbilityName == 'Projectile' then
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local Humanoid = Character:FindFirstChild("Humanoid")
           local  OriginalWalk = Humanoid.WalkSpeed
            Humanoid.WalkSpeed = 2
            local Mouse = game.Players.LocalPlayer:GetMouse()
            local MouseDirectionVector = Mouse.UnitRay.Direction
            AbilityService:Projectile(WeaponConfig,Rank,MouseDirectionVector)
            wait(0.1)
            Humanoid.WalkSpeed = OriginalWalk
        end

        if WeaponConfig.AbilityName == 'FastRun' then
            AbilityService:FastRun(WeaponConfig,Rank)
        end

        if WeaponConfig.AbilityName == 'None' then
           return
        end

        if WeaponConfig.AbilityName == 'Heal' then
            AbilityService:Heal(WeaponConfig,Rank)
        end

        if WeaponConfig.AbilityName == 'ForceField' then
            AbilityService:ForceField(WeaponConfig,Rank)
        end
	end
end


function AbilityController:Init()

end


return AbilityController