-- Context Action Service Controller
-- Username
-- September 28, 2022

local DoubleJumpAnimation = 'rbxassetid://10857202343'
local BackflipAnimation = "rbxassetid://11162593580"
local LastBackFlip = 0
local LastDoubleJump = 0 
local BackFlipCoolDown = 1
local DoubleJumpCoolDown = 0.8
local ContextActionServiceController = {}

function ContextActionServiceController:Start()
local Service = self.Services.CharacterManagerService
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local StartWalkSpeed = game.StarterPlayer.CharacterWalkSpeed
local StartJumpHeight = game.StarterPlayer.CharacterJumpHeight
local StartJumpPower = game.StarterPlayer.CharacterJumpPower




player.CharacterAdded:Connect(function(Character)    
local Humanoid = Character:WaitForChild("Humanoid",10)
local RightHand = Character:WaitForChild("RightHand",10)
Humanoid.WalkSpeed = StartWalkSpeed
Humanoid.JumpHeight = StartJumpHeight
Humanoid.JumpPower = StartJumpPower
local Anim = Instance.new("Animation")
Anim.Parent = script    
function ContextActionServiceController.BackFlipAction()
    local function backflip(ActionName,input)
        if tick() - LastBackFlip >= BackFlipCoolDown and ActionName == "backflip" and input == Enum.UserInputState.Begin then
            local Weapons = RightHand:GetChildren()
	for _,Child in pairs(Weapons) do
	    local IsTagged = game:GetService('CollectionService'):HasTag(Child, "GameItem")
            if IsTagged then  
                local WeaponTag = Child.Name
                local PathConfig = self.Shared.Config.PathConfigModule
                local WeaponConfig = require(PathConfig[WeaponTag]) 
                StartWalkSpeed = WeaponConfig.WalkSpeed 
                StartJumpHeight = WeaponConfig.JumpHeight 
            end
	end 
        LastBackFlip = tick()
        Anim.AnimationId = BackflipAnimation
        Humanoid:LoadAnimation(Anim):Play() 
        Service:Backflip(StartWalkSpeed,StartJumpHeight)
       end
    end
    ContextActionService:BindAction("backflip",backflip,true,Enum.KeyCode.LeftControl,Enum.KeyCode.ButtonB)        
end  
function ContextActionServiceController.DoubleJumpAction()
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.Button.Jump then
            if tick() - LastDoubleJump <= DoubleJumpCoolDown then return end
            if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            LastDoubleJump = tick()
            Anim.AnimationId = DoubleJumpAnimation
            Humanoid:LoadAnimation(Anim):Play()
            Service:DoubleJump()
            end
        end
    end)
end
    ContextActionServiceController.BackFlipAction()
    ContextActionServiceController.DoubleJumpAction()



        Humanoid.Died:Connect(function()
            ContextActionService:UnbindAction('backflip')
        end)
end)


player.CharacterRemoving:Connect(function()
    ContextActionService:UnbindAction('backflip')
end)

end


return ContextActionServiceController