local VERSION = " v1.0.0"

local github = 'https://raw.githubusercontent.com/'
local repo = github..'wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

local PS = game:GetService("Players")
local TS = game:GetService("Teams")
local RS = game:GetService("ReplicatedStorage")
local PSLP = PS.LocalPlayer
local GS = workspace.GameStuff
local CLEARMENU = PSLP.PlayerGui.Menu.Clear

if loaded then
	print("already loaded you dumb")
	return
end
getgenv().loaded = true

function isManual(mode:boolean, num:number):string
    return tostring(mode and num or math.random(0, 6))
end

local chooseVote, amountVote = 0, 0
local IsRandom, TeamType, TeamName = false, BrickColor.new(21), ''
local PlayerName = ''

local Window = Library:CreateWindow({Title = 'Where\'s the Ruiner' .. VERSION, Center = true, AutoShow = true}) do
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

				local section = Tab:AddTab('Extras') do
					section:AddButton('Delete Blind', function()
						for _, v in CLEARMENU:GetDescendants() do
							if type(tonumber(v.Name)) == "number" then
								v:Destroy()
							end
						end
					end)

					section:AddButton('Show Developer Menu', function()
						PSLP.PlayerGui.Menu.Config.Frame.Visible = true
					end)

					section:AddButton('Flip All', function()
						for _, v in pairs(workspace:GetDescendants()) do
							if v:IsA("BasePart") then
								if PSLP.Backpack:FindFirstChild("Spatula") then
									PSLP.Backpack.Spatula.ToolUse:FireServer(PSLP, v, v.Position, v.Position)
								else
									RS.UseTool:FireServer(PSLP, v, v.Position, v.Position)
								end
							end
						end
					end)

					section:AddDivider()
	
					section:AddButton('Hack Vote', function()
						GS.Votes.Vote:FireServer(isManual(not IsRandom, chooseVote), amountVote)
					end)

					section:AddToggle('IsRand', {Text = 'Is Randomized'})
					Toggles.IsRand:OnChanged(function()
						IsRandom = Toggles.IsRand.Value
					end)
	
					section:AddSlider('VoteSlider', {Text = 'Game Modes', Default = 0, Min = 0, Max = 6, Rounding = 0, Compact = false})
					Options.VoteSlider:OnChanged(function()
						chooseVote = Options.VoteSlider.Value
					end)
	
					section:AddInput('votemany', {Default = '', Numeric = false, Finished = false, Text = 'Vote Amount:', Placeholder = 'Amount'})
					Options.votemany:OnChanged(function()
						if Options.votemany.Value == "math.huge" then
							amountVote = math.huge
						elseif Options.votemany.Value == "-math.huge" then
							amountVote = -math.huge
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