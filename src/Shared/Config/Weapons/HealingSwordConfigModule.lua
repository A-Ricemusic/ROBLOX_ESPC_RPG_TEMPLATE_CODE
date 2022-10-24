-- Bronze Sword Config Module
-- Username
-- September 29, 2022



local SilverSwordWeaponConfig = {}
SilverSwordWeaponConfig.TagName = "HealingSword"
SilverSwordWeaponConfig.DisplayName = "Healing Sword"
SilverSwordWeaponConfig.HumanoidToKill = ("Enemy")
	SilverSwordWeaponConfig.WalkSpeed = 18
	SilverSwordWeaponConfig.JumpHeight = 10
	SilverSwordWeaponConfig.MaxDamage = 5
	SilverSwordWeaponConfig.MinDamage = 3
	SilverSwordWeaponConfig.AbilityDamage = 0
	SilverSwordWeaponConfig.HealAmount = 20
	SilverSwordWeaponConfig.Cooldown = 0.7
	SilverSwordWeaponConfig.Cost = 200
	SilverSwordWeaponConfig.ProjectileCooldown = 1
	SilverSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	SilverSwordWeaponConfig.AbilityForce = 100
	SilverSwordWeaponConfig.AbilityCooldown = 20
	SilverSwordWeaponConfig.AbilityDebrisTimer = 2
	SilverSwordWeaponConfig.PlayerKnockbackVelocity = 10
	SilverSwordWeaponConfig.ComboResetTimer = 1.5
	SilverSwordWeaponConfig.HitBoxSize = Vector3.new(10,3,7)
	SilverSwordWeaponConfig.AbilityName = "Heal"
	SilverSwordWeaponConfig.Description = "Light Weight Sword, Ability: Heal by "..tostring(SilverSwordWeaponConfig.HealAmount).." Health, Cooldown: "..tostring(SilverSwordWeaponConfig.AbilityCooldown)

	-- Animations & Sounds
	SilverSwordWeaponConfig.SwingAnimations = {
		'rbxassetid://9991581812', --1
        'rbxassetid://9991378000', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9820421213', --4
        'rbxassetid://9991697436', --5
    }
	SilverSwordWeaponConfig.Textures = { -- Slash
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
	SilverSwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return SilverSwordWeaponConfig