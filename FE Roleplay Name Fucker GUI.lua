--Services
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

--Functions
if loaded then
	print("already loaded you dumb")
	return
end

pcall(function()
	getgenv().loaded = true
end)

function typewriter(str, sec, isLocal, plrs)
	local plr = (plrs ~= "" and plrs or "LocalPlayer")
	local temp_str = str
	for i = 0, string.len(str) do
		local init_text = string.sub(temp_str, 0, i)
		Change_All_Name(init_text, isLocal, plr)
		wait_Func(sec)
	end
	Change_All_Name(temp_str, isLocal, plr)
end

function Random_Text(loops, min, max)
	local loops = tonumber(loops) and loops or 1
	local min = tonumber(min) and min or 0
	local max = tonumber(max) and max or 255

    local totTxt = ""
    for _ = 0, loops do
        totTxt = totTxt..string.char(math.random(min, max))
    end
    return totTxt
end

function Change_All_Name(str, isLocal, plrs)
	local plr = (plrs ~= "" and plrs or "LocalPlayer")
	for _, object in pairs((isLocal and game:GetService("Players")[plr].Character:GetDescendants() or workspace:GetDescendants())) do
		if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
			object:FireServer(str)
		end
	end
end

function Get_Name(plr)
	for _, object in pairs(game:GetService("Players")[plr].Character:GetDescendants()) do
		if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
			return object.Parent.Name
		end
	end
end

function Get_Player_Arrays(array:table)
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		table.insert(array, v.Name)
		table.sort(array)
	end
end

function Notification(title, text, dur:number, id:number)
	game.StarterGui:SetCore("SendNotification", {
		Title = title;
		Text = text;
		Icon = "rbxthumb://type=Asset&id=" .. id .."&w=150&h=150";
		Duration = dur;
	})
end

function has_value(tab, val)
    for _, v in pairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end

function CheckColor(Color: table | Color3)
	if type(Color) == "table" then
		return Color3.fromRGB(Color[1], Color[2], Color[3])
	elseif typeof(Color) == "Color3" then
		return Color
	end
end

--Variables
local prev_name = Get_Name("LocalPlayer")
local texts, review_text = "", ""
local islocalplayer = false
local waits, Loops = 0, 0
local minBytes, maxBytes = 0, 255
wait_Func = task.wait

local Toggled = true
local Selected_Player = ""
local looped = false

local event_text, wait_text = "", ""
local Text_List, Wait_List = {}, {}
local Players_List = {}

--Settings
local VERSION = " v1.2.0"

--Librarys

local Config = {
	WindowName = "[FE] Roleplay Name Fucker by Friskshift" .. VERSION,
	Color = {math.random(0, 255), math.random(0, 255), math.random(0, 255)},
	Keybind = Enum.KeyCode.RightBracket
}

Get_Player_Arrays(Players_List)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local linked_connection = UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode == Config.Keybind then
		Toggled = not Toggled
		Window:Toggle(Toggled)
	end
end)

--Begins of the Main Tab
local Tab1 = Window:CreateTab("Home")

--Begins of Section 1.
local Section1 = Tab1:CreateSection("Main")

local RFText = Section1:CreateLabel("My Name: ..")
RFText:UpdateText("My Name: " .. (Get_Name("LocalPlayer") ~= "" and Get_Name("LocalPlayer") or "No Name"))

Section1:CreateButton("Test Inject", function()
	Change_All_Name("Test Injecting.", true)
	wait_Func(3)
	Change_All_Name(prev_name, true)
end)

Section1:CreateTextBox("TextArea", "hello world!", false, function(String)
	texts = String
end)

Section1:CreateButton("Inject Name", function()
	Change_All_Name(texts, islocalplayer, Selected_Player)
	while looped do
		Change_All_Name(texts, islocalplayer, Selected_Player)
		wait_Func(waits)
	end
end)

