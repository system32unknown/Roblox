local banName = "BanPlr"
local aMethod = 1

function getInstance(name:string, instanceName:string)
    for _, even in game:GetDescendants() do
        if even.Name == name and even:IsA(instanceName) then
            return even
        end
    end
    return nil
end

local banPlr = getInstance(banName, "RemoteEvent")
local PS = game:GetService("Players")

local function ban(p, reason)
    local bantable = {}
    if aMethod == 1 then
        bantable = {
            [1] = {
                [1] = p,
                [2] = p,
                [3] = reason
            }
        }
    elseif aMethod == 2 then
        bantable = {
            [1] = {
                [1] = p.UserId,
                [2] = p.UserId,
                [3] = reason
            }
        }
    elseif aMethod == 3 then
        bantable = {
            [1] = p.UserId,
            [2] = '',
            [3] = '',
            [4] = '',
            [5] = '',
        }
    else
        bantable = {
            [1] = p,
            [2] = '',
            [3] = '',
            [4] = '',
            [5] = '',
        }
    end
    banPlr:FireServer(unpack(bantable))
end

for _, p in PS:GetPlayers() do
    if p == PS.LocalPlayer then continue end
    ban(p, "Exploiting")
end