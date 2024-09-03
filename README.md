# Debugger
Debugger provides easy integration into code, allowing you to view methods called, and overwrite globals

## Initialising the Debugger within a script
To start the debugger, at the first line, assuming that the Debugger module is located under ReplicatedStorage:

```lua
require(game:GetService("ReplicatedStorage").Debugger).Start()

-- Obfuscated code, anything goes *after* Debugger.Start() is called.
```
