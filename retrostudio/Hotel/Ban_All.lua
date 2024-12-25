local PS = game:GetService("Players")

local QU_ADMIN = workspace:FindFirstChild("Qu Admin")
local QU_REMOTE = QU_ADMIN.Code.Remotes

local BAN:RemoteEvent = QU_REMOTE.BanPlayer

for _, v in PS:GetPlayers() do
    if v == PS.LocalPlayer then continue end
    BAN:FireServer(unpack({
        [1] = {
            [1] = v.Name
        }
    }))
end
task.wait(2)
game:Shutdown()