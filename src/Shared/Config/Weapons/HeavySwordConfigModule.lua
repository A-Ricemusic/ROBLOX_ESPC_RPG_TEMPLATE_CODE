-- Bronze Sword Config Module
-- Username
-- September 29, 2022



local HeavySwordWeaponConfig = {}
HeavySwordWeaponConfig.TagName = "HeavySword"
HeavySwordWeaponConfig.DisplayName = "Heavy Sword"
HeavySwordWeaponConfig.HumanoidToKill = ("Enemy")
	HeavySwordWeaponConfig.WalkSpeed = 12
	HeavySwordWeaponConfig.JumpHeight = 5
	HeavySwordWeaponConfig.MaxDamage = 15
	HeavySwordWeaponConfig.MinDamage = 12
	HeavySwordWeaponConfig.AbilityDamage = 10
	HeavySwordWeaponConfig.Cooldown = 1.5
	HeavySwordWeaponConfig.Cost = 200
	HeavySwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	HeavySwordWeaponConfig.ProjectileName = "BigFireball"
	HeavySwordWeaponConfig.AbilityForce = 150
	HeavySwordWeaponConfig.AbilityCooldown = 30
	HeavySwordWeaponConfig.AbilityDebrisTimer = 10
	HeavySwordWeaponConfig.PlayerKnockbackVelocity = 70
	HeavySwordWeaponConfig.ComboResetTimer = 4
	HeavySwordWeaponConfig.HitBoxSize = Vector3.new(15,3,10)
	HeavySwordWeaponConfig.AbilityName = "ForceField"
	HeavySwordWeaponConfig.Description = "Heavy Weight Sword, Ability: Invincible for "..tostring(HeavySwordWeaponConfig.AbilityDebrisTimer).." Seconds, Cooldown: "..tostring(HeavySwordWeaponConfig.AbilityCooldown)
	-- Animations & Sounds
	HeavySwordWeaponConfig.SwingAnimations = {
        'rbxassetid://9991697436', --1
		'rbxassetid://9991581812', --2
        'rbxassetid://9991697436', --3
        'rbxassetid://9991378000', --4
        'rbxassetid://9991581812', --5
    }
	HeavySwordWeaponConfig.Textures = { -- Slash
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
	HeavySwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return HeavySwordWeaponConfig