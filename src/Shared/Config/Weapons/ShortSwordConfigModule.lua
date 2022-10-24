-- Bronze Sword Config Module
-- Username
-- September 29, 2022



local ShortSwordWeaponConfig = {}
ShortSwordWeaponConfig.TagName = "ShortSword"
ShortSwordWeaponConfig.DisplayName = "Short Sword"
ShortSwordWeaponConfig.HumanoidToKill = ("Enemy")
	ShortSwordWeaponConfig.WalkSpeed = 20
	ShortSwordWeaponConfig.JumpHeight = 15
	ShortSwordWeaponConfig.MaxDamage = 3
	ShortSwordWeaponConfig.MinDamage = 2
	ShortSwordWeaponConfig.AbilityRunSpeed = 30
	ShortSwordWeaponConfig.Cooldown = 0.3
	ShortSwordWeaponConfig.Cost = 200
	ShortSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	ShortSwordWeaponConfig.ProjectileName = "BigFireball"
	ShortSwordWeaponConfig.AbilityForce = 150
	ShortSwordWeaponConfig.AbilityCooldown = 15
	ShortSwordWeaponConfig.AbilityDebrisTimer = 5
	ShortSwordWeaponConfig.PlayerKnockbackVelocity = 10
	ShortSwordWeaponConfig.ComboResetTimer = 1.5
	ShortSwordWeaponConfig.HitBoxSize = Vector3.new(10,3,10)
	ShortSwordWeaponConfig.AbilityName = "FastRun"
	ShortSwordWeaponConfig.Description = "Feather weight Sword that does minimal damage but is fast. Special Ability allows you to sprint for"..tostring(ShortSwordWeaponConfig.AbilityDebrisTimer).." Seconds, Cooldown: "..tostring(ShortSwordWeaponConfig.AbilityCooldown)
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