Section1:CreateButton("Inject Name then Exit", function()
	Change_All_Name(texts, islocalplayer, Selected_Player)
	wait_Func(0.5)
	game:shutdown()
end)

Section1:CreateButton("TypeWriter", function()
	typewriter(texts, waits, islocalplayer, Selected_Player)
end)

Section1:CreateButton("Revert Name", function()
	Change_All_Name(prev_name, true)
end)

Section1:CreateButton("Update Name", function()
	prev_name = Get_Name("LocalPlayer")
	RFText:UpdateText("My Name: " .. Get_Name("LocalPlayer"))
end)

Section1:CreateToggle("Is Local", nil, function(State)
	islocalplayer = State
end)

Section1:CreateToggle("Use Legacy Wait", nil, function(State)
	wait_Func = State and wait or task.wait
end)

Section1:CreateToggle("Looped", nil, function(State)
	looped = State
end)

Section1:CreateSlider("Min Bytes", 0, 255, nil, true, function(Value)
	minBytes =  Value
end)

Section1:CreateSlider("Max Bytes", 0, 255, nil, true, function(Value)
	maxBytes = Value
end)

Section1:CreateTextBox("Loops Amount", "Loops Amount", true, function(String)
	Loops = String
end)

Section1:CreateButton("Randomize Name", function()
	Change_All_Name(Random_Text(Loops, minBytes, maxBytes), islocalplayer)
end)

Section1:CreateTextBox("Wait Settings", "Wait Settings", true, function(Value)
	waits = Value
end)

Section1:CreateButton("Destroy GUI", function()
	Window:DestroyGui()
	linked_connection:Disconnect()
	getgenv().loaded = false
end)
-- End of Section 1.

--Begins of Extra Section.
local SectionExtra = Tab1:CreateSection("Extras")

local plr_list = SectionExtra:CreateDropdown("Player List", Players_List, function(String)
	Selected_Player = String
end)

SectionExtra:CreateButton("Update List", function()
	plr_list:ClearOptions()
	table.clear(Players_List)
	Get_Player_Arrays(Players_List)
	table.sort(Players_List)
	plr_list:AddOption(Players_List)
end)

SectionExtra:CreateButton("Grab Name", function()
	local getting_name = Get_Name(Selected_Player)
	if Selected_Player ~= "" or Get_Name(Selected_Player) ~= "" then
		Notification("Grabbed Name!", "Copied to Clipboard!", 2, 4914902918)
		setclipboard(getting_name)
	end
end)

SectionExtra:CreateButton("Revert Selected Player", function()
	Selected_Player = ""
end)
--End of Extra Section.

--Begins of Event Section.
local SectionEvents = Tab1:CreateSection("Events")

local event_list = SectionEvents:CreateDropdown("Event List", Text_List, function(String)
	EvText:UpdateText("Text: " .. String)
end)

local wait_lists = SectionEvents:CreateDropdown("Wait List", Wait_List)

EvText = SectionEvents:CreateLabel("Text: ")

SectionEvents:CreateTextBox("Event Text", "hello world!", false, function(String)
	event_text = String
end)

SectionEvents:CreateTextBox("Event Wait", "Number", false, function(String)
	wait_text = String
end)

SectionEvents:CreateButton("Add List", function()
	if event_text ~= "" then
		table.insert(Text_List, event_text)
		event_list:ClearOptions()
		event_list:AddOption(Text_List)
	end

	if wait_text ~= "" then
		table.insert(Wait_List, tonumber(wait_text))
		wait_lists:ClearOptions()
		wait_lists:AddOption(Wait_List)
	end
end)

SectionEvents:CreateButton("Delete All List", function()
	if #Text_List > 0 or #Wait_List > 0 then
		table.clear(Text_List)
		event_list:ClearOptions()

		table.clear(Wait_List)
		wait_lists:ClearOptions()
	end
end)

local nums_ow = 0
SectionEvents:CreateTextBox("Delete List Number", "Numbers", true, function(String)
	if type(tonumber(String)) == "number" then
		nums_ow = String
	end
end)

