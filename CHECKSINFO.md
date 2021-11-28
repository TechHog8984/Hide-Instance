# This is information regarding the previous spoken about checks that syn.protect_gui fails, whilst this script bypasses.

## Check \#1:
### :FindFirstChild
Example:
- ### Parent:FindFirstChild(Name)

## Check \#2:
### .FindFirstChild
Example:
- #### local findfirstchild = game.FindFirstChild <br>findfirstchild(Parent, Name)

#### These above two checks, although similar, are different in the way of how they are hooked. <br></br>Check \#1 is hooked through the game's metamethod, whilst Check \#2 is hooked through the Parent.FindFirstChild function. <br></br> The detection used in Check \#2 is quite common as saving the game or another object's function to a variable and then calling that function with the first argument of the actual object (in this case the parent) is common as doing this allows you to not need to use the : operator getting the desired function every time and instead just use the saved function (that wouldn't change in the first place, meaning you would not need to get the desired every time) which can pose as a performance boost.

## Check \#3:
### .ChildAdded
Example:
- ##### Parent.ChildAdded:Connect(function(Child)<br>if Child.Name == 'not in whitelist' then<br>Child:Destroy() -- or kick the player<br>end<br>end)

## Check \#4:
### .DescendantAdded
Example:
- ##### workspace.DescendantAdded:Connect(function(Child)<br>if Child.Name == 'not in whitelist' then<br>Child:Destroy() --or kic kthe player<br>end<br>end)
