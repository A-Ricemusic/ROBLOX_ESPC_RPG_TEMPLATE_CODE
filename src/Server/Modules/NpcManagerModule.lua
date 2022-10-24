-- Npc Manager Module
-- Username
-- September 29, 2022



local NpcManagerModule = {}

local MobRankValue = "Grunt"
function NpcManagerModule:NewMob(figure)
    local PathConfig = self.Shared.Config.PathConfigModule
    local config = require(PathConfig[figure.Name])
    local MobRank = figure:FindFirstChild("Rank")
    if MobRank then
        MobRankValue = MobRank.Value
    end
    local MobRankConfigModule = self.Shared.Config.MobRankConfigModule
   local RankAddedValue = {}
    local RankDictionary = MobRankConfigModule[MobRankValue]
    for Key,Value in pairs(RankDictionary) do
       RankAddedValue[Key] = Value
    end
    local AnimateModule =  figure:WaitForChild('AnimateModule',10)
    local Animations = AnimateModule:WaitForChild("Animations",10) 
    local CollectionService = game:GetService("CollectionService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local Ragdoll = self.Shared.Ragdoll
    local Maid = self.Shared.Maid

    
    --[[
        Configuration
    ]]
    
    -- Attack configuration
        local ATTACK_DAMAGE = config.ATTACK_DAMAGE + RankAddedValue["ATTACK_DAMAGE"]
        local ATTACK_RADIUS = config.ATTACK_RADIUS
    
    -- Patrol configuration
        local PATROL_ENABLED = config.PATROL_ENABLED
        local PATROL_RADIUS = config.PATROL_RADIUS
    
    -- Etc
        local LastHitboxHit = 0
        local DESTROY_ON_DEATH = config.DESTROY_ON_DEATH
        local RAGDOLL_ENABLED = config.RAGDOLL_ENABLED
        local MaxHealth = config.Health + RankAddedValue["Health"]
        local DEATH_DESTROY_DELAY = config.DEATH_DESTROY_DELAY
        local PATROL_WALKSPEED = config.PATROL_WALKSPEED
        local MIN_REPOSITION_TIME = config.MIN_REPOSITION_TIME
        local MAX_REPOSITION_TIME = config.MAX_REPOSITION_TIME
        local MAX_PARTS_PER_HEARTBEAT = config.MAX_PARTS_PER_HEARTBEAT
        local ATTACK_STAND_TIME = config.ATTACK_STAND_TIME
        local HITBOX_SIZE = config.HITBOX_SIZE
        local SEARCH_DELAY = config.SEARCH_DELAY
        local ATTACK_RANGE = config.ATTACK_RANGE
        local ATTACK_DELAY = config.ATTACK_DELAY
        local ATTACK_MIN_WALKSPEED = config.ATTACK_MIN_WALKSPEED + RankAddedValue["WalkSpeed"]
        local ATTACK_MAX_WALKSPEED = config.ATTACK_MAX_WALKSPEED + RankAddedValue["WalkSpeed"]
        local AttackAnimations = Animations.AttackAnimations:GetChildren()
        local DeathAnimation = Animations.DeathAnimations:GetChildren()
        local Attack_Count = 0
        local HipHeight = config.HipHeight
        local SizeMultiply = RankAddedValue["Size"]
        local MobName = config.MobName
    --[[
        Instance references
    ]]
    
    

    local maid = Maid.new()
    maid.instance = figure
    local ModelParts = figure:GetChildren()
    for _,part in pairs(ModelParts) do
        if part:IsA("Part") then
        part.Size = part.Size * SizeMultiply
        end
    end
    local mobConfig = PathConfig[figure.Name]:Clone()
    mobConfig.Name = "MobConfig"
    mobConfig.Parent = figure
    mobConfig = nil
    maid.humanoid = maid.instance:WaitForChild("Enemy")
    local billboard = figure.Enemy:FindFirstChild("BillboardGui")
    local NameGui = billboard:WaitForChild("Name")
    NameGui.Text = MobName.."  "..MobRankValue
    maid.humanoid.Health = MaxHealth
    maid.humanoid.HipHeight = 	HipHeight
    maid.head = maid.instance:WaitForChild("Head")
    billboard.Adornee = maid.head
    maid.humanoidRootPart = maid.instance:FindFirstChild("HumanoidRootPart")
    maid.alignOrientation = maid.humanoidRootPart:FindFirstChild("AlignOrientation")
    --[[
        State
    ]]
    
    local startPosition = maid.instance.PrimaryPart.Position
    
    -- Attack state
    local attacking = false
    local searchingForTargets = false
    
    -- Target finding state
    local target = nil
    local newTarget = nil
    local newTargetDistance = nil
    local searchIndex = 0
    local timeSearchEnded = 0
    local searchRegion = nil
    local searchParts = nil
    local movingToAttack = false
    local lastAttackTime = 0
    
    --[[
        Instance configuration
    ]]
    
    -- Create an Attachment in the terrain so the AlignOrientation is world realtive
    local worldAttachment = Instance.new("Attachment")
    worldAttachment.Name = "SoldierWorldAttachment"
    worldAttachment.Parent = Workspace.Terrain
    
    maid.worldAttachment = worldAttachment
    maid.humanoidRootPart.AlignOrientation.Attachment1 = worldAttachment
    
        -- Load and configure the animations
    local function loadAttackAnimation(anim)
    if maid.humanoid == nil then maid:Destroy()end
    local attackAnimation = maid.humanoid:LoadAnimation(anim)
    attackAnimation.Looped = false
    attackAnimation.Priority = Enum.AnimationPriority.Action
    maid.attackAnimation = attackAnimation
    maid.attackAnimation:Play()	
    end
        
        local function loadDeathAnimation(anim)	
        if maid.humanoid == nil then maid:Destroy()end
        local deathAnimation = maid.humanoid:LoadAnimation(anim)
        deathAnimation.Looped = false
        deathAnimation.Priority = Enum.AnimationPriority.Action
        maid.deathAnimation = deathAnimation
        maid.deathAnimation:Play()
    end
    --[[
        Helper functions
    ]]
    
    local random = Random.new()
    
    local function getRandomPointInCircle(centerPosition, circleRadius)
        local radius = math.sqrt(random:NextNumber()) * circleRadius
        local angle = random:NextNumber(0, math.pi * 2)
        local x = centerPosition.X + radius * math.cos(angle)
        local z = centerPosition.Z + radius * math.sin(angle)
    
        local position = Vector3.new(x, centerPosition.Y, z)
    
        return position
    end
    
    --[[
        Implementation
    ]]
    
    local function isAlive()
        if maid.humanoid then
        return maid.humanoid.Health > 0 and maid.humanoid:GetState() ~= Enum.HumanoidStateType.Dead
        else
        return false
        end
    end
    
    local function destroy()
        maid:Destroy()
    end
    
    local function patrol()
        while isAlive() do
            if not attacking then
                local position = getRandomPointInCircle(startPosition, PATROL_RADIUS)
                    maid.humanoid.WalkSpeed = PATROL_WALKSPEED
                    maid.humanoid.MaxHealth = MaxHealth
                    maid.humanoid:MoveTo(position)
            end
    
            wait(random:NextInteger(MIN_REPOSITION_TIME, MAX_REPOSITION_TIME))
        end
    end
    
    local function isInstaceAttackable(targetInstance)
        local targetHumanoid = targetInstance and targetInstance.Parent and targetInstance.Parent:FindFirstChild("Humanoid")
        if not targetHumanoid then
            return false
        end
    
        local isAttackable = false
        local distance = (maid.humanoidRootPart.Position - targetInstance.Position).Magnitude
    
        if distance <= ATTACK_RADIUS then
            local ray = Ray.new(
                maid.humanoidRootPart.Position,
                (targetInstance.Parent.HumanoidRootPart.Position - maid.humanoidRootPart.Position).Unit * distance
            )
    
            local part = Workspace:FindPartOnRayWithIgnoreList(ray, {
                targetInstance.Parent, maid.instance,
            }, false, true)
    
            if
                targetInstance ~= maid.instance and
                targetInstance:IsDescendantOf(Workspace) and
                targetHumanoid.Health > 0 and
                targetHumanoid:GetState() ~= Enum.HumanoidStateType.Dead and
                not CollectionService:HasTag(targetInstance.Parent, "Mob") and
                not part
            then
                isAttackable = true
            end
        end
    
        return isAttackable
    end
    
    local function findTargets()
        -- Do a new search region if we are not already searching through an existing search region
        if not searchingForTargets and tick() - timeSearchEnded >= SEARCH_DELAY then
            searchingForTargets = true
    
            -- Create a new region
            local centerPosition = maid.humanoidRootPart.Position
            local topCornerPosition = centerPosition + Vector3.new(ATTACK_RADIUS, ATTACK_RADIUS, ATTACK_RADIUS)
            local bottomCornerPosition = centerPosition + Vector3.new(-ATTACK_RADIUS, -ATTACK_RADIUS, -ATTACK_RADIUS)
    
            searchRegion = Region3.new(bottomCornerPosition, topCornerPosition)
            searchParts = Workspace:FindPartsInRegion3(searchRegion, maid.instance, math.huge)
    
            newTarget = nil
            newTargetDistance = nil
    
            -- Reset to defaults
            searchIndex = 1
        end
    
        if searchingForTargets then
            -- Search through our list of parts and find attackable humanoids
            local checkedParts = 0
            while searchingForTargets and searchIndex <= #searchParts and checkedParts < MAX_PARTS_PER_HEARTBEAT do
                local currentPart = searchParts[searchIndex]
                if currentPart and isInstaceAttackable(currentPart) then
                    local character = currentPart.Parent
                    local distance = (character.HumanoidRootPart.Position - maid.humanoidRootPart.Position).magnitude
    
                    -- Determine if the charater is the closest
                    if not newTargetDistance or distance < newTargetDistance then
                        newTarget = character.HumanoidRootPart
                        newTargetDistance = distance
                    end
                end
    
                searchIndex = searchIndex + 1
    
                checkedParts = checkedParts + 1
            end
    
            if searchIndex >= #searchParts then
                target = newTarget
                searchingForTargets = false
                timeSearchEnded = tick()
            end
        end
    end
    
    local function runToTarget()
        local targetPosition = (maid.humanoidRootPart.Position - target.Position).Unit * ATTACK_RANGE + target.Position
    
        maid.humanoid:MoveTo(targetPosition)
    
        if not movingToAttack then
            maid.humanoid.WalkSpeed = random:NextInteger(ATTACK_MIN_WALKSPEED, ATTACK_MAX_WALKSPEED)
        end
    
        movingToAttack = true
            if attacking == true then
                attacking = false
                if maid.humanoid == nil then maid:Destroy()end
                maid.attackAnimation:Stop()	
                end
    
    end

local debounce = true
--configure attack
    local function attack()
        attacking = true
        lastAttackTime = tick()
    
        local originalWalkSpeed = maid.humanoid.WalkSpeed
        maid.humanoid.WalkSpeed = 0
            if Attack_Count == #AttackAnimations then
                Attack_Count = 0
            end
            -- Play the attack animation
            Attack_Count = Attack_Count + 1
            -- Load and configure the animations
        loadAttackAnimation(AttackAnimations[Attack_Count])
        local Hitboxes = figure:GetChildren()
        for _, Hitbox in pairs(Hitboxes) do
            if Hitbox.Name == "Hitbox" then
                maid.Touched = Hitbox.Touched:Connect(function(Hit)
                    local Player = game.Players:GetPlayerFromCharacter(Hit.Parent)
                    if Player then
                        local H = Hit.Parent:FindFirstChild("Humanoid")
                            if H and tick() - LastHitboxHit >= 0.5 and debounce then
                                LastHitboxHit = tick()
                                H:TakeDamage(ATTACK_DAMAGE)
                            end
                    end
                end)
            end
        end
        -- Create a part and use it as a collider, to find humanoids in front of the zombie
        -- This is not ideal, but it is the simplest way to achieve a hitbox
        local OtherHitBox = Instance.new("Part")
        OtherHitBox.Size = HITBOX_SIZE * SizeMultiply
        OtherHitBox.Transparency = 1
        OtherHitBox.CanCollide = true
        OtherHitBox.Anchored = true
        OtherHitBox.CFrame = maid.humanoidRootPart.CFrame * CFrame.new(0, -1, -3)
        OtherHitBox.Parent = Workspace
        local hitTouchingParts = OtherHitBox:GetTouchingParts()
        OtherHitBox:Destroy()
        -- Find humanoids to damage
        local attackedHumanoids	= {}
        for _, part in pairs(hitTouchingParts) do
            local parentModel = part:FindFirstAncestorOfClass("Model")
            if isInstaceAttackable(part) and not attackedHumanoids[parentModel]	then
                attackedHumanoids[parentModel.Humanoid] = true
            end
        end
        
        -- Damage the humanoids
        for humanoid in pairs(attackedHumanoids) do
            humanoid:TakeDamage(ATTACK_DAMAGE)
        end
        
        startPosition = maid.instance.PrimaryPart.Position
        
        wait(ATTACK_STAND_TIME)
          

        maid.humanoid.WalkSpeed = originalWalkSpeed
        if maid.humanoid == nil then maid:Destroy()end
        maid.attackAnimation:Stop()
    
        attacking = false
    end
    
    --[[
        Event functions
    ]]
    
    local function onHeartbeat()
        if target then
            -- Point towards the enemy
            maid.alignOrientation.Enabled = true
            maid.worldAttachment.CFrame = CFrame.new(maid.humanoidRootPart.Position, target.Position)
        else
            maid.alignOrientation.Enabled = false
        end
    
        if target then
            local inAttackRange = (target.Position - maid.humanoidRootPart.Position).magnitude <= ATTACK_RANGE + 1
    
            if inAttackRange then
                if not attacking and tick() - lastAttackTime > ATTACK_DELAY then
                    attack()
                end
            else
                runToTarget()
            end
        end
    
        -- Check if the current target no longer exists or is not attackable
        if not target or not isInstaceAttackable(target) then
            findTargets()
        end
    end
    
        local function died()
        target = nil
        attacking = false
        newTarget = nil
        searchParts = nil
        searchingForTargets = false
    
        maid.heartbeatConnection:Disconnect()
    
        maid.humanoidRootPart.Anchored = true
        
        loadDeathAnimation(DeathAnimation[1])
        wait(maid.deathAnimation.Length * 0.65)
        if maid.humanoid == nil then maid:Destroy()end
            maid.deathAnimation:Stop()
        maid.humanoidRootPart.Anchored = false
    
        if RAGDOLL_ENABLED then
            Ragdoll:ragdoll(maid.instance, maid.humanoid)
        end
            
        if DESTROY_ON_DEATH then
                delay(DEATH_DESTROY_DELAY, function()
                destroy()
            end)
        end
    end
    
    --[[
        Connections
    ]]
    
    maid.heartbeatConnection = RunService.Heartbeat:Connect(function()
        onHeartbeat()
    end)
    
    maid.diedConnection = maid.humanoid.Died:Connect(function()
            coroutine.wrap(function()
                died()
            end)()
    end)
    
    --[[
        Start
    ]]
    
    if PATROL_ENABLED then
        coroutine.wrap(function()
            patrol()
        end)()
    end
    
    end


return NpcManagerModule