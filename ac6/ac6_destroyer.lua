local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/refs/heads/main/ac6/ac6_api.lua"))()
if not api.delete(game) then
    game.Players.LocalPlayer:Kick("DeleteCar wasn't found in ReplicatedStorage.")
end