local CollectionService = game:GetService("CollectionService")

-- Weapons Service
-- Username
-- October 4, 2022
local WeaponsService = {Client = {}}
EventService = require(game.ServerStorage.Aero.Services.EventService)
function WeaponsService.Client:SetUpMobRank(p,Rank)
	print(Rank)
	local MobRankConfigModule = require(game.ReplicatedStorage.Aero.Shared.Config.MobRankConfigModule)
	if Rank == "Grunt" or Rank == "Officer"  or Rank == "Commander" or Rank == "General" or Rank == "Lord" then   
	local RankAddedValue = {}
	 local RankDictionary = MobRankConfigModule[Rank]
	 for Key,Value in pairs(RankDictionary) do
		RankAddedValue[Key] = Value
	 end
	 return RankAddedValue
	end
end

function WeaponsService.Client:SetUpSwordRank(p,Rank)
	if not Rank then return end
	if Rank == "Rusty" or Rank == "Iron"  or Rank == "Bronze" or Rank == "Silver" or Rank == "Gold" or Rank == "Lengendary"  then   
	local SwordRankConfigModule = require(game.ReplicatedStorage.Aero.Shared.Config.SwordRankConfigModule)
	local RankAddedValue = {}
	 local RankDictionary = SwordRankConfigModule[Rank]
	 for Key,Value in pairs(RankDictionary) do
		RankAddedValue[Key] = Value
	 end
	 return RankAddedValue
	 else
		return 
	end
end


--make DI

