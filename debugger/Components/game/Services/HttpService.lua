--[[

	Title: Components.game.HttpService
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A HttpService MITM implementation

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Packages = Debugger.Packages
local Constructor = require(Packages.Constructor)

-- game
local Component = {}

function Component:RequestAsync( ... )
	print( ... )
end

-- Constructor
return Constructor.new(game.HttpService, Component)
