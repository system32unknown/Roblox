local VERSION = " v1.2.0"

local github = 'https://raw.githubusercontent.com/'
local repo = github..'wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

local PS = game:GetService("Players")
local PSLP = PS.LocalPlayer
local GS = workspace.GameStuff

if loaded then
	print("already loaded you dumb")
	return
end
getgenv().loaded = true

function isManual(mode:boolean, num:number):string
    local av = 0
    if mode then
        av = num
    else
        av = math.random(0, 6)
    end
    return tostring(av)
end

local chooseVote = 0
local amountVote = 0
local isinf = false
local TeamType = BrickColor.new(21)
local PlayerName = ''

local Window = Library:CreateWindow({Title = 'Where\'s the RETARD' .. VERSION, Center = true, AutoShow = true}) do
	local Tabs = {Main = Window:AddTab('Main'), ['UI Settings'] = Window:AddTab('UI Settings')} do
		local Tab = Tabs.Main:AddLeftTabbox('Main') do
	    	local MainTab = Tab:AddTab('Main') do
	    	    MainTab:AddInput('PlayerText', {Default = '', Numeric = false, Finished = false, Text = 'Player Name:', Placeholder = 'Name'})
	    	    Options.PlayerText:OnChanged(function()
	    	        PlayerName = Options.PlayerText.Value
	    	    end)

	    	    MainTab:AddButton('Kill Player', function()
                    GS.FE.Interact:FireServer(PSLP, PS[PlayerName].Character, 100)
	    	    end)

	    	    MainTab:AddButton('Kill All', function()
                    for _, v in pairs(PS:GetChildren()) do
                        GS.FE.Interact:FireServer(PSLP, v.Character, 100)
                    end
	    	    end)

                MainTab:AddDivider()

	    	    MainTab:AddButton('Team Change', function()
                    GS.FE.TeamChange:FireServer(PSLP, TeamType)
	    	    end)

	    	    MainTab:AddButton('Team Change Neutral', function()
                    GS.FE.TeamChange:FireServer(PSLP, BrickColor.new(0))
	    	    end)

	    	    MainTab:AddToggle('IsBaby', {Text = 'Is Baby'})
	    	    Toggles.IsBaby:OnChanged(function()
	    	        TeamType = Toggles.IsBaby.Value and BrickColor.new(23) or BrickColor.new(21)
	    	    end)

                MainTab:AddDivider()

	    	    MainTab:AddButton('Show Developer Menu', function()
                    PSLP.PlayerGui.Menu.Config.Frame.Visible = true
	    	    end)

	    	    MainTab:AddButton('Grab All', function()
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") then
                            GS.FE.Grab:FireServer(PSLP, v)
                    
                            local Player_Position = PSLP.Character.HumanoidRootPart.Position
                            GS.FE.Move:FireServer(PSLP, v, Player_Position)
                        end
                    end
	    	    end)

                MainTab:AddDivider()

	    	    MainTab:AddButton('Kick Player', function()
                    GS.FE.Config:FireServer(PSLP, "Kick", PlayerName)
	    	    end)

	    	    MainTab:AddButton('Kick All', function()
                    for _, v in pairs(PS:GetPlayers()) do
                        if v ~= PSLP then
                            GS.FE.Config:FireServer(PSLP, "Kick", v.Name)
                        end
                    end
	    	    end)

                MainTab:AddDivider()

	    	    MainTab:AddButton('Flip Player', function()
					local deez = PS[PlayerName].Character
					local nuts = deez.HumanoidRootPart
                    PSLP.Character.Spatula.ToolUse:FireServer(PSLP, deez, nuts.Position, nuts.Position)
	    	    end)

	    	    MainTab:AddButton('Flip All', function()
					for _, v in pairs(workspace:GetDescendants()) do
						if v:IsA("BasePart") then
							PSLP.Character.Spatula.ToolUse:FireServer(PSLP, v, v.Position, v.Position)
						end
					end
	    	    end)

                MainTab:AddDivider()

	    	    MainTab:AddButton('Hack Vote', function()
                    GS.Votes.Vote:FireServer(isManual(not isinf, chooseVote), amountVote)
	    	    end)

	    	    MainTab:AddToggle('IsInfi', {Text = 'Is Infinite'})
	    	    Toggles.IsInfi:OnChanged(function()
	    	        isinf = Toggles.IsInfi.Value
	    	    end)

	    	    MainTab:AddSlider('VoteSlider', {Text = 'Game Modes', Default = 0, Min = 0, Max = 6, Rounding = 0, Compact = false})
	    	    Options.VoteSlider:OnChanged(function()
	    	        chooseVote = Options.VoteSlider.Value
	    	    end)

	    	    MainTab:AddInput('votemany', {Default = '', Numeric = true, Finished = false, Text = 'Vote Amount:', Placeholder = 'Name'})
	    	    Options.votemany:OnChanged(function()
	    	        amountVote = Options.votemany.Value
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

Library:Notify('Script fully loaded!')
Library:Notify('Press '.. Library.ToggleKeybind.Value ..' to toggle the menu!')