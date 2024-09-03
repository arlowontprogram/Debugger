--[[

	Title: Constructor
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A handy module for constructing Debugger Components

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Debugging = require(Debugger)

local Packages = Debugger.Packages
local Rabbit = require(Packages.Rabbit)

-- Types
export type func = (any) -> any

-- Constructor
local Constructor = {}
Constructor.__index = Constructor

-- Constructor Constructor
function Constructor.new(Context: any | string, Component: table | () -> any)
	-- Retrieve the caller
	local Caller = Debugging:GetCaller()
	assert(Caller, "No caller was found!")
	
	-- Initialise a MITM component
	if (type(Component) == "table") and (type(Context) ~= "string") then
		local ComponentRabbit = Rabbit.new(Context)
		
		-- Overwrite Component to a Metamethod hooked version
		Component = ComponentRabbit:HookMetamethods(Component)
	end
	
	return {
		Component,
		Caller.Name
	}
end

return Constructor