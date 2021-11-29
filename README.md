# Hide-Instance
## What is Hide-Instance? Hide-Instance is a script I made which can hide an Instance (also referred to as an object) preventing the game from accessing said Instance.
### This is significantly better than using syn.protect_gui (failed ~9 checks I used while testing, while this script bypasses all of them (more info can be found [here](/CHECKSINFO.md)).

# Script:
- [source](/script/HideObject.lua)<br>^[\(raw\)](https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua)

<!--
# !!Warning!! This script makes an object return nil when indexed!!!!
## What does this mean?<br>This means that if you are using this on a script's parent, then script.Parent will return nil even if the parent is a real object.
## How can I get around this?<br>You can get around this by using my [Gui To Lua plugin](https://github.com/TechHog8984/roblox-studio/tree/main/plugins/GuiToLuaV3) (NOT YET WORKING) if you are you working with a GUI.
-->

# Documentation:


## First, you have to get the actual "class":
```lua
    local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
```

## Then, you use the Create function to create your object as a substitute for Instance.new:
```lua
    local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
    
    local Object = HideObject.Create{ClassName = 'ScreenGui', Parent = workspace--[[THERE MUST BE A PARENT!!!!]], OtherNormalProperties = 'Go Here'}
    --now you are free to do whatever with this object as you normally would
```

#### Quick note:
#### You can use the Hide function to hide an already existing object, however it will be vulnerable to ChildAdded or DescendantAdded events as it would be parented before being hidden which would still trigger the events before the script hooks them.

#### The Hide function can be used like so:
```lua
    local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
    
    HideObject.Hide(Object, Object.Parent --[[again, THERE MUST BE A PARENT!!!!]])
```

## HookIndex option<br>The HookIndex option is not required and will determine whether or not you want to hook the game's __index metamethod to ensure your Instance is more hidden.<br>This is an option and not required because there are many cases where this will break scripts.
Example:
```lua
    local HideObject = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua'))()
    
    local Gui = HideObject.Create{HideIndex = true, ClassName = 'ScreenGui', Parent = workspace}
    local Frame = HideObject.Create{HideIndex = true, ClassName = 'Frame', Parent = Gui}
    local Script = HideObject.Create{HideIndex = true, ClassName = 'LocalScript', Parent = Frame}
    
    coroutine.wrap(function()
        while wait(1) do
            Script.Parent.Visible = not Script.Parent.Visible
         end
    end)()
```
## This can be an issue because this is typically how a Gui To Lua plugin (like [this one](https://github.com/TechHog8984/roblox-studio/tree/main/plugins/GuiToLuaV3) which I will be implementing support for Hide-Instance in the near future) would handle your script, by wrapping them in a coroutine with the "script" variable being the script.

# Issues, Bugs, etc,.
## If you experience any issues, bugs, etc,. or even if you want to make a suggestion, then please make a [new issue](https://github.com/TechHog8984/Hide-Instance/issues/new).
