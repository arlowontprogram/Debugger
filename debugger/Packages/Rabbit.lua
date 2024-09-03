--[[

	Title: Rabbit
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A module that allows metatable methods for retrieving objects from a source

]]

-- Rabbit
local Rabbit = {}
Rabbit.__index = Rabbit

-- Methods
function Rabbit:Get(Index): any?
	local _, SourceObject = pcall(function()
		return self.Source[Index]
	end)
	
	return SourceObject
end

function Rabbit:HookMetamethods(Component)
	return setmetatable(Component, {
		__index = function(s, index)
			local SourcedObject = self:Get(index)

			if not SourcedObject then
				return
			end

			-- indexed object is a method
			if type(SourcedObject) == "function" then
				local function eval( _self, ... )
					local _, result = pcall(SourcedObject, self.Source, ... )

					return result
				end

				rawset(s, index, eval)
				return eval
			else
				-- indexed object is a non-function object
				rawset(s, index, SourcedObject)
				return SourcedObject
			end
		end,

		__newindex = function(s, index, value)
			if not self.IsEditable then
				return
			end

			rawset(s, index, value)
		end
	})
end

-- Constructor
function Rabbit.new(Source: any)
	local IsEditable = pcall(function()
		Source["hi"] = true
		Source["hi"] = nil
	end)
	
	return setmetatable({
		Source = Source,
		IsEditable = IsEditable
	}, Rabbit)
end

return Rabbit :: {
	new: (Source: any) -> {
		Get: (Index: any?) -> any?,
		HookMetamethods: (Component: table) -> nil
	}
}
