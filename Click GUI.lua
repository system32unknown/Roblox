if getgenv().loaded then
	print("it's already running!")
	return
end

pcall(function()
	getgenv().loaded = true
	game.StarterGui:SetCore("SendNotification", {
		Title = "Loaded!";
		Text = "Click GUI v2 has loaded! Enjoy!";
		Icon = "rbxthumb://type=Asset&id=4914902918&w=150&h=150";
		Duration = 2;
	})
end)

local function getTypeCounter(type)
	local result = 0
	for _, object in pairs(workspace:GetDescendants()) do
		if object:IsA(type) then
			result = result + 1
		end
	end
	return result
end

-- Instances:
local ExploitGUI = Instance.new("ScreenGui")
local FirstFrame = Instance.new("Frame")
local SecondFrame = Instance.new("Frame")
local FireClick = Instance.new("TextButton")
local RandomPitch = Instance.new("TextButton")
local UnlockParts = Instance.new("TextButton")
local TriggerTouch = Instance.new("TextButton")
local ShowSelectionClick = Instance.new("TextButton")
local MaxActive = Instance.new("TextButton")
local ShowSelectionTouch = Instance.new("TextButton")
local Rstop = Instance.new("TextButton")
local KickMe = Instance.new("TextButton")
local FirePause = Instance.new("TextButton")
local ReasonText = Instance.new("TextBox")
local InfoFrame = Instance.new("Frame")
local Background = Instance.new("Frame")
local ClickCountText = Instance.new("TextLabel")
local TouchCountText = Instance.new("TextLabel")
local DestroyGUI = Instance.new("TextButton")
local TitleName = Instance.new("TextLabel")
local SpamButton = Instance.new("TextButton")
local RandomButton = Instance.new("TextButton")
local SpamRandomButton = Instance.new("TextButton")
local FireProButton = Instance.new("TextButton")
local SpamFireProButton = Instance.new("TextButton")
local SpamTouchInts = Instance.new("TextButton")
local SpamInterval = Instance.new("TextBox")
local LegacyR = Instance.new("TextButton")
local PlayerListFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UI = Instance.new("UIListLayout")
local PlrLabel = Instance.new("TextLabel")
local script = Instance.new('LocalScript', PlayerListFrame)
local RunService = game:GetService("RunService")

local isClickShown = false
local isTouchShown = false
local isSpammingTouch = false
local isSpammingTouchInt = false
local isSpammingRandomTouch = false
local isSpammingProximity = false
local UseLegacy = false
local FirePrompt = fireproximityprompt
local RenderStop = true
local LocalPlayer = game:GetService("Players").LocalPlayer

function Click(v)
	local _c = click_detector or fireclickdetector
	if v.Name ~= "ButtonEle1" and v.Name ~= "ButtonEle2" then
		_c(v)
	end
end

function ClrList()
	for _, item in pairs(ScrollingFrame:GetChildren()) do
		if item:IsA("TextLabel") then
			item:Destroy()
		end
	end
end
	
function FillList()
	ClrList()
	for _, Plr in pairs(game.Players:GetChildren()) do
		if not ScrollingFrame:FindFirstChild(Plr.Name) then
			local new = PlrLabel:Clone()
			new.Name = Plr.Name
			new.Text = Plr.Name
			new.Parent = ScrollingFrame
		end
	end
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UI.AbsoluteContentSize.Y)
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local Root = getRoot(LocalPlayer.Character) or LocalPlayer.Character:FindFirstChildWhichIsA("BasePart")
local function Touch(x)
	x = x.FindFirstAncestorWhichIsA(x, "Part")
	if x then
		if firetouchinterest then
			return task.spawn(function()
				firetouchinterest(x, Root, 1, wait() and firetouchinterest(x, Root, 0))
			end)
		end
		x.CFrame = Root.CFrame
	end
end

FillList()
game.Players.PlayerAdded:Connect(FillList)
game.Players.PlayerRemoving:Connect(FillList)

local foo = RunService.RenderStepped:Connect(function()
	if not RenderStop then
		ClickCountText.Text = "Clickable Count: " .. getTypeCounter("ClickDetector")
		TouchCountText.Text = "Touchable Count: " .. getTypeCounter("TouchTransmitter")
	end
end)

