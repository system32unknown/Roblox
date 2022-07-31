local OldNameCall = nil
local plr = game:GetService("Players").LocalPlayer
local cclosure = syn_newcclosure or newcclosure or nil

if not cclosure or not hookmetamethod then
   plr:Kick("\n\nYour exploit doesn't support hookmetamethod\n(x.synapse.to | script-ware.com | krnl.place)\n")
end

local success, reason = pcall(function()
	OldNameCall = hookmetamethod(game, "__namecall", cclosure(function(self, ...)
	    local NamecallMethod = getnamecallmethod()
	
	    if NamecallMethod == "FireServer" or NamecallMethod == "InvokeServer" then
	        if (NamecallMethod == "Kick" or NamecallMethod == "kick") and not checkcaller() then
				if self ~= plr then
					return OldNameCall(self, ...)
				end
	         	return
	        end
	    elseif (NamecallMethod == "Kick" or NamecallMethod == "kick") and not checkcaller() then
			if self ~= plr then
				return OldNameCall(self, ...)
			end
	        return
	    end

	    return OldNameCall(self, ...)
	end))
end)

if OldNameCall then
	print(success)
	if not success then
		error("reason:" .. reason)
	end
else
	plr:Kick("Anti Kick Failed.")
end
