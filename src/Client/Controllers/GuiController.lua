-- Gui Controller
-- Username
-- October 13, 2022



local GuiController = {}


-- CONFIG

-- Turn this off if you don't want the progress bar to follow the UI_Color in gameConfig.
local AUTO_COLOR_PROGRESS_BAR = true

-- MAIN STUFf

function GuiController:CreateGui()
local gameConfig =  self.Shared.Config.GameConfigModule
local QaCSettings =  self.Shared.Config.QuestConfigModule-- get quest and chat settings
local questify = self.Shared.QuestModule
local Players = game.Players
local player = Players.LocalPlayer
local character = player.Character
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- replicated storage is a storage
local mouse = player:GetMouse() -- get the players mouse
local quests = ReplicatedStorage:WaitForChild("Quests")
local questing = player:WaitForChild("Questing")
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = ReplicatedStorage.Gui.MainGui:Clone()
MainGui.Parent = PlayerGui
local questsFrame = MainGui:WaitForChild("QuestsFrame")-- the  QuestsFrame
local questContainer = questsFrame:WaitForChild("Container") -- use this to show the quest you are doing
local dragButton = questsFrame:WaitForChild("Drag",10) -- use this for dragging
local containerUILayout = questContainer:WaitForChild("UIListLayout")
local questTemplate = ReplicatedStorage.Gui.QuestTemplate:Clone()
local objectiveTemplate = questTemplate:WaitForChild("ObjectiveTemplate")
local OpenQuestsButton = MainGui:WaitForChild("OpenQuests")
local notifications = 0
local notification = OpenQuestsButton.Notification

    local guiPlayer = Instance.new("BillboardGui",character)
        guiPlayer.Adornee = character:WaitForChild("Head")
        guiPlayer.Active = true
        guiPlayer.AlwaysOnTop = true
        guiPlayer.Enabled = true
        guiPlayer.Size = UDim2.new(0,100,0,100)
        guiPlayer.ResetOnSpawn = true
        guiPlayer.ExtentsOffsetWorldSpace = Vector3.new(0,5,0)
    local text = Instance.new("TextLabel",guiPlayer)
        text.Text = player.Name.." Level:  "..tostring(player.leaderstats.Level.value)
        text.Size = UDim2.new(0,50,0,50)
        text.Visible = true
        text.Selectable = false
        text.TextWrapped = false
        text.TextScaled = false
        text.TextSize = 15
        text.BackgroundTransparency = 1
    text.TextColor = BrickColor.new("Wheat")



questsFrame:WaitForChild("Close").Activated:Connect(function()
questsFrame.Visible = false
end)

do -- dragging stuff
local userInputService = game:GetService("UserInputService") -- UserInputService is a service used to get input from a player's device

local x,y = mouse.X,mouse.Y -- the position of the mouse
local isDragging = false -- a boolean to tell if the QuestFrame is being dragged

dragButton.InputBegan:Connect(function(input) --- when the dragButton recieves input
    if (input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch) then -- if its mouse or touch input
        x,y = input.Position.X,input.Position.Y -- sets the starting position of the drag
        isDragging = true
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
                connection:Disconnect()
            end
        end)
    end
end)



OpenQuestsButton:WaitForChild("NotColor").BackgroundColor3 = gameConfig.UI_Color:lerp(Color3.new(0,0,0),.75)
OpenQuestsButton.NotColor:WaitForChild("Glow").ImageColor3 = gameConfig.UI_Color

OpenQuestsButton.Activated:Connect(function()
	questsFrame.Visible = not questsFrame.Visible
	
	if questsFrame.Visible then
		notification.Visible = false
		notifications = 0
	end
end)

questsFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	if questsFrame.Visible then
		OpenQuestsButton.NotColor.Glow.Visible = true
		OpenQuestsButton.NotColor.BackgroundTransparency = 1
	else -- if it isn't
		OpenQuestsButton.NotColor.Glow.Visible = false
		OpenQuestsButton.NotColor.BackgroundTransparency = 0
	end
end)

-- Notifications
questing.ChildAdded:Connect(function()
	if QaCSettings.QuestNotifications and (not questsFrame.Visible) then
		notifications += 1
		notification.Text = notifications
		notification.Visible = true
	end
end)