--Properties:

ExploitGUI.Name = "ExploitGUI"
ExploitGUI.Parent = game:GetService("CoreGui")

FirstFrame.Name = "FirstFrame"
FirstFrame.Parent = ExploitGUI
FirstFrame.Active = true
FirstFrame.BackgroundColor3 = Color3.fromRGB(0, 90, 247)
FirstFrame.BackgroundTransparency = 0.25
FirstFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
FirstFrame.Position = UDim2.new(0, 566, 0, 262)
FirstFrame.Size = UDim2.new(0, 310, 0, 180)
FirstFrame.Draggable = true

SecondFrame.Name = "SecondFrame"
SecondFrame.Parent = FirstFrame
SecondFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SecondFrame.BackgroundTransparency = 0.25
SecondFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
SecondFrame.Position = UDim2.new(0, 5, 0, 25)
SecondFrame.Size = UDim2.new(0, 300, 0, 150)

FireClick.Name = "FireClick"
FireClick.Parent = SecondFrame
FireClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FireClick.Size = UDim2.new(0, 65, 0, 20)
FireClick.Font = Enum.Font.SourceSans
FireClick.Text = "Fire Click Detectors"
FireClick.TextColor3 = Color3.fromRGB(0, 0, 0)
FireClick.TextScaled = true
FireClick.TextSize = 14
FireClick.TextWrapped = true
FireClick.MouseButton1Click:Connect(function()
	for _, object in pairs(workspace:GetDescendants()) do
		if object:IsA("ClickDetector") then
			Click(object)
		end
	end
end)

RandomPitch.Name = "RandomPitch"
RandomPitch.Parent = SecondFrame
RandomPitch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RandomPitch.Position = UDim2.new(0, 75, 0, 0)
RandomPitch.Size = UDim2.new(0, 65, 0, 20)
RandomPitch.Font = Enum.Font.SourceSans
RandomPitch.Text = "Random Pitch"
RandomPitch.TextColor3 = Color3.fromRGB(0, 0, 0)
RandomPitch.TextScaled = true
RandomPitch.TextSize = 14
RandomPitch.TextWrapped = true
RandomPitch.MouseButton1Click:Connect(function()
	for i, object in pairs(game.Workspace:GetDescendants()) do
		if object:IsA("Sound") then
			object.PlaybackSpeed = math.random(1, 3);
		end
	end
end)

UnlockParts.Name = "UnlockParts"
UnlockParts.Parent = SecondFrame
UnlockParts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UnlockParts.Position = UDim2.new(0, 75, 0, 30)
UnlockParts.Size = UDim2.new(0, 65, 0, 20)
UnlockParts.Font = Enum.Font.SourceSans
UnlockParts.Text = "Unlock Parts"
UnlockParts.TextColor3 = Color3.fromRGB(0, 0, 0)
UnlockParts.TextScaled = true
UnlockParts.TextSize = 14
UnlockParts.TextWrapped = true
UnlockParts.MouseButton1Click:Connect(function()
	local function unlockEverything(obj)
		for _, o in pairs(obj:GetChildren())do
			if o:IsA("BasePart") then
				o.Locked = false
			end
			unlockEverything(o)
		end
	end
	unlockEverything(workspace)
end)

TriggerTouch.Name = "TriggerTouch"
TriggerTouch.Parent = SecondFrame
TriggerTouch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TriggerTouch.Position = UDim2.new(0, 0, 0, 30)
TriggerTouch.Size = UDim2.new(0, 65, 0, 20)
TriggerTouch.Font = Enum.Font.SourceSans
TriggerTouch.Text = "Trigger Touch Interests"
TriggerTouch.TextColor3 = Color3.fromRGB(0, 0, 0)
TriggerTouch.TextScaled = true
TriggerTouch.TextSize = 14
TriggerTouch.TextWrapped = true
TriggerTouch.MouseButton1Click:Connect(function()
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("TouchTransmitter") then
			Touch(v)
		end
	end
end)

