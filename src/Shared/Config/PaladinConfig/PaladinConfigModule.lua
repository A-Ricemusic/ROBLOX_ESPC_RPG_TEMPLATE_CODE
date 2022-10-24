-- Goblin Config Module
-- Username
-- September 28, 2022



local PaladinConfigModule = {}

PaladinConfigModule.SOUND_DATA = {
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
PaladinConfigModule.ATTACK_DAMAGE = 20
PaladinConfigModule.ATTACK_RADIUS = 30

-- Patrol configuration
PaladinConfigModule.PATROL_ENABLED = true
PaladinConfigModule.PATROL_RADIUS = 20

-- Etc
PaladinConfigModule.FollowDistance = 10
PaladinConfigModule.DESTROY_ON_DEATH = true
PaladinConfigModule.RAGDOLL_ENABLED = true

PaladinConfigModule.DEATH_DESTROY_DELAY = 3
PaladinConfigModule.PATROL_WALKSPEED = 15
PaladinConfigModule.MIN_REPOSITION_TIME = 2
PaladinConfigModule.MAX_REPOSITION_TIME = 10
PaladinConfigModule.MAX_PARTS_PER_HEARTBEAT = 50
PaladinConfigModule.ATTACK_STAND_TIME = 0.8
PaladinConfigModule.HITBOX_SIZE = Vector3.new(7, 3, 7)
PaladinConfigModule.SEARCH_DELAY = 1
PaladinConfigModule.ATTACK_RANGE = 5
PaladinConfigModule.ATTACK_DELAY = 1
PaladinConfigModule.ATTACK_MIN_WALKSPEED = 10
PaladinConfigModule.ATTACK_MAX_WALKSPEED = 20

 PaladinConfigModule.REGEN_RATE = 1 / 100 -- Regenerate this fraction of MaxHealth per second.
 PaladinConfigModule.REGEN_STEP = 1 -- Wait this long between each regeneration step.
PaladinConfigModule.Respawn_Time = 5 + PaladinConfigModule.DEATH_DESTROY_DELAY
PaladinConfigModule.AwardedXP = 11
PaladinConfigModule.AwardedGold = 5
PaladinConfigModule.Health = 30
PaladinConfigModule.HipHeight = 3
PaladinConfigModule.MobName = "Paladin"
PaladinConfigModule.LevelRequiredToKill = 0
PaladinConfigModule.DropsWeapon1 = false
PaladinConfigModule.WeaponName1 = "Sword1"
PaladinConfigModule.WeaponDirectory1 = game.ReplicatedStorage.GameItems
PaladinConfigModule.WeaponChance1 = 1 -- 1 in (?)
--]
PaladinConfigModule.DropsWeapon2 = false
PaladinConfigModule.WeaponName2 = "Sword2"
PaladinConfigModule.WeaponDirectory2 = game.ReplicatedStorage.GameItems
PaladinConfigModule.WeaponChance2 = 1-- 1 in (?)
--]
PaladinConfigModule.DropsWeapon3 = false
PaladinConfigModule.WeaponName3 = "Sword3"
PaladinConfigModule.WeaponDirectory3 = game.ReplicatedStorage.GameItems
PaladinConfigModule.WeaponChance3 = 1 -- 1 in (?)
--] Name Rank
PaladinConfigModule.RankName = "Regular"
--] Optional: Teleport On Kill
PaladinConfigModule.DoesMobTeleportAfterKill = false
PaladinConfigModule.TeleportLocation = CFrame.new(0,0,0)
PaladinConfigModule.moveAnimation = "rbxassetid://10648232936"




return PaladinConfigModule