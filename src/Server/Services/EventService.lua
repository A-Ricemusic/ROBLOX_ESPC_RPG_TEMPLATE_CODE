-- Event Service
-- Username
-- October 21, 2022



local EventService = {Client = {}}


function EventService:FireSwordSetUpClient(plr,WeaponTag)
    self:FireClient("SwordSetUp", plr, WeaponTag)
end

function EventService:FireUnbindActions(plr)
    self:FireClient("Unbind", plr)
end

function EventService:Start()
	
end


function EventService:Init()
    self:RegisterClientEvent("SwordSetUp")
	self:RegisterClientEvent("Unbind")
	
end


return EventService