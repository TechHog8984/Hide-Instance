# Hide-Instance
## What is Hide-Instance? Hide-Instance is a script I made which can hide an Instance (also referred to as an object) preventing the game from accessing or detecting said Instance.
### Click [Here](/CHECKSINFO.md) for a list of checks this script bypasses.

# Script:
- [source](/script/HideObject.lua)<br>^[(raw)](https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua)

<!--
# !!Warning!! This script makes an object return nil when indexed!!!!
## What does this mean?<br>This means that if you are using this on a script's parent, then script.Parent will return nil even if the parent is a real object.
## How can I get around this?<br>You can get around this by using my [Gui To Lua plugin](https://github.com/TechHog8984/roblox-studio/tree/main/plugins/GuiToLuaV3) (NOT YET WORKING) if you are you working with a GUI.
-->

# Documentation:


## First, you have to get the actual class:
```lua
local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
```

## Then, you use the `Create` function with the following syntax:
```lua
HideObject.Create{<string>ClassName, <Instance>Parent, ...}
```
### Both `ClassName` and `Parent` are required fields, while `...` represents any other normal properties.<br>An example of adding properties would look like this:
```lua
HideObject.Create{ClassName, Parent, Name = 'Name', Position = Vector3.new(200, 20, 30), Transparency = .5}
```
## You use this function to create your object as a substitute for Instance.new, like so:
```lua
local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
    
local Object = HideObject.Create{'ScreenGui', workspace, Position = UDim2.new(1, 0, 1, 0}
--now, you can edit the object like normal.
Object.Size = UDim2.new(0, 200, 0, 300)
```

### Also, you can use the `Hide` function to hide an already existing object, however it will be vulnerable to ChildAdded or DescendantAdded events as it would be parented before being hidden which would still trigger the events before the script hooks them.

### The `Hide` function can be used with the following syntax:
```lua
HideObject.Hide(<Instance>Object, <Instance>Parent)
```
### `Parent` is REQUIRED and the script will NOT work if you do not provide a parent.
### Example of the hide function:
```lua
local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
    
HideObject.Hide(workspace, game) --trol
```

# Issues, Bugs, etc,.
## If you experience any issues, bugs, etc,. or even if you want to make a suggestion, then please make a [new issue](https://github.com/TechHog8984/Hide-Instance/issues/new).<br>If you have any other questions regarding the actual code itself, you can look at the [source code](/script/HideObject.lua), as there are many notes documenting most of the code.
