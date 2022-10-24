-- Mob Rank Config Module
-- Username
-- October 10, 2022



local MobRankConfigModule = {
    [""] = {["Gold"] = 0,["Xp"] = 0,["ATTACK_DAMAGE"] = 0,["WalkSpeed"] = 0,["Health"] = 0,["Size"] = 1},
    ["Grunt"] = {["Gold"] = 0,["Xp"] = 0,["ATTACK_DAMAGE"] = 0,["WalkSpeed"] = 0,["Health"] = 0,["Size"] = 1},
    ["Officer"] = {["Gold"] = 10,["Xp"] = 20,["ATTACK_DAMAGE"] = 5,["WalkSpeed"] = 2,["Health"] = 10,["Size"] = 1},
    ["Commander"] = {["Gold"] = 30,["Xp"] = 40,['ATTACK_DAMAGE'] = 10,["WalkSpeed"] = 5,["Health"] = 10,["Size"] = 1},
    ["General"] = {["Gold"] = 60,["Xp"] = 80,['ATTACK_DAMAGE'] = 20,["WalkSpeed"] = 10,["Health"] = 20,["Size"] = 1},
    ["Lord"] = {["Gold"] = 100,["Xp"] = 100,['ATTACK_DAMAGE'] = 30,["WalkSpeed"] = 20,["Health"] = 30,["Size"] = 1}
}



return MobRankConfigModule