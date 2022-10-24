-- On Start Creations Controller
-- Username
-- October 5, 2022



local OnStartCreationsController = {}

function OnStartCreationsController:Start()
    local TemplateModule = self.Modules.CreateOnStartClient.TemplateModule
    TemplateModule:Start(script.Parent.QuestController)
	
end


function OnStartCreationsController:Init()
	
end



return OnStartCreationsController