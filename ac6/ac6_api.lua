local acs = {}
acs.__indexd = acs

local RS = game:GetService('ReplicatedStorage')
local DC = RS:FindFirstChild("DeleteCar")

function acs.makeSound(pitch:number, vol:number, sndID:number, Remote:RemoteEvent, looped:boolean)
    looped = looped or true
	local randomized_id = "HACK_".. math.random(5838327) .. "_PROTECTED" .. math.random(5838327)
   	Remote:FireServer(unpack({
		[1] = "newSound",
		[2] = randomized_id,
		[3] = game:GetService("InsertService"),
		[4] = 'rbxassetid://' .. sndID,
		[5] = pitch,
		[6] = vol,
		[7] = looped
	}))
	return {[1] = "playSound", [2] = randomized_id}
end
function acs.delete(i:Instance):boolean
    if not DC then
        print("DeleteCar wasn't found in ReplicatedStorage")
        return false
    end

    for _, v in i:GetDescendants() do
        if v == DC or v == game.Players.LocalPlayer then continue end
        DC:FireServer(v)
    end
    return true
end

return acs