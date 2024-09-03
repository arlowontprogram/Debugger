--[[

	Title: Components.game.RunService
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A RunService MITM implementation

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Packages = Debugger.Packages
local Constructor = require(Packages.Constructor)

-- game
local Component = {}

function Component:IsRunMode()
	return false
end

function Component:IsStudio()
	return false
end

-- Constructor
return Constructor.new(game["Run Service"], Component)
