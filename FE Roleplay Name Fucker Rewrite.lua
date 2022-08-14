local VERSION = " v1.2.0"

local github = 'https://raw.githubusercontent.com/'
local repo = github..'wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local ExploitLIB = loadstring(game:HttpGet(github..'system32unknown/Roblox/main/MakeMessageClient.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

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

function CheckColor(Color: table | Color3)
	if type(Color) == "table" then
		return Color3.fromRGB(Color[1], Color[2], Color[3])
	elseif typeof(Color) == "Color3" then
		return Color
	end
end

function shuffle(str)
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

local Window = Library:CreateWindow({Title = '[FE] Roleplay Name Fucker by Friskshift' .. VERSION, Center = true, AutoShow = true}) do
	local Tabs = {Main = Window:AddTab('Main'), ['UI Settings'] = Window:AddTab('UI Settings')} do
		local Tab = Tabs.Main:AddLeftTabbox('Main') do
	    	local MainTab = Tab:AddTab('Main') do
	    	    MainTab:AddToggle('MyToggle', {Text = 'Loop', Tooltip = 'Loops Changing the Name'})

	    	    Toggles.MyToggle:OnChanged(function()
	    	        print('MyToggle changed to:', Toggles.MyToggle.Value)
	    	    end)

	    	    Toggles.MyToggle:SetValue(false)

	    	    local MyButton = MainTab:AddButton('Inject', function()
	    	        print('You clicked a button!')
	    	    end)

	    	    local MyButton2 = MyButton:AddButton('Test', function()
	    	        print('You clicked a sub button!')
	    	    end)

	    	    MainTab:AddLabel('This is a label')

	    	    MainTab:AddSlider('MinSlider', {Text = 'Min', Default = 0, Min = 0, Max = 255, Rounding = 1, Compact = false})

	    	    Options.MinSlider:OnChanged(function()
	    	        print('MySlider was changed! New value:', Options.MySlider.Value)
	    	    end)

	    	    MainTab:AddInput('MyTextbox', {Default = '', Numeric = false, Finished = false, Placeholder = 'Name'})

	    	    Options.MyTextbox:OnChanged(function()
	    	        print('Text updated. New text:', Options.MyTextbox.Value)
	    	    end)

	    	    MainTab:AddDropdown('MyDropdown', {Values = {'This', 'is', 'a', 'dropdown'}, Default = 1, Multi = false, Text = 'A dropdown', Tooltip = 'This is a tooltip'})

	    	    Options.MyDropdown:OnChanged(function()
	    	        print('Dropdown got changed. New value:', Options.MyDropdown.Value)
	    	    end)
	    	    Options.MyDropdown:SetValue('This')
	    	end

			local section = Tab:AddTab('Extras') do
				section:AddLabel('coming soon')
			end
		end

		Library:OnUnload(function()
		    Library.Unloaded = true
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