local SongList = {3929730934, 5567523008, 2631687985, 188088048, 343430735, 6343741731, 5538547181, 7696427240, 7696491068, 7145372503, 7147215136, 3900067524, 3175432527, 8294288087, 6201427049}
local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/refs/heads/main/ac6/ac6_api.lua"))()

for _, v in pairs(game:GetDescendants()) do
    if v.Name == "AC6_FE_Sounds" then
        local soundshit = SongList[math.random(1, #SongList)]
        v:FireServer(unpack(api.makeSound(math.random(-3, 3), 255, soundshit, v, true)))
    end
end