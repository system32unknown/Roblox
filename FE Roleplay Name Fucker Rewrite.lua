local VERSION = " v1.2.0"

local github = 'https://raw.githubusercontent.com/'
local repo = github..'wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local MessageLIB = loadstring(game:HttpGet(github..'system32unknown/Roblox/main/MakeMessageClient.lua'))()
local TableLIB = loadstring(game:HttpGet(github..'system32unknown/Roblox/main/TableTools.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()
local TextManager, PlayerManager = {}, {}

local wait_Func = task.wait

if loaded then
	print("already loaded you dumb")
	return
end

getgenv().loaded = true

function TextManager.TypeWrite(str, sec, isLocal, plrs)
	local plr = (plrs ~= "" and plrs or "LocalPlayer")
	local temp_str = str
	for i = 0, string.len(str) do
		local init_text = string.sub(temp_str, 0, i)
		PlayerManager.Change_All_Name(init_text, isLocal, plr)
		wait_Func(sec)
	end
	PlayerManager.Change_All_Name(temp_str, isLocal, plr)
end

function TextManager.Random_Text(loops, min, max)
	local loops = tonumber(loops) and loops or 1
	local min = tonumber(min) and min or 0
	local max = tonumber(max) and max or 255

    local totTxt = ""
    for _ = 0, loops do
        totTxt = totTxt..string.char(math.random(min, max))
    end
    return totTxt
end

function TextManager.shuffle(str)
	local letters = {}
	for letter in string.gmatch(str, '.[\128-\191]*') do
	  	table.insert(letters, {
			letter = letter,
			rnd = math.random()
		})
	end
	table.sort(letters, function(a, b)
		return a.rnd < b.rnd
	end)
	for i, v in ipairs(letters) do
		letters[i] = v.letter
	end
	return table.concat(letters)
end

function PlayerManager.Change_All_Name(str, isLocal, plrs)
	local plr = (plrs ~= "" and plrs or "LocalPlayer")
	for _, object in pairs((isLocal and game:GetService("Players")[plr].Character:GetDescendants() or workspace:GetDescendants())) do
		if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
			object:FireServer(str)
		end
	end
end

function PlayerManager.Get_Name(plr)
	for _, object in pairs(game:GetService("Players")[plr].Character:GetDescendants()) do
		if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
			return object.Parent.Name
		end
	end
end

function PlayerManager.Get_Player_Arrays(array:table)
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		table.insert(array, v.Name)
	end

	TableLIB.CheckDup(array)
	table.sort(array)
end

function CheckColor(Color: table | Color3)
	if type(Color) == "table" then
		return Color3.fromRGB(Color[1], Color[2], Color[3])
	elseif typeof(Color) == "Color3" then
		return Color
	end
end

local prev_name = PlayerManager.Get_Name("LocalPlayer")
local texts, review_text = "", ""
local islocalplayer = false
local waits, Loops = 0, 0
local minBytes, maxBytes = 0, 255

local Toggled, looped = true, false
local Selected_Player = ""

local event_text, wait_text = "", ""
local Text_List, Wait_List = {}, {}
local Players_List = {}

PlayerManager.Get_Player_Arrays(Players_List)

local Window = Library:CreateWindow({Title = '[FE] Roleplay Name Fucker by Friskshift' .. VERSION, Center = true, AutoShow = true}) do
	local Tabs = {Main = Window:AddTab('Main'), ['UI Settings'] = Window:AddTab('UI Settings')} do
		local Tab = Tabs.Main:AddLeftTabbox('Main') do
	    	local MainTab = Tab:AddTab('Main') do
                local Label = MainTab:AddLabel("My Name: " .. (texts ~= "" and texts or "No Name"))
				local PrevLabel = MainTab:AddLabel("Prev Name: " .. (PlayerManager.Get_Name("LocalPlayer") ~= "" and PlayerManager.Get_Name("LocalPlayer") or "No Name"))

	    	    local InjectButton = MainTab:AddButton('Inject', function()
					if PlayerManager.Get_Name("LocalPlayer") ~= "" then
						Label:SetText("My Name: " .. texts)
						PrevLabel:SetText("Prev Name: " .. PlayerManager.Get_Name("LocalPlayer"))
                    	PlayerManager.Change_All_Name(texts, islocalplayer, Selected_Player)
                    	while looped do
							Label:SetText("My Name: " .. texts)
							PrevLabel:SetText("Prev Name: " .. PlayerManager.Get_Name("LocalPlayer"))
                    	    PlayerManager.Change_All_Name(texts, islocalplayer, Selected_Player)
                    	    wait_Func(waits)
                    	end
					end
	    	    end)

	    	    InjectButton:AddButton('Test', function()
                    PlayerManager.Change_All_Name("Test Injecting.", true)
                    wait_Func(3)
                    PlayerManager.Change_All_Name(prev_name, true)
	    	    end)

	    	    MainTab:AddSlider('MinSlider', {Text = 'Min', Default = 0, Min = 0, Max = 255, Rounding = 1, Compact = false})
	    	    Options.MinSlider:OnChanged(function()
	    	        minBytes = Options.MinSlider.Value
	    	    end)

	    	    MainTab:AddSlider('MaxSlider', {Text = 'Max', Default = 0, Min = 0, Max = 255, Rounding = 1, Compact = false})
	    	    Options.MaxSlider:OnChanged(function()
	    	        minBytes = Options.MaxSlider.Value
	    	    end)

	    	    MainTab:AddInput('MyTextbox', {Default = '', Numeric = false, Finished = false, Placeholder = 'Name'})
	    	    Options.MyTextbox:OnChanged(function()
	    	        texts = Options.MyTextbox.Value
	    	    end)
	    	end

			local section = Tab:AddTab('Extras') do
	    	    section:AddToggle('Looping', {Text = 'Loop', Tooltip = 'Loops Changing the Name'})
	    	    Toggles.Looping:OnChanged(function()
	    	        looped = Toggles.Looping.Value
	    	    end)

	    	    section:AddToggle('UseLegacy', {Text = 'Use Legacy', Tooltip = 'Loops Changing the Name'})
	    	    Toggles.UseLegacy:OnChanged(function()
	    	        wait_Func = Toggles.UseLegacy.Value and wait or task.wait
	    	    end)

	    	    section:AddToggle('UseLocal', {Text = 'Is Local', Tooltip = 'Loops Changing the Name'})
	    	    Toggles.UseLocal:OnChanged(function()
	    	        islocalplayer = Toggles.UseLocal.Value
	    	    end)

	    	    local dropdown = section:AddDropdown('PlayerDropDown', {Values = Players_List, Default = 1, Multi = false, Text = 'Player List'})
	    	    Options.PlayerDropDown:OnChanged(function()
	    	        Selected_Player = Options.PlayerDropDown.Value
	    	    end)

	    	    section:AddButton('Update Player List', function()
                    table.clear(Players_List)
                    PlayerManager.Get_Player_Arrays(Players_List)
                    dropdown:SetValues(Players_List)
	    	    end)
			end
		end

		Library:OnUnload(function()
		    Library.Unloaded = true
            getgenv().loaded = false
		end)

		-- UI Settings
		local MenuGroup = Tabs['UI Settings']:AddLeftTabbox('Menu')

		local lol = MenuGroup:AddTab("Menu")
		lol:AddButton('Unload', function() Library:Unload() end)
		lol:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

		Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

		ThemeManager:SetLibrary(Library)
		SaveManager:SetLibrary(Library)

		SaveManager:IgnoreThemeSettings() 
		SaveManager:SetIgnoreIndexes({'MenuKeybind'})

		ThemeManager:SetFolder('MyScriptHub')
		SaveManager:SetFolder('MyScriptHub/specific-game')

		SaveManager:BuildConfigSection(Tabs['UI Settings'])
		ThemeManager:ApplyToTab(Tabs['UI Settings'])
	end
end