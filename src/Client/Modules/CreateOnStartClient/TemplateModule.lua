-- Template Module
-- Username
-- October 6, 2022



local TemplateModule = {}

function TemplateModule:Start(Parent)
local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "BillboardGui";
	Properties = {
		LightInfluence = 0.25;
		SizeOffset = Vector2.new(0,0.5);
		Name = "Template";
		Active = true;
		ResetOnSpawn = false;
		MaxDistance = 50;
		ExtentsOffsetWorldSpace = Vector3.new(0,2,0);
		Size = UDim2.new(2,0,2.5,0);
	};
	Children = {
		{
			ID = 1;
			Type = "TextButton";
			Properties = {
				TextWrapped = true;
				TextColor3 = Color3.new(1,1,1);
				Text = "?";
				Font = Enum.Font.Cartoon;
				Name = "Button";
				Size = UDim2.new(1,0,0.800000011920929,0);
				BackgroundColor3 = Color3.new(47/255,47/255,47/255);
				BorderSizePixel = 0;
				TextScaled = true;
				TextWrap = true;
			};
			Children = {
				{
					ID = 2;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(47/255,47/255,47/255);
						Image = "rbxassetid://2784691257";
						Name = "Triangle";
						Position = UDim2.new(0.5,0,1,0);
						SizeConstraint = Enum.SizeConstraint.RelativeYY;
						BackgroundTransparency = 1;
						AnchorPoint = Vector2.new(0.5,0);
						Size = UDim2.new(0.25,0,0.25,0);
					};
					Children = {};
				};
				{
					ID = 3;
					Type = "Frame";
					Properties = {
						Name = "Color";
						Position = UDim2.new(0,2,0,2);
						SizeConstraint = Enum.SizeConstraint.RelativeYY;
						Size = UDim2.new(0,2,1,-4);
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(197/255,0,0);
					};
					Children = {};
				};
			};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

Scan(root, Parent) 

end

return TemplateModule