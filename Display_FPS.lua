repeat task.wait() until game:IsLoaded()
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ST = game:GetService("Stats")

local Text = nil

_G.Bitch = not _G.Bitch
local peak = 0

local intervalArray = {'MB', 'GB'}
function getInterval(num)
	local size = num;
	local data = 0;
	while size >= 1024 and data < #intervalArray - 1 do
		data = data + 1;
		size = size / 1024;
	end
	return size .. ' ' .. intervalArray[data];
end

if _G.Bitch then
    Text = Drawing.new("Text")
    Text.Color = Color3.new(0, 1, 1)
    Text.Font = Drawing.Fonts.System
    Text.Outline = true
    Text.OutlineColor = Color3.new(0, 0, 0)
    Text.Position = Vector2.new(0, 30)
    Text.Size = 22
    Text.Text = "Loading"
    Text.Visible = false
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local Text_Pos = Vector2.new(Text.TextBounds.X, Text.Position.Y)
    Text.Position = Vector2.new(Camera.ViewportSize.X / Text_Pos.X, Text_Pos.Y)
end)

RunService.RenderStepped:Connect(function(v)
    pcall(function()
        if _G.Bitch then
			local mem = math.round(ST:GetTotalMemoryUsageMb())
			if mem > peak then peak = mem end

            Text.Visible = true
            Text.Text = "Server uptime: " .. math.floor(Workspace.DistributedGameTime) ..
            "\nPing: " .. ST.Network.ServerStatsItem["Data Ping"]:GetValueString(math.round(2 / v)) ..
            "\nFPS: " .. math.round(1 / v) .. " [MS: " .. string.format("%.2f", v) .. "]" ..
            "\nMEM: " .. getInterval(mem) .. " / PEAK: " .. getInterval(peak) ..
			"\nPlayer Count: " ..#Players:GetPlayers()
            Text.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        elseif not _G.Bitch then
            Text:Remove()
        end
    end)
end)