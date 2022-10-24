-- Chat Quene Module
-- Username
-- October 5, 2022



local ChatQueueModule = {}

ChatQueueModule.__index = ChatQueueModule

local triangleSize = 20

-- data is {text = text, ?barColor = barColor}
function ChatQueueModule:enqueue(data)
	if data == nil then return end
	table.insert(self.queue, 1, data)
	if #self.queue > self.capacity then
		self:dequeue()
	end
	if #self.queue > 1 then
		delay(self.bubbleLifetime, function()
			if self.alive then
				self:dequeue()
			end
		end)
	end
	
	self:redraw()
end

function ChatQueueModule:dequeue()
	table.remove(self.queue)
	self:redraw()
end

function ChatQueueModule:redraw()
	if not self.frame.Parent then return end
	
	local totalY = 0
	local maxX = 0
	self.frame:ClearAllChildren()
	
	if self.template.Button:FindFirstChild("Triangle") then
		local triangle = Instance.new("ImageLabel")
		
		triangle.BackgroundTransparency = 1
		triangle.Size = UDim2.new(0, triangleSize, 0, triangleSize)
		triangle.Position = UDim2.new(.5, 0, 1, 0)
		triangle.AnchorPoint = Vector2.new(.5, 1)
		
		triangle.Image = self.template.Button.Triangle.Image
		triangle.ImageColor3 = self.template.Button.Triangle.ImageColor3
		
		triangle.Name = "Triangle"
		triangle.Parent = self.frame
		totalY = totalY + triangleSize
	end
	
	for i = 1, #self.queue do
		local d = self.queue[i]
		local label = ChatQueueModule.createStyledLabel(d.text, self.textSize, d.barColor, (i > 1) and self.additionalTransparency, self.template)
		label.AnchorPoint = Vector2.new(.5, 1)
		label.Position = UDim2.new(.5, 0, 1, -totalY)
		
		label.Parent = self.frame
		totalY = totalY + label.AbsoluteSize.Y + self.spacing
		maxX = math.max(maxX, label.AbsoluteSize.X)
	end
	
	totalY = totalY - self.spacing
	self.frame.Size = UDim2.fromOffset(maxX, totalY)
	if self.drawn then
		self.drawn()
	end
end

function ChatQueueModule:kill()
	for i in pairs(self) do
		self[i] = nil
	end
end

ChatQueueModule.new = function(capacity, template, textSize, spacing, bubbleLifetime, additionalTransparency)
	local self = setmetatable({}, ChatQueueModule)
	self.queue = {}
	self.capacity = capacity
	self.template = template
	self.textSize = textSize
	self.spacing = spacing
	self.bubbleLifetime = bubbleLifetime
	self.additionalTransparency = additionalTransparency
	
	self.alive = true
	self.frame = Instance.new("Frame")
	self.frame.BackgroundTransparency = 1
	
	-- self.drawn; callback, called after redrawing
	return self
end

-- it's actually a button
ChatQueueModule.createStyledLabel = function(text, textSize, barColor, additionalTransparency, template,self)
	local QTextModule = require(game:GetService("ReplicatedStorage").Aero.Shared.QTextModule)
	local label = (template or script.Parent.Template).Button:Clone()
	label.AutoButtonColor = false
	label.Selectable = false
	label.Active = false
	label.Text = ""
	
	local qtextLabel = QTextModule.new(text, textSize, textSize * 12)
	qtextLabel.transparencyModifier = additionalTransparency or 0
	qtextLabel = qtextLabel:draw()
	qtextLabel.AnchorPoint = Vector2.new(.5, .5)
	qtextLabel.Position = UDim2.fromScale(.5, .5)
	qtextLabel.Parent = label
	
	label.Size = UDim2.new(0, qtextLabel.AbsoluteSize.X + 20, 0, qtextLabel.AbsoluteSize.Y + 6)
	if label:FindFirstChild("Triangle") then
		label.Triangle:Destroy()
	end
	if label:FindFirstChild("Color") and barColor then
		if label.Color.ClassName == "Frame" then
			label.Color.BackgroundColor3 = barColor
		elseif label.Color.ClassName == "ImageLabel" then
			label.Color.ImageColor3 = barColor
		end
	end
	
	return label
end
return ChatQueueModule