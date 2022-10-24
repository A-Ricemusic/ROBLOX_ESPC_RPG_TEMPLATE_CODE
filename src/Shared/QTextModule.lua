-- Q Text Module
-- Username
-- October 5, 2022



local QTextModule = {}
local textService = game:GetService("TextService")
local infinityVector = Vector2.new(math.huge, math.huge)
QTextModule.__index = QTextModule

QTextModule.defaultFont = Enum.Font.SourceSans
QTextModule.defaultSize = 30
QTextModule.defaultAlignment = "center"
QTextModule.defaultColor = Color3.new(1, 1, 1)

local textColorAttribute, textStrokeColorAttribute; do
	local colorShorthands = {
		red=Color3.new(1,0,0), green=Color3.new(0,1,0), blue=Color3.new(0,0,1);
		yellow=Color3.new(1,1,0), cyan=Color3.new(0,1,1), magenta=Color3.new(1,0,1);
		white=Color3.new(1,1,1), black=Color3.new(0,0,0);
		
		["dark red"]=Color3.new(.58,0,0), ["dark green"]=Color3.new(0,.39,0), ["dark blue"]=Color3.new(0,0,.58);
		["light red"]=Color3.new(1,.45,.45), ["light green"]=Color3.new(.55,1,.55), ["light blue"]=Color3.new(.58,.58,1);
		["dark yellow"]=Color3.new(.59,.59,0), ["dark cyan"]=Color3.new(0,.59,.59), ["purple"]=Color3.new(.45,0,.45);
		["light yellow"]=Color3.new(1,1,.39), ["light cyan"]=Color3.new(.54,1,1), ["light magenta"]=Color3.new(1,.5,1);
	}
	
	local function genProcess(property)
		return function(value)
			local nospace=value:gsub("%s", "")
			local r,g, b = nospace:match("(%d+),(%d+),(%d+)")
			if r and g and b then
				return {Color3.fromRGB(r, g, b), property}
			end
			
			local lowered = value:lower()
			if colorShorthands[lowered] then
				return {colorShorthands[lowered], property}
			end
			return {colorShorthands.white, property}
		end
	end
	
	textColorAttribute = {process = genProcess("TextColor3")}
	textStrokeColorAttribute = {process = genProcess("TextStrokeColor3")}
end

local textTransparencyAttribute, textStrokeTransparencyAttribute; do
	local transparencyShorthands = {
		opaque=0, translucent=.5, transparent=1
	}
	local function genProcess(property)
		return function(value)
			local transparency = tonumber(value:gsub(""))
			if transparency then
				return {transparency, property}
			end
			
			return {transparencyShorthands.opaque, property}
		end
	end
	
	textTransparencyAttribute = {process = genProcess("TextTransparency")}
	textStrokeTransparencyAttribute = {process = genProcess("TextStrokeTransparency")}
end

local attributes = {
	["end"] = {empty = true, ends=true};
	["b"] = {empty=true, process=function() return {"SourceSansBold", "Font"} end};
	["i"] = {empty=true, process=function() return {"SourceSansItalic", "Font"} end};
	["font"] = {process = function(value)
		if value == Enum.Font.Legacy then return {QTextModule.defaultFont, "Font"} end
		
		local fonts = Enum.Font:GetEnumItems()
		for _, font in ipairs(fonts) do
			if font.Name == value then
				return {value, "Font"}
			end
		end
		
		return {QTextModule.defaultFont, "Font"}
	end};
	
	["txtclr"] = textColorAttribute;
	["textcolor"] = textColorAttribute;
	["textclr"] = textColorAttribute;
	["txtcolor"] = textColorAttribute;
	
	["txtstrokeclr"] = textStrokeColorAttribute,
	["textstrokecolor"] = textStrokeColorAttribute,
	["textstrokeclr"] = textStrokeColorAttribute,
	["txtstrokecolor"] = textStrokeColorAttribute,
	
	["txttransparency"] = textTransparencyAttribute;
	["texttransparency"] = textTransparencyAttribute;
	
	["txtstroketransparency"] = textStrokeColorAttribute;
	["textstroketransparency"] = textStrokeTransparencyAttribute;
}
local tag = {start="<", finish=">"}
local attrval = {start="\"", finish="\"", assign="="}
local escapeCharacter = "\\"

