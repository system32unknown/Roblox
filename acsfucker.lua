local RS = game:GetService('ReplicatedStorage')
for _, object in pairs(RS:GetDescendants()) do
    if not RS:FindFirstChild("ACS_Engine") then
        print("RemoteEvent '" .. object.Name .. "' not found!")
        return
    end
end
local ACS_Event = RS['ACS_Engine'].Events
function setValue(ValueObj, NewValue)
	ACS_Event.Refil:FireServer(ValueObj, NewValue)
end

local FUCKING_NIL = math.huge * math.huge

for _, obj in pairs(game:GetDescendants()) do
	if obj:IsA("NumberValue") or obj:IsA("IntValue") then
		setValue(obj, FUCKING_NIL)
	end
end
