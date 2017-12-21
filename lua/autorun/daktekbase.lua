if SERVER then
hook.Add( "InitPostEntity", "DakTekRunOnLoadHook", function()
	local Settings = physenv.GetPerformanceSettings() // copy table from physenfv
	Settings.MaxVelocity = 1000000 // change max velocity
	Settings.MaxAngularVelocity = 1000000
	physenv.SetPerformanceSettings(Settings) // push max velocity back into engine.
	print("DakTekLoaded")
end)

DakTekEntList = {} --Create Entity list for storing things people spawn
--Setup global daktek function for setting up affected entities.
function DakTekSetupNewEnt(ent)
	if IsValid(ent) and not (string.Explode("_",ent:GetClass(),false)[1] == "dak") then --make sure its not daktek stuff
 		--setup values
 		ent.DakHealth = ent:GetPhysicsObject():GetMass()/20
 		ent.DakRed = ent:GetColor().r
		ent.DakGreen = ent:GetColor().g
		ent.DakBlue = ent:GetColor().b
		ent.DakName = "Armor"
 		ent.DakMaxHealth = ent:GetPhysicsObject():GetMass()/20
 		--DakTekEntList[ ent:EntIndex() ] = ent -- add to list
 		ent.DakPooled = 0
	else
		--exceptions for bots
		if ent:GetClass()=="dak_bot" then
			--ent.DakHealth = ent:GetPhysicsObject():GetMass()/20
			ent.DakHealth = 10
	 		ent.DakRed = ent:GetColor().r
			ent.DakGreen = ent:GetColor().g
			ent.DakBlue = ent:GetColor().b
			ent.DakName = "Armor"
			ent.DakMaxHealth = 10
	 		--ent.DakMaxHealth = ent:GetPhysicsObject():GetMass()/20
	 		--DakTekEntList[ ent:EntIndex() ] = ent -- add to list
	 		ent.DakPooled = 0
		end
	end
end

--[[
local LastTime = CurTime()
hook.Add("Think", "DakTekWeightAndColorHandlingHook", function() --runs through entity list to set armors based on weight and colors based on damage
	if(CurTime()>LastTime+1) then
			for k, v in pairs(DakTekEntList) do
				if IsValid(v) and v:IsSolid() and IsValid(v:GetPhysicsObject()) then --do a check for finding if its not weapons here
					local Mass = v:GetPhysicsObject():GetMass()
 					local ArmorPerTon = Mass/20 --50 points of armor per ton
 					if v.DakPooled==0 then
	 					local CurHealth = v.DakHealth
	 					local MaxHealth = v.DakMaxHealth
	 					if CurHealth == 0 or CurHealth == MaxHealth then --make sure entity either has no set health or is at full hp before letting current health change, avoids mass setting exploits
	 						v.DakHealth = ArmorPerTon
	 						v.DakRed = v:GetColor().r
							v.DakGreen = v:GetColor().g
							v.DakBlue = v:GetColor().b
	 					end
	 					v.DakMaxHealth = ArmorPerTon --set max health regardless of other values
	 					if CurHealth>MaxHealth then
	 						v.DakHealth = v.DakMaxHealth
	 					end
	 				else
	 					local CurHealth = v.DakHealth
	 					local MaxHealth = v.DakMaxHealth
	 					if CurHealth == 0 or CurHealth == MaxHealth then
	 						v.DakRed = v:GetColor().r
							v.DakGreen = v:GetColor().g
							v.DakBlue = v:GetColor().b
						end
	 				end
 					local HPPerc = v.DakHealth/v.DakMaxHealth --get hp percent then set colors based on it
					v:SetColor(Color(v.DakRed*HPPerc,v.DakGreen*HPPerc,v.DakBlue*HPPerc,v:GetColor().a))
				end
			end
		LastTime = CurTime()
	end
end)
]]--
end
