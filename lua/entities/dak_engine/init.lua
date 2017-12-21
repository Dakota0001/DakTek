AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakName = "Small Standard Engine"
ENT.DakTonnageLimit = 40000
ENT.DakCooling = 1
ENT.DakBaseCooling = 1
ENT.DakMaxHeat = 20
ENT.DakBaseMaxHeat = 20
ENT.DakHeat = 0
ENT.DakHealth = 25
ENT.DakMaxHealth = 25
ENT.DakMass = 5000
ENT.DakModel = "models/dak/smallstandardengine.mdl"
ENT.ECM = 0
ENT.BAP = 0
ENT.Tagged = 0
ENT.NARCed = 0
ENT.Stealthed = 0
ENT.Supercharged = 0
ENT.IsStandard = 0
ENT.IsCompact = 0
ENT.SortedContraption={}

--Module stuff here
ENT.HighYieldPayloads = 0
ENT.MissileLoader = 0
ENT.BeamFocus = 0
ENT.TightWadding = 0
ENT.DumbfireFins = 0
ENT.MissileExhaustVenting = 0
ENT.LaserInsulation = 0
ENT.PPCFrequencyScrambler = 0
ENT.WeaponShielding = 0
ENT.HeavyArmor = 0
ENT.ReactiveArmor = 0
ENT.ReflectiveArmor = 0
ENT.EnhancedBAP = 0
ENT.HeatsinkSupercooling = 0
ENT.ReinforcedHeatsinks = 0
ENT.EfficientLAMS = 0

--define all the ammo stuff here
ENT.LongTomAmmo = 0
ENT.LongTomAmmoUse = false 
ENT.LongTomAmmoUseQueue = 0
ENT.MachineGunAmmo = 0
ENT.MachineGunAmmoUse = false 
ENT.MachineGunAmmoUseQueue = 0
ENT.LightMachineGunAmmo = 0
ENT.LightMachineGunAmmoUse = false 
ENT.LightMachineGunAmmoUseQueue = 0
ENT.HeavyMachineGunAmmo = 0
ENT.HeavyMachineGunAmmoUse = false 
ENT.HeavyMachineGunAmmoUseQueue = 0
ENT.AC2Ammo = 0 
ENT.AC2AmmoUse = false 
ENT.AC2AmmoUseQueue = 0
ENT.AC5Ammo = 0
ENT.AC5AmmoUse = false 
ENT.AC5AmmoUseQueue = 0
ENT.AC10Ammo = 0
ENT.AC10AmmoUse = false 
ENT.AC10AmmoUseQueue = 0
ENT.AC20Ammo = 0
ENT.AC20AmmoUse = false 
ENT.AC20AmmoUseQueue = 0
ENT.IAC2Ammo = 0 
ENT.IAC2AmmoUse = false 
ENT.IAC2AmmoUseQueue = 0
ENT.IAC5Ammo = 0
ENT.IAC5AmmoUse = false 
ENT.IAC5AmmoUseQueue = 0
ENT.IAC10Ammo = 0
ENT.IAC10AmmoUse = false 
ENT.IAC10AmmoUseQueue = 0
ENT.IAC20Ammo = 0
ENT.IAC20AmmoUse = false 
ENT.IAC20AmmoUseQueue = 0
ENT.FAC2Ammo = 0 
ENT.FAC2AmmoUse = false 
ENT.FAC2AmmoUseQueue = 0
ENT.FAC5Ammo = 0
ENT.FAC5AmmoUse = false 
ENT.FAC5AmmoUseQueue = 0
ENT.FAC10Ammo = 0
ENT.FAC10AmmoUse = false 
ENT.FAC10AmmoUseQueue = 0
ENT.FAC20Ammo = 0
ENT.FAC20AmmoUse = false 
ENT.FAC20AmmoUseQueue = 0
ENT.UAC2Ammo = 0
ENT.UAC2AmmoUse = false 
ENT.UAC2AmmoUseQueue = 0
ENT.UAC5Ammo = 0
ENT.UAC5AmmoUse = false 
ENT.UAC5AmmoUseQueue = 0
ENT.UAC10Ammo = 0
ENT.UAC10AmmoUse = false 
ENT.UAC10AmmoUseQueue = 0
ENT.UAC20Ammo = 0
ENT.UAC20AmmoUse = false 
ENT.UAC20AmmoUseQueue = 0
ENT.RAC2Ammo = 0
ENT.RAC2AmmoUse = false 
ENT.RAC2AmmoUseQueue = 0
ENT.RAC5Ammo = 0
ENT.RAC5AmmoUse = false 
ENT.RAC5AmmoUseQueue = 0
ENT.RAC10Ammo = 0
ENT.RAC10AmmoUse = false 
ENT.RAC10AmmoUseQueue = 0
ENT.RAC20Ammo = 0
ENT.RAC20AmmoUse = false 
ENT.RAC20AmmoUseQueue = 0
ENT.LBX2Ammo = 0
ENT.LBX2AmmoUse = false 
ENT.LBX2AmmoUseQueue = 0
ENT.LBX5Ammo = 0
ENT.LBX5AmmoUse = false 
ENT.LBX5AmmoUseQueue = 0
ENT.LBX10Ammo = 0
ENT.LBX10AmmoUse = false 
ENT.LBX10AmmoUseQueue = 0
ENT.LBX20Ammo = 0
ENT.LBX20AmmoUse = false 
ENT.LBX20AmmoUseQueue = 0
ENT.AALBX2Ammo = 0
ENT.AALBX2AmmoUse = false 
ENT.AALBX2AmmoUseQueue = 0
ENT.AALBX5Ammo = 0
ENT.AALBX5AmmoUse = false 
ENT.AALBX5AmmoUseQueue = 0
ENT.AALBX10Ammo = 0
ENT.AALBX10AmmoUse = false 
ENT.AALBX10AmmoUseQueue = 0
ENT.AALBX20Ammo = 0
ENT.AALBX20AmmoUse = false 
ENT.AALBX20AmmoUseQueue = 0
ENT.SLBX2Ammo = 0
ENT.SLBX2AmmoUse = false 
ENT.SLBX2AmmoUseQueue = 0
ENT.SLBX5Ammo = 0
ENT.SLBX5AmmoUse = false 
ENT.SLBX5AmmoUseQueue = 0
ENT.SLBX10Ammo = 0
ENT.SLBX10AmmoUse = false 
ENT.SLBX10AmmoUseQueue = 0
ENT.SLBX20Ammo = 0
ENT.SLBX20AmmoUse = false 
ENT.SLBX20AmmoUseQueue = 0
ENT.LRM20Ammo = 0
ENT.LRM20AmmoUse = false 
ENT.LRM20AmmoUseQueue = 0
ENT.LRM15Ammo = 0
ENT.LRM15AmmoUse = false 
ENT.LRM15AmmoUseQueue = 0
ENT.LRM10Ammo = 0
ENT.LRM10AmmoUse = false 
ENT.LRM10AmmoUseQueue = 0
ENT.LRM5Ammo = 0
ENT.LRM5AmmoUse = false 
ENT.LRM5AmmoUseQueue = 0
ENT.MRM10Ammo = 0
ENT.MRM10AmmoUse = false 
ENT.MRM10AmmoUseQueue = 0
ENT.MRM20Ammo = 0
ENT.MRM20AmmoUse = false 
ENT.MRM20AmmoUseQueue = 0
ENT.MRM30Ammo = 0
ENT.MRM30AmmoUse = false 
ENT.MRM30AmmoUseQueue = 0
ENT.MRM40Ammo = 0
ENT.MRM40AmmoUse = false 
ENT.MRM40AmmoUseQueue = 0
ENT.SSRM2Ammo = 0
ENT.SSRM2AmmoUse = false 
ENT.SSRM2AmmoUseQueue = 0
ENT.SSRM4Ammo = 0
ENT.SSRM4AmmoUse = false 
ENT.SSRM4AmmoUseQueue = 0
ENT.SSRM6Ammo = 0
ENT.SSRM6AmmoUse = false 
ENT.SSRM6AmmoUseQueue = 0
ENT.SRM2Ammo = 0
ENT.SRM2AmmoUse = false 
ENT.SRM2AmmoUseQueue = 0
ENT.SRM4Ammo = 0
ENT.SRM4AmmoUse = false 
ENT.SRM4AmmoUseQueue = 0
ENT.SRM6Ammo = 0
ENT.SRM6AmmoUse = false 
ENT.SRM6AmmoUseQueue = 0
ENT.GaussAmmo = 0
ENT.GaussAmmoUse = false 
ENT.GaussAmmoUseQueue = 0
ENT.HeavyGaussAmmo = 0
ENT.HeavyGaussAmmoUse = false 
ENT.HeavyGaussAmmoUseQueue = 0
ENT.LightGaussAmmo = 0
ENT.LightGaussAmmoUse = false 
ENT.LightGaussAmmoUseQueue = 0
ENT.SBGAmmo = 0
ENT.SBGAmmoUse = false 
ENT.SBGAmmoUseQueue = 0
ENT.ThumperAmmo = 0
ENT.ThumperAmmoUse = false 
ENT.ThumperAmmoUseQueue = 0
ENT.RailgunAmmo = 0
ENT.RailgunAmmoUse = false 
ENT.RailgunAmmoUseQueue = 0
ENT.SniperAmmo = 0
ENT.SniperAmmoUse = false 
ENT.SniperAmmoUseQueue = 0
ENT.ArrowAmmo = 0
ENT.ArrowAmmoUse = false 
ENT.ArrowAmmoUseQueue = 0
ENT.MagshotAmmo = 0
ENT.MagshotAmmoUse = false 
ENT.MagshotAmmoUseQueue = 0
ENT.NARCAmmo = 0
ENT.NARCAmmoUse = false 
ENT.NARCAmmoUseQueue = 0
ENT.DakPooled=0
ENT.HAG20Ammo = 0
ENT.HAG20AmmoUse = false 
ENT.HAG20AmmoUseQueue = 0
ENT.HAG30Ammo = 0
ENT.HAG30AmmoUse = false 
ENT.HAG30AmmoUseQueue = 0
ENT.HAG40Ammo = 0
ENT.HAG40AmmoUse = false 
ENT.HAG40AmmoUseQueue = 0
ENT.ATM3HEAmmo = 0
ENT.ATM3HEAmmoUse = false 
ENT.ATM3HEAmmoUseQueue = 0
ENT.ATM6HEAmmo = 0
ENT.ATM6HEAmmoUse = false 
ENT.ATM6HEAmmoUseQueue = 0
ENT.ATM9HEAmmo = 0
ENT.ATM9HEAmmoUse = false 
ENT.ATM9HEAmmoUseQueue = 0
ENT.ATM12HEAmmo = 0
ENT.ATM12HEAmmoUse = false 
ENT.ATM12HEAmmoUseQueue = 0
ENT.ATM3SAmmo = 0
ENT.ATM3SAmmoUse = false 
ENT.ATM3SAmmoUseQueue = 0
ENT.ATM6SAmmo = 0
ENT.ATM6SAmmoUse = false 
ENT.ATM6SAmmoUseQueue = 0
ENT.ATM9SAmmo = 0
ENT.ATM9SAmmoUse = false 
ENT.ATM9SAmmoUseQueue = 0
ENT.ATM12SAmmo = 0
ENT.ATM12SAmmoUse = false 
ENT.ATM12SAmmoUseQueue = 0
ENT.ATM3ERAmmo = 0
ENT.ATM3ERAmmoUse = false 
ENT.ATM3ERAmmoUseQueue = 0
ENT.ATM6ERAmmo = 0
ENT.ATM6ERAmmoUse = false 
ENT.ATM6ERAmmoUseQueue = 0
ENT.ATM9ERAmmo = 0
ENT.ATM9ERAmmoUse = false 
ENT.ATM9ERAmmoUseQueue = 0
ENT.ATM12ERAmmo = 0
ENT.ATM12ERAmmoUse = false 
ENT.ATM12ERAmmoUseQueue = 0

