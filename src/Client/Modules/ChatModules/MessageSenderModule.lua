-- Message Sender Module
-- Username
-- October 5, 2022



local MessageSenderModule = {}
--//////////////////////////////////////
local modulesFolder = script.Parent

--////////////////////////////// Methods
--//////////////////////////////////////
local methods = {}
methods.__index = methods

function methods:SendMessage(message, toChannel)
	self.SayMessageRequest:FireServer(message, toChannel)
end

function methods:RegisterSayMessageFunction(func)
	self.SayMessageRequest = func
end

--///////////////////////// Constructors
--//////////////////////////////////////

function MessageSenderModule.new()
	local obj = setmetatable({}, methods)
	obj.SayMessageRequest = nil

	return obj
end



return MessageSenderModule.new()