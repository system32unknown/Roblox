local MMC_LIB = loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/MakeMessageClient.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/cerberus.lua"))()

local window = Library.new("Friskshift's Script Collection") -- Args(<string> Name, <boolean?> ConstrainToScreen)

window:LockScreenBoundaries(true) -- Args(<boolean> ConstrainToScreen)

local tab = window:Tab("Main") -- Args(<string> Name, <string?> TabImage)

local section = tab:Section("Main Scripts") -- Args(<string> Name)

section:Button("Telekinesis", function()
    getgenv().Keys_Settings = {
        ["Increase Distance"] = "h",
        ["Decrease Distance"] = "j",
        ["Freeze Rotation"] = "r",
        ["Pull"] = "t",
        ["Throw"] = "y",
        ["Increase Power"] = "-",
        ["Decrease Power"] = "=",
        ["Clone Object"] = "x",
        ["Net Bypass"] = "k",
        ["Pull Torso to Part"] = "b",
        ["Show Help Menu"] = "v",
        ["Spawn Cube"] = "n"
    }
    getgenv().useLegacyObj = true
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

local utilsection = tab:Section("Util Scripts")

utilsection:Button("Click GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/Click%20GUI.lua"))()
end)

utilsection:Button("IY Field", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

utilsection:Button("Kick Bypass", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/system32unknown/Roblox/main/Antis/%5BOP%5D%20New%20Kick%20Bypass.lua"))()
end)

utilsection:Button("Click All Play", function()
    local Click = click_detector or fireclickdetector

    for _, object in pairs(workspace:GetDescendants()) do
    	if object:IsA("ClickDetector") then
    		if string.lower(object.Parent.name) == "play" then
    			Click(object)
    		end
    	end
    end
end)