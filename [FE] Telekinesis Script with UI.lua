---@diagnostic disable-next-line: undefined-global
if AlreadyEquipped then
    print("Telekinesis Script with UI is already running.")
    return
end

getgenv().AlreadyEquipped = true
local TelekinesisGUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
TelekinesisGUI.Name = "TelekinesisGUI"
local VERSION = "v1.3"

local FirstFrame = Instance.new("Frame", TelekinesisGUI)
FirstFrame.Name = "FirstFrame"
FirstFrame.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
FirstFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
FirstFrame.Position = UDim2.new(0, 500, 0, 200)
FirstFrame.Size = UDim2.new(0, 150, 0, 200)
FirstFrame.Draggable = true
FirstFrame.Visible = false

local SecondFrame = Instance.new("Frame", FirstFrame)
SecondFrame.Name = "SecondFrame"
SecondFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SecondFrame.Position = UDim2.new(0, 5, 0, 5)
SecondFrame.Size = UDim2.new(0, 140, 0, 190)

local label_Text = {
	"Decrease Distance",
	"Increase Distance",
	"Freeze Rotation",
	"Pull",
    "Throw",
	"Increase Power",
	"Decrease Power",
	"Clone Object",
	"Net Bypass",
	"Pull Torso to Part",
    "Show Help Menu"
}

local Keys_Settings = getgenv().Keys_Settings or {
    ["Increase Distance"] = "q",
    ["Decrease Distance"] = "e",
    ["Freeze Rotation"] = "r",
    ["Pull"] = "t",
	["Throw"] = "y",
    ["Increase Power"] = "-",
    ["Decrease Power"] = "+",
    ["Clone Object"] = "x",
    ["Net Bypass"] = "k",
    ["Pull Torso to Part"] = "b",
    ["Show Help Menu"] = "v"
}

local E_PowerText = Instance.new("TextLabel", TelekinesisGUI)
E_PowerText.Name = "E_PowerText"
E_PowerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E_PowerText.BackgroundTransparency = 1
E_PowerText.Position = UDim2.new(0.825, 0, 0.925, 0)
E_PowerText.Size = UDim2.new(0, 227, 0, 11)
E_PowerText.Font = Enum.Font.SourceSans
E_PowerText.Text = "Power: 0"
E_PowerText.TextColor3 = Color3.fromRGB(0, 0, 0)
E_PowerText.TextSize = 16
E_PowerText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
E_PowerText.TextStrokeTransparency = 0
E_PowerText.TextWrapped = true
E_PowerText.TextXAlignment = Enum.TextXAlignment.Right
E_PowerText.TextYAlignment = Enum.TextYAlignment.Bottom

local E_OwnerText = Instance.new("TextLabel", TelekinesisGUI)
E_OwnerText.Name = "E_OwnerText"
E_OwnerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E_OwnerText.BackgroundTransparency = 1
E_OwnerText.Position = UDim2.new(0.825, 0, 0.945, 0)
E_OwnerText.Size = UDim2.new(0, 227, 0, 11)
E_OwnerText.Font = Enum.Font.SourceSans
E_OwnerText.Text = "Ownership: nil"
E_OwnerText.TextColor3 = Color3.fromRGB(0, 0, 0)
E_OwnerText.TextSize = 16
E_OwnerText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
E_OwnerText.TextStrokeTransparency = 0
E_OwnerText.TextWrapped = true
E_OwnerText.TextXAlignment = Enum.TextXAlignment.Right
E_OwnerText.TextYAlignment = Enum.TextYAlignment.Bottom

local E_DistanceText = Instance.new("TextLabel", TelekinesisGUI)
E_DistanceText.Name = "E_DistanceText"
E_DistanceText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E_DistanceText.BackgroundTransparency = 1
E_DistanceText.Position = UDim2.new(0.825, 0, 0.965, 0)
E_DistanceText.Size = UDim2.new(0, 227, 0, 11)
E_DistanceText.Font = Enum.Font.SourceSans
E_DistanceText.Text = "Distance: 0"
E_DistanceText.TextColor3 = Color3.fromRGB(0, 0, 0)
E_DistanceText.TextSize = 16
E_DistanceText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
E_DistanceText.TextStrokeTransparency = 0
E_DistanceText.TextWrapped = true
E_DistanceText.TextXAlignment = Enum.TextXAlignment.Right
E_DistanceText.TextYAlignment = Enum.TextYAlignment.Bottom

