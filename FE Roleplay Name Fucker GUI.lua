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

function typewriter(str, sec, isLocal, useLegacy, plrs)
	local plr = (plrs ~= "" and plrs or "LocalPlayer") 
	local temp_str = str
	for i = 0, string.len(str) do
		local init_text = string.sub(temp_str, 0, i)
		Change_All_Name(init_text, isLocal, plr)
		if UseLegacy_wait then
			wait(sec)
		else
			task.wait(sec)
		end
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

function Get_Player_Arrays(array)
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		table.insert(array, v.Name)
		table.sort(array)
	end
end

function Notification(title, text, dur, id)
	game.StarterGui:SetCore("SendNotification", {
		Title = title;
		Text = text;
		Icon = "rbxthumb://type=Asset&id=" .. id .."&w=150&h=150";
		Duration = dur;
	})
end

function Check_Admin(tabl)
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		if has_value(tabl, v.UserId) then
			print("Admin just joined the game.")
			print("Admin Name: " .. v.Name)
			print("Admin ID: " .. v.UserId)
			--Deprecated: Notification("Notifier", "Admin is here.", 2, 4914902918)
			game:GetService("Players").LocalPlayer:Kick("Admin is here.")
		end
	end
end

function has_value(tab, val)
    for _, v in pairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end

function CheckColor(Color)
	if type(Color) == "table" then
		return Color3.fromRGB(Color[1], Color[2], Color[3])
	elseif typeof(Color) == "Color3" then
		return Color
	else
		error("Color is not a table or Color3")
	end
end

--Variables
local prev_name = Get_Name("LocalPlayer")
local texts = ""
local islocalplayer = false
local waits = 0
local UseLegacy_wait = false
local minBytes, maxBytes = 0, 255

local Loops = 0
local Toggled = true
local Selected_Player = ""
local looped = false

local event_text, wait_text = "", ""
local Text_List, Wait_List = {}, {}
local Players_List = {}

--Settings
local VERSION = " v1.1.0"
local blacklisted_admin = {
	3163283356, -- Anime RP Admin
	127518522 -- The Lion King 2D Roleplay Owner
}

--Librarys
Check_Admin(blacklisted_admin)

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

local Tab1 = Window:CreateTab("Home")
local TabSetting = Window:CreateTab("Settings")

--Begins of Section 1.
local Section1 = Tab1:CreateSection("Main")

local RFText = Section1:CreateLabel("My Name: ..")
RFText:UpdateText("My Name: " .. (Get_Name("LocalPlayer") ~= "" and Get_Name("LocalPlayer") or "No Name"))

Section1:CreateButton("Test Inject", function()
	Change_All_Name("Test Injecting.", true)
	if UseLegacy_wait then
		wait(3)
	else
		task.wait(3)
	end
	Change_All_Name(prev_name, true)
end)

Section1:CreateTextBox("TextArea", "hello world!", false, function(String)
	texts = String
end)

Section1:CreateButton("Inject Name", function()
	Change_All_Name(texts, islocalplayer, Selected_Player)
	while looped do
		Change_All_Name(texts, islocalplayer, Selected_Player)
		if UseLegacy_wait then
			wait(waits)
		else
			task.wait(waits)
		end
	end
end)

Section1:CreateButton("TypeWriter", function()
	typewriter(texts, waits, islocalplayer, UseLegacy_wait, Selected_Player)
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
	UseLegacy_wait = State
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

SectionExtra:CreateButton("Check Admin", function()
	Get_Player_Arrays(Players_List)
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
		if UseLegacy_wait then
			wait(Wait_List[i])
		else
			task.wait(Wait_List[i])
		end
	end
end)

SectionEvents:CreateButton("Inject List Randomly", function()
	local choiced_name = Text_List[math.random(0, #Text_List)]
	Change_All_Name(choiced_name, islocalplayer, Selected_Player)
end)

SectionEvents:CreateButton("TypeWrite List", function()
	for i, v in pairs(Text_List) do
		typewriter(v, waits, islocalplayer, UseLegacy_wait, Selected_Player)
		if UseLegacy_wait then
			wait(Wait_List[i])
		else
			task.wait(Wait_List[i])
		end
	end
end)
--End of Extra Section.

--Begins of Setting Tab.
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

local file_name = ""
Section_Settings:CreateTextBox("Filename", "File", false, function(String)
	file_name = String
end)

Section_Settings:CreateButton("Save File", function()
	local data = {
		Color = HttpService:JSONEncode(Config.Color)
	}
	if not isfolder('FERNFG_Config') then
		makefolder('FERNFG_Config')
	end
	writefile('FERNFG_Config\\' .. file_name .. '.lxua', tostring(HttpService:JSONEncode(data)))
end)

Section_Settings:CreateButton("Load File", function()
	local data = readfile('FERNFG_Config\\' .. file_name .. '.lxua')
	if data then
		local data_full = HttpService:JSONDecode(data)
		if data_full.Color then
			Colorpicker3:UpdateColor(CheckColor(HttpService:JSONDecode(data.Color)))
		end
	end
end)
--End of Setting Tab.
