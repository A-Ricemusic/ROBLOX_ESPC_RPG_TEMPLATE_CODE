-- Sword Rank Config Module
-- Username
-- October 10, 2022



local SwordRankConfigModule = {
    ["Rusty"] = {["AbilityMultiply"] = 1,["AbilityDamage"] = 0,["ATTACK_DAMAGE"] = 0,["WalkSpeed"] = 0,["Health"] = 0,["Cost"] = 0, ["Color"] = Color3.fromRGB(71, 43, 0)},
    ["Iron"] = {["AbilityMultiply"] = 1.2,["AbilityDamage"] = 0,["ATTACK_DAMAGE"] = 5,["WalkSpeed"] = 2,["Health"] = 10,["Cost"] = 1000, ["Color"] = Color3.fromRGB(126, 126, 126)},
    ["Bronze"] = {["AbilityMultiply"] = 1.4,["AbilityDamage"] = 0,['ATTACK_DAMAGE'] = 10,["WalkSpeed"] = 5,["Health"] = 20,["Cost"] = 2000, ["Color"] = Color3.fromRGB(104, 71, 0)},
    ["Silver"] = {["AbilityMultiply"] = 1.6,["AbilityDamage"] = 0,['ATTACK_DAMAGE'] = 15,["WalkSpeed"] = 10,["Health"] = 30,["Cost"] = 3000, ["Color"] =Color3.fromRGB(255, 255, 255)},
    ["Gold"] = {["AbilityMultiply"] = 1.8,["AbilityDamage"] = 0,['ATTACK_DAMAGE'] = 20,["WalkSpeed"] = 15,["Health"] = 40,["Cost"] = 50000, ["Color"] =  Color3.fromRGB(255, 145, 0) },
    ["Legendary"] = {["AbilityMultiply"] = 2,["AbilityDamage"] = 0,['ATTACK_DAMAGE'] = 30,["WalkSpeed"] = 25,["Health"] = 50,["Cost"] = 100000,  Color3.fromRGB(160, 0, 99)},
}


return SwordRankConfigModule