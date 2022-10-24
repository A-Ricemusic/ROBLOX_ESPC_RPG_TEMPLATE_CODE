-- Goblin Config Module
-- Username
-- September 28, 2022



local GiantSpiderConfigModule = {


	--] Main
	MobName = ("Giant Spider"),
	LevelRequiredToKill = 0,
	--] Award
	AwardedXP = 137,
	AwardedGold = 15,
	--] Humanoid
	MobHealth = 60,
	MobWalkSpeed = 15,
	--] Damage & Respawning
	MobDamage = 10,
	RespawnTime = 10,
	--] Animations & Sounds
	AttackAnimIds = {
	"rbxassetid://186934658",
	},
	--] Chase
	FollowDistance = 10,
	FollowDelay = 0.1, 
	--] Optional: Weapon Drop
	DropsWeapon1 = false,
	WeaponName1 = "Sword1",
	WeaponDirectory1 = game.ReplicatedStorage.GameItems,
	WeaponChance1 = 1, -- 1 in (?)
	--]
	DropsWeapon2 = false,
	WeaponName2 = "Sword2",
	WeaponDirectory2 = game.ReplicatedStorage.GameItems,
	WeaponChance2 = 1, -- 1 in (?)
	--]
	DropsWeapon3 = false,
	WeaponName3 = "Sword3",
	WeaponDirectory3 = game.ReplicatedStorage.GameItems,
	WeaponChance3 = 1, -- 1 in (?)
	--]
	WeaponDirectory = game.ReplicatedStorage.GameItems,
	--] Name Rank
	RankName = "Boss",
	--] Optional: Teleport On Kill
	DoesMobTeleportAfterKill = false,
	TeleportLocation = CFrame.new(0,0,0),
	
}
return GiantSpiderConfigModule