local function tablefind(Table, Value)
    for I, V in next, Table do
        if V == Value then
            return I, V
        end
    end
end
local function tablefindByIndex(Table, Index) 
    for I, V in next, Table do
        if I == Index then
            return I, V
        end
    end
end

local Objects = {}
local DoHookIndex = {}

local function Hide(Object, Parent)
    local AllConnections = {}

    --get the connections for child added and descendant added of the parent of the object
    local ChildAddedConnections                 = getconnections(Parent.ChildAdded)
    local ParentDescendantAddedConnections      = getconnections(Parent.DescendantAdded)
    local GameDescendantAddedConnections        = getconnections(game.DescendantAdded)

    --loop through and disable them
    for I, Connection in next, ChildAddedConnections do
        Connection:Disable()
        table.insert(AllConnections, Connection)
    end
    for I, Connection in next, ParentDescendantAddedConnections do
        Connection:Disable()
        table.insert(AllConnections, Connection)
    end
     for I, Connection in next, GameDescendantAddedConnections do
        Connection:Disable()
        table.insert(AllConnections, Connection)
    end

    --once they are disabled, parent the object to the parent
    Object.Parent = Parent

    --once it is parented, we re enable the connections
    for I, Connection in next, AllConnections do
        Connection:Enable()
    end

    --hook the FindFirstChild function
    local oldFindFirstChild = nil
    oldFindFirstChild = hookfunction(Parent.FindFirstChild, function(...)
        --get the child it's trying to find
        local Child = oldFindFirstChild(...)
        
        --check if the child is the object and if it is, return nil
        if Child == Object then
            return nil
        end
        
        --return the child
        return Child
    end)
    --hook the GetChildren function
    local oldGetChildren = nil
    oldGetChildren = hookfunction(Parent.GetChildren, function(...)
        --get the original Children table
        local Children = oldGetChildren(...)

        --find the object in the Children table and get it's index if it exists
        local Index, Value = tablefind(Children, Object)

        --check if the index and value exist (object exists in table)
        if Index and Value and Value == Object then
            --remove object from the table
            table.remove(Children, Index)
        end
        --remote the either modified (if the object was found) table or the original if the object wasn't found
        return Children
    end)
    --hook the GetDescendants function
    local oldGetDescendants = nil
    oldGetDescendants = hookfunction(Parent.GetDescendants, function(...)
        --get the original Descendants table
        local Descendants = oldGetDescendants(...)

        --find the object in the Descendants table and get it's index if it exists
        local Index, Value = tablefind(Descendants, Object)

        --check if the index and value exist (object exists in table)
        if Index and Value and Value == Object then
            --remove object from the table
            table.remove(Descendants, Index)
        end

        --remote the either modified (if the object was found) table or the original if the object wasn't found
        return Descendants
    end)

    Objects[Object] = Parent
end

local function Create(Info)
    --this function expects a table, so if that table doesn't exist, error
    if Info and type(Info) == 'table' then
        --this table needs ClassName and Parent, so if those don't exist, error
        if Info.ClassName then
            if Info.Parent then
                --create the object using Instance.new
                local Object = Instance.new(Info.ClassName)
                --get the parent
                local Parent = Info.Parent
                --check whether or not the user wants to not hook the index metamethod
                if Info['HookIndex'] then
                    table.insert(DoHookIndex, Object)
                end

                --set the not needed values of the Info table nil
                Info.ClassName = nil
                Info.Parent = nil
                Info['HookIndex'] = nil

                --set the properties of the object to be the same as the Info table, thus why we set the not needed values to nil
                for I, V in next, Info do
                    Object[I] = V
                end

                --hide the object
                Hide(Object, Parent)

                --return the object
                return Object
            else
                error('Failed to get Parent, try Create{ClassName = classnameHere, Parent = parent}.', 2)
            end
        else
            error('Failed to get ClassName, try Create{ClassName = classnameHere}.', 2)
        end
    else
        error('Expected a table as the first parameter, try Create{...}.', 2)
    end
end

do --main hooks
    --hook the game's __namecall metamethod
    local oldNameCall = nil
    oldNameCall = hookmetamethod(game, '__namecall', newcclosure(function(...)
        --get the namecallmethod
        local method = getnamecallmethod()
        
        --check if the method is FindFirstChild or if it is GetChildren or if it is GetDescendants
        if method == 'FindFirstChild' then
            --get the child it's trying to find
            local Child = oldNameCall(...)
            
            --check if the child is the object and if it is, return nil
            if tablefindByIndex(Objects, Child) then
                return nil
            end
            
            --return the child
            return Child
        elseif method == 'GetChildren' then
            --get the original Children table
            local Children = oldNameCall(...)

            --loop through the hidden objects
            for Object, Parent in next, Objects do
                --find the object in the Children table and get it's index if it exists
                local Index, Value = tablefind(Children, Object)

                --check if the index and value exist (object exists in table)
                if Index and Value and Value == Object then
                    --remove object from the table
                    table.remove(Children, Index)
                end
            end
            --remote the either modified (if the object was found) table or the original if the object wasn't found
            return Children
        elseif method == 'GetDescendants' then
            --get the original Descendants table
            local Descendants = oldNameCall(...)

            --loop through the hidden objects
            for Object, Parent in next, Objects do
                --find the object in the Descendants table and get it's index if it exists
                local Index, Value = tablefind(Descendants, Object)

                --check if the index and value exist (object exists in table)
                if Index and Value and Value == Object then
                    --remove object from the table
                    table.remove(Descendants, Index)
                end
            end

            --remote the either modified (if the object was found) table or the original if the object wasn't found
            return Descendants
        end
        
        --return the child(ren) / descendants
        return oldNameCall(...)
    end))

    --hook the game's __index metamethod
    local oldIndex = nil
    oldIndex = hookmetamethod(game, '__index', newcclosure(function(...)
        --get the index and key (again, didn't really know what to name these (index is the parent and key is the name (basically)
        local Index, Key = ...
        --get the child
        local Value = oldIndex(Index, Key)
        
        --check if the child is in the list of objects and if the user wants to hook the index and return the base error just incase the game will check the error
        if tablefindByIndex(Objects, Value) and tablefind(DoHookIndex, Value) then
            return error(tostring(Key) .. ' is not a valid member of ' .. Index.ClassName .. ' "' .. tostring(Index) .. '"', 0)
        end
        
        --return the child
        return Value
    end))
end

return {Create = Create, Hide = Hide}
