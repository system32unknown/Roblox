local MMC_LIB = loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/MakeMessageClient.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/cerberus.lua"))()

_G.Key = "JEUFUb7Wyq4jsbWfE"

local Click = click_detector or fireclickdetector

local looped_sound = false
local pitch = 1
local volume = 1
local soundId = 0

function setSound(pitch, Volume, SoundID, Remote, looped)
    looped = looped or true
	local randomized_id = "V3rm was here".. math.random(5838327)
   	local Args = {
		[1] = "newSound",
		[2] = randomized_id,
		[3] = game.InsertService,
		[4] = 'rbxassetid://'..SoundID,
		[5] = pitch,
		[6] = Volume,
		[7] = looped
	}
   	Remote:FireServer(unpack(Args))
	return {[1] = "playSound", [2] = randomized_id}
end

local SongList = {3929730934, 5567523008, 5517133180, 2631687985, 2478816735, 188088048, 343430735}

local window = Library.new("Friskshift's Script Collection") -- Args(<string> Name, <boolean?> ConstrainToScreen)
window:LockScreenBoundaries(true) -- Args(<boolean> ConstrainToScreen)

local tab = window:Tab("Main") -- Args(<string> Name, <string?> TabImage)

local section = tab:Section("Main Scripts") -- Args(<string> Name)

section:Button("Telekinesis", function()
    local ShowUI = true
    local UIRequest = ShowUI and "%20with%20UI" or ""

    if not getgenv().AlreadyEquipped then
        MMC_LIB:MakeSysMsg("[Friskshift]: Telekinesis Final by Friskshift", Color3.fromRGB(255, 255, 255))
        MMC_LIB:MakeSysMsg("[Friskshift]: Press V to Show Keys")
    else
        MMC_LIB:MakeSysMsg("[Friskshift]: Telekinesis Already running, retrying..", Color3.fromRGB(255, 0, 0), Enum.Font.Arcade, 20)
        getgenv().AlreadyEquipped = false
        wait(2)
        MMC_LIB:MakeSysMsg("[Friskshift]: Done!", Color3.fromRGB(0, 255, 0), Enum.Font.Arcade, 20)
    end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/%5BFE%5D%20Telekinesis%20Script".. UIRequest ..".lua"))()
end)

section:Button("Roleplay Name Fucker", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/FE%20Roleplay%20Name%20Fucker%20Rewrite.lua"))()
end)

section:Button("Where's the ruiner", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/system32unknown/Roblox/main/Where\'s%20the%20ruiner.lua'))()
end)

section:Button("Apple GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Applehollyday7/Roblox-Apple_GUI/main/Main"))()
end)

section:Button("R15 GUI", function()
    loadstring(game:HttpGet('https://gitlab.com/Tsuniox/lua-stuff/-/raw/master/R15GUI.lua'))()
end)

section:Button("Town Trasher", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MojaveMF/miscscripts/main/towntrasher.lua",true))()
end)

section:Button("Runker 51 GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GoodB0y08/Sk1dW6r3.lua/main/cool-stuff/Runker51.lua"))("OMG GIVE PSU PREMIUM!!!! :(")("JOIN DISCORD OR NOOB")
end)

section:Button("Rook GUI", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Duderpast/nomi/main/rook-hub/rook-hub-loader.lua"))()
end)

section:Button("Bark", function()
    loadstring(game:HttpGetAsync'https://cdn.applebee1558.com/bark/bark.lua')('thanks for bark, #barkwinning')
end)

section:Button("Work at Pizza Place", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/system32unknown/Roblox/main/Work%20at%20Pizza%20Place.lua"))()
end)

local utilsection = tab:Section("Util Scripts")

utilsection:Button("Click GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/Click%20GUI.lua"))()
end)

utilsection:Button("Simple Remote Spy V3", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
end)

utilsection:Button("IY Field", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

utilsection:Button("Kick Bypass", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/Antis/%5BOP%5D%20New%20Kick%20Bypass.lua"))()
end)

utilsection:Button("Secured Dex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))()
end)

utilsection:Button("Hydroxide", function()
    local function webImport(file)
        return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/%s.lua"):format(file)), file .. '.lua')()
    end

    webImport("init")
    webImport("ui/main")
end)

local OPsection = tab:Section("OP Scripts")

OPsection:Button("Backdoor.exe", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/iK4oS/backdoor.exe/master/source.lua"))()
end)

OPsection:Button("Selexity", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/o5u3/Selexity/main/Main', true))()
end)

utilsection:Button("Click All Play", function()
    for _, object in pairs(workspace:GetDescendants()) do
    	if object:IsA("ClickDetector") then
    		if string.lower(object.Parent.name) == "play" then
    			Click(object)
    		end
    	end
    end
end)

local FEtab = window:Tab("FE") -- Args(<string> Name, <string?> TabImage)

local FEsection = FEtab:Section("FE Sound (Only Cars)") -- Args(<string> Name)

FEsection:Button("Play Crazy Sound", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "AC6_FE_Sounds" then
            local soundshit = SongList[math.random(1, #SongList)]
            v:FireServer(unpack(setSound(math.random(-3, 3), math.random(1, 100), soundshit, v)))
        end
    end
end)

FEsection:Button("Play Sound", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "AC6_FE_Sounds" then
            v:FireServer(unpack(setSound(pitch, volume, soundId, v, looped_sound)))
        end
    end
end)

FEsection:Button("Play Randomized Sound", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "AC6_FE_Sounds" then
            local soundshit = SongList[math.random(1, #SongList)]
            v:FireServer(unpack(setSound(pitch, volume, soundshit, v, looped_sound)))
        end
    end
end)

FEsection:Toggle("Looped", function(bool)
    looped_sound = bool
end) -- Args(<String> Name, <Function> Callback)

FEsection:Slider("Pitch", function(val)
   pitch = val
end, 3, -3) -- Args(<String> Name, <Function> Callback, <Number?> MaximumValue, <Number?> MinimumValue)ack)

FEsection:Slider("Volume", function(val)
   volume = val
end, 100, 0) -- Args(<String> Name, <Function> Callback, <Number?> MaximumValue, <Number?> MinimumValue)

FEsection:TextBox("SoundId", function(txt)
    soundId = tonumber(txt)
end) -- Args(<String> Name, <Function> Callback