local E_SelectedText = Instance.new("TextLabel", TelekinesisGUI)
E_SelectedText.Name = "E_SelectedText"
E_SelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E_SelectedText.BackgroundTransparency = 1
E_SelectedText.Position = UDim2.new(0.825, 0, 0.985, 0)
E_SelectedText.Size = UDim2.new(0, 227, 0, 11)
E_SelectedText.Font = Enum.Font.SourceSans
E_SelectedText.Text = "Selected Object: nil"
E_SelectedText.TextColor3 = Color3.fromRGB(0, 0, 0)
E_SelectedText.TextSize = 16
E_SelectedText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
E_SelectedText.TextStrokeTransparency = 0
E_SelectedText.TextWrapped = true
E_SelectedText.TextXAlignment = Enum.TextXAlignment.Right
E_SelectedText.TextYAlignment = Enum.TextYAlignment.Bottom

local E_VersionText = Instance.new("TextLabel", TelekinesisGUI)
E_VersionText.Name = "E_VersionText"
E_VersionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
E_VersionText.BackgroundTransparency = 1
E_VersionText.Position = UDim2.new(0, 0, 0.95, 0)
E_VersionText.Size = UDim2.new(0, 227, 0, 33)
E_VersionText.Font = Enum.Font.Code
E_VersionText.Text = "Telekinesis Script FE\nModded By Friskshift " .. VERSION
E_VersionText.TextColor3 = Color3.fromRGB(0, 0, 0)
E_VersionText.TextSize = 16
E_VersionText.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
E_VersionText.TextStrokeTransparency = 0
E_VersionText.TextWrapped = true
E_VersionText.TextXAlignment = Enum.TextXAlignment.Left
E_VersionText.TextYAlignment = Enum.TextYAlignment.Bottom

function Create_Text(Name, Color, Pos, Size, Text, TextSize)
	local text_frame = Instance.new("TextLabel", SecondFrame)
	text_frame.Name = Name
	text_frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	text_frame.BackgroundTransparency = 1
	text_frame.Position = UDim2.new(0, Pos[1], 0, Pos[2])
	text_frame.Size = UDim2.new(0, Size[1], 0, Size[2])
	text_frame.Font = Enum.Font.SourceSans
	text_frame.Text = Text
	text_frame.TextColor3 = Color
	text_frame.TextSize = TextSize
	text_frame.TextXAlignment = Enum.TextXAlignment.Left
end

for i, v in pairs(label_Text) do
	local pos = {0, (i - 1) * 15}
	Create_Text("Tex_" .. i, Color3.fromRGB(0, 0, 0), pos, {140, 20}, "Key "..string.upper(Keys_Settings[v])..": "..v, 14)
end

--The Script--
function sandbox(var, func)
	local env = getfenv(func)
	local newenv = setmetatable({}, {
		__index = function(self, k)
			if k == "script" then
				return var
			else
				return env[k]
			end
		end}
	)
	setfenv(func, newenv)
	return func
end
local useLegacyObj = getgenv().useLegacyObj or false

local wait_func = useLegacyObj and wait or task.wait
local hiddenproperty = sethiddenproperty or set_hidden_property or set_hidden_prop
local simulationradius = setsimulationradius or set_simulation_radius

local RenderStep = nil
local scripts = {}

local Model_tel = Instance.new("Model", game:GetService("Lighting"))

local tool = Instance.new("Tool", Model_tel)
tool.Name = "Telekinesis"
tool.Grip = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0)
tool.GripForward = Vector3.new(0, -1, 0)
tool.GripRight = Vector3.new(0, 0, 1)
tool.GripUp = Vector3.new(1, 0, 0)
tool.CanBeDropped = false

local handle = Instance.new("Part", tool)
handle.Name = "Handle"
handle.CFrame = CFrame.new(-17, 15, 46, 0, 1, 0, 1, 0, 0, 0, 0, -1)
handle.Position = Vector3.new(-17, 15, 46)
handle.Rotation = Vector3.new(-180, 0, 90)
handle.Color = Color3.new(0.5, 0.5, 0.5)
handle.Transparency = 0.5
handle.Size = Vector3.new(1, 1, 1)
handle.Material = Enum.Material.Metal

