# This is information regarding the previous spoken about checks that, as of Synapse X V2, syn.protect_gui fails, whilst this script bypasses.

## Check \#1:
### Parent.ObjectName
Example:
```lua
local object = Parent.ThisShouldntBeHere
if object then
    object:Destroy()
end
```
## Check \#2:
### Parent:FindFirstChild
Example:
```lua
local object = Parent:FindFirstChild('ThisShouldntBeHere')
if object then
    object:Destroy()
end
```
## Check \#3:
### .FindFirstChild
Example:
```lua 
local object = Parent.FindFirstChild(Parent, 'ThisShouldntBeHere')
if object then
    object:Destroy()
end
```
#### These above two checks, although similar, are different in the way of how they are hooked. <!--<br></br>Check \#2 is hooked through the game's metamethod, whilst Check \#3 is hooked through the Parent.FindFirstChild function. <br></br> The detection used in Check \#3 is quite common as saving the game or another object's function to a variable and then calling that function with the first argument of the actual object (in this case the parent) is common as doing this allows you to not need to use the : operator getting the desired function every time and instead just use the saved function (that wouldn't change in the first place, meaning you would not need to get the desired every time) which can pose as a performance boost.-->

## Check \#4:
### Parent.ChildAdded
Example:
```lua
Parent.ChildAdded:Connect(function(Child)
    if Child.Name == 'ThisShouldntBeHere' then
        Child:Destroy()
    end
end)
```
## Check \#5:
### Parent.DescendantAdded
Example:
```lua
Parent.DescendantAdded:Connect(function(Descendant)
    if Descendant.Name == 'ThisShouldntBeHere' then
        Descendant:Destroy()
    end
end)
```
## Check \#6:
### game.DescendantAdded
Example:
```lua
game.DescendantAdded:Connect(function(Descendant)
    if Descendant.Name == 'ThisShouldntBeHere' then
        Descendant:Destroy()
    end
end)
```
## Check \#7:
### Parent:GetChildren
Example:
```lua
local children = Parent:GetChildren()
for I, Child in pairs(children) do
    if Child and Child.Name == 'ThisShouldntBeHere' then
        Child:Destroy()
    end
end
```
## Check \#8:
### .GetChildren
Example:
```lua
local children = Parent.GetChildren(Parent)
for I, Child in pairs(children) do
    if Child and Child.Name == 'ThisShouldntBeHere' then
        Child:Destroy()
    end
end
```
### Just like in Check \#2 and Check \#3, although Check \#7 and Check \#8 look similar, they are hooked differently, thus two different checks exist.
### Same thing for the next 2 checks.

## Check \#9:
### :GetDescendants
Exampe:
```lua
local descendants = Parent:GetDescendants()
for I, Descendant in pairs(descendants) do
    if Descendant and Descendant.Name == 'ThisShouldntBeHere' then
        Descendant:Destroy()
    end
end
```
## Check \#10:
### .GetDescendants
Example:
```lua
local descendants = Parent.GetDescendants(Parent)
for I, Descendant in pairs(descendants) do
    if Descendant and Descendant.Name == 'ThisShouldntBeHere' then
        Descendant:Destroy()
    end
end
```

# Extra
## As I stated in the README, if you have any other questions regarding these, you can make a [new issue](https://github.com/TechHog8984/Hide-Instance/issues/new) or even look at the [source code](/script/HideObject.lua), as there are many notes documenting most of the code.