userInputService.InputChanged:Connect(function(input)
    if isDragging then -- if QuestFrame is being dragged
        if (input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch) then -- if the mouse is moving or finger drgging
            local difX,difY = input.Position.X - x,input.Position.Y - y -- difference in the mouse positions
            x,y = input.Position.X,input.Position.Y -- sets the position of the drag
            
            questsFrame.Position = questsFrame.Position + UDim2.new(0,difX,0,difY) -- move the QuestFrame
            do -- clamp the QuestFrame
                local xChange = 0
                local yChange = 0
                
                if questsFrame.AbsolutePosition.X + questsFrame.AbsoluteSize.X > MainGui.AbsoluteSize.X then
                    xChange = 
                        MainGui.AbsoluteSize.X - (questsFrame.AbsolutePosition.X + questsFrame.AbsoluteSize.X)
                end
                if questsFrame.AbsolutePosition.X < 0 then
                    xChange = -questsFrame.AbsolutePosition.X
                end
                
                if questsFrame.AbsolutePosition.Y + questsFrame.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
                    yChange = 
                        MainGui.AbsoluteSize.Y - (questsFrame.AbsolutePosition.Y + questsFrame.AbsoluteSize.Y)
                end
                if questsFrame.AbsolutePosition.Y < 0 then
                    yChange = -questsFrame.AbsolutePosition.Y
                end
                
                questsFrame.Position = questsFrame.Position + UDim2.new(0,xChange,0,yChange)
                x = x + xChange
                y = y + yChange
            end
            
            
        end
    end
end)
end

--------- QUEST STUFF

local function visualize() -- do every quest change
for _, v in ipairs(questContainer:GetChildren()) do
    if v.ClassName == questTemplate.ClassName then
        v:Destroy()
    end
end

for _, questProgress in ipairs(questing:GetChildren()) do
    local realQuest = quests:FindFirstChild(questProgress.Name)
    if realQuest then
        local questInfo = questify.getQuestData(realQuest)
        
        local frame = questTemplate:Clone()
        frame.Name = questProgress.Name
        frame.Title.Text = questProgress.Name
        
        for _, objective in ipairs(questProgress:GetChildren()) do
            local objectiveFrame = objectiveTemplate:Clone()
            objectiveFrame.Name = objective.Name
            objectiveFrame.Title.Text =
                questInfo.Objectives[objective.Name].Description .. " ("..objective.Value.."/"..questInfo.Objectives[objective.Name].Amount.." - "..string.sub(objective.Value/questInfo.Objectives[objective.Name].Amount * 100,1,5).."%)"
            objectiveFrame.BarFrame.Bar.Size = UDim2.new(objective.Value / questInfo.Objectives[objective.Name].Amount,0,1,0)
            
            if AUTO_COLOR_PROGRESS_BAR then
                objectiveFrame.BarFrame.BackgroundColor3 = gameConfig.UI_Color
                objectiveFrame.BarFrame.Bar.BackgroundColor3 = gameConfig.UI_Color
            end
            
            objectiveFrame.Parent = frame
        end
        
        frame.Size = UDim2.new(1, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 10)
        frame.Parent = questContainer
    end
end

questContainer.CanvasSize = UDim2.new(0,0,0, containerUILayout.AbsoluteContentSize.Y + 10)
end

visualize()

for _,quest in pairs(questing:GetChildren()) do
for _,value in pairs(quest:GetChildren()) do
    value.Changed:Connect(visualize)
end
end

questing.ChildAdded:Connect(function(thing)
task.wait() -- you have to wait because for some reason the quest folder loads in first (it's then parented to the quest folder) then the objectives in it load
visualize()

for _,value in pairs(thing:GetChildren()) do
    value.Changed:Connect(visualize)
end
end)
questing.ChildRemoved:Connect(visualize)

if AUTO_COLOR_PROGRESS_BAR then
questContainer.ScrollBarImageColor3 = gameConfig.UI_Color
end

local humanoid = character:WaitForChild("Humanoid",10) 
 

humanoid.Died:Connect(function()
local MainGui = nil
local questsFrame = nil
local questContainer = nil
local dragButton =  nil
local containerUILayout = nil
local questTemplate = nil
local objectiveTemplate = nil
local OpenQuestsButton = nil
local notification = nil
end)

end


function GuiController:Init()
	
	local Players = game.Players
	local player = Players.LocalPlayer
	player.CharacterAdded:Connect(function()
		GuiController:CreateGui()
	end)
	
end


return GuiController