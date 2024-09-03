--[[

	Title: Components.getfenv
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A getfenv MITM implementation

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Packages = Debugger.Packages
local Constructor = require(Packages.Constructor)

-- Constants
local getfenv = getfenv

local DEFUALT_ENV_KEYS = {
	"_G", "script", "shared"
}

-- Constructor
return Constructor.new(script.Name, function()
	local env = getfenv(2) -- retrieve the *actual* environment
		
	-- Cleanup the environment
	for Value, _Key in pairs(env) do
		if table.find(DEFUALT_ENV_KEYS, Value) then
			continue
		end
		
		env[Value] = nil
	end
	
	return env
end)
