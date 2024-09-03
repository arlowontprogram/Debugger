--[[

	Title: Components.game
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A game MITM implementation

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Packages = Debugger.Packages
local Constructor = require(Packages.Constructor)

-- game
local Component = {}

function Component:GetService(Service: string)	
	-- Check if a Debugger equivalent exists
	local DebuggerService = script.Services:FindFirstChild(Service)
	
	if DebuggerService then
		return unpack(require(DebuggerService))
	end
	
	return game:GetService(Service)
end

-- Constructor
return Constructor.new(game, Component)