local TelekinesisScript = Instance.new("LocalScript", tool)
TelekinesisScript.Name = "MainScript"
table.insert(scripts, sandbox(TelekinesisScript, function()
    wait_func()
    local tool = script.Parent
    local object = nil
    local mousedown = false
	local dist = 0

    local huge = math.huge * math.huge
	
    local BP = Instance.new("BodyPosition")
    BP.MaxForce = Vector3.new(huge, huge, huge)
    BP.P = BP.P * 1.1
	E_PowerText.Text = "Power: " .. math.floor(BP.P)
    
	local hooked = false 
	local hookBP = BP:clone()
	hookBP.maxForce = BP.MaxForce
	
    local point = Instance.new("Part")
    point.Locked = true
    point.Anchored = true
    point.Shape = Enum.PartType.Ball
    point.BrickColor = BrickColor.new("Toothpaste")
    point.Transparency = 0.5
    point.Size = Vector3.new(1, 1, 1)
    point.CanCollide = false
	
    local mesh = Instance.new("SpecialMesh", point)
    mesh.MeshType = "Sphere"
    mesh.Scale = Vector3.new(.7, .7, .7)
	
    local front = tool.Handle
	
    local function onButton1Down(mouse)
        if mousedown then
            return
        end

        mousedown = true
        coroutine.resume(coroutine.create(function()
            local H = point:Clone()
            H.Parent = tool
            while mousedown do
                H.Parent = tool
                if object == nil then
                    if mouse.Target == nil then
                        local w = CFrame.new(front.Position, mouse.Hit.p)
                        H.CFrame = CFrame.new(front.Position + w.LookVector * 1000)
                    else
                        H.CFrame = CFrame.new(mouse.Hit.p)
                    end
                else
                    break
                end
                wait_func()
            end
            H:Destroy()
        end))
		
        while mousedown do
            if mouse.Target ~= nil then
                local target = mouse.Target
                if not target.Anchored then
                    object = target
                    dist = (object.Position - front.Position).magnitude
                    E_SelectedText.Text = "Selected: " .. target.Name
                    E_DistanceText.Text = "Distance: " .. math.floor(dist) * .5
                    local s, r = pcall(function()
                        if target:CanSetNetworkOwnership() then
                            E_OwnerText.Text = "Ownership: " .. target:GetNetworkOwner()
                        end
                    end)
                    if not s then
                        print("[ERROR]: " .. r)
                    end
                    break
                end
            end
            wait_func()
        end
		
        while mousedown do
            if object.Parent == nil then
                break
            end
            local w = CFrame.new(front.Position, mouse.Hit.p)
            BP.Parent = object
            BP.position = front.Position + w.LookVector * dist
            wait_func()
        end
		
        if useLegacyObj then
            BP:Remove()
        else
            BP:Destroy()
        end
        object = nil

        E_SelectedText.Text = "Selected: nil"
        E_DistanceText.Text = "Distance: nil"
        E_OwnerText = "Ownership: nil"
    end

	local function take_ownership(boolean)
		if boolean then
			if RenderStep == nil then
            	RenderStep = game:GetService("RunService").RenderStepped:Connect(function()
            	    local s, r = pcall(function()
            	        settings().Physics.AllowSleep = false
            	        hiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
            	        hiddenproperty(game:GetService("Players").LocalPlayer, "MaxSimulationRadius", math.huge)
            	        game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.huge
            	        game:GetService("Players").LocalPlayer.ReplicationFocus = workspace
            	    end)
					
					if not s then
						error(r)
					end
            	end)
            	game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Simple Net",
					Text = "Enabled"
				})
			end
		else
			if RenderStep ~= nil then
            	RenderStep:Disconnect()
            	wait_func()
            	RenderStep = nil
            	if simulationradius then
            	    simulationradius(139, 139)
            	else
            	    hiddenproperty(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", 139)
            	    hiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", 139)
            	end
            	wait_func()
            	game:GetService("StarterGui"):SetCore("SendNotification", {
            	    Title = "Simple Net",
            	    Text = "Disabled"
            	})
			end
		end
	end

    local function onKeyDown(key)
        local key = key:lower()

        if key == Keys_Settings["Increase Distance"] then
            if dist >= 5 then
                dist = dist - 10
            end
        end

        if key == Keys_Settings["Decrease Distance"] then
            dist = dist + 10
        end
		
        if key == Keys_Settings["Freeze Rotation"] then
            if object == nil then
                return
            end

            for _, N in pairs(object:children()) do
                if N.className == "BodyGyro" then
                    return nil
                end
            end
			
            local BG = Instance.new("BodyGyro")
            BG.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BG.cframe = CFrame.new(object.CFrame.p)
            BG.Parent = object

            repeat
                wait_func()
            until object.CFrame == CFrame.new(object.CFrame.p)
            BG.Parent = nil
			
            if object == nil then
                return
            end

            for _, N in pairs(object:children()) do
                if N.className == "BodyGyro" then
                    N.Parent = nil
                end
            end

            object.Velocity = Vector3.zero
            object.RotVelocity = Vector3.zero
            object.Orientation = Vector3.zero
        end
		
        if key == Keys_Settings["Pull"] then
            if dist ~= 10 then
                dist = 10
            end
        end
		
        if key == Keys_Settings["Throw"] then
            if dist ~= 200 then
                dist = 200
            end
        end
		
        if key == Keys_Settings["Decrease Power"] then
            BP.P = BP.P * 1.5
        end
		
        if key == Keys_Settings["Increase Power"] then
            BP.P = BP.P * 0.5
        end

		if key == Keys_Settings["Clone Object"] then
			if object == nil then
                return
            end
			
			local New = object:Clone()
			New.Parent = object.Parent
			for _, v in pairs(New:children()) do
				if v.className == "BodyPosition" or v.className == "BodyGyro" then
					v.Parent = nil
				end
			end
		
			object = New
		end
		
        if key == Keys_Settings["Net Bypass"] then
            if hiddenproperty then
                if RenderStep == nil then
					take_ownership(true)
                else
					take_ownership(false)
                end
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Script Error", 
                    Text = "Missing sethiddenproperty"
                })
            end
        end
		
		if key == Keys_Settings["Pull Torso to Part"] then
			if not hooked then
				if object == nil then
					return
				end 
				hooked = true
				hookBP.position = object.Position
				if tool.Parent:FindFirstChild("Torso") then
					hookBP.Parent = tool.Parent.Torso
					if dist ~= (object.Size.x + object.Size.y + object.Size.z) + 5 then
						dist = (object.Size.x + object.Size.y + object.Size.z) + 5
					end
				end
			else
				hooked = false
				hookBP.Parent = nil
			end
		end

		if key == Keys_Settings["Show Help Menu"] then
			FirstFrame.Visible = not FirstFrame.Visible
		end

        if mousedown then
            E_DistanceText.Text = "Distance: " .. math.floor(dist) * .5
        end

        if BP then
            E_PowerText.Text = "Power: " .. math.floor(BP.P)
        else
            E_PowerText.Text = "Power: nil"
        end
    end
	
	local function onUnequip()
		mousedown = false
		hooked = false
		if FirstFrame.Visible then
			FirstFrame.Visible = false
		end
	end
	
    local function onEquipped(mouse)
        local human = tool.Parent.Humanoid
		
        human.Changed:connect(function()
            if human.Health == 0 then
				onUnequip()
				
                if useLegacyObj then
                    BP:Remove()
                    point:Remove()
                    tool:Remove()
                else
                    BP:Destroy()
                    point:Destroy()
                    tool:Destroy()
                end

                getgenv().AlreadyEquipped = false
            end
        end)

        mouse.Button1Down:connect(function()
            onButton1Down(mouse)
        end)

        mouse.Button1Up:connect(function()
            mousedown = false
        end)

        mouse.KeyDown:connect(function(key)
            onKeyDown(key)
        end)
        mouse.Icon = "rbxasset://textures\\GunCursor.png"
    end

    tool.Equipped:connect(onEquipped)
	tool.Unequipped:connect(onUnequip)
end))

for _, v in pairs(Model_tel:GetChildren()) do
    v.Parent = game:GetService("Players").LocalPlayer.Backpack
    local s, r = pcall(function()
		if v.ClassName ~= "Tool" then
            v:MakeJoints()
        end
    end)
	
    if not s then
        error(r)
    end
end

Model_tel:Destroy()

for i, v in pairs(scripts) do
    task.spawn(function()
        local s, r = pcall(v)
        if not s then
            error(r)
        end
    end)
	print("checking: " .. tostring(v) .. " - " .. i)
end
