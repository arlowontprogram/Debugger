# Debugger
Debugger provides easy integration into code, allowing you to view methods called, and overwrite globals

## Initialising the Debugger within a script
To start the debugger, at the first line, assuming that the Debugger module is located under ReplicatedStorage:

```lua
require(game:GetService("ReplicatedStorage").Debugger).Start()

-- Obfuscated code, anything goes *after* Debugger.Start() is called.
```

## Expanding the Components set
Components are built using the `Components` package, this package allows you to provide a source for methods, as well as allowing you to create new, and overwrite existing methods from the provided source.

This also means you don't have to completely re-write the entire class you are recreating.

Given an example for an implementation of the `game` global:

```lua
--[[

	Title: Components.[component name]
	Author: cyberari
	Version: 1.0.0
	
	Description:
		A handy component with an informative description

]]

-- Debugger
local Debugger = script:FindFirstAncestor("Debugger")

local Packages = Debugger.Packages
local Constructor = require(Packages.Constructor)

-- Component
local Component = {}

Component.workspace = {
    Gravity = Vector3.zero
}

-- Constructor
return Constructor.new(
    game, -- Original Source
    Component -- Our component
)

```

If a component is a global that is a function, replace the `Original Source` argument with the name of the global, so it can be defined when over-writing the script environment.
