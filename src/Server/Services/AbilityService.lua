-- Ability Service
-- Username
-- October 8, 2022



local AbilityService = {Client = {}}
local Debris = game:GetService("Debris")

local function SetUpSwordRank(Rank)
	print(Rank)
	if not Rank then return end
	if Rank == "Rusty" or Rank == "Iron"  or Rank == "Bronze" or Rank == "Silver" or Rank == "Gold" or Rank == "Lengendary"  then   
	local SwordRankConfigModule = require(game.ReplicatedStorage.Aero.Shared.Config.SwordRankConfigModule)
	local RankAddedValue = {}
	 local RankDictionary = SwordRankConfigModule[Rank]
	 for Key,Value in pairs(RankDictionary) do
		RankAddedValue[Key] = Value
	 end
	 print("Valid Rank")
	 return RankAddedValue
	 else
		return print("Not A Valid Rank")
	end
end



function AbilityService.Client:FastRun(Player, WeaponConfig,Rank)
    local SwordRankAddedValue = SetUpSwordRank(Rank)
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Aura = game:GetService("ReplicatedStorage").Effects.FastRun.FastRunAttachment:Clone()
    Aura.Parent = Character.PrimaryPart
    Humanoid.WalkSpeed = WeaponConfig.AbilityRunSpeed
    wait(WeaponConfig.AbilityDebrisTimer)
    Humanoid.WalkSpeed = WeaponConfig.WalkSpeed * SwordRankAddedValue["AbilityMultiply"]
    Debris:AddItem(Aura,WeaponConfig.AbilityDebrisTimer)
end

function AbilityService.Client:ForceField(Player, WeaponConfig,Rank)
    local SwordRankAddedValue = SetUpSwordRank(Rank)
    local Character = Player.Character
    local Aura = game:GetService("ReplicatedStorage").Effects.ForceField.ForceFieldAttachment:Clone()
   local ForceField = Instance.new("ForceField")
   ForceField.Parent = Character.PrimaryPart
    Aura.Parent = Character.PrimaryPart
  ForceField.Visible = true
    Debris:AddItem(ForceField,(WeaponConfig.AbilityDebrisTimer * SwordRankAddedValue["AbilityMultiply"]))
    Debris:AddItem(Aura, (WeaponConfig.AbilityDebrisTimer * SwordRankAddedValue["AbilityMultiply"]))
end


function AbilityService.Client:Heal(Player, WeaponConfig,Rank)
    local SwordRankAddedValue = SetUpSwordRank(Rank)
    local Character = Player.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    local Aura = game:GetService("ReplicatedStorage").Effects.Heal.HealAttachment:Clone()
    Aura.Parent = Character.PrimaryPart
    for count = 1, WeaponConfig.HealAmount do
        Humanoid.Health = Humanoid.Health + (1 * SwordRankAddedValue["AbilityMultiply"])
        wait(0.5)
    end
    Aura:Destroy()
end




function AbilityService.Client:Projectile(Player, WeaponConfig,Rank,MouseDirectionVector)
    local SwordRankAddedValue = SetUpSwordRank(Rank)
    local Character = Player.Character
	local ProjectileOriginal = game:GetService("ReplicatedStorage").Ability:FindFirstChild(WeaponConfig.ProjectileName)
    local Projectile = ProjectileOriginal:Clone()
    Projectile.Name = WeaponConfig.TagName
    game:GetService('CollectionService'):AddTag(Projectile,"Weapon")
    local ObjectValue = Instance.new('ObjectValue')
    ObjectValue.Parent = Projectile
    ObjectValue.Name = "Creator"
    ObjectValue.Value = Player
	Projectile.Position = Character.PrimaryPart.Position + (Character.PrimaryPart.CFrame.LookVector * 2.8)
	Projectile.Anchored = false
	Projectile.CanCollide = false
	Projectile.Parent = workspace
    local ProjectileDirection = MouseDirectionVector
	local Attachment = Instance.new("Attachment")
	Attachment.Parent = Projectile
	local ProjectileForce = Instance.new("LinearVelocity")
	ProjectileForce.Parent = Projectile
	ProjectileForce.Attachment0 = Attachment
	ProjectileForce.Enabled = true
	ProjectileForce.MaxForce = math.huge
	ProjectileForce.LineDirection =ProjectileDirection  *  Vector3.new(WeaponConfig.AbilityForce,0,WeaponConfig.AbilityForce) * SwordRankAddedValue["AbilityMultiply"]
	ProjectileForce.VectorVelocity = ProjectileDirection * Vector3.new(WeaponConfig.AbilityForce,0,WeaponConfig.AbilityForce)* SwordRankAddedValue["AbilityMultiply"]
	ProjectileForce.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    Projectile.Touched:Connect(function(Touched)
        if Touched:FindFirstAncestorOfClass('Model') == Player.Character then return else 
            wait(0.3)
        Projectile:Destroy()
        end
    end)
    Debris:AddItem(Projectile,WeaponConfig.AbilityDebrisTimer)
end




function AbilityService:Init()
	
end


return AbilityService