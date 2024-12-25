local PS = game:GetService("Players")

local QU_ADMIN = workspace:FindFirstChild("Qu Admin")
local QU_REMOTE = QU_ADMIN.Code.Remotes

local BAN:RemoteEvent = QU_REMOTE.BanPlayer

for _, v in PS:GetPlayers() do
    BAN:FireServer(unpack({
        [1] = {
            [1] = v.Name
        }
    }))
end