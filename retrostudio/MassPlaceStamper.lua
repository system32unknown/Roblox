local radius = 100
local times = 100

function getInstance(name:string, instanceName:string)
    local t = {}
    for _, even in game:GetDescendants() do
        if even.Name == name and even:IsA(instanceName) then
            table.insert(t, even)
        end
    end
    return t
end

local p = getInstance("Place", "RemoteFunction")
local gg = game:GetDescendants()

local github = 'https://raw.githubusercontent.com/system32unknown/'
local suffix = '/refs/heads/main/'
local RNG = loadstring(game:HttpGet(github .. 'Roblox' .. suffix .. 'RNG_LIB.lua'))()

for _ = 0, times do
    for _, remote in pairs(p) do
        remote:InvokeServer(unpack({
            [1] = {
                [1] = gg[math.random(0, #gg)],
                [2] = RNG.CFrame(radius, 360),
                [3] = gg[math.random(0, #gg)]
            }
        }))
    end
end