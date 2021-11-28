# This is information regarding the previous spoken about checks that syn.protect_gui fails, whilst this script bypasses.

### Check \#1:
#### :FindFirstChild
  #### - Parent:FindFirstChild(Name)

### Check \#2:
#### .FindFirstChild
- #### local findfirstchild = game.FindFirstChild
  ####   findfirstchild(Parent, Name)

## These above two checks, although similar, are different in the way of how they are hooked. <br> Check \#1 is hooked through the game's metamethod, whilst Check \#2 is hooked through the Parent.FindFirstChild function. <br> The detection used in Check \#2 is quite common as saving the game or another object's function and then calling that function with the first argument of the actual object (in this case the parent) to a variable is common as doing this allows you to not need to use the : operator getting the desired function every time and instead just use the saved function (that would change in the first place, meaning you would not need to get the desired every time).
