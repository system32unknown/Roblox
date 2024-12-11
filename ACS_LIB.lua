local acs = {}
acs.__index = acs

local RS = game:GetService('ReplicatedStorage')
local PS = game:GetService('Players')
local PSPL = PS.LocalPlayer

local RS_ACS = nil
local ACS_EVENTS = nil
local newACS = false

acs.version_ = "unknown"
acs.acs_id = "unknown"

function acs.getACS_Class(plr, type)
    if plr.Character:FindFirstChild("ACS_Client") then
        return plr.Character.ACS_Client[type]
    else return nil end
end

function acs.init(name:string, noaccess:boolean):boolean
    name = name or "ACS_Engine"
    noaccess = noaccess or true

    if not RS:FindFirstChild(name) then return false end
    RS_ACS = RS[name]

    if RS_ACS:FindFirstChild("Events") then
        ACS_EVENTS = RS_ACS.Events
        newACS = true
    else
        ACS_EVENTS = RS_ACS.Eventos
    end

    acs.version_ = newACS and "2.0.1" or "1.7.5"
    if newACS and not noaccess then
        acs.acs_id = ACS_EVENTS.AcessId:InvokeServer(PSPL.UserId) .. "-" .. PSPL.UserId
    end
    return true
end

function acs.setValue(ValueObj:ValueBase, NewValue:any):boolean
    local status, message = pcall(function()
        if newACS then
            ACS_EVENTS.Refil:FireServer(ValueObj, NewValue)
        else
            ACS_EVENTS.Recarregar:FireServer(NewValue, {["ACS_Modulo"] = {["Variaveis"] = {["StoredAmmo"] = ValueObj}}})
        end
    end)
    if not status then
        print("Tired to kick or error: " .. message)
        return false
    end

    return true
end

local crash_active = false
function acs.crash()
    if crash_active then
        print("Currently crashing in this server!")
        return
    end
    crash_active = true

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
    if newACS then
        ACS_EVENTS.Breach:InvokeServer(3, {Fortified = {}, Destroyable = workspace}, CFrame.new(), CFrame.new(), {CFrame = parent * cframe, Size = size})
    else
        ACS_EVENTS.Breach:FireServer(3, {Fortified = {}, Destroyable = workspace}, CFrame.new(), CFrame.new(), {CFrame = parent * cframe, Size = size})
    end
end
function acs.bypassbuild():boolean
    local status, message = pcall(function()
        for _, v in PS:GetPlayers() do
            local fort = acs.getACS_Class(v, "Kit").Fortifications
            if acs.getACS_Class(v, "Kit") ~= nil then
                if newACS then
                    ACS_EVENTS.Refil:FireServer(fort, -99999999)
                else
                    ACS_EVENTS.Recarregar:FireServer(9999999, {["ACS_Modulo"] = {["Variaveis"] = {["StoredAmmo"] = fort}}})
                end
            end
        end
    end)
    if not status then
        print("Tired to kick or error: " .. message)
        return false
    end

    return true
end

function acs.damage(p:Player, val:number)
    if newACS then
        local GunModel = PS:FindFirstChild("ACS_Settings", true) or workspace:FindFirstChild("ACS_Settings", true)
        if not GunModel then print("[WARN] No available gun in current game") return end
        GunModel = GunModel.Parent

        local Module:ModuleScript = require(GunModel.ACS_Settings)
        Module.BulletPenetration = 99999999

        ACS_EVENTS.Damage:InvokeServer(GunModel, p.Character.Humanoid, 999, 1, Module, {minDamageMod = val, DamageMod = val}, nil, nil, acs.acs_id)
    else
        ACS_EVENTS.Damage:FireServer(p, val, 0, 0)
    end
end

-- 1.7.5 Exclusive
function acs.supress(p:Player, x:number, y:number, z:number)
    if newACS then
        print("Supression event doesn't support for 2.0.1.")
        return
    end
    ACS_EVENTS.Suppression:FireServer(p, x, y, z)
end
function acs.explode(offset:Vector3, pressure:number, radius:number, desjoint:number, expdamage:number)
    pressure = pressure or 50
    radius = radius or 50
    desjoint = desjoint or 1
    expdamage = expdamage or 100

    if newACS then
        print("Explode event doesn't support for 2.0.1.")
        return
    end
    ACS_EVENTS.Hit:FireServer(offset, nil, Vector3.zero, nil, {
        ["ExplosiveHit"] = true, --Don't change this
        ["ExPressure"] = pressure, --Used to determine the amount of force applied to BaseParts caught in the BlastRadius
        ["ExpRadius"] = radius, --This property determines the radius of the Explosion, in studs. (0 - 100)
        ["DestroyJointRadiusPercent"] = desjoint, --Used to set how much of the BlastRadius, (0 - 1) within which all joints will be destroyed.
        ["ExplosionDamage"] = expdamage --Amount of damage it does
    })
end
function acs.surrender(on:boolean, p:Player)
    if newACS then
        print("Surrender event doesn't support for 2.0.1.")
        return
    end
    ACS_EVENTS.MedSys.Algemar:FireServer(on, p.Name, 1)
end

-- 2.0.1 Exclusive
function acs.nomodifiers()
    if not newACS then
        print("Modifiers doesn't support for 1.7.5.")
        return
    end

    local cfg:ModuleScript = require(RS_ACS.GameRules.Config)
    cfg.EnableStamina = false
    cfg.EnableFallDamage = false
    cfg.AntiBunnyHop = false
end
function acs.hitfx(p:Player, mat:Enum.Material, radius:number, damage:number)
    mat = mat or Enum.Material.DiamondPlate
    radius = radius or 99e99
    damage = damage or 333

    if not newACS then
        print("HitFX doesn't support for 1.7.5.")
        return
    end

    ACS_EVENTS.HitEffect:FireServer(unpack({
        [1] = p.Character.HumanoidRootPart.CFrame.Position,
        [2] = workspace,
        [4] = mat,
        [5] = {
            ["ExplosionRadius"] = radius,
            ["ExplosionType"] = "72EXP",
            ["ExplosiveAmmo"] = true,
            ["TorsoDamage"] = {[1] = damage, [2] = damage},
            ["LimbDamage"] = {[1] = damage, [2] = damage},
            ["HeadDamage"] = {[1] = damage, [2] = damage},
        }
    }))
end

return acs
