local VERSION = " v1.2.0"

local github = 'https://raw.githubusercontent.com/'
local repo = github..'wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

local PS = game:GetService("Players")
local TS = game:GetService("Teams")
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
local TeamName = ''
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

	    	    MainTab:AddButton('Change Neutral Everyone', function()
					for _, team in pairs(TS:GetChildren()) do
						if team.Name == TeamName then
							for _, player in pairs(team:GetPlayers()) do
								GS.FE.TeamChange:FireServer(player, BrickColor.new(0))
							end
						end
					end
	    	    end)

	    	    MainTab:AddToggle('IsBaby', {Text = 'Is Baby'})
	    	    Toggles.IsBaby:OnChanged(function()
					TeamName = Toggles.IsBaby.Value and 'Baby' or 'Parent'
	    	        TeamType = Toggles.IsBaby.Value and BrickColor.new(23) or BrickColor.new(21)
	    	    end)

                MainTab:AddDivider()

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

	    	    MainTab:AddButton('Kick Others', function()
                    for _, v in pairs(PS:GetPlayers()) do
                        if v ~= PSLP then
                            GS.FE.Config:FireServer(PSLP, "Kick", v.Name)
                        end
                    end
	    	    end)

	    	    MainTab:AddButton('Kick All', function()
                    for _, v in pairs(PS:GetPlayers()) do
                        GS.FE.Config:FireServer(PSLP, "Kick", v.Name)
                    end
	    	    end)

	    	    MainTab:AddButton('Kick Teams', function()
					for _, team in pairs(TS:GetChildren()) do
						if team.Name == TeamName then
							for _, player in pairs(team:GetPlayers()) do
								GS.FE.Config:FireServer(game:GetService("Players").LocalPlayer, "Kick", player.Name)
							end
						end
					end
	    	    end)

	    	    MainTab:AddButton('Ban Others', function()
					PS.PlayerAdded:Connect(function(plr:Player)
						GS.FE.Config:FireServer(PSLP, "Kick", plr.Name)
					end)
	    	    end)

                MainTab:AddDivider()

				local section = Tab:AddTab('Extras') do
					section:AddButton('Hack Vote', function()
						GS.Votes.Vote:FireServer(isManual(not isinf, chooseVote), amountVote)
					end)

					section:AddButton('Delete Blind', function()
						PSLP.PlayerGui.Menu.Clear:Destroy()
					end)

					section:AddButton('Show Developer Menu', function()
						PSLP.PlayerGui.Menu.Config.Frame.Visible = true
					end)

					MainTab:AddButton('Flip All', function()
						for _, v in pairs(workspace:GetDescendants()) do
							if v:IsA("BasePart") then
								PSLP.Character.Spatula.ToolUse:FireServer(PSLP, v, v.Position, v.Position)
							end
						end
					end)
	
					section:AddToggle('IsInfi', {Text = 'Is Randomized'})
					Toggles.IsInfi:OnChanged(function()
						isinf = Toggles.IsInfi.Value
					end)
	
					section:AddSlider('VoteSlider', {Text = 'Game Modes', Default = 0, Min = 0, Max = 6, Rounding = 0, Compact = false})
					Options.VoteSlider:OnChanged(function()
						chooseVote = Options.VoteSlider.Value
					end)
	
					section:AddInput('votemany', {Default = '', Numeric = false, Finished = false, Text = 'Vote Amount:', Placeholder = 'Name'})
					Options.votemany:OnChanged(function()
						if Options.votemany.Value == "math.huge" then
							amountVote = math.huge
						else
							amountVote = Options.votemany.Value
						end
					end)
				end
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