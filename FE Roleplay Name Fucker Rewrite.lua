local PS = game:GetService("Players")
local LP = PS.LocalPlayer

for _, object in pairs(LP.Character:GetDescendants()) do
    if not object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
        print("RemoteEvent 'ServerHandler' not found!")
        return
    end
end

local VERSION = " v1.3b"

local github = 'https://raw.githubusercontent.com/'
local repoName = 'system32unknown'
local repo = github..repoName..'/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local MessageLIB = loadstring(game:HttpGet(github..repoName..'/Roblox/main/MakeMessageClient.lua'))()
local TableLIB = loadstring(game:HttpGet(github..repoName..'/Roblox/main/TableTools.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

local wait_Func = task.wait

if _G.loaded then
	print("already loaded you dumb")
	return
end
_G.loaded = true

local TextManager = {}
TextManager.__index = TextManager
local PlayerManager = {}
PlayerManager.__index = PlayerManager

function TextManager.TypeWrite(str, sec, isLocal, plrs)
	local plr = (plrs ~= "" and plrs or "LocalPlayer")
	local temp_str = str
	for i = 0, string.len(str) do
		PlayerManager.Change_All_Name(string.sub(temp_str, 0, i), isLocal, plr)
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
	for _, object in pairs((isLocal and PS[plr].Character:GetDescendants() or workspace:GetDescendants())) do
		if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
			object:FireServer(str)
		end
	end
end

function PlayerManager.Get_Name(plr)
	for _, object in pairs(PS[plr].Character:GetDescendants()) do
		if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
			return object.Parent.Name
		end
	end
end

function PlayerManager.Get_Player_Arrays(array:table)
	for _, v in pairs(PS:GetPlayers()) do
		table.insert(array, v.Name)
	end

	TableLIB.CheckDup(array)
	table.sort(array)
end

local prev_name = PlayerManager.Get_Name("LocalPlayer")
local texts, Selected_Player = "", ""
local IsLocal, looped = false, false
local waits, Loops = 0, 0
local minBytes = 0
local maxBytes = 255
local del_num = 0

local event_text, wait_text = "", ""
local Text_List, Wait_List = {"Hello World!"}, {1}
local Players_List = {}

function UpdateName(Labels)
    prev_name = PlayerManager.Get_Name("LocalPlayer")
    Labels[1]:SetText("My Name: " .. texts)
    Labels[2]:SetText("Prev Name: " .. prev_name)
end

PlayerManager.Get_Player_Arrays(Players_List)

local Window = Library:CreateWindow({Title = '[FE] Roleplay Name Fucker by Friskshift' .. VERSION, Center = true, AutoShow = true}) do
	local Tabs = {Main = Window:AddTab('Main'), ['UI Settings'] = Window:AddTab('UI Settings')} do
		local Tab = Tabs.Main:AddLeftTabbox('Main') do
	    	local MainTab = Tab:AddTab('Main') do
                local Label = MainTab:AddLabel("My Name: " .. (texts ~= "" and texts or "No Name"))
				local PrevLabel = MainTab:AddLabel("Prev Name: " .. (prev_name ~= "" and prev_name or "No Name"))

	    	    local InjectButton = MainTab:AddButton('Inject', function()
					if PlayerManager.Get_Name("LocalPlayer") ~= "" then
                        UpdateName({Label, PrevLabel})
                    	PlayerManager.Change_All_Name(texts, IsLocal, Selected_Player)
                    	while looped do
                            UpdateName({Label, PrevLabel})
                    	    PlayerManager.Change_All_Name(texts, IsLocal, Selected_Player)
                    	    wait_Func(waits)
                    	end
					end
	    	    end)

	    	    InjectButton:AddButton('Test', function()
                    PlayerManager.Change_All_Name("Test Injecting.", true)
                    wait_Func(3)
                    PlayerManager.Change_All_Name(prev_name, true)
	    	    end)

                MainTab:AddDivider()

	    	    MainTab:AddSlider('MinSlider', {Text = 'Min', Default = 0, Min = 0, Max = 255, Rounding = 0, Compact = false})
	    	    Options.MinSlider:OnChanged(function()
	    	        minBytes = Options.MinSlider.Value
	    	    end)

	    	    MainTab:AddSlider('MaxSlider', {Text = 'Max', Default = 0, Min = 0, Max = 255, Rounding = 0, Compact = false})
	    	    Options.MaxSlider:OnChanged(function()
	    	        maxBytes = Options.MaxSlider.Value
	    	    end)

	    	    MainTab:AddInput('NameTextbox', {Default = '', Numeric = false, Finished = false, Text = 'RP Name:', Placeholder = 'Name'})
	    	    Options.NameTextbox:OnChanged(function()
	    	        texts = Options.NameTextbox.Value
	    	    end)

                MainTab:AddButton("Inject Name then Exit", function()
                    PlayerManager.Change_All_Name(texts, IsLocal, Selected_Player)
                    wait_Func(0.5)
                    game:shutdown()
                end)

                MainTab:AddButton("TypeWriter", function()
                    TextManager.TypeWrite(texts, waits, IsLocal, Selected_Player)
                end)

                MainTab:AddButton("Revert Name", function()
                    UpdateName({Label, PrevLabel})
                    PlayerManager.Change_All_Name(prev_name, true)
                end)

                MainTab:AddButton("Randomize Name", function()
                    PlayerManager.Change_All_Name(TextManager.Random_Text(Loops, minBytes, maxBytes), IsLocal)
                end)

                MainTab:AddButton("Shuffle Name", function()
                    for _, object in pairs((IsLocal and PS[Selected_Player].Character:GetDescendants() or workspace:GetDescendants())) do
                        if object.Name == "ServerHandler" and object:IsA("RemoteEvent") then
                            object:FireServer(TextManager.shuffle(texts))
                        end
                    end
                end)
	    	end

			local section = Tab:AddTab('Extras') do
	    	    section:AddToggle('Repeating', {Text = 'Loop', Tooltip = 'Loops Changing the Name'})
	    	    Toggles.Repeating:OnChanged(function()
	    	        looped = Toggles.Repeating.Value
	    	    end)

	    	    section:AddToggle('UseLegacy', {Text = 'Use Legacy', Tooltip = 'Uses Legacy Component'})
	    	    Toggles.UseLegacy:OnChanged(function()
	    	        wait_Func = Toggles.UseLegacy.Value and wait or task.wait
	    	    end)

	    	    section:AddToggle('UseAll', {Text = 'Is Local', Tooltip = 'Uses Local Players'})
	    	    Toggles.UseAll:OnChanged(function()
	    	        IsLocal = Toggles.UseAll.Value
	    	    end)

	    	    local dropdown = section:AddDropdown('PlayerDropDown', {Values = Players_List, Default = 1, Multi = false, Text = 'Player List'})
	    	    Options.PlayerDropDown:OnChanged(function()
	    	        Selected_Player = Options.PlayerDropDown.Value
	    	    end)

	    	    section:AddInput('WaitBox', {Default = '0', Numeric = false, Finished = false, Text = 'Wait Numbers', Placeholder = 'Wait Numbers'})
	    	    Options.WaitBox:OnChanged(function()
	    	        waits = Options.WaitBox.Value
	    	    end)

	    	    section:AddInput('LoopBox', {Default = '1', Numeric = true, Finished = false, Text = 'Loop Numbers', Placeholder = 'Loop Numbers'})
	    	    Options.LoopBox:OnChanged(function()
	    	        Loops = Options.LoopBox.Value
	    	    end)

	    	    section:AddButton('Update Player List', function()
                    table.clear(Players_List)
                    PlayerManager.Get_Player_Arrays(Players_List)
                    dropdown:SetValues(Players_List)
	    	    end)

                section:AddButton('Grab RP Name', function()
                    local getting_name = PlayerManager.Get_Name(Selected_Player)
                    if Selected_Player ~= "" or PlayerManager.Get_Name(Selected_Player) ~= "" then
                        MessageLIB:Notification("Grabbed Name!", "Copied to Clipboard!", 2, 4914902918)
                        setclipboard(getting_name)
                    end
                end)

                section:AddButton('Chat To RP Name', function()
					PS.PlayerAdded:Connect(function()
						local Action = PS:GetPlayers()
						for i = 1, #Action do
							Action[i].Chatted:Connect(function(Message)
								PlayerManager.Change_All_Name(Message, true, Action[i].Name)
							end)
						end
					end)
                end)

                section:AddButton("Revert Selected Player", function()
                    Selected_Player = ""
                end)
			end
		end

        local EventTab = Tabs.Main:AddRightTabbox('Events') do
            local MainTab = EventTab:AddTab('Main') do
                local EventLabel = MainTab:AddLabel("Text: ")

                event_list = MainTab:AddDropdown('EventDropdown', {Values = Text_List, Default = 1, Multi = false, Text = 'Event Text List'})
                Options.EventDropdown:OnChanged(function()
                    EventLabel:SetText("Text: " .. Options.EventDropdown.Value)
                end)

                wait_lists = MainTab:AddDropdown('WaitDropdown', {Values = Wait_List, Default = 1, Multi = false, Text = 'Event Wait List'})

	    	    MainTab:AddInput('EventTextBox', {Numeric = false, Finished = false, Text = 'Event Text', Placeholder = 'Event Text'})
	    	    Options.EventTextBox:OnChanged(function()
	    	        event_text = Options.EventTextBox.Value
	    	    end)

	    	    MainTab:AddInput('EventWaitBox', {Numeric = true, Finished = false, Text = 'Event Wait', Placeholder = 'Event Wait'})
	    	    Options.EventWaitBox:OnChanged(function()
	    	        wait_text = Options.EventWaitBox.Value
	    	    end)

                MainTab:AddButton("Add Lists", function()
                    if event_text ~= "" then
                        table.insert(Text_List, event_text)
                        event_list:SetValues(Text_List)
                    end

                    if wait_text ~= "" then
                        table.insert(Wait_List, tonumber(wait_text))
                        wait_lists:SetValues(Wait_List)
                    end
                end)

                MainTab:AddButton("Inject List", function()
                    for i, v in pairs(Text_List) do
                        PlayerManager.Change_All_Name(v, IsLocal, Selected_Player)
                        wait_Func(Wait_List[i])
                    end
                end)

                MainTab:AddButton("Inject List Randomly", function()
                    local choiced_name = Text_List[math.random(0, #Text_List)]
                    PlayerManager.Change_All_Name(choiced_name, IsLocal, Selected_Player)
                end)

                MainTab:AddButton("TypeWrite List", function()
                    for i, v in pairs(Text_List) do
                        TextManager.TypeWrite(v, waits, IsLocal, Selected_Player)
                        wait_Func(Wait_List[i])
                    end
                end)
            end

            local SettingTab = Tab:AddTab('List Settings') do
                SettingTab:AddButton("Delete All Lists", function()
                    if #Text_List > 0 then
                        table.clear(Text_List)
                        event_list:SetValues(Text_List)
					end
					if #Wait_List > 0 then
                        table.clear(Wait_List)
                        wait_lists:SetValues(Wait_List)
                    end
                end)

	    	    SettingTab:AddInput('DelListBox', {Numeric = true, Finished = false, Text = 'Delete List Number'})
	    	    Options.DelListBox:OnChanged(function()
	    	        del_num = tonumber(Options.DelListBox.Value)
	    	    end)

                SettingTab:AddButton("Delete List", function()
                    if #Text_List > 0 or #Wait_List > 0 then
                        table.remove(Text_List, del_num)
                        table.remove(Wait_List, del_num)

                        event_list:SetValues(Text_List)
                        wait_lists:SetValues(Wait_List)
                    end
                end)
            end
        end

		Library:OnUnload(function()
		    Library.Unloaded = true
            _G.loaded = false
		end)

		-- UI Settings
		local MenuGroup = Tabs['UI Settings']:AddLeftTabbox('Menu')

		local lol = MenuGroup:AddTab("Menu")
		lol:AddButton('Unload', function() Library:Unload() end)
		lol:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {Default = 'End', NoUI = true, Text = 'Menu keybind'}) 

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

Library:Notify('Script fully loaded!')
Library:Notify('Press '.. Library.ToggleKeybind.Value ..' to toggle the menu!')