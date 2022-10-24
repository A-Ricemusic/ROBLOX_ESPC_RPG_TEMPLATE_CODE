-- Spawn Service
-- Username
-- October 7, 2022

local Debris = game:GetService("Debris")
local LastSpawn = 0
local SpawnTimer = 60
local Rank = "Grunt"
local SpawnService = {Client = {}}
local debounce = true
function SpawnService:Start()

  --init spawn system
  local SpawnerIdNumbersArray = {}
  local SpawnerCheck = {}
    local Spawners = game:GetService('CollectionService'):GetTagged('Spawner')
    for _,Spawner in pairs(Spawners) do
        if Spawner:IsA('Part') then
          local SpawnerIdNumber = Instance.new("IntValue")
         while true do
          wait()
         local RandomNumber = nil
          RandomNumber = tick()
          if not table.find(SpawnerIdNumbersArray,RandomNumber,1) then
            Spawner.Name = tostring(RandomNumber)
            SpawnerCheck[Spawner.Name] = {}
            break
            else
            continue
          end
         end
          Spawner.Transparency = 1
          Spawner.Anchored = true
          Spawner.CanCollide = false
          Spawner = nil
        end
      end
        Spawners = nil

        --registers touch events and spawning
        local Spawners = game.Workspace.Spawners:GetChildren()
        for _,Spawner in pairs(Spawners) do
          Spawner.Touched:Connect(function(Touched)
            if not Touched.Parent:FindFirstChild("Humanoid") then return end
            local Player = game.Players:GetPlayerFromCharacter(Touched.Parent)
            if Player == nil then return end
            if SpawnerCheck[Spawner.Name][Player.UserId] ~= nil then
              if SpawnerCheck[Spawner.Name][Player.UserId] <= SpawnTimer then return end
              SpawnerCheck[Spawner.Name][Player.UserId] = tick() - SpawnerCheck[Spawner.Name][Player.UserId]
            else
              SpawnerCheck[Spawner.Name][Player.UserId] = tick()
            end
            local Timer = Spawner:FindFirstChild("Timer")
            if Timer then
            SpawnTimer = Timer.Value * 60
            else
              SpawnTimer = 5 * 60
            end
                local Values = Spawner:GetChildren()
                for _, Value in pairs(Values) do
                  local Name = Value.Name
                  local IsRank = Value:FindFirstChild("Rank")
                  if IsRank then
                    Rank = IsRank.Value
                  end
                  local IsBossSpawner = Value:FindFirstChild("Boss")
                  local Mob = nil
                  if IsBossSpawner then
                    Mob = nil
                    Mob = game:GetService("ReplicatedStorage").Bosses:FindFirstChild(Name)
                  else
                    Mob = game:GetService("ReplicatedStorage").Mobs:FindFirstChild(Name)
                  end
                
                  if Mob and debounce then
                    debounce = false
                    for c = 1,Value.Value do
                      wait()
                      local MobClone = Mob:Clone()
                      local MobRank = Instance.new("StringValue")
                      MobRank.Name = "Rank"
                      MobRank.Value = Rank
                      MobRank.Parent = MobClone
                      MobClone.PrimaryPart.Position = Touched.Position + Vector3.new(3 + (4*c),8, 3+(4*c))
                      MobClone.Parent = workspace
                      Debris:AddItem(MobClone,SpawnTimer)
                      MobClone = nil
                      MobRank = nil
                      Spawner.CanTouch = false
                      end	
                      task.wait(1)
                      Spawner.CanTouch = true
                      debounce = true
                  end
                end
          end)  
        end
end
	



function SpawnService:Init()
	
end


return SpawnService