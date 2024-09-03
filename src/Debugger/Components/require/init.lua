--[[

	Title: Components.require
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A require MITM implementation

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Packages = Debugger.Packages
local Constructor = require(Packages.Constructor)

-- Constructor
return Constructor.new(script.Name, function(Target: ModuleScript | number)
	print("Collecting", Target)
	
	-- Load an internal ModuleScript
	if typeof(Target) == "Instance" and Target:IsA("ModuleScript") then
		return require(Target)
	end
	
	assert(
		type(Target) == "number",
		"Attempting to require an invalid target!"
	)
	
	-- Load from Cache
	local CacheObject = script.Cache:FindFirstChild(tostring(Target))
	
	return require(CacheObject or Target or 0)
end)