local function parse(parsing)
	local textpack = {}
	local wordmap = {{}}
	
	local inTag = false
	local inAttributeValue = false
	local tags = {} -- tag at 1 is the current tag, tag at 2 is the tag the current tag is in and ...
	-- tags is a stack but upside down

	local currentCharProperties;
	local readAttributeName;
	local lastChar;
	local lastCharHasWhitespace;
	local lastUsedCharHasWhitespace; -- it's a used character if it appears visually
	
	local function tryEmptyAttribute()
		local falseReadAttributeName;
		if type(readAttributeName) == "table" then
			falseReadAttributeName = table.concat(readAttributeName)
		end
		falseReadAttributeName = falseReadAttributeName or ""
		
		local attribute = attributes[falseReadAttributeName:lower()]
		if attribute then
			if attribute.empty then
				if attribute.ends then
					table.remove(tags, 1) -- remove the end tag
					table.remove(tags, 1) -- then the next tag
					readAttributeName = nil
				else
					if tags[1] and (not tags[1].finished) then
						table.insert(tags[1], attribute.process())
						readAttributeName = nil
					end
				end
			end
		else
		--	warn("unknown attribute: " .. falseReadAttributeName)
		end
	end
	
	for position, codepoint in utf8.codes(parsing) do
		local char = utf8.char(codepoint)
		local hasWhitespace = (char == " ") or (char == "\t") or (char == "\v") or (char == "\n")
		local lastCharIsEscapeCharacter = (lastChar == escapeCharacter)
		local exitedOrEntertedTag = false
		local exitedAttributeValue = false
		
		if not lastCharIsEscapeCharacter then
			if (not inTag) and (char == tag.start) then
				inTag = position
				exitedOrEntertedTag = true
				table.insert(tags, 1, {})
			elseif (inTag) and (char == tag.finish) then
				tryEmptyAttribute()
				
				inTag = false
				readAttributeName = nil
				exitedOrEntertedTag = true
				
				if tags[1] then
					tags[1].finished = true
					
					currentCharProperties = {}
					for i = #tags, 1, -1 do
						local tag = tags[i]
						for _, d in ipairs(tag) do
							currentCharProperties[d[2]] = d[1]
						end
					end
				else
					currentCharProperties = nil
				end
			end
			if (not inAttributeValue) and (char == attrval.start) then
				inAttributeValue = position
			elseif (inAttributeValue) and (char == attrval.finish) then
				local attribute = attributes[readAttributeName:lower()]
				if attribute and (not attribute.empty) then
					local value = parsing:sub(inAttributeValue + 1, position - 1)
					local d = attribute.process(value)
					if tags[1] and (not tags[1].finished) then
						table.insert(tags[1], d)
					end
				elseif not attribute then
					--warn("unknown attribute: " .. readAttributeName)
				end
				
				inAttributeValue = false
				readAttributeName = nil
				exitedAttributeValue = true
			end
		end
		
		if (not inTag) and (not inAttributeValue) and (not exitedOrEntertedTag) then
			if lastUsedCharHasWhitespace and (not hasWhitespace) then
				table.insert(wordmap, {})
			end
			
			table.insert(textpack, {char=char, properties=currentCharProperties})
			table.insert(wordmap[#wordmap], char)
			lastUsedCharHasWhitespace = hasWhitespace
		elseif inTag and (not exitedOrEntertedTag) and (not exitedAttributeValue) then
			if not readAttributeName then
				readAttributeName = {}
			end
			local isTable = (type(readAttributeName) == "table")
			
			if (char == attrval.assign) and (not lastCharIsEscapeCharacter) then
				readAttributeName = table.concat(readAttributeName)
			elseif isTable and not hasWhitespace then
				if lastCharHasWhitespace and (#readAttributeName > 0) then
					tryEmptyAttribute()
					readAttributeName = {}
				end
				
				table.insert(readAttributeName, char)
			end
		-- elseif inAttributeValue then; inAttributeValue stuff happens when inAttributeValue is assigned to false (above)
		end
		
		lastChar = char
		lastCharHasWhitespace = hasWhitespace
	end
	
	if inTag then
		return false, "expected " .. tag.finish .. " to end the tag at " .. tostring(inTag) .. "(" .. tag.start .."): " .. parsing
	end
	if inAttributeValue then
		return false, "expected " .. attrval.finish .. " to end the attribute at " .. tostring(inAttributeValue) .. "(" .. attrval.start .."): " .. parsing
	end
	
	return textpack, wordmap
end

local function fastformat(formatting) -- get a string and convert it to a textpack and wordmap with no styling
	local textpack = {}
	local wordmap = {{}}
	
	for position, codepoint in utf8.codes(formatting) do
		local char = utf8.char(codepoint)
		table.insert(textpack, {char = char})
		table.insert(wordmap[#wordmap], char)
		if char:match("%s") then
			table.insert(wordmap, {})
		end
	end
	
	return textpack, wordmap
end

local function positionLabels(lines, QTextModule)
	local center = QTextModule.alignment == "center"
	local left = QTextModule.alignment == "left"
	local right = QTextModule.alignment == "right"
	local currentY = 0
	local maxX = 0
	if #lines > 1 then maxX = QTextModule.boundaries.X end
	
	for _, line in ipairs(lines) do
		local currentX;
		local visualX = line.visualX or line.x
		maxX = math.max(maxX, line.x)
		
		if center then
			currentX = math.floor((maxX / 2) - (visualX / 2))
		elseif left then
			currentX = 0
		elseif right then
			currentX = QTextModule.boundaries.X - visualX
		end
		for _, label in ipairs(line) do
			label.Position = UDim2.new(0,currentX, 0,currentY)
			currentX = currentX + label.Size.X.Offset
		end
		
		currentY = currentY + QTextModule.textSize
	end
	
	return maxX, currentY
end

function QTextModule:draw()
	local frame = Instance.new("Frame")
	frame.BackgroundTransparency = 1
	
	local lines = {{x=0}}
	local charnum = 1
	
	local function makeNewLine()
		local lastLine = lines[#lines]
		lastLine.visualX = lastLine.x
		for i = #lastLine, 1, -1 do
			local label = lastLine[i]
			local hasWhitespace = (label.Text == " ") or (label.Text == "\t") or (label.Text == "\v") or (label.Text == "\n")
			if not hasWhitespace then break end
			lastLine.visualX = lastLine.visualX - label.Size.X.Offset
		end
		table.insert(lines, {x=0})
	end
	
	for _, word in ipairs(self.wordmap) do
		local visualSize = 0
		local inWhitespace = false
		local charlist = {}
		
		for _ in ipairs(word) do
			local char = self.textpack[charnum]
			local font = (char.properties and char.properties.Font) or QTextModule.defaultFont
			local bounds = textService:GetTextSize(char.char, self.textSize, font, infinityVector)
			if not inWhitespace then
				if (char.char == " ") or (char.char == "\t") or (char.char == "\v") or (char.char == "\n") then
					inWhitespace = true
				else
					visualSize = visualSize + bounds.X
				end
			end
			
			local label = Instance.new("TextLabel")
			label.BackgroundTransparency = 1
			label.Font = font
			label.TextColor3 = QTextModule.defaultColor
			label.TextSize = self.textSize
			
			label.Text = char.char
			label.Size = UDim2.new(0,bounds.X, 0,bounds.Y)
			if char.properties then
				for property, value in pairs(char.properties) do
					label[property] = value
				end
			end
			label.TextTransparency = label.TextTransparency + (self.transparencyModifier or 0)
			
			table.insert(charlist, {label, inWhitespace})
			label.Parent = frame
			charnum = charnum + 1
		end
		
		if lines[#lines].x + visualSize > self.boundaries.X then
			makeNewLine()
		end
		for _, d in ipairs(charlist) do
			local charX = d[1].Size.X.Offset	
			local line = lines[#lines]	
			local newLineX = line.x + charX
			
			if newLineX > self.boundaries.X then
				if not d[2] then -- not whitespace
					makeNewLine()
					table.insert(lines[#lines], d[1])
				end
			else
				line.x = newLineX
				table.insert(lines[#lines], d[1])
			end
		end
	end
	
	local x, y = positionLabels(lines, self)
	frame.Size = UDim2.new(0,x, 0,y)
	frame.Name = "QTextModule-frame"
	return frame
end

QTextModule.new = function(text, textSize, xBound, alignment)
	local self = {}
	self.boundaries = {X = xBound}
	self.textSize = textSize or QTextModule.defaultSize
	self.alignment = alignment or QTextModule.defaultAlignment
	-- self.transparencyModifier
	
	local textpack, wordmap = parse(text)
	self.textpack = textpack
	self.wordmap = wordmap
	if not textpack then
		warn(wordmap)
		self.textpack, self.wordmap = fastformat(text)
	end
	
	return setmetatable(self, QTextModule)
end

return QTextModule