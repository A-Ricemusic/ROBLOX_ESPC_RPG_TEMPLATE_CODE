-- Quest Disable Controller
-- Username
-- October 5, 2022



local QuestDisableController = {}




function QuestDisableController:Start()
	local Player = game.Players.LocalPlayer
	local Maid = self.Shared.Maid
	local maid = Maid.new()
	
	
	maid.Character = Player.CharacterAdded:Connect(function(character)    
		local humanoid = character:WaitForChild("Humanoid")
		local chatter = self.Controllers.QuestController
		local chatSetting = self.Shared.Config.QuestConfigModule
		local root = character:WaitForChild("HumanoidRootPart")
		
		local running = false
		
	maid.Humanoid =	humanoid.Running:Connect(function(speed)
			if speed > 0 then
				running = true
				
				if chatter.isChatting then
					repeat
						wait(.5)
						if chatter.isChatting then
							local state = chatter.state
							if state and state.chatBillboard then
								local adornee = state.chatBillboard.Adornee
								
								if adornee:IsA("BasePart") then
									local distance = (adornee.Position - root.Position).Magnitude
									print(distance)
									print(chatSetting.ChatMaxDistance)
									if distance > chatSetting.ChatMaxDistance then
										chatter.displayChatStatus("chat ended because you walked away")
										chatter.endChat()
									end
								elseif adornee:IsA("Model") then
									if adornee.PrimaryPart then
										local distance = (adornee.PrimaryPart.Position - root.Position).Magnitude
										
										if distance > chatSetting.ChatMaxDistance then
											chatter.displayChatStatus("chat ended because you walked away")
											chatter.endChat()
										end
										
									end
								end
							end
						else
							break
						end
					until (not running) or (not character)
				end
			else
				running = false
			end
				
		end)
		
	maid.died =	humanoid.Died:Connect(function()
			if chatter.isChatting then
				humanoid = nil
				root = nil
				running = nil -- just in case
				
				character = game.Players.LocalPlayer -- so the removal of the character won't stop the function
				chatter.displayChatStatus("chat ended because you died")
				chatter.endChat()
				maid:Destroy()
			end
		end)
	end)		
		end
		
		
		function QuestDisableController:Init()
			
		end
	
return QuestDisableController