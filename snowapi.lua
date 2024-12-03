local snow = {}
snow.__index = snow

local RS = game:GetService("ReplicatedStorage")
local PS = game:GetService("Players")

local PD:RemoteEvent = RS:WaitForChild("PlaceDecoration")
local FT:RemoteEvent = RS:WaitForChild("FilterText")
local SH:RemoteEvent = RS:WaitForChild("SnowballHit")

local LocalChr = PS.LocalPlayer.Character

--init
local decos = {}
for _, v in RS:WaitForChild("Decoration"):GetDescendants() do decos[string.lower(v.Name)] = v end
for _, v in RS:WaitForChild("PremiumDecoration"):GetDescendants() do decos[string.lower(v.Name)] = v end

function get_keys(t):table
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

function snow.Draw(deco:string, r:Ray)
	local curDeco = nil
    if deco ~= nil then
        curDeco = deco
    else
        local _dec = get_keys(decos)
        local curDec = _dec[math.random(0, #_dec)]
        if curDec == nil then
            curDeco = "rock"
        else
            curDeco = decos[curDec]
        end
    end
    PD:FireServer(unpack({[1] = curDeco, [2] = r}))
end
function snow.WriteAllText(s:string)
    for _, tb in game:GetDescendants() do
        if tb:IsA("TextBox") or tb:IsA("TextLabel") then
            FT:FireServer(unpack({[1] = s, [2] = tb}))
        end
    end
end

function snow.Shovel(dig:boolean, digtype:string, vec3:Vector3)
    local shovelType = LocalChr:FindFirstChild(digtype)
    local mod:RemoteEvent = RS:FindFirstChild(dig and "Dig" or "Place")
    if dig then
        mod:FireServer(unpack({[1] = shovelType, [2] = vec3}))
    else
        mod:FireServer(unpack({[1] = shovelType, [2] = vec3, [3] = false}))
    end
end

function snow.Launch(location:Vector3, rad, height)
SH:FireServer(unpack({
    [1] = {
        [1] = workspace:WaitForChild("Baseplate"),
        [2] = location
    },
    [2] = rad,
    [3] = height
))
end

return snow
