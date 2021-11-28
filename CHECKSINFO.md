# This is information regarding the previous spoken about checks that syn.protect_gui fails, whilst this script bypasses.

## Check \#1:
### Parent.ObjectName
Example:
- ### local object = Parent.ThisShouldntBeHere<br>if object then<br>object:Destroy()<br>end

## Check \#2:
### Parent:FindFirstChild
Example:
- ### local object = Parent:FindFirstChild(Name)<br>if object then<br>object:Destroy()<br>end

## Check \#3:
### .FindFirstChild
Example:
- #### local findfirstchild = game.FindFirstChild <br>local object = findfirstchild(Parent, Name)<br>if object then<br>object:Destroy()<br>end

#### These above two checks, although similar, are different in the way of how they are hooked. <!--<br></br>Check \#2 is hooked through the game's metamethod, whilst Check \#3 is hooked through the Parent.FindFirstChild function. <br></br> The detection used in Check \#3 is quite common as saving the game or another object's function to a variable and then calling that function with the first argument of the actual object (in this case the parent) is common as doing this allows you to not need to use the : operator getting the desired function every time and instead just use the saved function (that wouldn't change in the first place, meaning you would not need to get the desired every time) which can pose as a performance boost.-->

## Check \#4:
### Parent.ChildAdded
Example:
- ##### Parent.ChildAdded:Connect(function(Child)<br>if Child.Name == 'not in whitelist' then<br>Child:Destroy()<br>end<br>end)

## Check \#5:
### game.DescendantAdded
Example:
- ##### game.DescendantAdded:Connect(function(Descendant)<br>if Descendant.Name == 'not in whitelist' then<br>Descendant:Destroy()r<br>end<br>end)

## Check \#6:
### Parent:GetChildren
Example:
- ##### local children = Parent:GetChildren()<br>for I, Child in pairs(children) do<br>if Child and Child.Name == 'not in whitelist' then<br>Child:Destroy()<br>end<br>end

## Check \#7:
### .GetChildren
Example:
- #### local getchildren = game.GetChildren <br>local children = getchildren(Parent)<br>for I, Child in pairs(children) do<br>if Child and Child.Name == 'not in whitelist' then<br>Child:Destroy()<br>end<br>end

### Just like in Check \#2 and Check \#3, although Check \#6 and Check \#7 look similar, they are hooked differently, thus two different checks exist.
### Same thing for the next 2 checks.

## Check \#8:
### :GetDescendants
Exampe:
- ##### local descendants = Parent:GetDescendants()<br>for I, Descendant in pairs(descendants) do<br>if Descendant and Descendant.Name == 'not in whitelist' then<br>Descendant:Destroy()<br>end<br>end

## Check \#9:
### .GetDescendants
Example:
- #### local getdescendants = game.GetDescendants <br>local descendants = getdescendants(Parent)<br>for I, Descendant in pairs(descendants) do<br>if Descendant and Descendant.Name == 'not in whitelist' then<br>Descendant:Destroy()<br>end<br>end
