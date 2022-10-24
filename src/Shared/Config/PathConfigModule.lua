-- Game Config Module
-- Username
-- October 5, 2022

local ConfigDirs = game:GetService("ReplicatedStorage").Aero.Shared.Config

local PathConfigModule = {
['Goblin'] =  ConfigDirs.GoblinConfig.GoblinConfigModule,
['Paladin'] =  ConfigDirs.PaladinConfig.PaladinConfigModule,
['Siba'] =  ConfigDirs.SibaConfig.SibaConfigModule,
['GiantSpider'] =  ConfigDirs.GiantSpiderConfig.GiantSpiderConfigModule,
['CursedKnight'] =  ConfigDirs.CursedKnightConfig.CursedKnightConfigModule,
['SkeletonMele'] =  ConfigDirs.SkeletonConfig.SkeletonConfigMeleModule,
['SkeletonRange'] =  ConfigDirs.SkeletonConfig.SkeletonConfigRangeModule,
['KillBlock'] = ConfigDirs.KillBlockConfig.KillBlockConfigModule,
['FireSword'] = ConfigDirs.Weapons.FireSwordConfigModule,
['RegularSword'] = ConfigDirs.Weapons.RegularSwordConfigModule,
['BlazeSword'] = ConfigDirs.Weapons.BlazeSwordConfigModule,
['HealingSword'] = ConfigDirs.Weapons.HealingSwordConfigModule,
['HeavySword'] = ConfigDirs.Weapons.HeavySwordConfigModule,
['ShortSword'] = ConfigDirs.Weapons.ShortSwordConfigModule,
['Dagger'] = ConfigDirs.Weapons.DaggerConfigModule,
['UltimateSword'] = ConfigDirs.Weapons.UltimateSwordConfigModule,

}

return PathConfigModule