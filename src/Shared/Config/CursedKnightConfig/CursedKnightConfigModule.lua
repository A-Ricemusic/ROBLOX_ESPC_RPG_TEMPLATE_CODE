-- Goblin Config Module
-- Username
-- September 28, 2022



local ZombieManager = {}


ZombieManager.SOUND_DATA = {
	Climbing = {
		SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
		Looped = true,
	},
	Died = {
		SoundId = "",
	},
	FreeFalling = {
		SoundId = "rbxasset://sounds/action_falling.mp3",
		Looped = true,
	},
	GettingUp = {
		SoundId = "rbxasset://sounds/action_get_up.mp3",
	},
	Jumping = {
		SoundId = "rbxasset://sounds/action_jump.mp3",
	},
	Landing = {
		SoundId = "rbxasset://sounds/action_jump_land.mp3",
	},
	Running = {
		SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
		Looped = true,
		Pitch = 1.85,
	},
	Splash = {
		SoundId = "rbxasset://sounds/impact_water.mp3",
	},
	Swimming = {
		SoundId = "rbxasset://sounds/action_swim.mp3",
		Looped = true,
		Pitch = 1.6,
	},
}


-- Attack configuration
ZombieManager.ATTACK_DAMAGE = 5
ZombieManager.ATTACK_RADIUS = 30

-- Patrol configuration
ZombieManager.PATROL_ENABLED = true
ZombieManager.PATROL_RADIUS = 20

-- Etc
ZombieManager.FollowDistance = 10
ZombieManager.DESTROY_ON_DEATH = true
ZombieManager.RAGDOLL_ENABLED = true

ZombieManager.DEATH_DESTROY_DELAY = 3
ZombieManager.PATROL_WALKSPEED = 15
ZombieManager.MIN_REPOSITION_TIME = 2
ZombieManager.MAX_REPOSITION_TIME = 10
ZombieManager.MAX_PARTS_PER_HEARTBEAT = 50
ZombieManager.ATTACK_STAND_TIME = 0.8
ZombieManager.HITBOX_SIZE = Vector3.new(0, 0, 0)
ZombieManager.SEARCH_DELAY = 1
ZombieManager.ATTACK_RANGE = 10
ZombieManager.ATTACK_DELAY = 1
ZombieManager.ATTACK_MIN_WALKSPEED = 15
ZombieManager.ATTACK_MAX_WALKSPEED = 20

 ZombieManager.REGEN_RATE = 1 / 100 -- Regenerate this fraction of MaxHealth per second.
 ZombieManager.REGEN_STEP = 1 -- Wait this long between each regeneration step.
ZombieManager.Respawn_Time = 5 + ZombieManager.DEATH_DESTROY_DELAY
ZombieManager.AwardedXP = 11
ZombieManager.AwardedGold = 5
ZombieManager.Health = 20
ZombieManager.HipHeight = 3
ZombieManager.MobName = "Cursed Knight"
ZombieManager.LevelRequiredToKill = 0
ZombieManager.DropsWeapon1 = false
ZombieManager.WeaponName1 = "Sword1"
ZombieManager.WeaponDirectory1 = game.ReplicatedStorage.GameItems
ZombieManager.WeaponChance1 = 1 -- 1 in (?)
--]
ZombieManager.DropsWeapon2 = false
ZombieManager.WeaponName2 = "Sword2"
ZombieManager.WeaponDirectory2 = game.ReplicatedStorage.GameItems
ZombieManager.WeaponChance2 = 1-- 1 in (?)
--]
ZombieManager.DropsWeapon3 = false
ZombieManager.WeaponName3 = "Sword3"
ZombieManager.WeaponDirectory3 = game.ReplicatedStorage.GameItems
ZombieManager.WeaponChance3 = 1 -- 1 in (?)



return ZombieManager