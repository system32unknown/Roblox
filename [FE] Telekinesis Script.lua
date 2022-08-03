local TelekinesisGUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
TelekinesisGUI.Name = "TelekinesisGUI"

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
	"Key Q = Decrease Distance",
	"Key E = Increase Distance",
	"Key R = Freeze Rotation",
	"Key T = Pull",
	"Key \"-\" = Increase Power",
	"Key \"+\" = Decrease Power",
	"Key X = Clone Object",
	"Key K = Net Bypass",
	"Key B = Pull Torso to Part",

}

function Create_Text(Name, Color, Pos, Size, Text, TextSize)
	local text_frame = Instance.new("TextLabel", SecondFrame)
	text_frame.Name = Name
	text_frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
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
	local pos = {0, (i - 1) * 20}
	Create_Text("Tex_" .. i, Color3.fromRGB(0, 0, 0), pos, {140, 20}, v, 14)
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

local useLegacyObj = true

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
	local dist = nil

    local huge = math.huge * math.huge
	
    local BP = Instance.new("BodyPosition")
    BP.MaxForce = Vector3.new(huge, huge, huge)
    BP.P = BP.P * 1.1
    
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
                        H.CFrame = CFrame.new(front.Position + w.lookVector * 1000)
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
            BP.position = front.Position + w.lookVector * dist
            wait_func()
        end
		
        if useLegacyObj then
            BP:Remove()
        else
            BP:Destroy()
        end
        object = nil
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

        if key == "q" then
            if dist >= 5 then
                dist = dist - 10
            end
        end
		
        if key == "r" then
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
		
        if key == "e" then
            dist = dist + 10
        end
		
        if key == "t" then
            if dist ~= 10 then
                dist = 10
            end
        end
		
        if key == "y" then
            if dist ~= 200 then
                dist = 200
            end
        end
		
        if key == "=" then
            BP.P = BP.P * 1.5
        end
		
        if key == "-" then
            BP.P = BP.P * 0.5
        end

		if key == "x" then
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
		
        if key == "k" then
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
		
		if key == "b" then
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

		if key == "v" then
			FirstFrame.Visible = not FirstFrame.Visible
		end
    end
	
	local function onUnequipOrDeact()
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
				onUnequipOrDeact()
				
                BP:Destroy()
                point:Destroy()
                tool:Destroy()
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
	tool.Unequipped:connect(onUnequipOrDeact)
	tool.Deactivated:connect(onUnequipOrDeact)
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