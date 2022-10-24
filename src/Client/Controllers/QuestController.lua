-- Quest System Controller
-- Username
-- October 5, 2022


local QuestController = {}


function QuestController:Start()


	local StarterGui = game:GetService('StarterGui')
	local Player = game.Players.LocalPlayer
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local UserInputService = game:GetService("UserInputService") -- used to get clicks
	local TextService = game:GetService("TextService") -- this will be used to get the size of text
	local TweenService = game:GetService("TweenService")
	local ChatQueue = self.Shared.ChatQueueModule
	local QuestModule = self.Shared.QuestModule
	local QuestService = self.Services.QuestService
	local QuestConfigModule = self.Shared.Config.QuestConfigModule
	local ContextActionServce = game:GetService("ContextActionService")
	QuestController.isChatting = false-- sets up the table
	function QuestController:BarColor()
	return {
		PerformAction = function(object, QuestController)
			QuestController.state.barColor = object.Value
		end
	}
	end
	
	function QuestController:CancelQuest()
		return {
			PerformAction = function(object)
				if Player.Questing:FindFirstChild(object.Value) then
					QuestService:CancelQuest(object.Value)
				end
			end
		}
	end
	
	
	function QuestController:DoActions()
		return {
			Priority = 6,
			IsRandom = true,
			
			ShouldTakePath = function(object, QuestController)
				QuestController.performActions(object)
				return true
			end,
		}
	
	end
	
	function QuestController:Redirect()
		return {
			Priority = 5,
			
			ShouldTakePath = function(object, QuestController)
				if object:FindFirstChild("LockAfter") then
					table.insert(QuestController.state.lockedPaths, object.Value)
				end
				
				return true, object.Value
			end
		}
	end
	
	
	
	
	
	function QuestController:PickRandom()
	return {
		Priority = 0,
		IsRandom = true,
		
		ShouldTakePath = function(object)
			local options = {}
			local max = 0
			local allNumber = true
			
			for _, case in pairs(object:GetChildren()) do
				if case.Name:sub(1, 4):lower() == "case" then
					local isNumber = (case.ClassName == "NumberValue") and (case.Value > 0)
					allNumber = allNumber and isNumber
					if isNumber then
						max += case.Value
					end
					
					table.insert(options, {case, isNumber and case.Value or 1})
				end
			end
			
			local chosen;
			if #options > 0 then
				if allNumber then
					local rand = math.random() * max
					local entries = {}
					local runningVal = 0
					
					for _, case in ipairs(options) do
						table.insert(entries, {case[1], runningVal})
						runningVal += case[2]
					end
					
					for i = #entries, 1, -1 do
						local case = entries[i]
						if case[2] <= rand then
							chosen = case[1]
							break
						end
					end
					
					if not chosen then
						chosen = options[1][1]
					end
				else
					chosen = options[math.random(1, #options)][1]
				end
				
				return true, chosen
			else
				return false
			end
		end
	}
	end
	
	function QuestController:IfQuesting()
		return {
			Priority = 1,
			
			ShouldTakePath = function(object)
				return Player.Questing:FindFirstChild(object.Value)
			end
		}
	end
	
	
	function QuestController:IfQuested()
		return {
			Priority = 2,
			
			ShouldTakePath = function(object)
				return Player.Quested:FindFirstChild(object.Value)
			end
		}
	end
	
	function QuestController:IfEver()
		return {
			Priority = 4,
			
			ShouldTakePath = function(object)
				return Player.Questing:FindFirstChild(object.Value) or Player.Quested:FindFirstChild(object.Value)
			end
		}
	end
	
	
	function QuestController:IfComplete()
	 
		local quests = game:GetService("ReplicatedStorage").Quests
	
		local function checkIfQuestComplete(quest)
			local pair = Player.Questing:FindFirstChild(quest.Name)
			
			if pair then
				local data = QuestModule.getQuestData(quest)
			
				for objectiveName,objectiveData in pairs(data.Objectives) do
					if pair[objectiveName].Value < objectiveData.Amount then
						return
					end
				end
				
				return true
			end
		end
		
		return {
			Priority = 3,
			
			ShouldTakePath = function(object)
				return checkIfQuestComplete(quests[object.Value])
			end
		}
	
	
	end
	
	
	function QuestController:TeleportPlayer()
		return {	
			PerformAction = function(object)
				QuestService:TeleportPlayerByChat(object)
			end
		}
	end
	
	
	
	function QuestController:STYLE_TEMPLATE()
		return {
			PerformAction = function(object, QuestController)
				QuestController.state.template = object
			end
		}
	
	end
	
	function QuestController:ProceedChatQuest()
	
		return {	
			PerformAction = function(object)
				for _,quest in pairs(Player.Questing:GetChildren()) do
					for _,objective in pairs(quest:GetChildren()) do
						if objective.Type.Value == "Chat" then
							if objective.Targets:FindFirstChild(object.Value) then
								if objective.Max.Value > objective.Value then
									QuestService:ProceedChatQuest(object.Value)
								end
							end
						end
					end
					
				end
			end
		}
		
	end
	
	function QuestController:OpenGui()
	
		local guis = game:GetService("ReplicatedStorage"):FindFirstChild("GameGuis") or game:GetService("ReplicatedStorage"):FindFirstChild("Guis")
	
		return {
			PerformAction = function(object)
				if not Player.PlayerGui:FindFirstChild(object.Value) then
					local gui = guis:FindFirstChild(object.Value)
					
					if gui then
						local clone = gui:Clone()
						clone.Parent = Player.PlayerGui
					end
				end
			end
		}
	end
	
	function  QuestController:DoQuest()   
	return {	
		PerformAction = function(object)
			if ReplicatedStorage.Quests:FindFirstChild(object.Value) and (not Player.Questing:FindFirstChild(object.Value)) then
				QuestService:DoQuest(object.Value)
				
				StarterGui:SetCore("ChatMakeSystemMessage",
					{
						Text = string.format(QuestConfigModule.QuestChatNotificationMessage, object.Value);
						Color = QuestConfigModule.QuestChatNotificationColor;
						Font = QuestConfigModule.QuestNotificationFont;
						FontSize = 20;
					}
				)
			end
		end
	}   
	end
	
	
	function QuestController:CompleteQuest()
	local function checkIfQuestComplete(quest)
		local pair = Player.Questing:FindFirstChild(quest.Name)
		
		if pair then
			local data = QuestModule.getQuestData(quest)
		
			for objectiveName,objectiveData in pairs(data.Objectives) do
				if pair[objectiveName].Value < objectiveData.Amount then
					return
				end
			end
			
			return true
		end
	end
	
	return {	
		PerformAction = function(object)
			local quest = ReplicatedStorage.Quests:FindFirstChild(object.Value)
			if quest then
				if checkIfQuestComplete(quest) then
					QuestService:CompleteQuest(object.Value)
				end
			end
		end
	}
	end
	
	local GameConfig = self.Shared.Config.GameConfigModule
	
	if not QuestConfigModule.ChatTypeDefaults then -- polyfill
		QuestConfigModule.ChatTypeDefaults = {
			Default = {Type = "~"};
			IfComplete = {Type = "Quest", SymbolColor = Color3.fromRGB(239, 255, 83)};
			IfQuesting = {Type = "Quest", SymbolColor = Color3.fromRGB(110, 110, 110)};
		};
	end
	
	QuestController.chatSize = QuestConfigModule.ChatBubbleSize
	QuestController.maxDistance = QuestConfigModule.ChatMaxDistance
	QuestController.chatDelay = QuestConfigModule.ChatResponseDelay
	QuestController.canChatAgain = QuestConfigModule.ChatWaitTime
	QuestController.questColor = QuestConfigModule.ChatQuestColor
	QuestController.template = script:WaitForChild('Template')
	
	do
		local color = QuestController.template.Button:FindFirstChild("Color")
		if color then
			color.BackgroundColor3 = GameConfig.UI_Color
		end
	end
	
	local keyNames = 
	{
		Response = true;
		Type = true;
		IfQuested = true;
		IfQuesting = true;
		IfComplete = true;
		CompleteQuest = true;
		OpenGui = true;
		DoQuest = true;
		ProceedChatQuest = true;
		BarColor = true;
		Priority = true;
		STYLE_TEMPLATE = true;
		TeleportPlayer = true;
	}
	
	local actions = {['BarColor'] = QuestController:BarColor(),
	['CancelQuest'] = QuestController:CancelQuest(),
	['CompleteQuest'] = QuestController:CompleteQuest(),
	['DoQuest'] = QuestController:DoQuest(),
	['OpenGui'] = QuestController:OpenGui(),
	['ProceedChatQuest'] = QuestController:ProceedChatQuest(),
	['STYLE_TEMPLATE'] = QuestController:STYLE_TEMPLATE(),
	['TeleportPlayer'] = QuestController:TeleportPlayer(),}
	
	local controls = {['DoActions'] = QuestController:DoActions(),
	['IfComplete'] = QuestController:IfComplete(),
	['IfEver'] = QuestController:IfEver(),
	['IfQuested'] = QuestController:IfQuested(),
	['IfQuesting'] = QuestController:IfQuesting(),
	['PickRandom'] = QuestController:PickRandom(),
	['Redirect'] = QuestController:Redirect()}
	
	QuestController.canChats = {} -- chat debounces
	
	-- QuestController.state = {
	-- chatgui
	-- ChatQueue
	-- chatBillboard
	-- clickConnection
	-- lastNumberOfWords = nil; used in endChat to know how long to wait before removing the bubble
	
	-- template
	-- barColor 
	-- lockedPaths = {}
	--}
	
	local function getSizeOfText()
		if Player.PlayerGui:WaitForChild("MainGui").AbsoluteSize.Y > 1000 then
			return 34
		elseif Player.PlayerGui:WaitForChild("MainGui").AbsoluteSize.Y > 500 then
			return 28
		else
			return 24
		end
	end
	
	function QuestController.performActions(chatPath)
		for _, object in ipairs(chatPath:GetChildren()) do
			if object:IsA("LuaSourceContainer") then continue end
			
			local action = actions[object.Name]
			
			if action then
				action.PerformAction(object, QuestController)
			end
		end
	end
	
	function QuestController.determineChatPathNonRandom(chatPath)
		local chosen = nil
		local chosenPriority = -1
		
		for _, object in ipairs(chatPath:GetChildren()) do
			if object:IsA("LuaSourceContainer") then continue end
			
			local control = controls[object.Name]
			local priority = object:FindFirstChild("Priority")
			
			if priority then
				priority = priority.Value
			end
			
			if control and (chosenPriority < (priority or control.Priority)) then
				if control.IsRandom then continue end
				
				local shouldTake, altPath = control.ShouldTakePath(object, QuestController)
				local isLocked = false
				if QuestController.state then
					isLocked = table.find(QuestController.state.lockedPaths, altPath or object)
				end
				
				if shouldTake and not isLocked then
					chosenPriority = priority or control.Priority
					chosen = altPath or object
				end
			end
		end
		
		if not chosen then
			return chatPath
		else
			return QuestController.determineChatPath(chosen)
		end
	end
	function QuestController.determineChatPath(chatPath)
		local chosen = nil
		local chosenPriority = -1
		
		for _, object in ipairs(chatPath:GetChildren()) do
			if object:IsA("LuaSourceContainer") then continue end
			
			local control = controls[object.Name]
			local priority = object:FindFirstChild("Priority")
			
			if priority then
				priority = priority.Value
			end
			
			if control and (chosenPriority < (priority or control.Priority)) then
				local shouldTake, altPath = control.ShouldTakePath(object, QuestController)
				local isLocked = false
				if QuestController.state then
					isLocked = table.find(QuestController.state.lockedPaths, altPath or object)
				end
				
				if shouldTake and not isLocked then
					chosenPriority = priority or control.Priority
					chosen = altPath or object
				end
			end
		end
		
		if not chosen then
			return chatPath
		else
			return QuestController.determineChatPath(chosen)
		end
	end
	
	function QuestController.getChatSymbol(chatBranch, origin)
		local type;
		local color;
		local template = (chatBranch:FindFirstChild("STYLE_TEMPLATE") or QuestController.template)
		
		if chatBranch:FindFirstChild("Type") then
			type = chatBranch.Type.Value
			
			if chatBranch.Type:FindFirstChild("SymbolColor") then
				color = chatBranch.Type.SymbolColor
			end
		else
			local default = QuestConfigModule.ChatTypeDefaults[chatBranch.Name]
			
			if default then
				type = default.Type
				color = default.SymbolColor
			end
		end
		
		if (origin ~= chatBranch) and (not (type and color)) then
			return QuestController.getChatSymbol(origin, origin)
		end
		
		type = (type or QuestConfigModule.ChatTypeDefaults.Default.Type)
		color = (color or template.Button.TextColor3)
		
		return (
				(type == "Quest" and "?") or
				(type == "Notice" and "!") or
				(type == "Shop" and "$") or
				(typeof(type) == "string" and type)), color
	end
	
	local triangleSize = 20 -- add to settings later
	function QuestController.chat(chat)
		local response;
		local chatPath = chat
		local state = QuestController.state
		state.template = state.template or chat:FindFirstChild("STYLE_TEMPLATE") or QuestController.template
		
		chatPath = QuestController.determineChatPath(chatPath)
		QuestController.performActions(chatPath)
		
		if chatPath:FindFirstChild("Response") then
			response = chatPath.Response.Value
		else
			QuestController.endChat()
			return
		end
		
		if not state.chatBillboard then warn("there's no chat billboard!!!"); QuestController.endChat() return end
		if not state.chatGui then warn("there's no chat gui!!!"); QuestController.endChat() return end
		-- check if everything is there if not then don't chat
		if not state.ChatQueue then
			local chatBillboardCache = state.chatBillboard
			local myChatqueue = ChatQueue.new(QuestConfigModule.MaximumChatStack + 1, state.template, getSizeOfText(), QuestConfigModule.RetroChatBubbleSpacing, QuestConfigModule.RetroChatBubbleLifetime, QuestConfigModule.RetroTextAdditionalTransparency)
			state.ChatQueue = myChatqueue
			myChatqueue.drawn = function(self)
				chatBillboardCache.Size = UDim2.fromOffset(myChatqueue.frame.AbsoluteSize.X, myChatqueue.frame.AbsoluteSize.Y)
			end
			
			myChatqueue.frame.Name = "Responses"
			myChatqueue.frame.Parent = state.chatBillboard
			state.chatBillboard.Active = false -- so chat bubbles don't sink input
		else
			state.ChatQueue.template = state.template
		end
		
		QuestController.canChats[state.chatBillboard] = false
		QuestController.isChatting = true
		
		state.chatGui:ClearAllChildren()	
		state.lastNumberOfWords = #response:split(" ")
		
		local barColor3;
		if state.template.Button:FindFirstChild("Color") then
			barColor3 = state.barColor or state.template.Button.Color.BackgroundColor3
		end
		state.ChatQueue:enqueue({text = response, barColor = barColor3})
		
		do -- make things the Player says
			local sizeOfText = getSizeOfText()
			local saySort = {} -- sorting for say
			local says = {} -- table for what you say
			
			for _, saying in pairs(chatPath:GetChildren()) do
				if (not keyNames[saying.Name]) and (saying.ClassName == "StringValue") then
					table.insert(saySort,tonumber(saying.Name) or saying.Name)
				end
			end
			table.sort(saySort,function(a,b)
				a = tonumber(a) or 999
				b = tonumber(b) or 999
				
				return a > b
			end) -- sort the things you can say in order
			
			for order,name in pairs(saySort) do -- move everything to the say table
				local pair = chatPath:FindFirstChild(name)
				
				if pair then
					says[order] = pair
				end
			end
			
			local yPadding = workspace.CurrentCamera.ViewportSize.Y * (3.5/22)  -- start padding
			if #saySort > 0 then -- checks if you have anything to say
				task.wait(QuestController.chatDelay)
				
				for _, pair in ipairs(says) do -- go through everything you can say
					local saying = pair.Value
					local buttonBarColor;
					if state.template.Button:FindFirstChild("Color") then
						buttonBarColor = (pair:FindFirstChild("BarColor") and pair.BarColor.Value) or state.barColor or state.template.Button.Color.BackgroundColor3
					end
					
					local button = ChatQueue.createStyledLabel(saying, sizeOfText, buttonBarColor, nil, state.template)
					button.Position = UDim2.new(.5, 0, 1, -yPadding - button.AbsoluteSize.Y)
					button.AnchorPoint = Vector2.new(.5 , 0)
					button.AutoButtonColor = true
					button.Active = true
					button.Selectable = true



					

						button.Activated:Connect(function()
						QuestController.chat(pair)
						end)

				
					button.Parent = state.chatGui				
					yPadding = yPadding + button.AbsoluteSize.Y + 5
				end
				
			else
				if chatPath.Response:FindFirstChild("Response") then
					task.wait(QuestController.chatDelay)
					local responseObject = chatPath.Response
					local buttonBarColor;
					if state.template.Button:FindFirstChild("Color") then
						buttonBarColor = (responseObject:FindFirstChild("BarColor") and responseObject.BarColor.Value) or state.barColor or state.template.Button.Color.BackgroundColor3
					end
					local text = "continue"
					if UserInputService.GamepadEnabled then
						text = "Dpad down to continue"
					elseif UserInputService.KeyboardEnabled then
						text = "hit T to continue"
					else
						text = "continue"
					end

					local label = ChatQueue.createStyledLabel(text, sizeOfText, barColor3, nil, state.template)
					label.Size = label.Size + UDim2.new(0, 30, 0, 0)
					label.Position = UDim2.new(.5, 0, 1, -yPadding - label.AbsoluteSize.Y)
					label.AnchorPoint = Vector2.new(.5, 0)
					
					state.clickConnection = UserInputService.InputBegan:Connect(function(object,gpe)
						if ((object.KeyCode == Enum.KeyCode.T) or (object.KeyCode == Enum.KeyCode.DPadDown) or (object.UserInputType == Enum.UserInputType.Touch)) then
				
							state.clickConnection:Disconnect()
							state.clickConnection = nil
							QuestController.chat(chatPath.Response)
						end
					end)
					
					label.Parent = state.chatGui
				else -- no response = end chat
					QuestController.chat(chatPath.Response)
				end
			end
		end
	end
	
	function QuestController.displayChatStatus(text)
		local gui = Instance.new("ScreenGui")
		gui.Name = "chat-status: " .. text
		gui.ResetOnSpawn = false
		
		local textBounds = TextService:GetTextSize(text, 18, Enum.Font.Code, Vector2.new(math.huge, math.huge))
		local textLabel = Instance.new("TextLabel")
		textLabel.BorderSizePixel = 0
		textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = text
		
		textLabel.Size = UDim2.new()
		textLabel.TextSize = 18
		textLabel.Font = Enum.Font.Code
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.TextTransparency = 1
		textLabel.Position = UDim2.new(.5, 0, .8, 0)
		textLabel.AnchorPoint = Vector2.new(.5, 1)
		
		local tween = TweenService:Create(textLabel, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(textBounds.X + 10, textBounds.Y + 6), BackgroundTransparency = .4, TextTransparency = 0})
		textLabel.Parent = gui
		gui.DisplayOrder = 2
		gui.Parent = Player.PlayerGui
		tween:Play()
		task.delay(3, function()
			gui:Destroy()
		end)
	end
	
	function QuestController.endChat()
		if QuestController.isChatting then
			local state = QuestController.state
			
			if state.clickConnection then
				state.clickConnection:Disconnect()
				state.clickConnection = nil -- clear connection to prevent memory leaks
			end
			
			QuestController.isChatting = false
			QuestController.canChats[state.chatBillboard] = false
			-- disable and remove some stuff so  you can't chat
			
			if state.chatGui then
				state.chatGui:Destroy()
			end
			
			local waitTime = math.clamp((state.lastNumberOfWords or 0) * .5, QuestController.canChatAgain/2, 18.5)
			task.wait(waitTime)
			
			if state.chatBillboard then -- remove what the person is saying
				if state.ChatQueue then
					state.ChatQueue:kill()
				end
				
				local responseFrame = state.chatBillboard:FindFirstChild("Responses")
				if responseFrame then
					responseFrame:Destroy()
				end
				
				state.chatBillboard.Button.Visible = false
				state.chatBillboard.AlwaysOnTop = false
			end
			
			task.wait(QuestController.canChatAgain)
			-- reactivate chatting
			
			QuestController.canChats[state.chatBillboard] = true
			state.chatBillboard.Size = UDim2.new(QuestController.chatSize.X, 0, QuestController.chatSize.Y * 1.25, 0)
			state.chatBillboard.SizeOffset = Vector2.new(0,.5)
			state.chatBillboard.Button.Visible = true
			state.chatBillboard.Active = true -- because when a chat starts it's disabled
		end
	end
	
	
	
	
	
	
	end
	

return QuestController