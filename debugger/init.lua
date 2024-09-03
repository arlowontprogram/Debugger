--[[

	Title: Debugger
	Author: cyberari
	Version: 1.0.0
	
	Description:
		Function environment globals mutation based debugger

]]

-- Debugger
local Debugger = {}
Debugger.__index = Debugger

-- Constants
local getfenv = getfenv
local setfenv = setfenv

-- Methods
function Debugger:GetCaller(Offset: number?): Instance?
	-- Collect debug info
	local Caller = debug.info(3 + (Offset or 0), "s")

	if type(Caller) ~= "string" then
		warn("Failed to retrive Caller location!")
		return
	end

	-- Return the object
	local Bits = string.split(Caller, ".")
	local Source = game

	for i = 1, #Bits - 1 do
		local Descendant = Source:FindFirstChild(Bits[i])

		if not Descendant then
			return
		end

		Source = Descendant
	end

	return Source:FindFirstChild(Bits[#Bits])
end

function Debugger:GetEnv(Offset: number?): table
	return getfenv(
		3 + (Offset or 0)
	)
end

function Debugger:SetEnv(Env: table?, Extension: table): nil
	if type(Env) ~= "table" then
		Env = Debugger:GetEnv(1)
	end

	for Key, Value in pairs(Extension or {}) do
		Env[Key] = Value
	end

	setfenv(3, Env)
end

function Debugger.Start(): nil
	-- Collect information about the caller
	local CallerObject = Debugger:GetCaller()
	print(`Initialising debugging on {CallerObject.Name}`)

	local Components = {}

	for _, Component in pairs(script.Components:GetChildren()) do
		if not Component:IsA("ModuleScript") then
			continue
		end

		-- Collect the Component
		local PackagedComponent = require(Component)

		local ComponentObject = PackagedComponent[1]
		local ComponentKey = PackagedComponent[2]

		-- Verify component is valid
		if type(ComponentKey) ~= "string" then
			continue
		end

		if
			(type(ComponentObject) ~= "table")
			and (type(ComponentObject) ~= "function")
		then
			continue
		end

		-- Add to Components table
		Components[ComponentKey] = ComponentObject
	end

	Debugger:SetEnv(nil, Components)
end

return Debugger :: {
	GetCaller: (self, Offset: number?) -> Instance?,
	GetEnv: (self, Offset: number?) -> table,
	SetEnv: (self, Env: table?, Extension: table) -> nil,
	Start: () -> nil
}
