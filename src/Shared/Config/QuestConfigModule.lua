-- Quest Config Module
-- Username
-- October 5, 2022



local QuestConfigModule = {uestNotifications = true; -- if a player has unviewed quests a label will appear on the quest button displaying how many quests they haven't seen
	QuestChatNotification = true; -- if a player starts a quest it will appear in the chat (only for them).
		QuestChatNotificationFont = Enum.Font.SourceSansBold; -- font of the text in the chat
		QuestChatNotificationColor = Color3.fromRGB(0, 255, 0); -- color of the text in the chat
		QuestChatNotificationMessage = "Quest '%s' started."; -- what message will be displayed. %s is the name of the quest
	
	DoorOpenTime = 5; -- how long quest doors stay open
	
	ChatTypeDefaults = {
		Default = {Type = "~"};
		IfComplete = {Type = "Quest", SymbolColor = Color3.fromRGB(239, 255, 83)};
		IfQuesting = {Type = "Quest", SymbolColor = Color3.fromRGB(110, 110, 110)};
		--IfQuested = {Type = "Notice"};
	};
	
	RetrospectiveChat = true; -- things NPC said before will still appear (like in roblox's dialog system)
		MaximumChatStack = 2; -- how many chat bubbles can stack on top of eachother
		RetroChatBubbleLifetime = 6; -- how long the chat bubbles last
		RetroChatBubbleSpacing = 5; -- distance between each chat bubble in offset
		RetroTextAdditionalTransparency = .5;
	
	PlayerResponseBubblesEnabled = true; -- if the player has a bubble appear on top of them when they respond
	
	ChatBubbleSize = Vector2.new(2,2);  -- the size of the floating chat thing
	ChatMaxDistance = 10; -- the maximum distance you can chat at
	ChatResponseDelay = 1; -- how long you have to wait till you can pick an option for chatting
	ChatWaitTime = 3; -- how long you have to wait till you can chat again after chatting
	
	BasicGrammar = true;
		-- if this is true then the system will use an extremely basic grammar system thing
		-- if this is fales then the system won't
}

return QuestConfigModule