-- Ragdoll
-- Username
-- September 29, 2022



local Ragdoll = {}

local CollectionService = game:GetService("CollectionService")

local RAGDOLLED_TAG = "__Ragdoll_Active"

function Ragdoll:ragdoll(model, humanoid)
    local RigTypes = self.Shared.RigTypes
	assert(humanoid:IsDescendantOf(model))
	if CollectionService:HasTag(model, RAGDOLLED_TAG) then
		return
	end
	CollectionService:AddTag(model, RAGDOLLED_TAG)
	-- Turn into loose body:
	humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	-- Instantiate BallSocketConstraints:
	local attachments = RigTypes.getAttachments(model, humanoid.RigType)
	for name, objects in pairs(attachments) do
		local parent = model:FindFirstChild(name)
		if parent then
			local constraint = Instance.new("BallSocketConstraint")
			constraint.Name = "RagdollBallSocketConstraint"
			constraint.Attachment0 = objects.attachment0
			constraint.Attachment1 = objects.attachment1
			constraint.LimitsEnabled = true
			constraint.UpperAngle = objects.limits.UpperAngle
			constraint.TwistLimitsEnabled = true
			constraint.TwistLowerAngle = objects.limits.TwistLowerAngle
			constraint.TwistUpperAngle = objects.limits.TwistUpperAngle
			constraint.Parent = parent
		end
	end
	-- Instantiate NoCollisionConstraints:
	local parts = RigTypes.getNoCollisions(model, humanoid.RigType)
	for _, objects in pairs(parts) do
		local constraint = Instance.new("NoCollisionConstraint")
		constraint.Name = "RagdollNoCollisionConstraint"
		constraint.Part0 = objects[1]
		constraint.Part1 = objects[2]
		constraint.Parent = objects[1]
	end

	-- Destroy all regular joints:
	for _, motor in pairs(model:GetDescendants()) do
		if motor:IsA("Motor6D") then
			motor:Destroy()
		end
	end
end

return Ragdoll