function ENT:Initialize()
	self:SetModel( self.DakModel )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.DakHealth = self.DakMaxHealth

	local phys = self:GetPhysicsObject()
	self.timer = CurTime()

	if(IsValid(phys)) then
		phys:Wake()
	end

	self.Outputs = WireLib.CreateOutputs( self, { "Heat", "Cooling", "MaxHeat", "Health" } )
	self.Ammoboxes = {}
	self.Heatsinks = {}
	self.TagTimer = 0
	self.NARCTimer = 0
	self.BAPTimer = 0
	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.SlowThinkTime = CurTime()
 	self.DakActive = 0
	self.CurMass = 0
	self.LastCurMass = 0
	self.HitBox = {}
	self.HitBoxMass = 0
	self.Hitboxthinktime = CurTime()
	self.LastRemake = CurTime()
	--self.CurrentHealth = self.DakMaxHealth
end

local function GetPhysCons( ent, Results )
	local Results = Results or {}
	if not IsValid( ent ) then return end
		if Results[ ent ] then return end
		Results[ ent ] = ent
		local Constraints = constraint.GetTable( ent )
		for k, v in ipairs( Constraints ) do
			if not (v.Type == "NoCollide") then
				for i, Ent in pairs( v.Entity ) do
					GetPhysCons( Ent.Entity, Results )
				end
			end
		end
	return Results
end

local function GetParents( ent, Results )
	local Results = Results or {}
	local Parent = ent:GetParent()
	Results[ ent ] = ent
	if IsValid(Parent) then
		GetParents(Parent, Results)
	end
	return Results
end

