-- Day And Night Cycle Service
-- Username
-- October 14, 2022



local DayAndNightCycleService = {Client = {}}

local function DayAndNightCycle()

    local config =
    {['timeSpeed'] = 400,   --if 60 then 1 min = 1 hour
    ['startTime'] = 9,   -- 9am
    }

local Lighting = game:GetService("Lighting")

local minutesAfterMidnight = config['startTime'] * 60
local waitTime = 60 / config['timeSpeed']
while true do
minutesAfterMidnight = minutesAfterMidnight + 1
Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)
task.wait(waitTime)end

end


function DayAndNightCycleService:Start()
	DayAndNightCycle()
end


function DayAndNightCycleService:Init()
	
end


return DayAndNightCycleService