ShowSelectionClick.Name = "ShowSelectionClick"
ShowSelectionClick.Parent = SecondFrame
ShowSelectionClick.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ShowSelectionClick.Position = UDim2.new(0, 150, 0, 30)
ShowSelectionClick.Size = UDim2.new(0, 65, 0, 20)
ShowSelectionClick.Font = Enum.Font.SourceSans
ShowSelectionClick.Text = "Show Selection Click"
ShowSelectionClick.TextColor3 = Color3.fromRGB(0, 0, 0)
ShowSelectionClick.TextScaled = true
ShowSelectionClick.TextSize = 14
ShowSelectionClick.TextWrapped = true
ShowSelectionClick.MouseButton1Click:Connect(function()
	if not isClickShown then
		for _, object in pairs(workspace:GetDescendants()) do
			if object:IsA("ClickDetector") and object.parent:FindFirstChild("SelectionBox") == nil then
				Instance.new("SelectionBox", object.parent).Adornee = object.parent
			end
		end
		ShowSelectionClick.Text = "Hide Selection Click"
		ShowSelectionClick.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		for _, object in pairs(workspace:GetDescendants()) do
			if object:IsA("ClickDetector") and object.parent:FindFirstChild("SelectionBox") ~= nil then
				object.parent:FindFirstChild("SelectionBox"):Destroy()
			end
		end
		ShowSelectionClick.Text = "Show Selection Click"
		ShowSelectionClick.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	isClickShown = not isClickShown
end)

MaxActive.Name = "MaxActive"
MaxActive.Parent = SecondFrame
MaxActive.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MaxActive.Position = UDim2.new(0, 150, 0, 0)
MaxActive.Size = UDim2.new(0, 65, 0, 20)
MaxActive.Font = Enum.Font.SourceSans
MaxActive.Text = "Max Activation"
MaxActive.TextColor3 = Color3.fromRGB(0, 0, 0)
MaxActive.TextScaled = true
MaxActive.TextSize = 14
MaxActive.TextWrapped = true
MaxActive.MouseButton1Click:Connect(function()
	for _, object in pairs(workspace:GetDescendants()) do
		if object:IsA("ClickDetector") and object then
			object.MaxActivationDistance = math.huge
		end
	end
end)

ShowSelectionTouch.Name = "ShowSelectionTouch"
ShowSelectionTouch.Parent = SecondFrame
ShowSelectionTouch.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ShowSelectionTouch.Position = UDim2.new(0, 225, 0, 0)
ShowSelectionTouch.Size = UDim2.new(0, 65, 0, 20)
ShowSelectionTouch.Font = Enum.Font.SourceSans
ShowSelectionTouch.Text = "Show Selection Touch"
ShowSelectionTouch.TextColor3 = Color3.fromRGB(0, 0, 0)
ShowSelectionTouch.TextScaled = true
ShowSelectionTouch.TextSize = 14
ShowSelectionTouch.TextWrapped = true
ShowSelectionTouch.MouseButton1Click:Connect(function()
	if not isTouchShown then
		for _, object in pairs(workspace:GetDescendants()) do
			if object:IsA("TouchTransmitter") and object.parent:FindFirstChild("SelectionBox") == nil then
				local selectionbox = Instance.new("SelectionBox", object.parent)
				selectionbox.Adornee = object.parent
			end
		end
		ShowSelectionTouch.Text = "Hide Selection Touch"
		ShowSelectionTouch.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		for _, object in pairs(workspace:GetDescendants()) do
			if object:IsA("TouchTransmitter") and object.parent:FindFirstChild("SelectionBox") ~= nil then
				object.parent:FindFirstChild("SelectionBox"):Destroy()
			end
		end
		ShowSelectionTouch.Text = "Show Selection Touch"
		ShowSelectionTouch.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	isTouchShown = not isTouchShown
end)

Rstop.Name = "RStop"
Rstop.Parent = SecondFrame
Rstop.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Rstop.Position = UDim2.new(0, 225, 0, 60)
Rstop.Size = UDim2.new(0, 65, 0, 20)
Rstop.Font = Enum.Font.SourceSans
Rstop.Text = "RenderStep Stop"
Rstop.TextColor3 = Color3.fromRGB(0, 0, 0)
Rstop.TextScaled = true
Rstop.TextSize = 14
Rstop.TextWrapped = true
Rstop.MouseButton1Click:Connect(function()
	if not RenderStop then
		Rstop.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		Rstop.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	RenderStop = not RenderStop
end)