SectionEvents:CreateButton("Delete List", function()
	if #Text_List > 0 or #Wait_List > 0 then
		table.remove(Text_List, nums_ow)
		event_list:ClearOptions()
		event_list:AddOption(Text_List)

		table.remove(Wait_List, nums_ow)
		wait_lists:ClearOptions()
		wait_lists:AddOption(Wait_List)
	end
end)

SectionEvents:CreateButton("Inject List", function()
	for i, v in pairs(Text_List) do
		Change_All_Name(v, islocalplayer, Selected_Player)
		wait_Func(Wait_List[i])
	end
end)

SectionEvents:CreateButton("Inject List Randomly", function()
	local choiced_name = Text_List[math.random(0, #Text_List)]
	Change_All_Name(choiced_name, islocalplayer, Selected_Player)
end)

SectionEvents:CreateButton("TypeWrite List", function()
	for i, v in pairs(Text_List) do
		typewriter(v, waits, islocalplayer, Selected_Player)
		wait_Func(Wait_List[i])
	end
end)
--End of Extra Section.

--Begins of Setting Tab.
local TabSetting = Window:CreateTab("Settings")

--Begins of Setting Section.
local Section_Settings = TabSetting:CreateSection("Settings")

local Colorpicker3 = Section_Settings:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(CheckColor(Config.Color))

local Dropdown3 = Section_Settings:CreateDropdown("Image", {"Default", "Hearts", "Abstract", "Hexagon", "Circles", "Lace With Flowers", "Floral", "checker"}, function(Name)
	if Name == "Default" then
		Window:SetBackground("2151741365")
	elseif Name == "Hearts" then
		Window:SetBackground("6073763717")
	elseif Name == "Abstract" then
		Window:SetBackground("6073743871")
	elseif Name == "Hexagon" then
		Window:SetBackground("6073628839")
	elseif Name == "Circles" then
		Window:SetBackground("6071579801")
	elseif Name == "Lace With Flowers" then
		Window:SetBackground("6071575925")
	elseif Name == "Floral" then
		Window:SetBackground("5553946656")
	elseif Name == "checker" then
		Window:SetBackground("6032311318")
	end
end)
Dropdown3:SetOption("Default")

local Colorpicker4 = Section_Settings:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1, 1, 1))

local Slider3 = Section_Settings:CreateSlider("Transparency", 0, 1, nil, false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section_Settings:CreateSlider("Tile Scale", 0, 1, nil, false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)

Section_Settings:CreateButton("Randomize Colors", function()
	local BG_color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	local Window_Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))

	Window:SetBackgroundColor(BG_color)
	Window:ChangeColor(Window_Color)

	Colorpicker3:UpdateColor(Window_Color)
	Colorpicker4:UpdateColor(BG_color)
end)
--End of Setting Tab.

--Begins of String Tab.
local StringSetting = Window:CreateTab("Strings")

--Begins of String Section.
local Section_Strings = StringSetting:CreateSection("Stings")

local review_textbox = Section_Strings:CreateTextBox("Review Text", "Texts", false, function(String)
	review_text = String
end)

review_textbox:SetValue("lorum ipsum")

Section_Strings:CreateButton("Reverse Text", function()
	review_textbox:SetValue(string.reverse(review_text))
end)

Section_Strings:CreateButton("Upper Text", function()
	review_textbox:SetValue(string.upper(review_text))
end)

Section_Strings:CreateButton("Lower Text", function()
	review_textbox:SetValue(string.lower(review_text))
end)

Section_Strings:CreateButton("Posion Text", function()
	local blank_text = ""
	for v in string.gmatch(review_text, "%w+") do
		blank_text = blank_text .. (math.random(0, 10) == 5 and string.upper(v) or string.lower(v))
	end
	review_textbox:SetValue(blank_text)
end)

-- End of String Section.

--End of String Tab.