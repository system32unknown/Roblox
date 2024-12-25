local github = 'https://raw.githubusercontent.com/system32unknown/'
local suffix = '/refs/heads/main/'
local RNG = loadstring(game:HttpGet(github .. 'Roblox' .. suffix .. 'RNG_LIB.lua'))()

function getType(istan:Instance, type_name:string, name:string):table
    local type_tbl = {}
    for _, even in istan:GetDescendants() do
        if even:IsA(type_name) then
            if name == nil then
                table.insert(type_tbl, even)
            elseif even.Name == name then
                table.insert(type_tbl, even)
            end
        end
    end
    return type_tbl
end

local ev = getType(game, "RemoteEvent", "Plant")
for _, v in game:GetDescendants() do
    for _, lol in pairs(ev) do
        lol:FireServer(unpack({
            [1] = {
                [1] = RNG.CFrame(100, 360),
                [2] = v
            }
        }))
    end
end