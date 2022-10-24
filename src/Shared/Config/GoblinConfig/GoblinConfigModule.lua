-- Goblin Config Module
-- Username
-- September 28, 2022



local GoblinConfigModule = {}

GoblinConfigModule.SOUND_DATA = {
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
GoblinConfigModule.ATTACK_DAMAGE = 10
GoblinConfigModule.ATTACK_RADIUS = 30

-- Patrol configuration
GoblinConfigModule.PATROL_ENABLED = true
GoblinConfigModule.PATROL_RADIUS = 20

-- Etc
GoblinConfigModule.FollowDistance = 10
GoblinConfigModule.DESTROY_ON_DEATH = true
GoblinConfigModule.RAGDOLL_ENABLED = true

GoblinConfigModule.DEATH_DESTROY_DELAY = 3
GoblinConfigModule.PATROL_WALKSPEED = 15
GoblinConfigModule.MIN_REPOSITION_TIME = 2
GoblinConfigModule.MAX_REPOSITION_TIME = 10
GoblinConfigModule.MAX_PARTS_PER_HEARTBEAT = 50
GoblinConfigModule.ATTACK_STAND_TIME = 0.8
GoblinConfigModule.HITBOX_SIZE = Vector3.new(7, 3, 7)
GoblinConfigModule.SEARCH_DELAY = 1
GoblinConfigModule.ATTACK_RANGE = 5
GoblinConfigModule.ATTACK_DELAY = 1
GoblinConfigModule.ATTACK_MIN_WALKSPEED = 10
GoblinConfigModule.ATTACK_MAX_WALKSPEED = 20

 GoblinConfigModule.REGEN_RATE = 1 / 100 -- Regenerate this fraction of MaxHealth per second.
 GoblinConfigModule.REGEN_STEP = 1 -- Wait this long between each regeneration step.
GoblinConfigModule.Respawn_Time = 5 + GoblinConfigModule.DEATH_DESTROY_DELAY
GoblinConfigModule.AwardedXP = 11
GoblinConfigModule.AwardedGold = 5
GoblinConfigModule.Health = 30
GoblinConfigModule.HipHeight = 3
GoblinConfigModule.MobName = "Goblin"
GoblinConfigModule.LevelRequiredToKill = 0
GoblinConfigModule.DropsWeapon1 = false
GoblinConfigModule.WeaponName1 = "Sword1"
GoblinConfigModule.WeaponDirectory1 = game.ReplicatedStorage.GameItems
GoblinConfigModule.WeaponChance1 = 1 -- 1 in (?)
--]
GoblinConfigModule.DropsWeapon2 = false
GoblinConfigModule.WeaponName2 = "Sword2"
GoblinConfigModule.WeaponDirectory2 = game.ReplicatedStorage.GameItems
GoblinConfigModule.WeaponChance2 = 1-- 1 in (?)
--]
GoblinConfigModule.DropsWeapon3 = false
GoblinConfigModule.WeaponName3 = "Sword3"
GoblinConfigModule.WeaponDirectory3 = game.ReplicatedStorage.GameItems
GoblinConfigModule.WeaponChance3 = 1 -- 1 in (?)
--] Name Rank
GoblinConfigModule.RankName = "Regular"
--] Optional: Teleport On Kill
GoblinConfigModule.DoesMobTeleportAfterKill = false
GoblinConfigModule.TeleportLocation = CFrame.new(0,0,0)
GoblinConfigModule.moveAnimation = "rbxassetid://10648232936"




return GoblinConfigModule