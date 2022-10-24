-- Goblin Config Module
-- Username
-- September 28, 2022



local SkeletonConfigModule = {}
SkeletonConfigModule.SOUND_DATA = {
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
SkeletonConfigModule.ATTACK_DAMAGE = 15
SkeletonConfigModule.ATTACK_RADIUS = 30

-- Patrol configuration
SkeletonConfigModule.PATROL_ENABLED = true
SkeletonConfigModule.PATROL_RADIUS = 20
-- Etc
SkeletonConfigModule.FollowDistance = 15
SkeletonConfigModule.DESTROY_ON_DEATH = true
SkeletonConfigModule.RAGDOLL_ENABLED = true

SkeletonConfigModule.DEATH_DESTROY_DELAY = 3
SkeletonConfigModule.PATROL_WALKSPEED = 15
SkeletonConfigModule.MIN_REPOSITION_TIME = 2
SkeletonConfigModule.MAX_REPOSITION_TIME = 10
SkeletonConfigModule.MAX_PARTS_PER_HEARTBEAT = 50
SkeletonConfigModule.ATTACK_STAND_TIME = 3
SkeletonConfigModule.HITBOX_SIZE = Vector3.new(0, 0, 0)
SkeletonConfigModule.SEARCH_DELAY = 2
SkeletonConfigModule.ATTACK_RANGE = 15
SkeletonConfigModule.ATTACK_DELAY = 0.5
SkeletonConfigModule.ATTACK_MIN_WALKSPEED = 15
SkeletonConfigModule.ATTACK_MAX_WALKSPEED = 20


 SkeletonConfigModule.REGEN_RATE = 1 / 100 -- Regenerate this fraction of MaxHealth per second.
 SkeletonConfigModule.REGEN_STEP = 1 -- Wait this long between each regeneration step.
SkeletonConfigModule.Respawn_Time = 5 + SkeletonConfigModule.DEATH_DESTROY_DELAY
SkeletonConfigModule.AwardedXP = 11
SkeletonConfigModule.AwardedGold = 5
SkeletonConfigModule.Health = 20
SkeletonConfigModule.HipHeight = 4
SkeletonConfigModule.MobName = "Skeleton"
SkeletonConfigModule.LevelRequiredToKill = 0
SkeletonConfigModule.DropsWeapon1 = false
SkeletonConfigModule.WeaponName1 = "Sword1"
SkeletonConfigModule.WeaponDirectory1 = game.ReplicatedStorage.GameItems
SkeletonConfigModule.WeaponChance1 = 1 -- 1 in (?)
--]
SkeletonConfigModule.DropsWeapon2 = false
SkeletonConfigModule.WeaponName2 = "Sword2"
SkeletonConfigModule.WeaponDirectory2 = game.ReplicatedStorage.GameItems
SkeletonConfigModule.WeaponChance2 = 1-- 1 in (?)
--]
SkeletonConfigModule.DropsWeapon3 = false
SkeletonConfigModule.WeaponName3 = "Sword3"
SkeletonConfigModule.WeaponDirectory3 = game.ReplicatedStorage.GameItems
SkeletonConfigModule.WeaponChance3 = 1 -- 1 in (?)


return SkeletonConfigModule