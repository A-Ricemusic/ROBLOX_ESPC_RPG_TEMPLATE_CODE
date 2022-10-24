-- Game Leveling Service
-- Username
-- October 5, 2022



local GameLevelingService = {Client = {}}


function GameLevelingService:Start()

    local LevelUp = function(plr, Level, XP)
        if XP.Value >= Level.Value * 25 then
            -- Leveling
            XP.Value = XP.Value - Level.Value * 25 
            Level.Value = Level.Value + 1
            -- Health
            if (not plr.Character) then return end
            local hum = plr.Character:WaitForChild("Humanoid")
            hum.MaxHealth = hum.MaxHealth + 10
        end
    end
    
    
    game.Players.PlayerAdded:Connect(function(plr)
        
        plr.CharacterAdded:Connect(function(chr)
            local hum = chr:WaitForChild("Humanoid",10)
            local leaderstats = plr:WaitForChild("leaderstats")
            local Level = leaderstats:WaitForChild("Level")
            repeat wait() until plr:FindFirstChild("DataLoaded")~=nil
            hum.MaxHealth = Level.Value * 10 + 100
            hum.Health = hum.MaxHealth
        end)
        
        local leaderstats = plr:WaitForChild("leaderstats")
        local Level = leaderstats:WaitForChild("Level")
        local XP = leaderstats:WaitForChild("XP")
        
        Level.Changed:Connect(function() wait() LevelUp(plr, Level, XP) end)
        XP.Changed:Connect(function() wait() LevelUp(plr, Level, XP) end)
    end)
	
end


function GameLevelingService:Init()
	
end


return GameLevelingService