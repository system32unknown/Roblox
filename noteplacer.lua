local loops = 100

local github = 'https://raw.githubusercontent.com/system32unknown/'
local suffix = '/refs/heads/main/'

local RNG = loadstring(game:HttpGet(github .. 'Roblox' .. suffix .. 'RNG_LIB.lua'))()
local NOTE = loadstring(game:HttpGet(github .. 'Roblox' .. suffix .. 'retrostudio/noteapi.lua'))()

for i = 0, loops do
    NOTE.change(RNG.Char(300, 100), RNG.Color())
    NOTE.place(RNG.Vector(200), RNG.Vector(200))
end