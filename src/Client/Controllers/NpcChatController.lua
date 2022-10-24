--[[
	Made by:
		Danrich123
	
	This generates chat bubbles and handles quest doors
--]]

local NpcChatController = {}
function NpcChatController:Start()
    

	local QaCSettings = self.Shared.Config.QuestConfigModule
	local collectionService = game:GetService("CollectionService")
	local heartbeat = game:GetService("RunService").Heartbeat -- I just remembered that wait() is unreliable
	
	repeat heartbeat:Wait() until game:IsLoaded() --- wait for game to load
	game.Players.LocalPlayer:WaitForChild("Quested")
	
	local player = game.Players.LocalPlayer
	local QuestController = self.Controllers.QuestController
	
	
	local quested = player:WaitForChild("Quested")
	local questing = player:WaitForChild("Questing")
	
	-- right now color changing for mouse input doesn''t work for mobile
	local mouseHoverOffset = -.1
	local mouseDownOffset = .1
	
	local chatboardList = {}
	local function processChat(chat)
		task.wait(0.5)
		local package = {chat = chat, branch = QuestController.determineChatPathNonRandom(chat)} -- gui = billboard
		local template = package.branch:FindFirstChild("STYLE_TEMPLATE") or QuestController.template
		template.Enabled = false
		
		local isDown = false
		local billboard = template:Clone()
		
		billboard.Size = UDim2.new(QuestController.chatSize.X, 0, QuestController.chatSize.Y * 1.25,0) -- multiply by x to account for the triangle
		billboard.MaxDistance = QuestController.maxDistance + 10
		billboard.Active = true
		billboard.ResetOnSpawn = false
		billboard.SizeOffset = Vector2.new(0,.5)
		billboard.Enabled = true
		
		local button = billboard.Button
		
		do
			local symbol, color = QuestController.getChatSymbol(package.branch, package.chat)
			button.Text = symbol
			button.TextColor3 = color
		end
		button.Active = false
		button.AutoButtonColor = false
		
		local triangle = button:FindFirstChild("Triangle")
		if button:FindFirstChild("Color") then
			local barColor = (package.branch:FindFirstChild("BarColor") and package.branch.BarColor.Value) or template.Button.Color.BackgroundColor3
			if button.Color.ClassName == "Frame" then
				button.Color.BackgroundColor3 = barColor
			elseif button.Color.ClassName == "ImageLabel" then
				button.Color.ImageColor3 = barColor
			end
		end
		
		button.Name = "Button"
		billboard.Name = "ChatBillboard" .. chat.Parent.Name
		
		button.Parent = billboard
		
		billboard.Adornee = chat.Parent:FindFirstChild("Head") or chat.Parent
		billboard.Parent = player:WaitForChild("PlayerGui")
		
		button.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.MouseButton1) then
				local offset = (input.UserInputType == Enum.UserInputType.MouseMovement) and mouseHoverOffset or mouseDownOffset
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isDown = true
				end
				
				button.BackgroundColor3 = Color3.new(math.clamp(template.Button.BackgroundColor3.r + offset, 0, 1),
					math.clamp(template.Button.BackgroundColor3.g + offset, 0, 1),
					math.clamp(template.Button.BackgroundColor3.b + offset, 0, 1))
				if triangle then
					triangle.ImageColor3 = Color3.new(math.clamp(template.Button.Triangle.ImageColor3.r + offset, 0, 1),
						math.clamp(template.Button.Triangle.ImageColor3.g + offset, 0, 1),
						math.clamp(template.Button.Triangle.ImageColor3.b + offset, 0, 1))
				end
			end
		end)
		
		button.InputEnded:Connect(function(input)
			if  (input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.MouseButton1) then
				local offset = (input.UserInputType == Enum.UserInputType.MouseMovement) and 0 or ((isDown and mouseHoverOffset) or 0)
				isDown = false
				
				button.BackgroundColor3 = Color3.new(math.clamp(template.Button.BackgroundColor3.r + offset, 0, 1),
					math.clamp(template.Button.BackgroundColor3.g + offset, 0, 1),
					math.clamp(template.Button.BackgroundColor3.b + offset, 0, 1))
				if triangle then
					triangle.ImageColor3 = Color3.new(math.clamp(template.Button.Triangle.ImageColor3.r + offset, 0, 1),
						math.clamp(template.Button.Triangle.ImageColor3.g + offset, 0, 1),
						math.clamp(template.Button.Triangle.ImageColor3.b + offset, 0, 1))
				end
			end
		end)
		
		QuestController.canChats[billboard] = true
		-- mousebutton1click is being used because it works without Active set to true
		-- and when Active is set to true scrolling input is sinked
		-- so to prevent then Active is set to false and mousebutton1click is used
		button.MouseButton1Click:Connect(function()
			if (not QuestController.isChatting) and (QuestController.canChats[billboard]) then
				local chatGui = Instance.new("ScreenGui")
				chatGui.Name = "ChatGui"
				chatGui.DisplayOrder = 1
				chatGui.Parent = player:WaitForChild("PlayerGui")
				
				QuestController.state = {
					chatGui = chatGui,
					chatBillboard = billboard,
					lockedPaths = {},
				}
				
				QuestController.isChatting = true
				billboard.AlwaysOnTop = true
				button.Visible = false
				
				QuestController.chat(chat)
			end
		end)
		
		package.gui = billboard
		table.insert(chatboardList, package)
	end
	
	do
		local function updateChatBillboards()
			for _, package in ipairs(chatboardList) do
				local newpath = QuestController.determineChatPathNonRandom(package.chat)
				
				if newpath ~= package.branch then
					package.branch = newpath
					
					local symbol, color = QuestController.getChatSymbol(package.branch, package.chat)
					package.gui.Button.Text = symbol
					package.gui.Button.TextColor3 = color
				end
			end
		end
		
		for _, quest in ipairs(questing:GetChildren()) do
			for _, value in ipairs(quest:GetChildren()) do
				value.Changed:Connect(updateChatBillboards)
			end
		end
		
		questing.ChildAdded:Connect(function(quest)
			heartbeat:Wait() -- for replication
			
			for _, value in ipairs(quest:GetChildren()) do
				value.Changed:Connect(updateChatBillboards)
			end
			updateChatBillboards()
		end)
		questing.ChildRemoved:Connect(updateChatBillboards)
		quested.ChildAdded:Connect(updateChatBillboards)
	end
	
	local function processQuestDoor(door)
		local questedToEnter = door:FindFirstChild("QuestedToEnter")
		local doorPart = door.PrimaryPart or door:FindFirstChild("Door")
		
		if questedToEnter and doorPart then
			do -- labeling
				local label = door:FindFirstChild("Label")
				if label then
					local board = label:FindFirstChild("board")
					if board then
						local textLabel = board:FindFirstChild("label")
						if textLabel then
							local description;
							if door:FindFirstChild("Description") then
								description = door.Description.Value
							else
								description = "Finish \"" .. questedToEnter.Value .. "\""
							end
							
							textLabel.Text = description
						end
					end
				end
			end
			
			doorPart.Touched:Connect(function(hit)
				if hit.Parent == player.Character then
					if doorPart.CanCollide then -- it's closed
						if quested:FindFirstChild(questedToEnter.Value) then
							doorPart.CanCollide = false
							doorPart.Transparency = doorPart.Transparency + .3
							
							wait(QaCSettings.DoorOpenTime or 5)
							doorPart.CanCollide = true
							doorPart.Transparency = doorPart.Transparency - .3
						end
					end
				end
			end)
		end
	end
	
	for _, door in ipairs(collectionService:GetTagged("quest-door")) do
		processQuestDoor(door)
	end
	collectionService:GetInstanceAddedSignal("quest-door"):Connect(processQuestDoor)
	
	for _, chat in ipairs(collectionService:GetTagged("chat")) do
		processChat(chat)
	end
	collectionService:GetInstanceAddedSignal("chat"):Connect(processChat)
	
	
	
	
	local running = false
	
	
	local Player = game.Players.LocalPlayer
	local Character = Player.Character
	local humanoid = Character:FindFirstChildOfClass("Humanoid")
	local root = Character.PrimaryPart
	
	humanoid.Running:Connect(function(speed)
		if speed > 0 then
			running = true
			
			if QuestController.isChatting then
				repeat
					task.wait(.5)
					if QuestController.isChatting then
						local state = QuestController.state
						if state and state.chatBillboard then
							local adornee = state.chatBillboard.Adornee
							
							if adornee:IsA("BasePart") then
								local distance = (adornee.Position - root.Position).Magnitude
								
								if distance > QuestController.maxDistance then
									QuestController.displayChatStatus("chat ended because you walked away")
									QuestController.endChat()
								end
							elseif adornee:IsA("Model") then
								if adornee.PrimaryPart then
									local distance = (adornee.PrimaryPart.Position - root.Position).Magnitude
									
									if distance > QuestController.maxDistance then
										QuestController.displayChatStatus("chat ended because you walked away")
										QuestController.endChat()
									end
									
								end
							end
						end
					else
						break
					end
				until (not running) or (not script.Parent)
			end
		else
			running = false
		end
			
	end)
	
	humanoid.Died:Connect(function()
		if QuestController.isChatting then
			humanoid = nil
			root = nil
			running = nil -- just in case
			Player = game.Players.LocalPlayer -- so the removal of the character won't stop the function
			QuestController.displayChatStatus("chat ended because you died")
			QuestController.endChat()
		end
	end)
	
	
	--[[do
		local waitTerval = 0
		
		local function find(parent)
			if willWait then
				if waitTerval > waitForEach then
					heartbeat:Wait()
					waitTerval = 0
				else
					waitTerval = waitTerval + 1
				end
			end
			
			for _, thing in pairs(parent:GetChildren()) do
				if (thing.Name == "Chat") and ((thing.ClassName == "Folder") or (thing.ClassName == "Model") or (thing.ClassName == "Configuration")) then
					processChat(thing)
				else
					find(thing)
				end
			end
		end
		
		find(workspace)
	end]]
	end
return NpcChatController