local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "BillboardGui";
	Properties = {
		ExtentsOffsetWorldSpace = Vector3.new(0,1.25,0);
		MaxDistance = 50;
		AlwaysOnTop = true;
		Size = UDim2.new(0,200,0,50);
	};
	Children = {
		{
			ID = 1;
			Type = "TextLabel";
			Properties = {
				FontSize = Enum.FontSize.Size18;
				TextColor3 = Color3.new(1,1,1);
				Text = "0 damage";
				TextStrokeTransparency = 0.5;
				Font = Enum.Font.Cartoon;
				BackgroundTransparency = 1;
				BackgroundColor3 = Color3.new(0,0,0);
				TextSize = 15;
				Size = UDim2.new(0,200,0,18);
			};
			Children = {};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end


function CreateTag(player,Enemy)
	if Enemy ~= nil then
		if (Enemy:FindFirstChild("Player_Tag")) then return end
		local tag = Instance.new("ObjectValue")
		tag.Parent = Enemy
		tag.Name = "Player_Tag"
		tag.Value = player
	end
end

function addComas(str)
	return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

function DestroyTag(Enemy)
	if Enemy ~= nil then
		local tag = Enemy:FindFirstChild("Player_Tag")
		if tag ~= nil then tag:Destroy() end
	end
end

local function CreateObject(hit,Damage)
	local ObjModel = Instance.new("Model",workspace:FindFirstChild("DebrisHolder") or workspace)
	local Obj = Instance.new("Part")
	Obj.Parent = ObjModel
	-- Appearance
	Obj.BrickColor = BrickColor.new("Bright red")
	Obj.Material = Enum.Material.Neon
	Obj.Transparency = 1
	-- Data
	local HitModel = hit:FindFirstAncestorOfClass("Model")
	if not HitModel then return end
	Obj.Position = HitModel.PrimaryPart.Position + Vector3.new(math.random(-1.6,1.6),5,math.random(-1.6,1.6))
	-- Behavior
	Obj.Anchored = true
	Obj.CanCollide = false
	Obj.Locked = true
	-- Part
	Obj.Shape = Enum.PartType.Ball
	Obj.Size = Vector3.new(0.75,0.75,0.75)
	-- Billboard Gui
	local Gui = script.BillboardGui:Clone()
	Gui.Adornee = ObjModel:FindFirstChild("Part")
	Gui.TextLabel.Text = addComas(tostring(Damage))
	Gui.Parent = ObjModel
	
	local ObjPos = Instance.new("BodyPosition")
	ObjPos.Parent = Obj
	ObjPos.Position = Vector3.new(0,7.85,0)
	for i = 1,0,-0.1 do
		Obj.Transparency = i
		Gui.TextLabel.TextTransparency = i
		Gui.TextLabel.TextStrokeTransparency = i
		wait()
	end
	wait(0.50)
	for i = 0,1,0.1 do
		Obj.Transparency = i
		Gui.TextLabel.TextTransparency = i
		Gui.TextLabel.TextStrokeTransparency = i
		wait()
	end
	return ObjModel
end

local function FindGameItem(RightHand)

	local Children = RightHand:GetChildren()
	local GameItem = nil
		for _, Child in pairs(Children) do
			if CollectionService:HasTag(Child,"GameItem") then
				GameItem = Child
				return GameItem
			end
		end
	
end

function WeaponsService.Client:HitBox(player,WeaponTag,HitBoxSize)
	local Hitbox = Instance.new("Part")
	Hitbox.Name = WeaponTag
	game:GetService("CollectionService"):AddTag(Hitbox,"Weapon")
	local ObjectValue = Instance.new('ObjectValue')
	ObjectValue.Name = "Creator"
	ObjectValue.Parent = Hitbox
	ObjectValue.Value = player
	Hitbox.Size = HitBoxSize
	Hitbox.Position = player.Character.PrimaryPart.Position + (player.Character.PrimaryPart.CFrame.LookVector * 5)
	Hitbox.Anchored = true
	Hitbox.CanCollide = false
	Hitbox.CastShadow = false
	Hitbox.Transparency = 1
	Hitbox.Material = Enum.Material.ForceField
	Hitbox.CanQuery = false
	Hitbox.Parent = workspace
	game:GetService('Debris'):AddItem(Hitbox,0.5)
	Hitbox.Destroying:Connect(function()
		game:GetService("CollectionService"):RemoveTag(Hitbox,"Weapon")
	end)
	
end

function WeaponsService.Client:SwordSetUp(plr,WeaponTag,Rank)
	task.wait(0.5)
	if WeaponTag == "" or Rank == "" then return end
	local char = plr.Character
	local RightHand = char:FindFirstChild("RightHand") 
	local WeaponEquipped = RightHand:GetChildren()
	for _,Child in pairs(WeaponEquipped) do
		if CollectionService:HasTag(Child,"GameItem") then
			CollectionService:RemoveTag(Child,"GameItem")
			Child:Destroy()
		end
	end
	local leaderstats = plr:FindFirstChild("leaderstats")
	if not leaderstats then return end
	local SwordStat = leaderstats:FindFirstChild("Sword")
	local RankStat = SwordStat:FindFirstChild("Rank")
		if SwordStat and RankStat then 
			SwordStat.Value = WeaponTag
			RankStat.Value = Rank
		else
			local SwordStat = Instance.new("StringValue",leaderstats)
			SwordStat.Value = WeaponTag
			local RankStat = Instance.new("StringValue",SwordStat)
			RankStat.Value = Rank
		end
	local Weapon = game:GetService("ReplicatedStorage").GameItems:FindFirstChild(WeaponTag)
	if not Weapon then return end
		local Handle = Weapon:Clone()
		Handle.Parent = RightHand
		local weld = Instance.new("ManualWeld")
		weld.Part0 = Handle
		weld.Part1 = RightHand
		weld.C0 = weld.Part1.CFrame:ToObjectSpace(weld.Part1.CFrame) - Vector3.new(0,-0.15,-0.3)
		weld.Parent = weld.Part0
		local WeaponRank = Instance.new("StringValue")
		WeaponRank.Parent = Handle
		WeaponRank.Value = Rank
		WeaponRank.Name = "Rank"
		local h = char:WaitForChild("Humanoid")
		h.HealthDisplayType = "AlwaysOn"
		h.NameOcclusion = Enum.NameOcclusion.NoOcclusion
		CollectionService:AddTag(Handle,"GameItem")
		EventService:FireSwordSetUpClient(plr,WeaponTag)
			h.Died:Connect(function()
				Handle:Destroy()
				CollectionService:RemoveTag(Handle,"GameItem")
			end)
end

local buyDebounce = true
function WeaponsService:BuySword(SwordPawn)
	task.wait(0.1)
	local IsSwordPawn = CollectionService:HasTag(SwordPawn,'SwordPawn')
	if not IsSwordPawn then return end
	local Rank = "Rusty"
	if SwordPawn:FindFirstChild("Rank") then 
	Rank = SwordPawn.Rank.Value 
	end
	local P= nil
	local SwordRankAddedValue = WeaponsService.Client:SetUpSwordRank(P,Rank)
	local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
	local WeaponConfig = require(PathConfig[SwordPawn.Name])
	local Cost = WeaponConfig.Cost + SwordRankAddedValue["Cost"]
	local ProximityPrompt = SwordPawn.ProximityPrompt
		ProximityPrompt.ActionText = "Buy "..WeaponConfig.DisplayName.." Rank: "..Rank.. " Cost: "..tostring(Cost)
		ProximityPrompt.ObjectText = WeaponConfig.Description
		ProximityPrompt.GamepadKeyCode = Enum.KeyCode.DPadUp
		ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.C
		ProximityPrompt.HoldDuration = 1
		ProximityPrompt.Triggered:Connect(function(player)
			if not player then return end
			local leaderstats = player:FindFirstChild("leaderstats")
			if not leaderstats then return end
			local Gold = leaderstats:FindFirstChild("Gold")
			local Character = player.Character
			local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
			if PrimaryPart == nil then return end
			local RightHand = Character:FindFirstChild("RightHand")
			if not RightHand then return end
			local GameItem = FindGameItem(RightHand)
			if GameItem ~= nil then
				if GameItem.Name == SwordPawn.Name then
					return CreateObject(PrimaryPart,"You Have This Sword")
				end
			end
			if Gold.Value < Cost then
			return CreateObject(PrimaryPart,"Not Enough Gold")
			elseif Gold.Value >= Cost then
			Gold.Value = Gold.Value - Cost
			CreateObject(PrimaryPart, "Successful Purchase")
			local Save = require(game.ServerStorage.Aero.Modules.SaveDataModule)
			if buyDebounce then
				buyDebounce = false
			Save.SaveStats(player)
				task.wait(5)
				buyDebounce = true
			end
			WeaponsService.Client:SwordSetUp(player,SwordPawn.Name,Rank)
			else return
			end
		end)
end

local sellDebounce = true
function WeaponsService:SellSword(SwordSell)
	task.wait(0.1)
	local IsSwordPawn = CollectionService:HasTag(SwordSell,'SwordSell')
	if not IsSwordPawn then return end
	local ProximityPrompt = SwordSell.ProximityPrompt
	ProximityPrompt.ActionText = "Sell Currently Equipped Item" 
	ProximityPrompt.GamepadKeyCode = Enum.KeyCode.DPadUp
	ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.C
	ProximityPrompt.HoldDuration = 1
	ProximityPrompt.Triggered:Connect(function(player)
		if not player then return end
		local leaderstats = player:FindFirstChild("leaderstats")
		if not leaderstats then return end
		local Gold = leaderstats:FindFirstChild("Gold")
		if not Gold then return end
		local Character = player.Character
		local RightHand = Character:FindFirstChild("RightHand")
		if not RightHand then return end
		local GameItem = FindGameItem(RightHand)
		if GameItem == nil then return CreateObject(Character.PrimaryPart,"No Sword Found") end
		local IsRank = GameItem:FindFirstChild("Rank") 
		local Rank = "Rusty"
		if IsRank then 
		Rank = IsRank.Value 
		end
	local SwordRankAddedValue = WeaponsService.Client:SetUpSwordRank(player,Rank)
	local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
	local WeaponConfig = require(PathConfig[GameItem.Name])
	local Cost = WeaponConfig.Cost + SwordRankAddedValue["Cost"]
	Gold.Value = Gold.Value + Cost
	local leaderstats = game.Players:GetPlayerFromCharacter(Character):FindFirstChild("leaderstats")
	if not leaderstats then return end
	local SwordStat = leaderstats:FindFirstChild("Sword")
	local RankStat = SwordStat:FindFirstChild("Rank")
		if SwordStat and RankStat then 
			SwordStat.Value = ""
			RankStat.Value = ""
		end
	CollectionService:RemoveTag(GameItem,"GameItem")
	local Save = require(game.ServerStorage.Aero.Modules.SaveDataModule)
	if sellDebounce then
		sellDebounce = false
	Save.SaveStats(player)
		task.wait(5)
		sellDebounce = true
	end
	EventService:FireUnbindActions(player)
	GameItem:Destroy()
	end)	
end




function WeaponsService:Start()
Scan(root, script)
local Maid = self.Shared.Maid
local maid = Maid.new()
local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
local SwordPawns = CollectionService:GetTagged("SwordPawn")
local SwordSells = CollectionService:GetTagged("SwordSell")
for _,Shop in pairs(SwordPawns) do
	task.wait(0.1)
	WeaponsService:BuySword(Shop)
end
for _,SwordSell in pairs(SwordSells) do
	task.wait(0.1)
	WeaponsService:SellSword(SwordSell)
end
local LastDamage = 0
maid.WorkspaceSignal = game.Workspace.DescendantAdded:Connect(function(descendant)
	WeaponsService:BuySword(descendant)
    local IsWeapon = CollectionService:HasTag(descendant,"Weapon")
    if not IsWeapon then return end
    local WeaponConfig = require(PathConfig[descendant.Name])
	local player=  game:GetService('Players'):GetPlayerFromCharacter(descendant:FindFirstAncestorOfClass('Model'))
	local ObjectValue = descendant:FindFirstChildWhichIsA('ObjectValue')
	if ObjectValue and ObjectValue.Name == 'Creator'  then
	player = ObjectValue.Value
	end
	if descendant:IsA('Part') then
		
		local HumanoidToKill = WeaponConfig.HumanoidToKill
		local Connection
Connection = descendant.Touched:Connect(function(HitPart)
	--Initial Checks before Damaging Mob and doing knockback
	if tick() - LastDamage <= 0.2 then return end
	local Model = HitPart:FindFirstAncestorOfClass("Model")
	if Model == nil then return end
	local Enemy = Model:FindFirstChild(HumanoidToKill)
	if	not Enemy then return end
	if Enemy.Health <= 0 then return end
	local HumanoidRootPart = Enemy.Parent:FindFirstChild("HumanoidRootPart")
	if  not HumanoidRootPart then return end
	local Character = player.Character
	local Humanoid = Character:FindFirstChild("Humanoid")
	if (not Humanoid) then return end		
	if Enemy == Humanoid then return end
	local RightHand = Character:FindFirstChild("RightHand")
	local GameItem = FindGameItem(RightHand)
	if not GameItem then return end	
	if not RightHand then return end
		local SwordRankAddedValue = WeaponsService.Client:SetUpSwordRank(player,GameItem.Rank.Value)
		local MobRank = "Grunt"
		local IsMobRank = Model:FindFirstChild("Rank")
		if IsMobRank then
			MobRank = IsMobRank.Value
		end
		local MobRankAddedValue = WeaponsService.Client:SetUpMobRank(player,MobRank)
		LastDamage = tick()	
		--Knockback
		if HumanoidRootPart:FindFirstChild("BodyVelocity") ~= nil then					
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Parent = Model.PrimaryPart
		BodyVelocity.MaxForce = Vector3.new(99999,0,99999)
		BodyVelocity.Name = "BodyVelocity"
		BodyVelocity.Velocity = player.Character.PrimaryPart.CFrame.LookVector * WeaponConfig.PlayerKnockbackVelocity
		game:GetService("Debris"):AddItem(BodyVelocity,0.7)
		end
		--Damage Mob and Track Quest and player Data
		local Damage = math.random(WeaponConfig.MinDamage, WeaponConfig.MaxDamage) + SwordRankAddedValue["ATTACK_DAMAGE"]
		if CollectionService:HasTag(descendant,'Ability') then
			Damage = WeaponConfig.AbilityDamage + SwordRankAddedValue["AbilityDamage"]
		end
        CreateTag(player,Enemy)
		local leaderstats = player:FindFirstChild("leaderstats")
		local Level = leaderstats:FindFirstChild("Level")
		local LevelValue = Level.Value
		local AddedDamage = LevelValue
		if LevelValue >= 10 and LevelValue<20 then
			AddedDamage = 12
		end
		if LevelValue >= 30 and LevelValue<50 then
			AddedDamage = 20
		end
		if LevelValue >= 50 and LevelValue<70 then
			AddedDamage = 28
		end
		if LevelValue >= 70 and LevelValue<100 then
			AddedDamage = 35
		end
		if LevelValue >= 100 then
			AddedDamage = 40
		end
		local damageFinal = Damage + AddedDamage 
        Enemy:TakeDamage(damageFinal)
        if Enemy.Health <= 0 then
			local exp = leaderstats:FindFirstChild("XP")
			local gold = leaderstats:FindFirstChild("Gold")
            local MobConfig = require(Enemy.Parent.MobConfig)
			exp.Value = exp.Value + MobConfig.AwardedXP + MobRankAddedValue["Xp"]
			gold.Value = gold.Value + MobConfig.AwardedGold + MobRankAddedValue["Gold"]
            for _,quest in pairs(player.Questing:GetChildren()) do
                for _,objective in pairs(quest:GetChildren()) do
                    if objective.Type.Value == "Kill" then
                        if objective.Targets:FindFirstChild(MobConfig.MobName.." "..MobRank) then
                            if objective.Max.Value > objective.Value then
                                objective.Value = objective.Value + 1
                            end
                        end
                    end
                end
                
            end
            
        end
        local ObjModel = CreateObject(HitPart,tostring(damageFinal).." Damage")
        ObjModel:Destroy()
        DestroyTag(ObjModel)
		Connection:Disconnect()
	end)
	end
end)

end
function WeaponsService:Init()
	
end




return WeaponsService