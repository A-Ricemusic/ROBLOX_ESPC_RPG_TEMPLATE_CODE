-- My Service
-- Username
-- September 28, 2022



local KillBlockService= {Client = {}}

function KillBlockService:KillBlockProperties(obj)
    local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
    local Config = require(PathConfig[obj.Name])
    obj.CanCollide = true
    obj.Anchored = true
    obj.Material = Enum.Material.Neon
    obj.Name = "KillBlock"
    obj.Color = Color3.new(1,0,0)
        obj.Touched:Connect(function(t)
            local h = t.Parent:FindFirstChild("Humanoid")
            if h then
                h:TakeDamage(Config.Damage)
            end
        end)
end

function KillBlockService:MakeKillBlocks()
local KillBlocks = game:GetService("CollectionService"):GetTagged("KillBlock")
for _,KillBlock in pairs(KillBlocks) do
    KillBlock.Name = "Killblock"
    KillBlockService:KillBlockProperties(KillBlock)
end
end



function KillBlockService:Start()
	KillBlockService:MakeKillBlocks()
end


function KillBlockService:Init()end


return KillBlockService