function ENT:Think()
	if CurTime()>=self.SparkTime+0.33 then
		if self.DakHealth<=(self.DakMaxHealth*0.80) and self.DakHealth>(self.DakMaxHealth*0.60) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(1)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+3 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.4, 6)
				self.Soundtime=CurTime()
			end
		end
		if self.DakHealth<=(self.DakMaxHealth*0.60) and self.DakHealth>(self.DakMaxHealth*0.40) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(2)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+2 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.5, 6)
				self.Soundtime=CurTime()
			end
		end
		if self.DakHealth<=(self.DakMaxHealth*0.40) and self.DakHealth>(self.DakMaxHealth*0.20) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(3)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+1 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.6, 6)
				self.Soundtime=CurTime()
			end
		end
		if self.DakHealth<=(self.DakMaxHealth*0.20) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(4)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+0.5 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.75, 6)
				self.Soundtime=CurTime()
			end
		end
		self.SparkTime=CurTime()
	end
	if CurTime()>=self.SlowThinkTime+1 then
		if self.DakName == "Micro Compact Engine" then
			self.DakTonnageLimit = 10000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 15
			self.DakBaseMaxHeat = 15
			self.DakBaseMaxHealth = 10
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 10
			end
			self.DakMass = 1000
			self.DakModel = "models/dak/microcompactengine.mdl"
			self.PowerMod = 0.25
			self.IsCompact = 1
			self.IsStandard = 0
		end
		if self.DakName == "Micro Standard Engine" then
			self.DakTonnageLimit = 10000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 12.5
			self.DakBaseMaxHeat = 12.5
			self.DakBaseMaxHealth = 7.5
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 7.5
			end
			self.DakMass = 750
			self.DakModel = "models/dak/microstandardengine.mdl"
			self.PowerMod = 0.25
			self.IsCompact = 0
			self.IsStandard = 1
		end
		if self.DakName == "Micro XL Engine" then
			self.DakTonnageLimit = 10000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 10
			self.DakBaseMaxHeat = 10
			self.DakBaseMaxHealth = 5
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 5
			end
			self.DakMass = 500
			self.DakModel = "models/dak/microxlengine.mdl"
			self.PowerMod = 0.25
			self.IsCompact = 0
			self.IsStandard = 0
		end
		if self.DakName == "Small Compact Engine" then
			self.DakTonnageLimit = 40000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 30
			self.DakBaseMaxHeat = 30
			self.DakBaseMaxHealth = 50
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 50
			end
			self.DakMass = 5000
			self.DakModel = "models/dak/smallcompactengine.mdl"
			self.PowerMod = 1
			self.IsCompact = 1
			self.IsStandard = 0
		end
		if self.DakName == "Small Standard Engine" then
			self.DakTonnageLimit = 40000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 25
			self.DakBaseMaxHeat = 25
			self.DakBaseMaxHealth = 37.5
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 37.5
			end
			self.DakMass = 3750
			self.DakModel = "models/dak/smallstandardengine.mdl"
			self.PowerMod = 1
			self.IsCompact = 0
			self.IsStandard = 1
		end
		if self.DakName == "Small XL Engine" then
			self.DakTonnageLimit = 40000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 20
			self.DakBaseMaxHeat = 20
			self.DakBaseMaxHealth = 25
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 25
			end
			self.DakMass = 2500
			self.DakModel = "models/dak/smallxlengine.mdl"
			self.PowerMod = 1
			self.IsCompact = 0
			self.IsStandard = 0
		end
		if self.DakName == "Medium Compact Engine" then
			self.DakTonnageLimit = 75000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 50
			self.DakBaseMaxHeat = 50
			self.DakBaseMaxHealth = 100
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 100
			end
			self.DakMass = 10000
			self.DakModel = "models/dak/mediumcompactengine.mdl"
			self.PowerMod = 1.15
			self.IsCompact = 1
			self.IsStandard = 0
		end
		if self.DakName == "Medium Standard Engine" then
			self.DakTonnageLimit = 75000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 40
			self.DakBaseMaxHeat = 40
			self.DakBaseMaxHealth = 75
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 75
			end
			self.DakMass = 7500
			self.DakModel = "models/dak/mediumstandardengine.mdl"
			self.PowerMod = 1.15
			self.IsCompact = 0
			self.IsStandard = 1
		end
		if self.DakName == "Medium XL Engine" then
			self.DakTonnageLimit = 75000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 30
			self.DakBaseMaxHeat = 30
			self.DakBaseMaxHealth = 50
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 50
			end
			self.DakMass = 5000
			self.DakModel = "models/dak/mediumxlengine.mdl"
			self.PowerMod = 1.15
			self.IsCompact = 0
			self.IsStandard = 0
		end
		if self.DakName == "Large Compact Engine" then
			self.DakTonnageLimit = 100000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 60
			self.DakBaseMaxHeat = 60
			self.DakBaseMaxHealth = 150
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 150
			end
			self.DakMass = 15000
			self.DakModel = "models/dak/largecompactengine.mdl"
			self.PowerMod = 1.35
			self.IsCompact = 1
			self.IsStandard = 0
		end
		if self.DakName == "Large Standard Engine" then
			self.DakTonnageLimit = 100000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 50
			self.DakBaseMaxHeat = 50
			self.DakBaseMaxHealth = 112.5
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 112.5
			end
			self.DakMass = 11250
			self.DakModel = "models/dak/largestandardengine.mdl"
			self.PowerMod = 1.35
			self.IsCompact = 0
			self.IsStandard = 1
		end
		if self.DakName == "Large XL Engine" then
			self.DakTonnageLimit = 100000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 40
			self.DakBaseMaxHeat = 40
			self.DakBaseMaxHealth = 75
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 75
			end
			self.DakMass = 7500
			self.DakModel = "models/dak/largexlengine.mdl"
			self.PowerMod = 1.35
			self.IsCompact = 0
			self.IsStandard = 0
		end
		if self.DakName == "Ultra Compact Engine" then
			self.DakTonnageLimit = 200000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 80
			self.DakBaseMaxHeat = 80
			self.DakBaseMaxHealth = 300
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 300
			end
			self.DakMass = 30000
			self.DakModel = "models/dak/ultracompactengine.mdl"
			self.PowerMod = 1.7
			self.IsCompact = 1
			self.IsStandard = 0
		end
		if self.DakName == "Ultra Standard Engine" then
			self.DakTonnageLimit = 200000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 70
			self.DakBaseMaxHeat = 70
			self.DakBaseMaxHealth = 225
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 225
			end
			self.DakMass = 22500
			self.DakModel = "models/dak/ultrastandardengine.mdl"
			self.PowerMod = 1.7
			self.IsCompact = 0
			self.IsStandard = 1
		end
		if self.DakName == "Ultra XL Engine" then
			self.DakTonnageLimit = 200000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 60
			self.DakBaseMaxHeat = 60
			self.DakBaseMaxHealth = 150
			if table.Count(self.HitBox)==0 then
				self.DakMaxHealth = 150
			end
			self.DakMass = 15000
			self.DakModel = "models/dak/ultraxlengine.mdl"
			self.PowerMod = 1.7
			self.IsCompact = 1
			self.IsStandard = 0
		end
		if table.Count(self.HitBox)==0 then
			if self.DakHealth>self.DakMaxHealth then
				self.DakHealth = self.DakMaxHealth
			end
		end
		if self.Supercharged == 1 then
			self.DakBaseCooling = self.DakBaseCooling - 1
			self.PowerMod = self.PowerMod*1.5
		end

		if not self:GetModel() == self.DakModel then
			self:SetModel(self.DakModel)
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
		end
		
		self.Contraption = {}
		self.Ammoboxes = {}
		self.Heatsinks = {}
		self.Guns = {}
		self.ECM = 0
		table.Add(self.Contraption,GetParents(self))

		for k, v in pairs(GetParents(self)) do
			table.Add(self.Contraption,GetPhysCons(v))
		end

		local Mass = 0

		for i=1, #self.Contraption do
			table.Add( self.Contraption, self.Contraption[i]:GetChildren() )
			table.Add( self.Contraption, self.Contraption[i]:GetParent() )
		end
		local Children = {}
		for i2=1, #self.Contraption do
			if table.Count(self.Contraption[i2]:GetChildren()) > 0 then
			table.Add( Children, self.Contraption[i2]:GetChildren() )
			end
		end
		table.Add( self.Contraption, Children )

		local hash = {}
		local res = {}
		for _,v in ipairs(self.Contraption) do
	   		if (not hash[v]) then
	    		res[#res+1] = v
	       		hash[v] = true
	   		end
		end
		self.Contraption=res
		self.Test = #self.Contraption
		self.DakWeaponHeat = 0
		self.DakWeaponHPS = 0
		for i=1, #res do
			if res[i]:IsSolid() then
				res[i].IsDakTekFutureTech = 1
				Mass = Mass + res[i]:GetPhysicsObject():GetMass()
				if res[i]:GetClass() == "dak_heatsink" then

					if self.ReinforcedHeatsinks==1 then
						if res[i].Armored==0 then
							res[i].DakMaxHealth = res[i].DakMaxHealth+10
							res[i].DakHealth=res[i].DakHealth+10
							res[i].Armored=1
						end
				 	end

					table.insert(self.Heatsinks,res[i])
				end
				if res[i]:GetClass() == "dak_ammo" then
					table.insert(self.Ammoboxes,res[i])
				end
				if (res[i]:GetClass() == "dak_gun") then
					table.insert(self.Guns,res[i])
					if res[i].IsHAG == 1 then
						self.DakWeaponHeat = self.DakWeaponHeat + (res[i].DakHeat*10)
						self.DakWeaponHPS = self.DakWeaponHPS + ((res[i].DakHeat*10)/(res[i].DakCooldown+1))
					else
					self.DakWeaponHeat = self.DakWeaponHeat + (res[i].DakHeat)
					self.DakWeaponHPS = self.DakWeaponHPS + (res[i].DakHeat/res[i].DakCooldown)
					end
				end
				if (res[i]:GetClass() == "dak_hitboxcontroller") then
					res[i].HeavyArmor = self.HeavyArmor
					res[i].ReactiveArmor = self.ReactiveArmor
					res[i].ReflectiveArmor = self.ReflectiveArmor
					res[i].StandardEngine = self.IsStandard
					res[i].CompactEngine = self.IsCompact
					res[i].DakEngine = self
				end
				if (res[i]:GetClass() == "dak_laser") then
					table.insert(self.Guns,res[i])
					self.DakWeaponHeat = self.DakWeaponHeat + (res[i].DakHeat)
					self.DakWeaponHPS = self.DakWeaponHPS + (res[i].DakHeat/(res[i].DakCooldown+res[i].DakDuration))
				end
				if (res[i]:GetClass() == "dak_xpulselaser") then
					table.insert(self.Guns,res[i])
					self.DakWeaponHeat = self.DakWeaponHeat + (res[i].DakHeat)
					self.DakWeaponHPS = self.DakWeaponHPS + (res[i].DakHeat/(res[i].DakCooldown+res[i].DakDuration))
				end
				if (res[i]:GetClass() == "dak_launcher") then
					table.insert(self.Guns,res[i])
					self.DakWeaponHeat = self.DakWeaponHeat + (res[i].DakHeat)
					self.DakWeaponHPS = self.DakWeaponHPS + (res[i].DakHeat/res[i].DakCooldown)
				end
				if res[i]:GetClass() == "dak_ecm" then
					if self.BAP == 0 then
						self.ECM = 1
					end
				end
			end
		end
		
		self:GetPhysicsObject():SetMass(self.DakMass)
		local Heatsinkcount = 0 
		for i = 1, #self.Heatsinks do
			if IsValid(self.Heatsinks[i]) then
				Heatsinkcount = Heatsinkcount+1
			end
		end
		if(self:IsOnFire()) then
			self.DakCooling = (self.DakBaseCooling + (0.5*Heatsinkcount))*0.2
		else
			self.DakCooling = self.DakBaseCooling + (0.5*Heatsinkcount)
		end
		if self:WaterLevel() == 0 then
			self.DakCooling = self.DakCooling
		end
		if self:WaterLevel() == 1 then
			self.DakCooling = self.DakCooling*1.25
		end
		if self:WaterLevel() == 2 then
			self.DakCooling = self.DakCooling*1.35
		end
		if self:WaterLevel() == 3 then
			self.DakCooling = self.DakCooling*1.5
		end
		if self.Stealthed == 1 then
			self.DakCooling = -1
		end
		if self.HeatsinkSupercooling==1 then
			self.DakMaxHeat = self.DakBaseMaxHeat + (2*Heatsinkcount)
		else
	 		self.DakMaxHeat = self.DakBaseMaxHeat + (1*Heatsinkcount)
	 	end
	 	---
	 	if Mass > self.DakTonnageLimit then
	 		self.DakHeat = self.DakMaxHeat
	 		self.DakCooling = 0
		end
		if table.Count(self.Guns) > 16 then
	 		self.DakHeat = self.DakMaxHeat
	 		self.DakCooling = 0
		end
		self.TotalMass = Mass

		self.DakAlphaHeatThreshhold = self.DakWeaponHeat/self.DakMaxHeat
		self.DakHeatEfficiency = self.DakCooling/self.DakWeaponHPS
		self.DakOverheatTime = self.DakMaxHeat/(self.DakWeaponHPS-self.DakCooling)

	 	self.SlowThinkTime=CurTime()
	end

	if(CurTime() > self.timer+1) then
		if(self.DakHeat>=0) then
			local NewHeat = self.DakHeat - self.DakCooling
			if NewHeat < 0 then
				NewHeat = 0
			end
			self.DakHeat = NewHeat
			if(self.DakHeat>self.DakMaxHeat) then
				if not(self:GetTable().OnDieFunctions.GetCountUpdate==nil) then
					if self:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
						self.DakHealth = self.DakHealth-((self.DakHeat-self.DakMaxHeat)*5)
					end
				else
					self.DakHealth = self.DakHealth-((self.DakHeat-self.DakMaxHeat)*5)
				end
			end
		end
		self.TagTimer = self.TagTimer + 1
		if self.TagTimer >= 2 then
			self.TagTimer = 0
			self.Tagged = 0
		end
		self.NARCTimer = self.NARCTimer + 1
		if self.NARCTimer >= 30 then
			self.NARCTimer = 0
			self.NARCed = 0
		end
		self.BAPTimer = self.BAPTimer + 1
		if self.BAPTimer >= 5 then
			self.BAPTimer = 0
			self.BAP = 0
		end
		self.timer = CurTime()
	end
	WireLib.TriggerOutput(self, "Heat", self.DakHeat)
	WireLib.TriggerOutput(self, "MaxHeat", self.DakMaxHeat)
	WireLib.TriggerOutput(self, "Cooling", self.DakCooling)
	if table.Count(self.HitBox) == 0 then
		WireLib.TriggerOutput(self, "Health", self.DakHealth)
	end

	--DEFINE AMMO USE
	--LBX2 Ammo
	if self.LBX2AmmoUse then
		for k = 1,self.LBX2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LBX2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LBX2AmmoUse = false
						break end
					end
				end
			end
		end
		self.LBX2AmmoUseQueue = 0
	end
	self.LBX2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LBX2" then
				self.LBX2AmmoCount = self.LBX2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LBX2AmmoCount = 0
		end
	end
	self.LBX2Ammo = self.LBX2AmmoCount
	--LBX5 Ammo
	if self.LBX5AmmoUse then
		for k = 1,self.LBX5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LBX5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LBX5AmmoUse = false
						break end
					end
				end
			end
		end
		self.LBX5AmmoUseQueue = 0
	end
	self.LBX5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LBX5" then
				self.LBX5AmmoCount = self.LBX5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LBX5AmmoCount = 0
		end
	end
	self.LBX5Ammo = self.LBX5AmmoCount
	--LBX10 Ammo
	if self.LBX10AmmoUse then
		for k = 1,self.LBX10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LBX10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LBX10AmmoUse = false
						break end
					end
				end
			end
		end
		self.LBX10AmmoUseQueue = 0
	end
	self.LBX10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LBX10" then
				self.LBX10AmmoCount = self.LBX10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LBX10AmmoCount = 0
		end
	end
	self.LBX10Ammo = self.LBX10AmmoCount
	--LBX20 Ammo
	if self.LBX20AmmoUse then
		for k = 1,self.LBX20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LBX20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LBX20AmmoUse = false
						break end
					end
				end
			end
		end
		self.LBX20AmmoUseQueue = 0
	end
	self.LBX20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LBX20" then
				self.LBX20AmmoCount = self.LBX20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LBX20AmmoCount = 0
		end
	end
	self.LBX20Ammo = self.LBX20AmmoCount
	--AC2 Ammo
	if self.AC2AmmoUse then
		for k = 1,self.AC2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AC2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AC2AmmoUse = false
						break end
					end
				end
			end
		end
		self.AC2AmmoUseQueue = 0
	end
	self.AC2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AC2" then
				self.AC2AmmoCount = self.AC2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AC2AmmoCount = 0
		end
	end
	self.AC2Ammo = self.AC2AmmoCount
	--AC5 Ammo
	if self.AC5AmmoUse then
		for k = 1,self.AC5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AC5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AC5AmmoUse = false
						break end
					end
				end
			end
		end
		self.AC5AmmoUseQueue = 0
	end
	self.AC5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AC5" then
				self.AC5AmmoCount = self.AC5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AC5AmmoCount = 0
		end
	end
	self.AC5Ammo = self.AC5AmmoCount
	--AC10 Ammo
	if self.AC10AmmoUse then
		for k = 1,self.AC10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AC10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AC10AmmoUse = false
						break end
					end
				end
			end
		end
		self.AC10AmmoUseQueue = 0
	end
	self.AC10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AC10" then
				self.AC10AmmoCount = self.AC10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AC10AmmoCount = 0
		end
	end
	self.AC10Ammo = self.AC10AmmoCount
	--AC20 Ammo
	if self.AC20AmmoUse then
		for k = 1,self.AC20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AC20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AC20AmmoUse = false
						break end
					end
				end
			end
		end
		self.AC20AmmoUseQueue = 0
	end
	self.AC20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AC20" then
				self.AC20AmmoCount = self.AC20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AC20AmmoCount = 0
		end
	end
	self.AC20Ammo = self.AC20AmmoCount
	--AALBX2 Ammo
	if self.AALBX2AmmoUse then
		for k = 1,self.AALBX2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AALBX2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AALBX2AmmoUse = false
						break end
					end
				end
			end
		end
		self.AALBX2AmmoUseQueue = 0
	end
	self.AALBX2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AALBX2" then
				self.AALBX2AmmoCount = self.AALBX2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AALBX2AmmoCount = 0
		end
	end
	self.AALBX2Ammo = self.AALBX2AmmoCount
	--AALBX5 Ammo
	if self.AALBX5AmmoUse then
		for k = 1,self.AALBX5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AALBX5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AALBX5AmmoUse = false
						break end
					end
				end
			end
		end
		self.AALBX5AmmoUseQueue = 0
	end
	self.AALBX5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AALBX5" then
				self.AALBX5AmmoCount = self.AALBX5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AALBX5AmmoCount = 0
		end
	end
	self.AALBX5Ammo = self.AALBX5AmmoCount
	--AALBX10 Ammo
	if self.AALBX10AmmoUse then
		for k = 1,self.AALBX10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AALBX10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AALBX10AmmoUse = false
						break end
					end
				end
			end
		end
		self.AALBX10AmmoUseQueue = 0
	end
	self.AALBX10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AALBX10" then
				self.AALBX10AmmoCount = self.AALBX10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AALBX10AmmoCount = 0
		end
	end
	self.AALBX10Ammo = self.AALBX10AmmoCount
	--AALBX20 Ammo
	if self.AALBX20AmmoUse then
		for k = 1,self.AALBX20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "AALBX20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.AALBX20AmmoUse = false
						break end
					end
				end
			end
		end
		self.AALBX20AmmoUseQueue = 0
	end
	self.AALBX20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "AALBX20" then
				self.AALBX20AmmoCount = self.AALBX20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.AALBX20AmmoCount = 0
		end
	end
	self.AALBX20Ammo = self.AALBX20AmmoCount
	--IAC2 Ammo
	if self.IAC2AmmoUse then
		for k = 1,self.IAC2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "IAC2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.IAC2AmmoUse = false
						break end
					end
				end
			end
		end
		self.IAC2AmmoUseQueue = 0
	end
	self.IAC2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "IAC2" then
				self.IAC2AmmoCount = self.IAC2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.IAC2AmmoCount = 0
		end
	end
	self.IAC2Ammo = self.IAC2AmmoCount
	--IAC5 Ammo
	if self.IAC5AmmoUse then
		for k = 1,self.IAC5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "IAC5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.IAC5AmmoUse = false
						break end
					end
				end
			end
		end
		self.IAC5AmmoUseQueue = 0
	end
	self.IAC5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "IAC5" then
				self.IAC5AmmoCount = self.IAC5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.IAC5AmmoCount = 0
		end
	end
	self.IAC5Ammo = self.IAC5AmmoCount
	--IAC10 Ammo
	if self.IAC10AmmoUse then
		for k = 1,self.IAC10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "IAC10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.IAC10AmmoUse = false
						break end
					end
				end
			end
		end
		self.IAC10AmmoUseQueue = 0
	end
	self.IAC10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "IAC10" then
				self.IAC10AmmoCount = self.IAC10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.IAC10AmmoCount = 0
		end
	end
	self.IAC10Ammo = self.IAC10AmmoCount
	--IAC20 Ammo
	if self.IAC20AmmoUse then
		for k = 1,self.IAC20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "IAC20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.IAC20AmmoUse = false
						break end
					end
				end
			end
		end
		self.IAC20AmmoUseQueue = 0
	end
	self.IAC20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "IAC20" then
				self.IAC20AmmoCount = self.IAC20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.IAC20AmmoCount = 0
		end
	end
	self.IAC20Ammo = self.IAC20AmmoCount
	--SLBX2 Ammo
	if self.SLBX2AmmoUse then
		for k = 1,self.SLBX2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SLBX2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SLBX2AmmoUse = false
						break end
					end
				end
			end
		end
		self.SLBX2AmmoUseQueue = 0
	end
	self.SLBX2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SLBX2" then
				self.SLBX2AmmoCount = self.SLBX2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SLBX2AmmoCount = 0
		end
	end
	self.SLBX2Ammo = self.SLBX2AmmoCount
	--SLBX5 Ammo
	if self.SLBX5AmmoUse then
		for k = 1,self.SLBX5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SLBX5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SLBX5AmmoUse = false
						break end
					end
				end
			end
		end
		self.SLBX5AmmoUseQueue = 0
	end
	self.SLBX5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SLBX5" then
				self.SLBX5AmmoCount = self.SLBX5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SLBX5AmmoCount = 0
		end
	end
	self.SLBX5Ammo = self.SLBX5AmmoCount
	--SLBX10 Ammo
	if self.SLBX10AmmoUse then
		for k = 1,self.SLBX10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SLBX10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SLBX10AmmoUse = false
						break end
					end
				end
			end
		end
		self.SLBX10AmmoUseQueue = 0
	end
	self.SLBX10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SLBX10" then
				self.SLBX10AmmoCount = self.SLBX10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SLBX10AmmoCount = 0
		end
	end
	self.SLBX10Ammo = self.SLBX10AmmoCount
	--SLBX20 Ammo
	if self.SLBX20AmmoUse then
		for k = 1,self.SLBX20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SLBX20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SLBX20AmmoUse = false
						break end
					end
				end
			end
		end
		self.SLBX20AmmoUseQueue = 0
	end
	self.SLBX20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SLBX20" then
				self.SLBX20AmmoCount = self.SLBX20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SLBX20AmmoCount = 0
		end
	end
	self.SLBX20Ammo = self.SLBX20AmmoCount
	--FAC2 Ammo
	if self.FAC2AmmoUse then
		for k = 1,self.FAC2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "FAC2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.FAC2AmmoUse = false
						break end
					end
				end
			end
		end
		self.FAC2AmmoUseQueue = 0
	end
	self.FAC2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "FAC2" then
				self.FAC2AmmoCount = self.FAC2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.FAC2AmmoCount = 0
		end
	end
	self.FAC2Ammo = self.FAC2AmmoCount
	--FAC5 Ammo
	if self.FAC5AmmoUse then
		for k = 1,self.FAC5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "FAC5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.FAC5AmmoUse = false
						break end
					end
				end
			end
		end
		self.FAC5AmmoUseQueue = 0
	end
	self.FAC5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "FAC5" then
				self.FAC5AmmoCount = self.FAC5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.FAC5AmmoCount = 0
		end
	end
	self.FAC5Ammo = self.FAC5AmmoCount
	--FAC10 Ammo
	if self.FAC10AmmoUse then
		for k = 1,self.FAC10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "FAC10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.FAC10AmmoUse = false
						break end
					end
				end
			end
		end
		self.FAC10AmmoUseQueue = 0
	end
	self.FAC10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "FAC10" then
				self.FAC10AmmoCount = self.FAC10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.FAC10AmmoCount = 0
		end
	end
	self.FAC10Ammo = self.FAC10AmmoCount
	--FAC20 Ammo
	if self.FAC20AmmoUse then
		for k = 1,self.FAC20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "FAC20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.FAC20AmmoUse = false
						break end
					end
				end
			end
		end
		self.FAC20AmmoUseQueue = 0
	end
	self.FAC20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "FAC20" then
				self.FAC20AmmoCount = self.FAC20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.FAC20AmmoCount = 0
		end
	end
	self.FAC20Ammo = self.FAC20AmmoCount
	--UAC2 Ammo
	if self.UAC2AmmoUse then
		for k = 1,self.UAC2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "UAC2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.UAC2AmmoUse = false
						break end
					end
				end
			end
		end
		self.UAC2AmmoUseQueue = 0
	end
	self.UAC2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "UAC2" then
				self.UAC2AmmoCount = self.UAC2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.UAC2AmmoCount = 0
		end
	end
	self.UAC2Ammo = self.UAC2AmmoCount
	--UAC5 Ammo
	if self.UAC5AmmoUse then
		for k = 1,self.UAC5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "UAC5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.UAC5AmmoUse = false
						break end
					end
				end
			end
		end
		self.UAC5AmmoUseQueue = 0
	end
	self.UAC5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "UAC5" then
				self.UAC5AmmoCount = self.UAC5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.UAC5AmmoCount = 0
		end
	end
	self.UAC5Ammo = self.UAC5AmmoCount
	--UAC10 Ammo
	if self.UAC10AmmoUse then
		for k = 1,self.UAC10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "UAC10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.UAC10AmmoUse = false
						break end
					end
				end
			end
		end
		self.UAC10AmmoUseQueue = 0
	end
	self.UAC10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "UAC10" then
				self.UAC10AmmoCount = self.UAC10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.UAC10AmmoCount = 0
		end
	end
	self.UAC10Ammo = self.UAC10AmmoCount
	--UAC20 Ammo
	if self.UAC20AmmoUse then
		for k = 1,self.UAC20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "UAC20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.UAC20AmmoUse = false
						break end
					end
				end
			end
		end
		self.UAC20AmmoUseQueue = 0
	end
	self.UAC20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "UAC20" then
				self.UAC20AmmoCount = self.UAC20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.UAC20AmmoCount = 0
		end
	end
	self.UAC20Ammo = self.UAC20AmmoCount
	--RAC2 Ammo
	if self.RAC2AmmoUse then
		for k = 1,self.RAC2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "RAC2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.RAC2AmmoUse = false
						break end
					end
				end
			end
		end
		self.RAC2AmmoUseQueue = 0
	end
	self.RAC2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "RAC2" then
				self.RAC2AmmoCount = self.RAC2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.RAC2AmmoCount = 0
		end
	end
	self.RAC2Ammo = self.RAC2AmmoCount
	--RAC5 Ammo
	if self.RAC5AmmoUse then
		for k = 1,self.RAC5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "RAC5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.RAC5AmmoUse = false
						break end
					end
				end
			end
		end
		self.RAC5AmmoUseQueue = 0
	end
	self.RAC5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "RAC5" then
				self.RAC5AmmoCount = self.RAC5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.RAC5AmmoCount = 0
		end
	end
	self.RAC5Ammo = self.RAC5AmmoCount
	--RAC10 Ammo
	if self.RAC10AmmoUse then
		for k = 1,self.RAC10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "RAC10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.RAC10AmmoUse = false
						break end
					end
				end
			end
		end
		self.RAC10AmmoUseQueue = 0
	end
	self.RAC10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "RAC10" then
				self.RAC10AmmoCount = self.RAC10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.RAC10AmmoCount = 0
		end
	end
	self.RAC10Ammo = self.RAC10AmmoCount
	--RAC20 Ammo
	if self.RAC20AmmoUse then
		for k = 1,self.RAC20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "RAC20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.RAC20AmmoUse = false
						break end
					end
				end
			end
		end
		self.RAC20AmmoUseQueue = 0
	end
	self.RAC20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "RAC20" then
				self.RAC20AmmoCount = self.RAC20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.RAC20AmmoCount = 0
		end
	end
	self.RAC20Ammo = self.RAC20AmmoCount
	--Light MachineGun Ammo
	if self.LightMachineGunAmmoUse then
		for k = 1,self.LightMachineGunAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LightMachineGun" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LightMachineGunAmmoUse = false
						break end
					end
				end
			end
		end
		self.LightMachineGunAmmoUseQueue = 0
	end
	self.LightMachineGunAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LightMachineGun" then
				self.LightMachineGunAmmoCount = self.LightMachineGunAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LightMachineGunAmmoCount = 0
		end
	end
	self.LightMachineGunAmmo = self.LightMachineGunAmmoCount
	--MachineGun Ammo
	if self.MachineGunAmmoUse then
		for k = 1,self.MachineGunAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "MachineGun" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.MachineGunAmmoUse = false
						break end
					end
				end
			end
		end
		self.MachineGunAmmoUseQueue = 0
	end
	self.MachineGunAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "MachineGun" then
				self.MachineGunAmmoCount = self.MachineGunAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.MachineGunAmmoCount = 0
		end
	end
	self.MachineGunAmmo = self.MachineGunAmmoCount
	--Heavy MachineGun Ammo
	if self.HeavyMachineGunAmmoUse then
		for k = 1,self.HeavyMachineGunAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "HeavyMachineGun" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.HeavyMachineGunAmmoUse = false
						break end
					end
				end
			end
		end
		self.HeavyMachineGunAmmoUseQueue = 0
	end
	self.HeavyMachineGunAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "HeavyMachineGun" then
				self.HeavyMachineGunAmmoCount = self.HeavyMachineGunAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.HeavyMachineGunAmmoCount = 0
		end
	end
	self.HeavyMachineGunAmmo = self.HeavyMachineGunAmmoCount
	--LongTom Ammo
	if self.LongTomAmmoUse then
		for k = 1,self.LongTomAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LongTom" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LongTomAmmoUse = false
						break end
					end
				end
			end
		end
		self.LongTomAmmoUseQueue = 0
	end
	self.LongTomAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LongTom" then
				self.LongTomAmmoCount = self.LongTomAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LongTomAmmoCount = 0
		end
	end
	self.LongTomAmmo = self.LongTomAmmoCount
	--Gauss Ammo
	if self.GaussAmmoUse then
		for k = 1,self.GaussAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "Gauss" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.GaussAmmoUse = false
						break end
					end
				end
			end
		end
		self.GaussAmmoUseQueue = 0
	end
	self.GaussAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "Gauss" then
				self.GaussAmmoCount = self.GaussAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.GaussAmmoCount = 0
		end
	end
	self.GaussAmmo = self.GaussAmmoCount
	--LightGauss Ammo
	if self.LightGaussAmmoUse then
		for k = 1,self.LightGaussAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LightGauss" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LightGaussAmmoUse = false
						break end
					end
				end
			end
		end
		self.LightGaussAmmoUseQueue = 0
	end
	self.LightGaussAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LightGauss" then
				self.LightGaussAmmoCount = self.LightGaussAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LightGaussAmmoCount = 0
		end
	end
	self.LightGaussAmmo = self.LightGaussAmmoCount
	--HeavyGauss Ammo
	if self.HeavyGaussAmmoUse then
		for k = 1,self.HeavyGaussAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "HeavyGauss" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.HeavyGaussAmmoUse = false
						break end
					end
				end
			end
		end
		self.HeavyGaussAmmoUseQueue = 0
	end
	self.HeavyGaussAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "HeavyGauss" then
				self.HeavyGaussAmmoCount = self.HeavyGaussAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.HeavyGaussAmmoCount = 0
		end
	end
	self.HeavyGaussAmmo = self.HeavyGaussAmmoCount
	--Magshot Ammo
	if self.MagshotAmmoUse then
		for k = 1,self.MagshotAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "Magshot" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.MagshotAmmoUse = false
						break end
					end
				end
			end
		end
		self.MagshotAmmoUseQueue = 0
	end
	self.MagshotAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "Magshot" then
				self.MagshotAmmoCount = self.MagshotAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.MagshotAmmoCount = 0
		end
	end
	self.MagshotAmmo = self.MagshotAmmoCount
	--LRM5 Ammo
	if self.LRM5AmmoUse then
		for k = 1,self.LRM5AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LRM5" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LRM5AmmoUse = false
						break end
					end
				end
			end
		end
		self.LRM5AmmoUseQueue = 0
	end
	self.LRM5AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LRM5" then
				self.LRM5AmmoCount = self.LRM5AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LRM5AmmoCount = 0
		end
	end
	self.LRM5Ammo = self.LRM5AmmoCount
	--LRM10 Ammo
	if self.LRM10AmmoUse then
		for k = 1,self.LRM10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LRM10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LRM10AmmoUse = false
						break end
					end
				end
			end
		end
		self.LRM10AmmoUseQueue = 0
	end
	self.LRM10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LRM10" then
				self.LRM10AmmoCount = self.LRM10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LRM10AmmoCount = 0
		end
	end
	self.LRM10Ammo = self.LRM10AmmoCount
	--LRM15 Ammo
	if self.LRM15AmmoUse then
		for k = 1,self.LRM15AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LRM15" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LRM15AmmoUse = false
						break end
					end
				end
			end
		end
		self.LRM15AmmoUseQueue = 0
	end
	self.LRM15AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LRM15" then
				self.LRM15AmmoCount = self.LRM15AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LRM15AmmoCount = 0
		end
	end
	self.LRM15Ammo = self.LRM15AmmoCount
	--LRM20 Ammo
	if self.LRM20AmmoUse then
		for k = 1,self.LRM20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "LRM20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.LRM20AmmoUse = false
						break end
					end
				end
			end
		end
		self.LRM20AmmoUseQueue = 0
	end
	self.LRM20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "LRM20" then
				self.LRM20AmmoCount = self.LRM20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.LRM20AmmoCount = 0
		end
	end
	self.LRM20Ammo = self.LRM20AmmoCount
	--MRM10 Ammo
	if self.MRM10AmmoUse then
		for k = 1,self.MRM10AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "MRM10" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.MRM10AmmoUse = false
						break end
					end
				end
			end
		end
		self.MRM10AmmoUseQueue = 0
	end
	self.MRM10AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "MRM10" then
				self.MRM10AmmoCount = self.MRM10AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.MRM10AmmoCount = 0
		end
	end
	self.MRM10Ammo = self.MRM10AmmoCount
	--MRM20 Ammo
	if self.MRM20AmmoUse then
		for k = 1,self.MRM20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "MRM20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.MRM20AmmoUse = false
						break end
					end
				end
			end
		end
		self.MRM20AmmoUseQueue = 0
	end
	self.MRM20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "MRM20" then
				self.MRM20AmmoCount = self.MRM20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.MRM20AmmoCount = 0
		end
	end
	self.MRM20Ammo = self.MRM20AmmoCount
	--MRM30 Ammo
	if self.MRM30AmmoUse then
		for k = 1,self.MRM30AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "MRM30" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.MRM30AmmoUse = false
						break end
					end
				end
			end
		end
		self.MRM30AmmoUseQueue = 0
	end
	self.MRM30AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "MRM30" then
				self.MRM30AmmoCount = self.MRM30AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.MRM30AmmoCount = 0
		end
	end
	self.MRM30Ammo = self.MRM30AmmoCount
	--MRM40 Ammo
	if self.MRM40AmmoUse then
		for k = 1,self.MRM40AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "MRM40" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.MRM40AmmoUse = false
						break end
					end
				end
			end
		end
		self.MRM40AmmoUseQueue = 0
	end
	self.MRM40AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "MRM40" then
				self.MRM40AmmoCount = self.MRM40AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.MRM40AmmoCount = 0
		end
	end
	self.MRM40Ammo = self.MRM40AmmoCount
	--SRM2 Ammo
	if self.SRM2AmmoUse then
		for k = 1,self.SRM2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SRM2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SRM2AmmoUse = false
						break end
					end
				end
			end
		end
		self.SRM2AmmoUseQueue = 0
	end
	self.SRM2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SRM2" then
				self.SRM2AmmoCount = self.SRM2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SRM2AmmoCount = 0
		end
	end
	self.SRM2Ammo = self.SRM2AmmoCount
	--SRM4 Ammo
	if self.SRM4AmmoUse then
		for k = 1,self.SRM4AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SRM4" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SRM4AmmoUse = false
						break end
					end
				end
			end
		end
		self.SRM4AmmoUseQueue = 0
	end
	self.SRM4AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SRM4" then
				self.SRM4AmmoCount = self.SRM4AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SRM4AmmoCount = 0
		end
	end
	self.SRM4Ammo = self.SRM4AmmoCount
	--SRM6 Ammo
	if self.SRM6AmmoUse then
		for k = 1,self.SRM6AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SRM6" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SRM6AmmoUse = false
						break end
					end
				end
			end
		end
		self.SRM6AmmoUseQueue = 0
	end
	self.SRM6AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SRM6" then
				self.SRM6AmmoCount = self.SRM6AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SRM6AmmoCount = 0
		end
	end
	self.SRM6Ammo = self.SRM6AmmoCount
	--SSRM2 Ammo
	if self.SSRM2AmmoUse then
		for k = 1,self.SSRM2AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SSRM2" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SSRM2AmmoUse = false
						break end
					end
				end
			end
		end
		self.SSRM2AmmoUseQueue = 0
	end
	self.SSRM2AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SSRM2" then
				self.SSRM2AmmoCount = self.SSRM2AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SSRM2AmmoCount = 0
		end
	end
	self.SSRM2Ammo = self.SSRM2AmmoCount
	--SSRM4 Ammo
	if self.SSRM4AmmoUse then
		for k = 1,self.SSRM4AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SSRM4" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SSRM4AmmoUse = false
						break end
					end
				end
			end
		end
		self.SSRM4AmmoUseQueue = 0
	end
	self.SSRM4AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SSRM4" then
				self.SSRM4AmmoCount = self.SSRM4AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SSRM4AmmoCount = 0
		end
	end
	self.SSRM4Ammo = self.SSRM4AmmoCount
	--SSRM6 Ammo
	if self.SSRM6AmmoUse then
		for k = 1,self.SSRM6AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SSRM6" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SSRM6AmmoUse = false
						break end
					end
				end
			end
		end
		self.SSRM6AmmoUseQueue = 0
	end
	self.SSRM6AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SSRM6" then
				self.SSRM6AmmoCount = self.SSRM6AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SSRM6AmmoCount = 0
		end
	end
	self.SSRM6Ammo = self.SSRM6AmmoCount
	--ATM3HE Ammo
	if self.ATM3HEAmmoUse then
		for k = 1,self.ATM3HEAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM3HE" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM3HEAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM3HEAmmoUseQueue = 0
	end
	self.ATM3HEAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM3HE" then
				self.ATM3HEAmmoCount = self.ATM3HEAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM3HEAmmoCount = 0
		end
	end
	self.ATM3HEAmmo = self.ATM3HEAmmoCount
	--ATM6HE Ammo
	if self.ATM6HEAmmoUse then
		for k = 1,self.ATM6HEAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM6HE" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM6HEAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM6HEAmmoUseQueue = 0
	end
	self.ATM6HEAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM6HE" then
				self.ATM6HEAmmoCount = self.ATM6HEAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM6HEAmmoCount = 0
		end
	end
	self.ATM6HEAmmo = self.ATM6HEAmmoCount
	--ATM9HE Ammo
	if self.ATM9HEAmmoUse then
		for k = 1,self.ATM9HEAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM9HE" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM9HEAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM9HEAmmoUseQueue = 0
	end
	self.ATM9HEAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM9HE" then
				self.ATM9HEAmmoCount = self.ATM9HEAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM9HEAmmoCount = 0
		end
	end
	self.ATM9HEAmmo = self.ATM9HEAmmoCount
	--ATM12HE Ammo
	if self.ATM12HEAmmoUse then
		for k = 1,self.ATM12HEAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM12HE" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM12HEAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM12HEAmmoUseQueue = 0
	end
	self.ATM12HEAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM12HE" then
				self.ATM12HEAmmoCount = self.ATM12HEAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM12HEAmmoCount = 0
		end
	end
	self.ATM12HEAmmo = self.ATM12HEAmmoCount
	--ATM3S Ammo
	if self.ATM3SAmmoUse then
		for k = 1,self.ATM3SAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM3S" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM3SAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM3SAmmoUseQueue = 0
	end
	self.ATM3SAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM3S" then
				self.ATM3SAmmoCount = self.ATM3SAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM3SAmmoCount = 0
		end
	end
	self.ATM3SAmmo = self.ATM3SAmmoCount
	--ATM6S Ammo
	if self.ATM6SAmmoUse then
		for k = 1,self.ATM6SAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM6S" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM6SAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM6SAmmoUseQueue = 0
	end
	self.ATM6SAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM6S" then
				self.ATM6SAmmoCount = self.ATM6SAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM6SAmmoCount = 0
		end
	end
	self.ATM6SAmmo = self.ATM6SAmmoCount
	--ATM9S Ammo
	if self.ATM9SAmmoUse then
		for k = 1,self.ATM9SAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM9S" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM9SAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM9SAmmoUseQueue = 0
	end
	self.ATM9SAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM9S" then
				self.ATM9SAmmoCount = self.ATM9SAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM9SAmmoCount = 0
		end
	end
	self.ATM9SAmmo = self.ATM9SAmmoCount
	--ATM12HE Ammo
	if self.ATM12SAmmoUse then
		for k = 1,self.ATM12SAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM12S" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM12SAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM12SAmmoUseQueue = 0
	end
	self.ATM12SAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM12S" then
				self.ATM12SAmmoCount = self.ATM12SAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM12SAmmoCount = 0
		end
	end
	self.ATM12SAmmo = self.ATM12SAmmoCount
	--ATM3ER Ammo
	if self.ATM3ERAmmoUse then
		for k = 1,self.ATM3ERAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM3ER" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM3ERAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM3ERAmmoUseQueue = 0
	end
	self.ATM3ERAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM3ER" then
				self.ATM3ERAmmoCount = self.ATM3ERAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM3ERAmmoCount = 0
		end
	end
	self.ATM3ERAmmo = self.ATM3ERAmmoCount
	--ATM6ER Ammo
	if self.ATM6ERAmmoUse then
		for k = 1,self.ATM6ERAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM6ER" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM6ERAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM6ERAmmoUseQueue = 0
	end
	self.ATM6ERAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM6ER" then
				self.ATM6ERAmmoCount = self.ATM6ERAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM6ERAmmoCount = 0
		end
	end
	self.ATM6ERAmmo = self.ATM6ERAmmoCount
	--ATM9ER Ammo
	if self.ATM9ERAmmoUse then
		for k = 1,self.ATM9ERAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM9ER" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM9ERAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM9ERAmmoUseQueue = 0
	end
	self.ATM9ERAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM9ER" then
				self.ATM9ERAmmoCount = self.ATM9ERAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM9ERAmmoCount = 0
		end
	end
	self.ATM9ERAmmo = self.ATM9ERAmmoCount
	--ATM12ER Ammo
	if self.ATM12ERAmmoUse then
		for k = 1,self.ATM12ERAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "ATM12ER" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ATM12ERAmmoUse = false
						break end
					end
				end
			end
		end
		self.ATM12ERAmmoUseQueue = 0
	end
	self.ATM12ERAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "ATM12ER" then
				self.ATM12ERAmmoCount = self.ATM12ERAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ATM12ERAmmoCount = 0
		end
	end
	self.ATM12ERAmmo = self.ATM12ERAmmoCount
	--SBG Ammo
	if self.SBGAmmoUse then
		for k = 1,self.SBGAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "SBG" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SBGAmmoUse = false
						break end
					end
				end
			end
		end
		self.SBGAmmoUseQueue = 0
	end
	self.SBGAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "SBG" then
				self.SBGAmmoCount = self.SBGAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SBGAmmoCount = 0
		end
	end
	self.SBGAmmo = self.SBGAmmoCount
	--HAG20 Ammo
	if self.HAG20AmmoUse then
		for k = 1,self.HAG20AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "HAG20" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.HAG20AmmoUse = false
						break end
					end
				end
			end
		end
		self.HAG20AmmoUseQueue = 0
	end
	self.HAG20AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "HAG20" then
				self.HAG20AmmoCount = self.HAG20AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.HAG20AmmoCount = 0
		end
	end
	self.HAG20Ammo = self.HAG20AmmoCount
	--HAG30 Ammo
	if self.HAG30AmmoUse then
		for k = 1,self.HAG30AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "HAG30" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.HAG30AmmoUse = false
						break end
					end
				end
			end
		end
		self.HAG30AmmoUseQueue = 0
	end
	self.HAG30AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "HAG30" then
				self.HAG30AmmoCount = self.HAG30AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.HAG30AmmoCount = 0
		end
	end
	self.HAG30Ammo = self.HAG30AmmoCount
	--HAG40 Ammo
	if self.HAG40AmmoUse then
		for k = 1,self.HAG40AmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "HAG40" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.HAG40AmmoUse = false
						break end
					end
				end
			end
		end
		self.HAG40AmmoUseQueue = 0
	end
	self.HAG40AmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "HAG40" then
				self.HAG40AmmoCount = self.HAG40AmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.HAG40AmmoCount = 0
		end
	end
	self.HAG40Ammo = self.HAG40AmmoCount
	--Thumper Ammo
	if self.ThumperAmmoUse then
		for k = 1,self.ThumperAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "Thumper" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ThumperAmmoUse = false
						break end
					end
				end
			end
		end
		self.ThumperAmmoUseQueue = 0
	end
	self.ThumperAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "Thumper" then
				self.ThumperAmmoCount = self.ThumperAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ThumperAmmoCount = 0
		end
	end
	self.ThumperAmmo = self.ThumperAmmoCount
		--Railgun Ammo
	if self.RailgunAmmoUse then
		for k = 1,self.RailgunAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "Railgun" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.RailgunAmmoUse = false
						break end
					end
				end
			end
		end
		self.RailgunAmmoUseQueue = 0
	end
	self.RailgunAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "Railgun" then
				self.RailgunAmmoCount = self.RailgunAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.RailgunAmmoCount = 0
		end
	end
	self.RailgunAmmo = self.RailgunAmmoCount
	--Sniper Cannon Ammo
	if self.SniperAmmoUse then
		for k = 1,self.SniperAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "Sniper" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.SniperAmmoUse = false
						break end
					end
				end
			end
		end
		self.SniperAmmoUseQueue = 0
	end
	self.SniperAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "Sniper" then
				self.SniperAmmoCount = self.SniperAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.SniperAmmoCount = 0
		end
	end
	self.SniperAmmo = self.SniperAmmoCount
	--NARC Ammo
	if self.NARCAmmoUse then
		for k = 1,self.NARCAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "NARC" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.NARCAmmoUse = false
						break end
					end
				end
			end
		end
		self.NARCAmmoUseQueue = 0
	end
	self.NARCAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "NARC" then
				self.NARCAmmoCount = self.NARCAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.NARCAmmoCount = 0
		end
	end
	self.NARCAmmo = self.NARCAmmoCount
	--ArrowIV Ammo
	if self.ArrowAmmoUse then
		for k = 1,self.ArrowAmmoUseQueue do
			for i = 1, #self.Ammoboxes do
				if IsValid(self.Ammoboxes[i]) then
					if self.Ammoboxes[i].DakAmmoType == "Arrow" then
						if self.Ammoboxes[i].DakAmmo > 0 then
							self.Ammoboxes[i].DakAmmo = self.Ammoboxes[i].DakAmmo-1
							self.ArrowAmmoUse = false
						break end
					end
				end
			end
		end
		self.ArrowAmmoUseQueue = 0
	end
	self.ArrowAmmoCount = 0 
	for i = 1, #self.Ammoboxes do
		if IsValid(self.Ammoboxes[i]) then
			if self.Ammoboxes[i].DakAmmoType == "Arrow" then
				self.ArrowAmmoCount = self.ArrowAmmoCount + self.Ammoboxes[i].DakAmmo
			end
		else
		self.ArrowAmmoCount = 0
		end
	end
	self.ArrowAmmo = self.ArrowAmmoCount

	--SETUP HEALTHPOOL
	--print(table.Count(self.HitBox))
	--print(table.ToString(self.HitBox,"table",true))
	if table.Count(self.HitBox) == 0 and not(self.Contraption==nil) then
		self.Remake = 0
		self.DakPooled = 1
		self.DakEngine = self
		self.Controller = self
		if #self.Contraption>0 then
			for i=1, #self.Contraption do
				if self.Contraption[i].Controller == nil or self.Contraption[i].Controller == NULL or self.Contraption[i].Controller == self then
					--if res[i]:IsVehicle() then
					--	res[i]:SetColor(Color(255,0,0,255))
					--	--print("Got Vehicle")
					--	table.insert(self.HitBox,res[i])
					--end
					--if(string.Explode("_",res[i]:GetClass(),false)[2] == "wire") then
					--	res[i]:SetColor(Color(255,0,0,255))
					--	table.insert(self.HitBox,res[i])
					--end
					--if not(res[i].DakPooled==1) then
					if IsValid(self.Contraption[i]) then
						if not(string.Explode("_",self.Contraption[i]:GetClass(),false)[1] == "dak") then
							if self.Contraption[i]:IsSolid() then
								table.insert(self.HitBox,self.Contraption[i])
								self.Contraption[i].Controller = self
								self.Contraption[i].DakPooled = 1
							end
						end
					end
					--end
				end
			end
		end
		self.HitBoxMass = 0
		for i=1, table.Count(self.HitBox) do
			self.HitBoxMass = self.HitBoxMass + self.HitBox[i]:GetPhysicsObject():GetMass()
		end
		--self.DakBaseMaxHealth = self.DakMaxHealth
		self.CurrentHealth = (self.HitBoxMass/160) + self.DakBaseMaxHealth
		self.DakMaxHealth = (self.HitBoxMass/160) + self.DakBaseMaxHealth
		for i=1, table.Count(self.HitBox) do
			DakTekSetupNewEnt(self.HitBox[i])
			self.HitBox[i].DakHealth = self.CurrentHealth
			self.HitBox[i].DakMaxHealth = self.CurrentHealth
			self.HitBox[i].Controller = self
			self.HitBox[i].DakPooled = 1
		end
		self.LastRemake = CurTime()
	end
	if not(table.Count(self.HitBox)==0) then
		self.DakActive = 1
	else
		self.DakActive = 0
	end

	if CurTime() > self.Hitboxthinktime+1 then
		if self.DakActive == 1 and not(table.Count(self.HitBox)==0) and not(self.CurrentHealth==nil) then
			if table.Count(self.HitBox) > 0 then
				self.DamageCycle = 0
				if self.DakHealth < self.CurrentHealth then
					self.DamageCycle = self.DamageCycle+(self.CurrentHealth-self.DakHealth)
					self.DakLastDamagePos = self.DakLastDamagePos	
				end
				self.Remake = 0
				self.LastCurMass = self.CurMass
				self.CurMass = 0
				for i = 1, table.Count(self.HitBox) do
					if not(self.HitBox[i].Controller == self) then
						self.Remake = 1	
					end
					if self.Remake == 1 then
						if self.HitBox[i].Controller == self then
							self.HitBox[i].DakPooled = 0
							self.HitBox[i].Controller = nil
						end
					end
					if self.CurMass>0 then
						if not(self.HitBox[i].DakHealth==nil) then
							if self.HitBox[i].DakHealth < self.CurrentHealth then
								self.DamageCycle = self.DamageCycle+(self.CurrentHealth-self.HitBox[i].DakHealth)
								self.DakLastDamagePos = self.HitBox[i].DakLastDamagePos	
							end
						end
					end
					if self.Remake == 1 then
						self.HitBox = {}
						self.Remake = 0
						break
					end
					if not(self.HitBox[i]==NULL) then
						if self.HitBox[i].Controller == self then
							if self.HitBox[i]:IsSolid() then
								self.CurMass = self.CurMass + self.HitBox[i]:GetPhysicsObject():GetMass()
							end
						end
					end
				end

				if not(self.CurMass>self.LastCurMass) then
					if self.DamageCycle>0 then
						if self.LastRemake+3 > CurTime() then
							self.DamageCycle = 0
						end
						self.CurrentHealth = self.CurrentHealth-self.DamageCycle
					end
				end

				for i = 1, table.Count(self.HitBox) do
					if self.CurrentHealth >= (self.CurMass/160) + self.DakBaseMaxHealth then
						self.DakMaxHealth = (self.CurMass/160) + self.DakBaseMaxHealth
						self.CurrentHealth = (self.CurMass/160) + self.DakBaseMaxHealth
						self.HitBox[i].DakMaxHealth = (self.CurMass/160) + self.DakBaseMaxHealth
						self.HitBox[i].DakRed = self.HitBox[i]:GetColor().r
						self.HitBox[i].DakGreen = self.HitBox[i]:GetColor().g
						self.HitBox[i].DakBlue = self.HitBox[i]:GetColor().b
					else
						local HPPerc = self.HitBox[i].DakHealth/self.HitBox[i].DakMaxHealth --get hp percent then set colors based on it
						self.HitBox[i]:SetColor(Color(self.HitBox[i].DakRed*HPPerc,self.HitBox[i].DakGreen*HPPerc,self.HitBox[i].DakBlue*HPPerc,self.HitBox[i]:GetColor().a))
					end
					self.HitBox[i].DakHealth = self.CurrentHealth
					if not(self.HitBox[i]==NULL) then
						if self.HitBox[i].DakHealth <= 0 then
							if i <= 10 then
								self.salvage = ents.Create( "dak_salvage" )
								self.salvage.DakModel = self.HitBox[i]:GetModel()
								self.salvage:SetPos( self.HitBox[i]:GetPos())
								self.salvage:SetAngles( self.HitBox[i]:GetAngles())
								self.salvage.DakLastDamagePos = self.DakLastDamagePos
								self.salvage:Spawn()
							end
							self.HitBox[i]:Remove()
						end
					end
				end
				self.DakHealth = self.CurrentHealth

				WireLib.TriggerOutput(self, "Health", (self.DakHealth/self.DakMaxHealth)*100)
				--WireLib.TriggerOutput(self, "HealthPercent", (self.DakHealth/self.DakMaxHealth)*100)
				if not(self.DakHealth == nil) then
					if self.DakHealth <= 0 then
						for i=1, #self.Contraption do
							if self.Contraption[i].DakPooled == 0 or self.Contraption[i]:GetParent()==self:GetParent() or self.Contraption[i].Controller == self then
								self.Contraption[i].DakLastDamagePos = self.DakLastDamagePos
								if self.Contraption[i].DakHealth == nil then
									DakTekSetupNewEnt(self.Contraption[i])
								end
								if i <= 10 then
									self.salvage = ents.Create( "dak_salvage" )
									self.salvage.DakModel = self.Contraption[i]:GetModel()
									self.salvage:SetPos( self.Contraption[i]:GetPos())
									self.salvage:SetAngles( self.Contraption[i]:GetAngles())
									self.salvage:Spawn()
								end
								self.Contraption[i]:Remove()
							end
						end
						self.salvage = ents.Create( "dak_salvage" )
						self.salvage.DakModel = self:GetModel()
						self.salvage:SetPos( self:GetPos())
						self.salvage:SetAngles( self:GetAngles())
						self.salvage:Spawn()
						self:Remove()
					end
				else
					self:Remove()
				end

			end
		end
		self.Hitboxthinktime = CurTime()
	end
	if self.DakHealth <= 0 then
		self.salvage = ents.Create( "dak_salvage" )
		self.salvage.DakModel = self:GetModel()
		self.salvage:SetPos( self:GetPos())
		self.salvage:SetAngles( self:GetAngles())
		self.salvage.DakLastDamagePos = self.DakLastDamagePos
		self.salvage:Spawn()
		self:Remove()
	end
	self:NextThink(CurTime()+0.25)
    return true
end

function ENT:PreEntityCopy()

	local info = {}
	local entids = {}

	info.DakName = self.DakName
	info.DakTonnageLimit = self.DakTonnageLimit
	info.DakCooling = self.DakCooling
	info.DakBaseCooling = self.DakBaseCooling
	info.DakMaxHeat = self.DakMaxHeat
	info.DakBaseMaxHeat = self.DakBaseMaxHeat
	info.DakHeat = self.DakHeat
	info.DakHealth = self.DakHealth
	info.DakMaxHealth = self.DakBaseMaxHealth
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakOwner = self.DakOwner

	duplicator.StoreEntityModifier( self, "DakTek", info )

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then
		self.DakName = Ent.EntityMods.DakTek.DakName
		self.DakTonnageLimit = Ent.EntityMods.DakTek.DakTonnageLimit
		self.DakCooling = Ent.EntityMods.DakTek.DakCooling
		self.DakBaseCooling = Ent.EntityMods.DakTek.DakBaseCooling
		self.DakMaxHeat = Ent.EntityMods.DakTek.DakMaxHeat
		self.DakBaseMaxHeat = Ent.EntityMods.DakTek.DakBaseMaxHeat
		self.DakHeat = Ent.EntityMods.DakTek.DakHeat
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakOwner = Player

		if self.DakName == "Micro Compact Engine" then
			self.DakMaxHealth = 10
		end
		if self.DakName == "Micro Standard Engine" then
			self.DakMaxHealth = 7.5
		end
		if self.DakName == "Micro XL Engine" then
			self.DakMaxHealth = 5
		end
		if self.DakName == "Small Compact Engine" then
			self.DakMaxHealth = 50
		end
		if self.DakName == "Small Standard Engine" then
			self.DakMaxHealth = 37.5
		end
		if self.DakName == "Small XL Engine" then
			self.DakMaxHealth = 25
		end
		if self.DakName == "Medium Compact Engine" then
			self.DakMaxHealth = 100
		end
		if self.DakName == "Medium Standard Engine" then
			self.DakMaxHealth = 75
		end
		if self.DakName == "Medium XL Engine" then
			self.DakMaxHealth = 50
		end
		if self.DakName == "Large Compact Engine" then
			self.DakMaxHealth = 150
		end
		if self.DakName == "Large Standard Engine" then
			self.DakMaxHealth = 112.5
		end
		if self.DakName == "Large XL Engine" then
			self.DakMaxHealth = 75
		end
		if self.DakName == "Ultra Compact Engine" then
			self.DakMaxHealth = 300
		end
		if self.DakName == "Ultra Standard Engine" then
			self.DakMaxHealth = 225
		end
		if self.DakName == "Ultra XL Engine" then
			self.DakMaxHealth = 150
		end

		self:PhysicsDestroy()
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		
		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.DakHeat>self.DakMaxHeat and self.DakHealth<5  then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self)
		effectdata:SetAttachment(1)
		effectdata:SetMagnitude(.5)
		effectdata:SetScale(200)
		util.Effect("dakenergyexplosion", effectdata)
		self.DamageList = {}
		self.RemoveList = {}
		self.IgnoreList = {}
		local Targets = ents.FindInSphere( self:GetPos(), 750 )
		if table.Count(Targets) > 0 then
			for i = 1, #Targets do
				if Targets[i]:IsValid() then
					if not(Targets[i].DakHealth == nil) then
						if Targets[i].DakHealth <= 0 then
							table.insert(self.IgnoreList,Targets[i])
						end
					end
				end
			end
			table.insert(self.IgnoreList,self)
			for i = 1, #Targets do
				if Targets[i]:IsValid() or Targets[i]:IsPlayer() or Targets[i]:IsNPC() then
					local trace = {}
					trace.start = self:GetPos()
					trace.endpos = Targets[i]:GetPos()
					trace.filter = self.IgnoreList
					local ExpTrace = util.TraceLine( trace )
					if ExpTrace.Entity == Targets[i] then
						if not(string.Explode("_",Targets[i]:GetClass(),false)[2] == "wire") then
							if (not(ExpTrace.Entity:IsPlayer())) and (not(ExpTrace.Entity:IsNPC())) then
								if ExpTrace.Entity.DakHealth == nil then
									DakTekSetupNewEnt(ExpTrace.Entity)
								end
								table.insert(self.DamageList,ExpTrace.Entity)
							else
								if (Targets[i]:GetClass() == "dak_bot" or Targets[i]:GetClass() == "dak_zombie") then
									Targets[i]:SetHealth(Targets[i]:Health() - (2*self.DakTonnageLimit/1000)*50*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)) )
									if sTargets[i]:Health() <= 0 and self.revenge==0 then
										local body = ents.Create( "prop_ragdoll" )
										body:SetPos( Targets[i]:GetPos() )
										body:SetModel( Targets[i]:GetModel() )
										body:Spawn()
										Targets[i]:Remove()
										local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
										body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
										timer.Simple( 5, function()
											body:Remove()
										end )
									end
								else
									local ExpPain = DamageInfo()
									ExpPain:SetDamageForce( ExpTrace.Normal*(self.DakTonnageLimit/1000)*2500 )
									ExpPain:SetDamage( (2*self.DakTonnageLimit/1000)*50*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)) )
									ExpPain:SetAttacker( self.DakOwner )
									ExpPain:SetInflictor( self )
									ExpPain:SetReportedPosition( self:GetPos() )
									ExpPain:SetDamagePosition( ExpTrace.Entity:GetPhysicsObject():GetMassCenter() )
									ExpPain:SetDamageType(DMG_BLAST)
									ExpTrace.Entity:TakeDamageInfo( ExpPain )
								end
							end
						end
					end
				end
				Targets[i]:Ignite(10,1)
				if Targets[i]:GetClass() == "dak_engine" then
					Targets[i].DakHeat = Targets[i].DakHeat+self.DakBaseMaxHeat
				end
			end
			for i = 1, #self.DamageList do
				if(self.DamageList[i]:IsValid()) then
					if not((self.DamageList[i]:GetClass() == "dak_bot" or self.DamageList[i]:GetClass() == "dak_zombie")) then
						if(self.DamageList[i]:GetParent():IsValid()) then
							if(self.DamageList[i]:GetParent():GetParent():IsValid()) then
								self.DamageList[i]:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(2/table.Count(self.DamageList)*self.DakTonnageLimit/500)*10000*2*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)) )
							end
						end
						if not(self.DamageList[i]:GetParent():IsValid()) then
							self.DamageList[i]:GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(2/table.Count(self.DamageList)*self.DakTonnageLimit/500)*10000*2*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))  )
						end
					end
				end
				if not(self.DamageList[i]:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate==nil) then
					if not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
						if self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
							if (self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
								local HPPerc = (self.DamageList[i].DakHealth-(2/table.Count(self.DamageList)*self.DakTonnageLimit/500)*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DamageList[i].DakMaxHealth
								self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(2/table.Count(self.DamageList)*self.DakTonnageLimit/500)*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))
								if not(self.DamageList[i].DakRed == nil) then
									self.DamageList[i]:SetColor(Color(self.DamageList[i].DakRed*HPPerc,self.DamageList[i].DakGreen*HPPerc,self.DamageList[i].DakBlue*HPPerc,self.DamageList[i]:GetColor().a))
								end
								self.DamageList[i].DakLastDamagePos = self:GetPhysicsObject():GetPos()
								if self.DamageList[i].DakHealth <= 0 and self.DamageList[i].DakPooled==0 then
									table.insert(self.RemoveList,self.DamageList[i])
								end
							end
						end
					end
				else
					local HPPerc = (self.DamageList[i].DakHealth-(2/table.Count(self.DamageList)*self.DakTonnageLimit/500)*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DamageList[i].DakMaxHealth
					self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(2/table.Count(self.DamageList)*self.DakTonnageLimit/500)*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))
					if not(self.DamageList[i].DakRed == nil) then
						self.DamageList[i]:SetColor(Color(self.DamageList[i].DakRed*HPPerc,self.DamageList[i].DakGreen*HPPerc,self.DamageList[i].DakBlue*HPPerc,self.DamageList[i]:GetColor().a))
					end
					self.DamageList[i].DakLastDamagePos = self:GetPhysicsObject():GetPos()
					if self.DamageList[i].DakHealth <= 0 and self.DamageList[i].DakPooled==0 then
						table.insert(self.RemoveList,self.DamageList[i])
					end
				end
			end
			for i = 1, #self.RemoveList do
				if i <= 10 then
					self.salvage = ents.Create( "dak_salvage" )
					self.salvage.DakModel = self.RemoveList[i]:GetModel()
					self.salvage:SetPos( self.RemoveList[i]:GetPos())
					self.salvage:SetAngles( self.RemoveList[i]:GetAngles())
					self.salvage.DakLastDamagePos = self:GetPhysicsObject():GetPos()
					self.salvage:Spawn()
					self.RemoveList[i]:Remove()
				end
			end
		end
		self:EmitSound( "dak/engineexplode.wav", 150, 75, 1)
		self:Remove()
	end

	if self.DakHealth <= 0 then
		for i = 1, table.Count(self.HitBox) do
			self.salvage = ents.Create( "dak_salvage" )
			self.salvage.DakModel = self.HitBox[i]:GetModel()
			self.salvage:SetPos( self.HitBox[i]:GetPos())
			self.salvage:SetAngles( self.HitBox[i]:GetAngles())
			self.salvage.DakLastDamagePos = self.DakLastDamagePos
			self.salvage:Spawn()
			self.HitBox[i]:Remove()
		end
	end

	if table.Count(self.HitBox)>0 then
		for i = 1, table.Count(self.HitBox) do
			self.HitBox[i].DakPooled = 0
			self.HitBox[i].DakController = nil
		end
	end
end