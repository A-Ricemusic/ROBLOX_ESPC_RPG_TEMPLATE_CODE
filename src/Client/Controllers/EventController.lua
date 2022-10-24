-- Event Controller
-- Username
-- October 21, 2022



local EventController = {}


function EventController:Start()

    self.Services.EventService.SwordSetUp:Connect(function(WeaponTag)
        self.Controllers.WeaponController:OnSetUp(WeaponTag)
    end)

    self.Services.EventService.Unbind:Connect(function(WeaponTag)
        self.Controllers.WeaponController:UnbindAction()
    end)
	
end


function EventController:Init()
	
end


return EventController