local sound_method = "play_audio"
local loop = 100

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

function playSND(s:Sound)
    for _, v in pairs(getType(game, "RemoteEvent", sound_method)) do
        if sound_method == "play_audio" then
            local gd = game:GetDescendants()
            v:FireServer(unpack({
                [1] = gd[math.random(0, #gd)],
                [2] = s,
                [3] = "",
                [4] = "",
                [5] = ""
            }))
        else
            v:FireServer(unpack({[1] = {[1] = s}}))
        end
    end
end

local global_snd = getType(game, "Sound", nil)
for _ = 0, loop do
    playSND(global_snd[math.random(0, #global_snd)])
end