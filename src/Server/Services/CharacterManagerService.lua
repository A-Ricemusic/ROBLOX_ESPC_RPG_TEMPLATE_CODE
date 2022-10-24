-- Character Manager Service
-- Username
-- September 28, 2022



local CharacterManagerService = {Client = {}}
local BackflipConfig = {['ForcefieldTimer'] = 0.3,['DebrisTime'] = 0.5,['Force'] = 25}
local DoubleJumpConfig = {['Force'] = Vector3.new(0,2,0),['DebrisTime'] = 0.2,}
local debris = game:GetService("Debris")
local StartJumpPower = game.StarterPlayer.CharacterJumpPower
function CharacterManagerService.Client:Backflip(Player,StartWalkSpeed,StartJumpHeight)
local Character = Player.Character
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local ForceFiled = Instance.new("ForceField")
ForceFiled.Parent = Character
Humanoid.WalkSpeed = 0
Humanoid.JumpHeight = 0
Humanoid.JumpPower = 0
local BackflipForce = Instance.new("LinearVelocity")
BackflipForce.Parent = Character.PrimaryPart
BackflipForce.Attachment0 = Character.PrimaryPart.RootRigAttachment
BackflipForce.Enabled = true
BackflipForce.MaxForce = math.huge
BackflipForce.LineDirection = -Character.PrimaryPart.CFrame.LookVector *  Vector3.new(BackflipConfig['Force'],0,BackflipConfig['Force'])
BackflipForce.VectorVelocity = -Character.PrimaryPart.CFrame.LookVector *  Vector3.new(BackflipConfig['Force'],0,BackflipConfig['Force'])
BackflipForce.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
debris:AddItem(BackflipForce,BackflipConfig['DebrisTime'])
debris:AddItem(ForceFiled,BackflipConfig['ForcefieldTimer'])
Humanoid.WalkSpeed = StartWalkSpeed
Humanoid.JumpHeight = StartJumpHeight
Humanoid.JumpPower = StartJumpPower
end

function CharacterManagerService.Client:DoubleJump(Player)
		local Character = Player.Character
		local DoubleJumpForce = Instance.new("LinearVelocity")
        DoubleJumpForce.Parent = Character.PrimaryPart
		DoubleJumpForce.Attachment0 = Character.HumanoidRootPart.RootRigAttachment
		DoubleJumpForce.Enabled = true
		DoubleJumpForce.MaxForce = math.huge
		DoubleJumpForce.LineDirection = DoubleJumpConfig['Force']
		DoubleJumpForce.VectorVelocity = DoubleJumpConfig['Force']
		DoubleJumpForce.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		debris:AddItem(DoubleJumpForce,DoubleJumpConfig['DebrisTime'])
end



return CharacterManagerService