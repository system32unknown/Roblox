local PS = game:GetService("Players")
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

function getACS_Class(plr, type)
	if plr.Character:FindFirstChild("ACS_Client") then
		return plr.Character.ACS_Client[type]
	else return nil end
end
for _, v in pairs(PS:GetPlayers()) do
	if getACS_Class(v, "Kit") ~= nil then
		setValue(getACS_Class(v, "Kit").Fortifications, -99999999)
	end
end

function getRNGVec()
	return Vector3.new(math.random(0, 500), math.random(0, 500), math.random(0, 500))
end

function build(vec, min, max)
	for _, v in pairs(PS:GetPlayers()) do
		local lol = v.Character.HumanoidRootPart.CFrame
		ACS_Event.Breach:InvokeServer(3, {
			Fortified = {},
			Destroyable = workspace
		}, CFrame.new(), CFrame.new(), {
			CFrame = lol * CFrame.new(vec),
			Size  = {
				X = math.random(min, max),
				Y = math.random(min, max),
				Z = math.random(min, max)
			}
		})
	end
end

build(getRNGVec(), 1, 800)
