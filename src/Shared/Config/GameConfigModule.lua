-- Game Config Module
-- Username
-- October 5, 2022



local GameConfigModule = {

	-- Main Configuration
	
	Game_Title = "MY RPG";
	Game_Version = "1.0.0";
	Game_CircuitV = "Beta";
	
	-- Leaderstats & Data Saving
	
	Level_Max = tonumber(1_000_000);
	ToolStorage = game.ReplicatedStorage.GameItems;
	
	-- Game UI

	UI_Color = BrickColor.new("White").Color; -- The highlighted color of the GUIs.
	UI_Theme = "Dark" -- Currently only Dark is available, in the future may there be light.


}


return GameConfigModule