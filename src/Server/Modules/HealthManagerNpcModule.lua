-- Health Manager Npc Module
-- Username
-- September 28, 2022



local HealthManagerNpcModule = {}
function HealthManagerNpcModule:Heal(figure)
    local PathConfig = self.Shared.Config.PathConfigModule
    local config = require(PathConfig[figure.Name])
    local REGEN_RATE = config.REGEN_RATE -- Regenerate this fraction of MaxHealth per second.
    local REGEN_STEP = config.REGEN_STEP  -- Wait this long between each regeneration step.
    local Character = figure
    local Enemy = Character:FindFirstChild("Enemy")
    local IsHealing = false
    if Enemy == nil then return end
    Enemy.HealthChanged:Connect(function()
        if IsHealing then return end
        while Enemy.Health < Enemy.MaxHealth and Enemy.Health > 0 and Enemy:GetState() ~= Enum.HumanoidStateType.Dead do
            IsHealing = true
            local dt = wait(REGEN_STEP)
            local dh = dt * REGEN_RATE * Enemy.MaxHealth
            Enemy.Health = math.min(Enemy.Health + dh, Enemy.MaxHealth)
            if Enemy.Health >= Enemy.MaxHealth then
                IsHealing = false
                break
            end
        end
    end) 
end
return HealthManagerNpcModule