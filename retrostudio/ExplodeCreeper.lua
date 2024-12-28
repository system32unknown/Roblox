local CREEPER_EVENT = game:GetService("Lighting"):WaitForChild("Events")
local EXPLODE_EVENT = CREEPER_EVENT:WaitForChild("ExplosionEvent")

for _, v in workspace:GetDescendants() do
    EXPLODE_EVENT:FireServer(unpack({
        [1] = {
            [1] = v
        }
    }))
end