KickMe.Name = "KickMe"
KickMe.Parent = SecondFrame
KickMe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KickMe.Position = UDim2.new(0, 225, 0, 30)
KickMe.Size = UDim2.new(0, 65, 0, 20)
KickMe.Font = Enum.Font.SourceSans
KickMe.Text = "Kick Yourself"
KickMe.TextColor3 = Color3.fromRGB(0, 0, 0)
KickMe.TextScaled = true
KickMe.TextSize = 14
KickMe.TextWrapped = true
KickMe.MouseButton1Click:Connect(function()
	game.Players.LocalPlayer:Kick(ReasonText.Text)
end)

FirePause.Name = "FirePause"
FirePause.Parent = SecondFrame
FirePause.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
FirePause.Position = UDim2.new(0, 150, 0, 60)
FirePause.Size = UDim2.new(0, 65, 0, 20)
FirePause.Font = Enum.Font.SourceSans
FirePause.Text = "Pause Sounds"
FirePause.TextColor3 = Color3.fromRGB(0, 0, 0)
FirePause.TextScaled = true
FirePause.TextSize = 14
FirePause.TextWrapped = true
FirePause.MouseButton1Click:Connect(function()
	for _, object in pairs(workspace:GetDescendants()) do
		if object.parent.Name == "Stop" and object:IsA("ClickDetector") then
			Click(object)
		end
	end
end)

ReasonText.Name = "ReasonText"
ReasonText.Parent = SecondFrame
ReasonText.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
ReasonText.Position = UDim2.new(0, 0, 0, 60)
ReasonText.Size = UDim2.new(0, 140, 0, 20)
ReasonText.Font = Enum.Font.SourceSans
ReasonText.PlaceholderColor3 = Color3.fromRGB(103, 103, 103)
ReasonText.PlaceholderText = "Reason Here"
ReasonText.Text = ""
ReasonText.TextColor3 = Color3.fromRGB(0, 0, 0)
ReasonText.TextSize = 14

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = SecondFrame
InfoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
InfoFrame.BackgroundTransparency = 0.25
InfoFrame.Position = UDim2.new(0, 45, 0, 160)
InfoFrame.Size = UDim2.new(0, 220, 0, 50)

Background.Name = "Background"
Background.Parent = InfoFrame
Background.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Background.BackgroundTransparency = 0.25
Background.Position = UDim2.new(0, 5, 0, 5)
Background.Size = UDim2.new(0, 210, 0, 40)

ClickCountText.Name = "ClickCountText"
ClickCountText.Parent = Background
ClickCountText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickCountText.BackgroundTransparency = 1
ClickCountText.Size = UDim2.new(0, 200, 0, 17)
ClickCountText.Font = Enum.Font.SourceSans
ClickCountText.Text = "Clickable Count: " .. getTypeCounter("ClickDetector")
ClickCountText.TextColor3 = Color3.fromRGB(0, 0, 0)
ClickCountText.TextSize = 14
ClickCountText.TextXAlignment = Enum.TextXAlignment.Left

TouchCountText.Name = "TouchCountText"
TouchCountText.Parent = Background
TouchCountText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TouchCountText.BackgroundTransparency = 1
TouchCountText.Position = UDim2.new(0, 0, 0, 20)
TouchCountText.Size = UDim2.new(0, 200, 0, 17)
TouchCountText.Font = Enum.Font.SourceSans
TouchCountText.Text = "Touchable Count: " .. getTypeCounter("TouchTransmitter")
TouchCountText.TextColor3 = Color3.fromRGB(0, 0, 0)
TouchCountText.TextSize = 14
TouchCountText.TextXAlignment = Enum.TextXAlignment.Left

DestroyGUI.Name = "DestroyGUI"
DestroyGUI.Parent = SecondFrame
DestroyGUI.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
DestroyGUI.Position = UDim2.new(0, 280, 0, -25)
DestroyGUI.Size = UDim2.new(0, 20, 0, 20)
DestroyGUI.Font = Enum.Font.SourceSans
DestroyGUI.Text = "X"
DestroyGUI.TextColor3 = Color3.fromRGB(0, 0, 0)
DestroyGUI.TextSize = 18
DestroyGUI.MouseButton1Click:Connect(function()
	ExploitGUI:Destroy()
	pcall(function() 
		getgenv().loaded = false 
	end)
	foo:Disconnect()
end)

