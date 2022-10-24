-- Bronze Sword Config Module
-- Username
-- September 29, 2022



local ShortSwordWeaponConfig = {}
ShortSwordWeaponConfig.TagName = "Dagger"
ShortSwordWeaponConfig.DisplayName = "Dagger"
ShortSwordWeaponConfig.HumanoidToKill = ("Enemy")
	ShortSwordWeaponConfig.WalkSpeed = 20
	ShortSwordWeaponConfig.JumpHeight = 15
	ShortSwordWeaponConfig.MaxDamage = 2
	ShortSwordWeaponConfig.MinDamage = 1
	ShortSwordWeaponConfig.AbilityDamage = 5
	ShortSwordWeaponConfig.Cooldown = 1
	ShortSwordWeaponConfig.Cost = 200
	ShortSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	ShortSwordWeaponConfig.ProjectileName = "ThrowingKnife"
	ShortSwordWeaponConfig.AbilityForce = 100
	ShortSwordWeaponConfig.AbilityCooldown = 1
	ShortSwordWeaponConfig.AbilityDebrisTimer = 0.5
	ShortSwordWeaponConfig.PlayerKnockbackVelocity = 5
	ShortSwordWeaponConfig.ComboResetTimer = 1.5
	ShortSwordWeaponConfig.HitBoxSize = Vector3.new(5,3,5)
	ShortSwordWeaponConfig.AbilityName = "Projectile"
	ShortSwordWeaponConfig.Description = "Dagger, great at ranged. Ability: throwing knife with BaseDamage"..tostring(ShortSwordWeaponConfig.AbilityDamage)..", Cooldown: "..tostring(ShortSwordWeaponConfig.AbilityCooldown)
	-- Animations & Sounds
	ShortSwordWeaponConfig.SwingAnimations = {
        'rbxassetid://9991697436', --1
		'rbxassetid://9991581812', --2
        'rbxassetid://9991697436', --3
        'rbxassetid://9991378000', --4
        'rbxassetid://9991581812', --5
    }
	ShortSwordWeaponConfig.Textures = { -- Slash
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
	ShortSwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return ShortSwordWeaponConfig