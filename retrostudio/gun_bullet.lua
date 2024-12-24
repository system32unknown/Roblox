local LP = game:GetService("Lighting")
local PS = game:GetService("Players")
local GUN_SYS = LP:WaitForChild("gun_system"):WaitForChild("Remotes")

local plrs = PS:GetPlayers()

function getRoot(char):Part
	return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
end

local github = 'https://raw.githubusercontent.com/system32unknown/'
local suffix = '/refs/heads/main/'
local RNG = loadstring(game:HttpGet(github .. 'Roblox' .. suffix .. 'RNG_LIB.lua'))()

for _, v in game:GetDescendants() do
    local selected_plr = plrs[math.random(0, #plrs)]
    if selected_plr.Character == nil then continue end

    local chr = getRoot(selected_plr.Character)
    if chr == nil then continue end
    GUN_SYS:WaitForChild("bullet_visual"):FireServer(unpack({
        [1] = v,
        [2] = chr.Position + RNG.Vector(10),
        [3] = chr.Position + RNG.Vector(10),
        [4] = "",
        [5] = ""
    }))
end