TitleName.Name = "TitleName"
TitleName.Parent = SecondFrame
TitleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleName.BackgroundTransparency = 1
TitleName.BorderColor3 = Color3.fromRGB(255, 85, 0)
TitleName.Position = UDim2.new(0, 50, 0, -37)
TitleName.Size = UDim2.new(0, 200, 0, 50)
TitleName.Font = Enum.Font.SourceSans
TitleName.Text = "Click GUI Exploit v2 By Friskshift"
TitleName.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleName.TextSize = 20

SpamButton.Name = "SpamButton"
SpamButton.Parent = SecondFrame
SpamButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpamButton.Position = UDim2.new(0, 0, 0, 90)
SpamButton.Size = UDim2.new(0, 65, 0, 20)
SpamButton.Font = Enum.Font.SourceSans
SpamButton.Text = "Spam Button"
SpamButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SpamButton.TextScaled = true
SpamButton.TextSize = 14
SpamButton.TextWrapped = true
SpamButton.MouseButton1Click:Connect(function()
	if not isSpammingTouch then
		SpamButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		SpamButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	isSpammingTouch = not isSpammingTouch
	while isSpammingTouch do
		for _, object in pairs(workspace:GetDescendants()) do
			if object:IsA("ClickDetector") then
				Click(object)
			end
		end
		wait(tonumber(SpamInterval.Text))
	end
end)

SpamInterval.Name = "SpamInterval"
SpamInterval.Parent = SecondFrame
SpamInterval.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpamInterval.Position = UDim2.new(0, 75, 0, 90)
SpamInterval.Size = UDim2.new(0, 65, 0, 20)
SpamInterval.Font = Enum.Font.SourceSans
SpamInterval.PlaceholderText = "Interval"
SpamInterval.Text = ""
SpamInterval.TextColor3 = Color3.fromRGB(0, 0, 0)
SpamInterval.TextSize = 14

PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Parent = FirstFrame
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(0, 90, 247)
PlayerListFrame.BackgroundTransparency = 0.25
PlayerListFrame.Position = UDim2.new(0, -165, 0, 0)
PlayerListFrame.Size = UDim2.new(0, 160, 0, 180)

ScrollingFrame.Parent = PlayerListFrame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 0.25
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
ScrollingFrame.Size = UDim2.new(0, 150, 0, 170)
ScrollingFrame.ScrollBarThickness = 10

RandomButton.Name = "RandomButton"
RandomButton.Parent = SecondFrame
RandomButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RandomButton.Position = UDim2.new(0, 150, 0, 90)
RandomButton.Size = UDim2.new(0, 65, 0, 20)
RandomButton.Font = Enum.Font.SourceSans
RandomButton.Text = "Random Button"
RandomButton.TextColor3 = Color3.fromRGB(0, 0, 0)
RandomButton.TextScaled = true
RandomButton.TextSize = 14
RandomButton.TextWrapped = true
RandomButton.MouseButton1Click:Connect(function()
	for _, object in pairs(workspace:GetDescendants()) do
		if object:IsA("ClickDetector") then
			if math.random(1, 3) == 2 then
				Click(object)
			end
		end
	end
end)

SpamRandomButton.Name = "SpamRandomButton"
SpamRandomButton.Parent = SecondFrame
SpamRandomButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpamRandomButton.Position = UDim2.new(0, 225, 0, 90)
SpamRandomButton.Size = UDim2.new(0, 65, 0, 20)
SpamRandomButton.Font = Enum.Font.SourceSans
SpamRandomButton.Text = "Spam Random Buttons"
SpamRandomButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SpamRandomButton.TextScaled = true
SpamRandomButton.TextSize = 14
SpamRandomButton.TextWrapped = true
SpamRandomButton.MouseButton1Click:Connect(function()
	if not isSpammingRandomTouch then
		SpamRandomButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		SpamRandomButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	isSpammingRandomTouch = not isSpammingRandomTouch
	while isSpammingRandomTouch do
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ClickDetector") then
			if math.random(1, 3) == 2 then
				Click(v)
			end
		end
	end
		wait(tonumber(SpamInterval.Text))
	end
end)

