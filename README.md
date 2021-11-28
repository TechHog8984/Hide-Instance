# Hide-Instance
## What is this Hide-Instance? Hide-Instance is a script I made which can hide an Instance (also referred to as an object) preventing the game from accessing said Instance. 
### This is significantly better than using syn.protect_gui (failed 8 checks I made, while my script bypasses all of them (more info can be found [here](/CHECKSINFO.md)).

[source](/script/HideObject.lua)<br>^[\(raw\)](https://raw.githubusercontent.com/TechHog8984/Hide-Instance/main/script/HideObject.lua)

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
