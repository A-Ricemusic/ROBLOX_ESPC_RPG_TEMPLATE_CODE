-- Notify Event Module
-- Username
-- October 5, 2022



local NotifyEventModule = {}
function CreateHint(plr,msg)
	local ui = plr:WaitForChild("PlayerGui")
	if (ui:FindFirstChild("ClientNotify")) then ui:FindFirstChild("ClientNotify"):Destroy() end
	
	local H = script.ClientNotify:Clone()
	for _,v in pairs(H:GetDescendants()) do
		if v.Name == "NotifyText" then
			v.Text = msg
		end
	end
	H.Parent = ui
	H.GameNotify.Main:TweenPosition(UDim2.new(.5,0,.5,0),"Out","Bounce",1)
	wait(2)
	if H ~= nil and H:FindFirstChild("GameNotify") and H.GameNotify.Main then
		H.GameNotify.Main:TweenPosition(UDim2.new(2,1,.5,0),"In","Linear",1)
	end
	wait(0.5)
	if H ~= nil and H:FindFirstChild("GameNotify") and H.GameNotify.Main then
		H:Destroy()
	end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemStorage = ReplicatedStorage:WaitForChild("GameItems")

function NotifyEventModule.Notify(plr,msg)
	CreateHint(plr,msg)
end


return NotifyEventModule