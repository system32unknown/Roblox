local LP = game:GetService("Lighting")
local GUN_SYS = LP:WaitForChild("gun_system"):WaitForChild("Remotes")

function getType(istan:Instance, type_name:string):table
    local type_tbl = {}
    for _, even in istan:GetDescendants() do
        if even:IsA(type_name) then
            table.insert(type_tbl, even)
        end
    end
    return type_tbl
end

local global_snd = getType(game, "Sound")
for _, v in game:GetDescendants() do
    GUN_SYS:WaitForChild("play_audio"):FireServer(unpack({
        [1] = v,
        [2] = global_snd[math.random(0, #global_snd)],
        [3] = "",
        [4] = "",
        [5] = ""
    }))
end