FireProButton.Name = "FireProButton"
FireProButton.Parent = SecondFrame
FireProButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FireProButton.Position = UDim2.new(0, 225, 0, 120)
FireProButton.Size = UDim2.new(0, 65, 0, 20)
FireProButton.Font = Enum.Font.SourceSans
FireProButton.Text = "Fire Proximity Prompt"
FireProButton.TextColor3 = Color3.fromRGB(0, 0, 0)
FireProButton.TextScaled = true
FireProButton.TextSize = 14
FireProButton.TextWrapped = true
FireProButton.MouseButton1Click:Connect(function()
	for _, object in pairs(workspace:GetDescendants()) do
		if object:FindFirstChild("ProximityPrompt") then
			FirePrompt(object.ProximityPrompt)
		end
	end
end)

SpamFireProButton.Name = "SpamFireProButton"
SpamFireProButton.Parent = SecondFrame
SpamFireProButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpamFireProButton.Position = UDim2.new(0, 150, 0, 120)
SpamFireProButton.Size = UDim2.new(0, 65, 0, 20)
SpamFireProButton.Font = Enum.Font.SourceSans
SpamFireProButton.Text = "Spam Fire Proximity Prompt"
SpamFireProButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SpamFireProButton.TextScaled = true
SpamFireProButton.TextSize = 14
SpamFireProButton.TextWrapped = true
SpamFireProButton.MouseButton1Click:Connect(function()
	if not isSpammingProximity then
		SpamFireProButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		SpamFireProButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	isSpammingProximity = not isSpammingProximity
	while isSpammingProximity do
		for i, v in pairs(workspace:GetDescendants()) do
    		if v:FindFirstChild("ProximityPrompt") then
        		FirePrompt(v.ProximityPrompt)
        	end
    	end
    	wait(tonumber(SpamInterval.Text))
    end
end)

SpamTouchInts.Name = "SpamTouchInts"
SpamTouchInts.Parent = SecondFrame
SpamTouchInts.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpamTouchInts.Position = UDim2.new(0, 0, 0, 120)
SpamTouchInts.Size = UDim2.new(0, 65, 0, 20)
SpamTouchInts.Font = Enum.Font.SourceSans
SpamTouchInts.Text = "Spam Touch Interests"
SpamTouchInts.TextColor3 = Color3.fromRGB(0, 0, 0)
SpamTouchInts.TextScaled = true
SpamTouchInts.TextSize = 14
SpamTouchInts.TextWrapped = true
SpamTouchInts.MouseButton1Click:Connect(function()
	local human = (UseLegacy and game.Players.LocalPlayer.Character.Humanoid or game.Players.LocalPlayer.Character.HumanoidRootPart)
	if not isSpammingTouchInt then
		SpamTouchInts.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		SpamTouchInts.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	isSpammingTouchInt = not isSpammingTouchInt
	while isSpammingTouchInt do
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
				Touch(v)
            end
        end
		wait(tonumber(SpamInterval.Text))
	end
end)

LegacyR.Name = "LegacyR"
LegacyR.Parent = SecondFrame
LegacyR.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
LegacyR.Position = UDim2.new(0, 75, 0, 120)
LegacyR.Size = UDim2.new(0, 65, 0, 20)
LegacyR.Font = Enum.Font.SourceSans
LegacyR.Text = "Use Legacy Roblox"
LegacyR.TextColor3 = Color3.fromRGB(0, 0, 0)
LegacyR.TextScaled = true
LegacyR.TextSize = 14
LegacyR.TextWrapped = true
LegacyR.MouseButton1Click:Connect(function()
	if not isSpammingTouchInt then
		LegacyR.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		LegacyR.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
	UseLegacy = not UseLegacy
end)

UI.Name = "UI"
UI.Parent = ScrollingFrame
UI.SortOrder = Enum.SortOrder.LayoutOrder

PlrLabel.Name = "PlrLabel"
PlrLabel.Parent = script
PlrLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlrLabel.BackgroundTransparency = 1.000
PlrLabel.Position = UDim2.new(-2.02874994, 0, 0.286111116, 0)
PlrLabel.Size = UDim2.new(0, 150, 0, 20)
PlrLabel.Font = Enum.Font.SourceSans
PlrLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
PlrLabel.TextSize = 20
