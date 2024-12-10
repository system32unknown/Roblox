local acs = {}
acs.__index = acs

local RS = game:GetService('ReplicatedStorage')
local PS = game:GetService('Players')
local PSPL = PS.LocalPlayer

local RS_ACS = nil
local ACS_EVENTS = nil
local newACS = false

acs.version = "unknown"

function acs.init(name:string):boolean
    name = name or "ACS_Engine"

    if not RS:FindFirstChild(name) then
        return false
    else
        RS_ACS = RS[name]
    end

    if RS_ACS:FindFirstChild("Events") then
        ACS_EVENTS = RS_ACS.Events
        newACS = true
    else
        ACS_EVENTS = RS_ACS.Eventos
    end

    acs.version = newACS and "2.0.1" or "1.7.5"
    return true
end

function acs.setValue(ValueObj, NewValue):boolean
    local status, message = pcall(function()
        if newACS then
            ACS_EVENTS.Refil:FireServer(ValueObj, NewValue)
        else
            ACS_EVENTS.Recarregar:FireServer(NewValue, {ACS_Modulo = {Variaveis = {StoredAmmo = ValueObj}}})
        end
    end)
    if status then
        return true
    else
        print("Tired to kick: " .. message)
        return false
    end
end

local crash_active = false
function acs.crash()
    if not crash_active then
        crash_active = true
    else
        return
    end

    while task.wait() do
        if newACS then
            for _, p in PS:GetPlayers() do
                ACS_EVENTS.Suppression:FireServer(p, 666, 666, 666)
            end
        else
            ACS_EVENTS.ServerBullet:FireServer(Vector3.new(0 / 0 / 0),Vector3.new(0 / 0 / 0))
        end
    end
end

function acs.whizz(p:Player)
    ACS_EVENTS.Whizz:FireServer(p)
end

function acs.build(parent:CFrame, cframe:CFrame, size:Vector3)
    ACS_EVENTS.Breach:FireServer(3, {Fortified = {}, Destroyable = workspace}, CFrame.new(), CFrame.new(), {CFrame = parent * cframe, Size = size})
end
function acs.bypassbuild():boolean
    local fort = PSPL.Character.ACS_Client.Kit.Fortifications
    local status, message = pcall(function()
        if newACS then
            ACS_EVENTS.Refil:FireServer(fort, -99999999)
        else
            ACS_EVENTS.Recarregar:FireServer(9999999, {ACS_Modulo = {Variaveis = {StoredAmmo = fort}}})
        end
    end)
    if status then
        return true
    else
        print("Tired to kick: " .. message)
        return false
    end
end

-- 1.7.5 Exclusive
function acs.supress(p:Player, x:number, y:number, z:number)
    if not newACS then
        ACS_EVENTS.Suppression:FireServer(p, x, y, z)
    else
        print("Supression event doesn't support on 2.0.1.")
    end
end
function acs.damage(p:Player, val:number)
    if not newACS then
        ACS_EVENTS.Damage:FireServer(p, val, 0, 0)
    else
        print("Damage event doesn't support on 2.0.1.")
    end
end

function acs.nomodifiers()
    if acs.version == "2.0.1" then
        local cfg = require(RS_ACS.GameRules.Config)
        cfg.EnableStamina = false
        cfg.EnableFallDamage = false
        cfg.AntiBunnyHop = false
    else
        print("Damage event doesn't support on 1.7.5.")
    end
end

return acs
