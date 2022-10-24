-- Bronze Sword Config Module
-- Username
-- September 29, 2022



local BlazeSwordWeaponConfig = {}
BlazeSwordWeaponConfig.TagName = "BlazeSword"
BlazeSwordWeaponConfig.DisplayName = "Blaze Sword"
BlazeSwordWeaponConfig.Description = "Medium Weight Sword that does good damage. Special Ability Cast Heavy Fireball"
BlazeSwordWeaponConfig.HumanoidToKill = ("Enemy")
	BlazeSwordWeaponConfig.WalkSpeed = 15
	BlazeSwordWeaponConfig.JumpHeight = 8
	BlazeSwordWeaponConfig.MaxDamage = 10
	BlazeSwordWeaponConfig.MinDamage = 7
	BlazeSwordWeaponConfig.AbilityDamage = 10
	BlazeSwordWeaponConfig.Cooldown = 1
	BlazeSwordWeaponConfig.Cost = 200
	BlazeSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	BlazeSwordWeaponConfig.ProjectileName = "BigFireball"
	BlazeSwordWeaponConfig.AbilityForce = 150
	BlazeSwordWeaponConfig.AbilityCooldown = 10
	BlazeSwordWeaponConfig.AbilityDebrisTimer = 8
	BlazeSwordWeaponConfig.PlayerKnockbackVelocity = 50
	BlazeSwordWeaponConfig.ComboResetTimer = 3
	BlazeSwordWeaponConfig.HitBoxSize = Vector3.new(12,3,7)
	BlazeSwordWeaponConfig.AbilityName = "Projectile"
	BlazeSwordWeaponConfig.Description = "Medium Weight Sword, Ability: Heavy Fireball with BaseDamage: "..tostring(BlazeSwordWeaponConfig.AbilityDamage)..", Cooldown: "..tostring(BlazeSwordWeaponConfig.AbilityCooldown)

	-- Animations & Sounds
	BlazeSwordWeaponConfig.SwingAnimations = {
        'rbxassetid://9991697436', --1
		'rbxassetid://9991697436', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9991378000', --4
        'rbxassetid://9991581812', --5
    }
	BlazeSwordWeaponConfig.Textures = { -- Slash
	'rbxassetid://8821193347', --1
	'rbxassetid://8821230983', --2
	'rbxassetid://8821246947', --3
	'rbxassetid://8821254467', --4
	'rbxassetid://8821272181', --5
	'rbxassetid://8821280832', --6
	'rbxassetid://8821300395', --7
	'rbxassetid://8821311218', --8
	'rbxassetid://8896641723', --9
	}
	BlazeSwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return BlazeSwordWeaponConfig