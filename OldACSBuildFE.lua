local RS = game:GetService("ReplicatedStorage")
local PS = game:GetService("Players")

RS['ACS_Engine'].Eventos.Recarregar:FireServer(9999999, {
    ACS_Modulo = {
        Variaveis = {
            StoredAmmo = PS.LocalPlayer.Character.ACS_Client.Kit.Fortifications
        }
    }
})

function Build(remote:RemoteFunction, target:Player, pos:Vector3, size:Vector3)
    remote:InvokeServer(3, {Fortified = {}, Destroyable = workspace}, CFrame.new(), CFrame.new(), {CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(pos), Size = CFrame.new(size)})
end

function getRNGVector(min:number, max:number):Vector3
    min = min or 0
    max = max or 255
    return Vector3.new(math.random(min, max), math.random(min, max), math.random(min, max))
end

for _, v in next, RS:GetDescendants() do
    if v.Name == 'Breach' and v:IsA('RemoteFunction') then
        Build(v, PS[math.random(0, #PS)], getRNGVector(-500, 500), getRNGVector(1, 500))
    end
end
