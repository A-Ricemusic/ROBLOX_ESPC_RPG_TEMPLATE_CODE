-- Bronze Sword Config Module
-- Username
-- September 29, 2022



local UltimateSwordWeaponConfig = {}
UltimateSwordWeaponConfig.TagName = "UltimateSword"
UltimateSwordWeaponConfig.DisplayName = "Ultimate Sword"
UltimateSwordWeaponConfig.HumanoidToKill = ("Enemy")
	UltimateSwordWeaponConfig.WalkSpeed = 25
	UltimateSwordWeaponConfig.JumpHeight = 12
	UltimateSwordWeaponConfig.MaxDamage = 20
	UltimateSwordWeaponConfig.MinDamage = 15
	UltimateSwordWeaponConfig.AbilityDamage = 15
	UltimateSwordWeaponConfig.Cooldown = 0.5
	UltimateSwordWeaponConfig.Cost = 10000
	UltimateSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	UltimateSwordWeaponConfig.ProjectileName = "BasicFireball"
	UltimateSwordWeaponConfig.AbilityForce = 100
	UltimateSwordWeaponConfig.AbilityCooldown = 1
	UltimateSwordWeaponConfig.AbilityDebrisTimer = 2
	UltimateSwordWeaponConfig.PlayerKnockbackVelocity = 35
	UltimateSwordWeaponConfig.ComboResetTimer = 1.2
	UltimateSwordWeaponConfig.HitBoxSize = Vector3.new(15,5,10)
	UltimateSwordWeaponConfig.AbilityName = "Projectile"
	UltimateSwordWeaponConfig.Description = "The Best Sword! Ability: Fire Ball with BaseDamage: "..tostring(UltimateSwordWeaponConfig.AbilityDamage)..", Cooldown: "..tostring(UltimateSwordWeaponConfig.AbilityCooldown)

	-- Animations & Sounds
	UltimateSwordWeaponConfig.SwingAnimations = {
        'rbxassetid://9820421213', --1
        'rbxassetid://9991378000', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9820421213', --4
        'rbxassetid://9991697436', --5
    }
	UltimateSwordWeaponConfig.Textures = { -- Slash
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
	UltimateSwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return UltimateSwordWeaponConfig