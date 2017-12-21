E2Lib.RegisterExtension("daktek",true)

-- Dakota for DakTek
-- Liddul for Functions :D

local function getName(ent) -- Checks if it's a DakTek entity, if so, returns the Name, else "" as string
	if not IsValid(ent) then return end
	local Name=ent.DakName or ""
	if Name then return Name or "" else return "" end
end

local function usesAmmo(ent) -- Returns true if ent uses ammo, else false
	if not IsValid(ent) then return end
	local Class=(ent:GetClass() or "")
	if Class=="dak_gun" then
		return ent.DakUseAmmo or false
	elseif Class=="dak_launcher" then
		return true
	else
		return false
	end
end

local function getAmmo(ent) -- Returns ammo, if available
	if not IsValid(ent) then return end
	if usesAmmo(ent)==true then return ent.DakEngine[ent.DakAmmoType] or 0 else return 0 end
end

-- E2 Functions
__e2setcost(1)
e2function string entity:dtName() -- Returns the name of the object
	if not IsValid(this) then return end
	return getName(this) or ""
end

e2function number entity:dtHealth() -- Returns the health of the object
	if not IsValid(this) then return end
	return this.DakHealth or 0
end

e2function number entity:dtMaxHealth() -- Returns the max health of the object
	if not IsValid(this) then return end
	return this.DakMaxHealth or 0
end

e2function number entity:dtShellVelocity() -- Returns shell velocity for cannons, for ballistics calculations
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_gun" then return this.DakShellVelocity or 0 else return 0 end
end

e2function number entity:dtShellMass() -- Returns shell mass for cannons, for ballistics calculations
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_gun" then return this.DakShellMass or 0 else return 0 end
end

e2function number entity:dtUsesAmmo() -- Returns 1/0 if Weapon uses Ammo
	if not IsValid(this) then return end
	local DoesUseAmmo=usesAmmo(this)
	if DoesUseAmmo==true then return 1 else return 0 end
end

e2function number entity:dtAmmo() -- Returns ammo, 0 if invalid or no ammo
	if not IsValid(this) then return end
	return getAmmo(this)
end

e2function string entity:dtAmmoType() -- Returns ammo type, returns an empty string if invalid or no ammo type
	if not IsValid(this) then return end
	if usesAmmo(this)==true then return this.DakAmmoType or "" else return "" end
end

e2function number entity:dtHeatPerShot() -- Returns the heat per shot, works on anything with such a thing
	if not IsValid(this) then return end
	if not ((this:GetClass() or "")=="dak_engine") then return this.DakHeat or 0 else return 0 end
end

e2function number entity:dtCooldown() -- Returns the cooldown in seconds
	if not IsValid(this) then return end
	local Class=(this:GetClass() or "")
	
	if Class=="dak_gun" or Class=="dak_laser" or Class=="dak_xpulselaser" or Class=="dak_lams" or Class=="dak_launcher" then
		return this.DakCooldown or 0
	else
		return 0
	end
end

e2function number entity:dtLaserDuration()
	if not IsValid(this) then return end
	if this:GetClass()=="dak_laser" then return this.DakDuration or 0 else return 0 end
end

--100*(math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100)/self.DakCooldown)
e2function number entity:dtCooldownPercent() -- Returns percentage of current cooldown, includes Laser Duration
	if not IsValid(this) then return end
	return (100*(math.Clamp(((this.LastFireTime or CurTime())+(this.DakCooldown or 0))-CurTime(),0,100)/(this.DakCooldown or 1))) or 0
end

-- Engine stuff
e2function number entity:dtHeat() -- Returns heat, only works on engine
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_engine" then return this.DakHeat or 0 else return 0 end
end

e2function number entity:dtMaxHeat() -- Returns max heat, only works on engine
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_engine" then return this.DakMaxHeat or 0 else return 0 end
end

e2function number entity:dtCooling() -- Returns cooling power, only works on engine
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_engine" then return this.DakCooling or 0 else return 0 end
end

e2function number entity:dtIsTagged() -- Returns if the engine is tagged.
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_engine" then return this.Tagged or 0 else return 0 end
end

e2function number entity:dtIsNARCed() -- Returns if the engine is NARCed.
	if not IsValid(this) then return end
	if (this:GetClass() or "")=="dak_engine" then return this.NARCed or 0 else return 0 end
end