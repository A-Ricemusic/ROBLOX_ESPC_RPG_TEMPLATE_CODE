-- Bronze Sword Config Module
-- Username
-- September 29, 2022



RegularSwordConfigModule = {}
RegularSwordConfigModule.TagName = "RegularSword"
RegularSwordConfigModule.DisplayName = "Regular Sword"
RegularSwordConfigModule.HumanoidToKill = ("Enemy")
	RegularSwordConfigModule.WalkSpeed = 22
	RegularSwordConfigModule.JumpHeight = 12
	RegularSwordConfigModule.MaxDamage = 4
	RegularSwordConfigModule.MinDamage = 3
	RegularSwordConfigModule.AbilityDamage = 3
	RegularSwordConfigModule.Cooldown = 0.7
	RegularSwordConfigModule.Cost = 0
	RegularSwordConfigModule.ProjectileAnimation = "rbxassetid://10149103707"
	RegularSwordConfigModule.ProjectileName = "BasicFireball"
	RegularSwordConfigModule.AbilityForce = 100
	RegularSwordConfigModule.AbilityCooldown = 1
	RegularSwordConfigModule.AbilityDebrisTimer = 2
	RegularSwordConfigModule.PlayerKnockbackVelocity = 35
	RegularSwordConfigModule.ComboResetTimer = 1.2
	RegularSwordConfigModule.HitBoxSize = Vector3.new(10,5,10)
	RegularSwordConfigModule.AbilityName = "None"
	RegularSwordConfigModule.Description = "Lightweight and versitile sword, Ability: None"

	-- Animations & Sounds
	RegularSwordConfigModule.SwingAnimations = {
        'rbxassetid://9820421213', --1
        'rbxassetid://9991378000', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9820421213', --4
        'rbxassetid://9991697436', --5
    }
	RegularSwordConfigModule.Textures = { -- Slash
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
	RegularSwordConfigModule.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return RegularSwordConfigModule