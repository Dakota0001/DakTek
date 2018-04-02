AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakOwner = NULL
ENT.DakName = "Base Gun"
ENT.DakCooldown = 1
ENT.DakHeat = 1
ENT.DakMaxHealth = 1
ENT.DakHealth = 1
ENT.DakAmmo = 0
ENT.DakMass = 1
ENT.DakEngine = NULL
ENT.DakModel = "models/dak/6ac.mdl"
ENT.DakUseAmmo = true
ENT.DakAmmoType = "AC2Ammo"
ENT.DakAmmoUse = "AC2AmmoUse"
ENT.DakAmmoQueue = "AC2AmmoUseQueue"
ENT.DakFireEffect = "dakac5fire"
ENT.DakFireSound = "dak/AC5.wav"
ENT.DakFirePitch = 90
ENT.DakFireSpecialShell = false
ENT.DakShellEnt = "dak_baseshell"
ENT.DakIsLBX = false
ENT.DakLBXPellets = 1
ENT.DakIsExplosive = false
ENT.DakIsRAC = false
ENT.DakIsUAC = false
ENT.DakIsPPC = false
ENT.DakIsEnergy = false
--shell definition
ENT.DakShellTrail = "ac2trail"
ENT.DakShellVelocity = 25000
ENT.DakShellDamage = 2
ENT.DakShellExplosionEffect = "daksmallballisticexplosion"
ENT.DakShellImpactSound = "dak/ballisticimpact.wav"
ENT.DakShellImpactPitch = 75
ENT.DakShellGravity = true
ENT.DakShellMass = 20
ENT.DakPooled=0
ENT.IsHAG = 0
ENT.Armored = 0
ENT.DakCanSwapAmmo = 0
ENT.CurrentAmmoType = 1
ENT.ShellList = {}

function ENT:Initialize()
	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.DakHealth = self.DakMaxHealth

	local phys = self:GetPhysicsObject()
	self.timer = CurTime()
	if(IsValid(phys)) then
		phys:Wake()
	end
	self.Inputs = Wire_CreateInputs(self, { "Fire", "SwapAmmo" })
	self.Outputs = WireLib.CreateOutputs( self, { "Cooldown" , "CooldownPercent", "Ammo", "AmmoType [STRING]" } )
 	self.Held = false
 	self.jamtime = 0
 	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.SlowThinkTime = CurTime()
 	self.MidThinkTime = CurTime()
 	self.LastFireTime = CurTime()

	function self:SetupDataTables()
 		self:NetworkVar("Bool",0,"Firing")
 		self:NetworkVar("Float",0,"Timer")
 		self:NetworkVar("Float",1,"Cooldown")
 		self:NetworkVar("String",0,"Model")
 	end

 	self.ShellList = {}
 	self.RemoveList = {}
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
	--CLAN--
		--Ultra AutoCannons
		if self.DakName == "CUAC2" then
			self.IsHAG = 0
			self.DakCooldown = 0.1875
			self.DakHeat = 0.395
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/7ac.mdl"
			self.DakAmmoType = "UAC2Ammo"
			self.DakAmmoUse = "UAC2AmmoUse"
			self.DakAmmoQueue = "UAC2AmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/uac2.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 1.4
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 14
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 110
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self.DakName == "CUAC5" then
			self.IsHAG = 0
			self.DakCooldown = 0.4375
			self.DakHeat = 1.05
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/9ac.mdl"
			self.DakAmmoType = "UAC5Ammo"
			self.DakAmmoUse = "UAC5AmmoUse"
			self.DakAmmoQueue = "UAC5AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/uac5.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self.DakName == "CUAC10" then
			self.IsHAG = 0
			self.DakCooldown = 0.75
			self.DakHeat = 2.925
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/13ac.mdl"
			self.DakAmmoType = "UAC10Ammo"
			self.DakAmmoUse = "UAC10AmmoUse"
			self.DakAmmoQueue = "UAC10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/uac10.wav"
			self.DakFirePitch = 95
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 9
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 90
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self.DakName == "CUAC20" then
			self.IsHAG = 0
			self.DakCooldown = 1
			self.DakHeat = 4.6875
			self.DakMaxHealth = 120
			self.DakMass = 12000
			--self.DakModel = "models/dak/15ac.mdl"
			self.DakAmmoType = "UAC20Ammo"
			self.DakAmmoUse = "UAC20AmmoUse"
			self.DakAmmoQueue = "UAC20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/uac20.wav"
			self.DakFirePitch = 95
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		--Rotary AutoCannons
		if self.DakName == "CRAC2" then
			self.IsHAG = 0
			self.DakCooldown = 0.05
			self.DakHeat = 0.13
			self.DakMaxHealth = 60
			self.DakMass = 6000
			--self.DakModel = "models/dak/8ac.mdl"
			self.DakAmmoType = "RAC2Ammo"
			self.DakAmmoUse = "RAC2AmmoUse"
			self.DakAmmoQueue = "RAC2AmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/rac2.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 0.55
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 150
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "CRAC5" then
			self.IsHAG = 0
			self.DakCooldown = 0.1
			self.DakHeat = 0.3125
			self.DakMaxHealth = 80
			self.DakMass = 8000
			--self.DakModel = "models/dak/10ac.mdl"
			self.DakAmmoType = "RAC5Ammo"
			self.DakAmmoUse = "RAC5AmmoUse"
			self.DakAmmoQueue = "RAC5AmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/rac5.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 1.375
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 13.75
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 130
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "CRAC10" then
			self.IsHAG = 0
			self.DakCooldown = 0.15
			self.DakHeat = 0.8
			self.DakMaxHealth = 110
			self.DakMass = 11000
			--self.DakModel = "models/dak/14ac.mdl"
			self.DakAmmoType = "RAC10Ammo"
			self.DakAmmoUse = "RAC10AmmoUse"
			self.DakAmmoQueue = "RAC10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/rac10.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 2.75
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 27.5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "CRAC20" then
			self.IsHAG = 0
			self.DakCooldown = 0.25
			self.DakHeat = 1.54
			self.DakMaxHealth = 130
			self.DakMass = 13000
			--self.DakModel = "models/dak/16ac.mdl"
			self.DakAmmoType = "RAC20Ammo"
			self.DakAmmoUse = "RAC20AmmoUse"
			self.DakAmmoQueue = "RAC20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/rac20.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 5.5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 55
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		--Proxmity LBX AutoCannons
		if self.DakName == "Anti-Air CLBX2" then
			self.DakName = "CLBX2"
		end
		if self.DakName == "Anti-Air CLBX5" then
			self.DakName = "CLBX5"
		end
		if self.DakName == "Anti-Air CLBX10" then
			self.DakName = "CLBX10"
		end
		if self.DakName == "Anti-Air CLBX20" then
			self.DakName = "CLBX20"
		end
		--LBX AutoCannons
		if self.DakName == "CLBX2" then
			self.IsHAG = 0
			self.DakCooldown = 0.45
			self.DakHeat = 0.5
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/5ac.mdl"
			self.DakAmmoType = "LBX2Ammo"
			self.DakAmmoUse = "LBX2AmmoUse"
			self.DakAmmoQueue = "LBX2AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx2.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = true
			self.DakLBXPellets = 2
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "CLBX5" then
			self.IsHAG = 0
			self.DakCooldown = 1
			self.DakHeat = 1.15
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/7ac.mdl"
			self.DakAmmoType = "LBX5Ammo"
			self.DakAmmoUse = "LBX5AmmoUse"
			self.DakAmmoQueue = "LBX5AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx5.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = true
			self.DakLBXPellets = 5
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "CLBX10" then
			self.IsHAG = 0
			self.DakCooldown = 1.375
			self.DakHeat = 2.75
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/11ac.mdl"
			self.DakAmmoType = "LBX10Ammo"
			self.DakAmmoUse = "LBX10AmmoUse"
			self.DakAmmoQueue = "LBX10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx10.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = true
			self.DakLBXPellets = 10
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "CLBX20" then
			self.IsHAG = 0
			self.DakCooldown = 2.33
			self.DakHeat = 5.85
			self.DakMaxHealth = 120
			self.DakMass = 12000
			--self.DakModel = "models/dak/13ac.mdl"
			self.DakAmmoType = "LBX20Ammo"
			self.DakAmmoUse = "LBX20AmmoUse"
			self.DakAmmoQueue = "LBX20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx20.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = true
			self.DakLBXPellets = 20
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Machine Gun
		if self.DakName == "C-Light Machine Gun" then
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 1.25
			self.DakMass = 125
			--self.DakModel = "models/dak/05ac.mdl"
			self.DakAmmoType = "LightMachineGunAmmo"
			self.DakAmmoUse = "LightMachineGunAmmoUse"
			self.DakAmmoQueue = "LightMachineGunAmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/lmg.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 0.075
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "C-Machine Gun" then
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 2.5
			self.DakMass = 250
			--self.DakModel = "models/dak/05ac.mdl"
			self.DakAmmoType = "MachineGunAmmo"
			self.DakAmmoUse = "MachineGunAmmoUse"
			self.DakAmmoQueue = "MachineGunAmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/mg.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 0.15
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 225
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "C-Heavy Machine Gun" then
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/05ac.mdl"
			self.DakAmmoType = "HeavyMachineGunAmmo"
			self.DakAmmoUse = "HeavyMachineGunAmmoUse"
			self.DakAmmoQueue = "HeavyMachineGunAmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/hmg.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 0.3
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 3
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 200
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "Clan Gauss Rifle" then
			self.IsHAG = 0
			self.DakCooldown = 4.125
			self.DakHeat = 1
			self.DakMaxHealth = 60
			self.DakMass = 12000
			--self.DakModel = "models/dak/gauss.mdl"
			self.DakAmmoType = "GaussAmmo"
			self.DakAmmoUse = "GaussAmmoUse"
			self.DakAmmoQueue = "GaussAmmoUseQueue"
			self.DakFireEffect = "dakgaussfire"
			self.DakFireSound = "dak/Gauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakgausstrail"
			self.DakShellVelocity = 60000
			self.DakShellDamage = 30
			self.DakShellExplosionEffect = "dakgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 600
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end	
		if self.DakName == "Railgun" then
			self.IsHAG = 0
			self.DakCooldown = 5
			self.DakHeat = 5
			self.DakMaxHealth = 140
			self.DakMass = 28000
			--self.DakModel = "models/dak/28ac.mdl"
			self.DakAmmoType = "RailgunAmmo"
			self.DakAmmoUse = "RailgunAmmoUse"
			self.DakAmmoQueue = "RailgunAmmoUseQueue"
			self.DakFireEffect = "dakrailgunfire"
			self.DakFireSound = "dak/railgun.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakrailguntrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 100
			self.DakShellExplosionEffect = "dakrailgunexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 2000
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--HAGs
		if self.DakName == "Hyper-Assault Gauss Rifle 20" then
			self.IsHAG = 1
			self.DakCooldown = 1
			self.DakHeat = 0.6
			self.DakMaxHealth = 50
			self.DakMass = 10000
			--self.DakModel = "models/dak/lgauss.mdl"
			self.DakAmmoType = "HAG20Ammo"
			self.DakAmmoUse = "HAG20AmmoUse"
			self.DakAmmoQueue = "HAG20AmmoUseQueue"
			self.DakFireEffect = "dakapgaussfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakapgausstrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "dakapgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 125
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Hyper-Assault Gauss Rifle 30" then
			self.IsHAG = 1
			self.DakCooldown = 1
			self.DakHeat = 0.9
			self.DakMaxHealth = 65
			self.DakMass = 13000
			--self.DakModel = "models/dak/lgauss.mdl"
			self.DakAmmoType = "HAG30Ammo"
			self.DakAmmoUse = "HAG30AmmoUse"
			self.DakAmmoQueue = "HAG30AmmoUseQueue"
			self.DakFireEffect = "dakmagshotfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakmagshottrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 3
			self.DakShellExplosionEffect = "dakmagshotexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 60
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 110
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Hyper-Assault Gauss Rifle 40" then
			self.IsHAG = 1
			self.DakCooldown = 1
			self.DakHeat = 1.2
			self.DakMaxHealth = 80
			self.DakMass = 16000
			--self.DakModel = "models/dak/lgauss.mdl"
			self.DakAmmoType = "HAG40Ammo"
			self.DakAmmoUse = "HAG40AmmoUse"
			self.DakAmmoQueue = "HAG40AmmoUseQueue"
			self.DakFireEffect = "daklightgaussfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "daklightgausstrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "daklightgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 80
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--PPCs
		if self.DakName == "CERPPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3.5
			self.DakHeat = 11
			self.DakMaxHealth = 60
			self.DakMass = 6000
			--self.DakModel = "models/dak/ppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "ppcfire"
			self.DakFireSound = "dak/clanppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 25
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 250
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Plasma Cannon
		if self.DakName == "Plasma Cannon" then
			self.DakIsEnergy = true
			self.IsHAG = 0
			self.DakCooldown = 5
			self.DakHeat = 13.5
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/plasmacannon.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "plasmacannonfire"
			self.DakFireSound = "dak/plasmacannon.wav"
			self.DakFirePitch = 135
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_plasmabolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Flamer
		if self.DakName == "C-ER Flamer" then
			self.DakIsEnergy = true
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0.36
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/flamer.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_erflamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 5000
			self.DakShellDamage = 1
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "C-Flamer" then
			self.DakIsEnergy = true
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0.36
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/flamer.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_flamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 2500
			self.DakShellDamage = 1
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
	--IS--
	--Autocannons
	if self.DakName == "AC2" then
		self.IsHAG = 0
		self.DakCooldown = 0.35
		self.DakHeat = 0.4
		self.DakMaxHealth = 60
		self.DakMass = 6000
		--self.DakModel = "models/dak/6ac.mdl"
		self.DakAmmoType = "AC2Ammo"
		self.DakAmmoUse = "AC2AmmoUse"
		self.DakAmmoQueue = "AC2AmmoUseQueue"
		self.DakFireEffect = "dakballisticfire"
		self.DakFireSound = "dak/ac2.wav"
		self.DakFirePitch = 90
		self.DakFireSpecialShell = false
		self.DakShellEnt = "dak_baseshell"
		self.DakShellTrail = "dakshelltrail"
		self.DakShellVelocity = 40000
		self.DakShellDamage = 2
		self.DakShellExplosionEffect = "daksmallballisticexplosion"
		self.DakShellGravity = true
		self.DakShellMass = 20
		self.DakIsLBX = false
		self.DakLBXPellets = 1
		self.DakShellImpactSound = "dak/ballisticimpact.wav"
		self.DakShellImpactPitch = 90
		self.DakIsExplosive = false
		self.DakUseAmmo = true
		self.DakIsRAC = false
		self.DakIsUAC = false
		self.DakCanSwapAmmo = 1
	end
	if self.DakName == "AC5" then
			self.IsHAG = 0
			self.DakCooldown = 0.7
			self.DakHeat = 1
			self.DakMaxHealth = 80
			self.DakMass = 8000
			--self.DakModel = "models/dak/8ac.mdl"
			self.DakAmmoType = "AC5Ammo"
			self.DakAmmoUse = "AC5AmmoUse"
			self.DakAmmoQueue = "AC5AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/ac5.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "AC10" then
			self.IsHAG = 0
			self.DakCooldown = 1
			self.DakHeat = 2.5
			self.DakMaxHealth = 120
			self.DakMass = 12000
			--self.DakModel = "models/dak/12ac.mdl"
			self.DakAmmoType = "AC10Ammo"
			self.DakAmmoUse = "AC10AmmoUse"
			self.DakAmmoQueue = "AC10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/ac10.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "AC20" then
			self.IsHAG = 0
			self.DakCooldown = 1.6
			self.DakHeat = 5
			self.DakMaxHealth = 140
			self.DakMass = 14000
			--self.DakModel = "models/dak/14ac.mdl"
			self.DakAmmoType = "AC20Ammo"
			self.DakAmmoUse = "AC20AmmoUse"
			self.DakAmmoQueue = "AC20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/ac20.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Armored Autocannons
	if self.DakName == "Armored AC2" then
		self.IsHAG = 0
			self.DakCooldown = 0.35
		self.DakHeat = 0.4
		self.DakMaxHealth = 160
		self.DakMass = 8000
		--self.DakModel = "models/dak/6ac.mdl"
		self.DakAmmoType = "AC2Ammo"
		self.DakAmmoUse = "AC2AmmoUse"
		self.DakAmmoQueue = "AC2AmmoUseQueue"
		self.DakFireEffect = "dakballisticfire"
		self.DakFireSound = "dak/ac2.wav"
		self.DakFirePitch = 90
		self.DakFireSpecialShell = false
		self.DakShellEnt = "dak_baseshell"
		self.DakShellTrail = "dakshelltrail"
		self.DakShellVelocity = 40000
		self.DakShellDamage = 2
		self.DakShellExplosionEffect = "daksmallballisticexplosion"
		self.DakShellGravity = true
		self.DakShellMass = 20
		self.DakIsLBX = false
		self.DakLBXPellets = 1
		self.DakShellImpactSound = "dak/ballisticimpact.wav"
		self.DakShellImpactPitch = 90
		self.DakIsExplosive = false
		self.DakUseAmmo = true
		self.DakIsRAC = false
		self.DakIsUAC = false
		self.DakCanSwapAmmo = 1
	end
	if self.DakName == "Armored AC5" then
			self.IsHAG = 0
			self.DakCooldown = 0.7
			self.DakHeat = 1
			self.DakMaxHealth = 200
			self.DakMass = 10000
			--self.DakModel = "models/dak/8ac.mdl"
			self.DakAmmoType = "AC5Ammo"
			self.DakAmmoUse = "AC5AmmoUse"
			self.DakAmmoQueue = "AC5AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/ac5.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "Armored AC10" then
			self.IsHAG = 0
			self.DakCooldown = 1
			self.DakHeat = 2.5
			self.DakMaxHealth = 280
			self.DakMass = 14000
			--self.DakModel = "models/dak/12ac.mdl"
			self.DakAmmoType = "AC10Ammo"
			self.DakAmmoUse = "AC10AmmoUse"
			self.DakAmmoQueue = "AC10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/ac10.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "Armored AC20" then
			self.IsHAG = 0
			self.DakCooldown = 1.6
			self.DakHeat = 5
			self.DakMaxHealth = 320
			self.DakMass = 16000
			--self.DakModel = "models/dak/14ac.mdl"
			self.DakAmmoType = "AC20Ammo"
			self.DakAmmoUse = "AC20AmmoUse"
			self.DakAmmoQueue = "AC20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/ac20.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Ultra AutoCannons
		if self.DakName == "UAC2" then
			self.IsHAG = 0
			self.DakCooldown = 0.1875
			self.DakHeat = 0.28
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/7ac.mdl"
			self.DakAmmoType = "UAC2Ammo"
			self.DakAmmoUse = "UAC2AmmoUse"
			self.DakAmmoQueue = "UAC2AmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/uac2.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 1.4
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 14
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 110
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self.DakName == "UAC5" then
			self.IsHAG = 0
			self.DakCooldown = 0.4375
			self.DakHeat = 0.8
			self.DakMaxHealth = 90
			self.DakMass = 9000
			--self.DakModel = "models/dak/9ac.mdl"
			self.DakAmmoType = "UAC5Ammo"
			self.DakAmmoUse = "UAC5AmmoUse"
			self.DakAmmoQueue = "UAC5AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/uac5.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self.DakName == "UAC10" then
			self.IsHAG = 0
			self.DakCooldown = 0.75
			self.DakHeat = 2.25
			self.DakMaxHealth = 130
			self.DakMass = 13000
			--self.DakModel = "models/dak/13ac.mdl"
			self.DakAmmoType = "UAC10Ammo"
			self.DakAmmoUse = "UAC10AmmoUse"
			self.DakAmmoQueue = "UAC10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/uac10.wav"
			self.DakFirePitch = 95
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 9
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 90
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self.DakName == "UAC20" then
			self.IsHAG = 0
			self.DakCooldown = 1
			self.DakHeat = 3.75
			self.DakMaxHealth = 150
			self.DakMass = 15000
			--self.DakModel = "models/dak/15ac.mdl"
			self.DakAmmoType = "UAC20Ammo"
			self.DakAmmoUse = "UAC20AmmoUse"
			self.DakAmmoQueue = "UAC20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/uac20.wav"
			self.DakFirePitch = 95
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		--Rotary AutoCannons
		if self.DakName == "RAC2" then
			self.IsHAG = 0
			self.DakCooldown = 0.05
			self.DakHeat = 0.1
			self.DakMaxHealth = 80
			self.DakMass = 8000
			--self.DakModel = "models/dak/8ac.mdl"
			self.DakAmmoType = "RAC2Ammo"
			self.DakAmmoUse = "RAC2AmmoUse"
			self.DakAmmoQueue = "RAC2AmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/rac2.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 0.55
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 5.5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 150
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "RAC5" then
			self.IsHAG = 0
			self.DakCooldown = 0.1
			self.DakHeat = 0.25
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/10ac.mdl"
			self.DakAmmoType = "RAC5Ammo"
			self.DakAmmoUse = "RAC5AmmoUse"
			self.DakAmmoQueue = "RAC5AmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/rac5.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 1.375
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 13.75
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 130
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "RAC10" then
			self.IsHAG = 0
			self.DakCooldown = 0.15
			self.DakHeat = 0.625
			self.DakMaxHealth = 140
			self.DakMass = 14000
			--self.DakModel = "models/dak/14ac.mdl"
			self.DakAmmoType = "RAC10Ammo"
			self.DakAmmoUse = "RAC10AmmoUse"
			self.DakAmmoQueue = "RAC10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/rac10.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 2.75
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 27.5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "RAC20" then
			self.IsHAG = 0
			self.DakCooldown = 0.25
			self.DakHeat = 1.25
			self.DakMaxHealth = 160
			self.DakMass = 16000
			--self.DakModel = "models/dak/16ac.mdl"
			self.DakAmmoType = "RAC20Ammo"
			self.DakAmmoUse = "RAC20AmmoUse"
			self.DakAmmoQueue = "RAC20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/rac20.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 5.5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 55
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		--Proxmity LBX AutoCannons
		if self.DakName == "Anti-Air LBX2" then
			self.DakName = "LBX2"
		end
		if self.DakName == "Anti-Air LBX5" then
			self.DakName = "LBX5"
		end
		if self.DakName == "Anti-Air LBX10" then
			self.DakName = "LBX10"
		end
		if self.DakName == "Anti-Air LBX20" then
			self.DakName = "LBX20"
		end
		--LBX AutoCannons
		if self.DakName == "LBX2" then
			self.IsHAG = 0
			self.DakCooldown = 0.375
			self.DakHeat = 0.4
			self.DakMaxHealth = 60
			self.DakMass = 6000
			--self.DakModel = "models/dak/5ac.mdl"
			self.DakAmmoType = "LBX2Ammo"
			self.DakAmmoUse = "LBX2AmmoUse"
			self.DakAmmoQueue = "LBX2AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx2.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = true
			self.DakLBXPellets = 2
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "LBX5" then
			self.IsHAG = 0
			self.DakCooldown = 0.875
			self.DakHeat = 1
			self.DakMaxHealth = 80
			self.DakMass = 8000
			--self.DakModel = "models/dak/7ac.mdl"
			self.DakAmmoType = "LBX5Ammo"
			self.DakAmmoUse = "LBX5AmmoUse"
			self.DakAmmoQueue = "LBX5AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx5.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = true
			self.DakLBXPellets = 5
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "LBX10" then
			self.IsHAG = 0
			self.DakCooldown = 1.25
			self.DakHeat = 2.5
			self.DakMaxHealth = 110
			self.DakMass = 11000
			--self.DakModel = "models/dak/11ac.mdl"
			self.DakAmmoType = "LBX10Ammo"
			self.DakAmmoUse = "LBX10AmmoUse"
			self.DakAmmoQueue = "LBX10AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx10.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = true
			self.DakLBXPellets = 10
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self.DakName == "LBX20" then
			self.IsHAG = 0
			self.DakCooldown = 2
			self.DakHeat = 5
			self.DakMaxHealth = 140
			self.DakMass = 14000
			--self.DakModel = "models/dak/13ac.mdl"
			self.DakAmmoType = "LBX20Ammo"
			self.DakAmmoUse = "LBX20AmmoUse"
			self.DakAmmoQueue = "LBX20AmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/lbx20.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_lbxpellet"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = true
			self.DakLBXPellets = 20
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Machine Gun
		if self.DakName == "Light Machine Gun" then
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 2.5
			self.DakMass = 250
			--self.DakModel = "models/dak/05ac.mdl"
			self.DakAmmoType = "LightMachineGunAmmo"
			self.DakAmmoUse = "LightMachineGunAmmoUse"
			self.DakAmmoQueue = "LightMachineGunAmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/lmg.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 0.1125
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "Machine Gun" then
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/05ac.mdl"
			self.DakAmmoType = "MachineGunAmmo"
			self.DakAmmoUse = "MachineGunAmmoUse"
			self.DakAmmoQueue = "MachineGunAmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/mg.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 0.225
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 2
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 225
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self.DakName == "Heavy Machine Gun" then
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/05ac.mdl"
			self.DakAmmoType = "HeavyMachineGunAmmo"
			self.DakAmmoUse = "HeavyMachineGunAmmoUse"
			self.DakAmmoQueue = "HeavyMachineGunAmmoUseQueue"
			self.DakFireEffect = "daksmallballisticfire"
			self.DakFireSound = "dak/hmg.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshelllight"
			self.DakShellTrail = "daksmallshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 0.45
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 200
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		--Cannons
		if self.DakName == "Long Tom" then
			self.IsHAG = 0
			self.DakCooldown = 7.5
			self.DakHeat = 20
			self.DakMaxHealth = 200
			if self.DakHealth > self.DakMaxHealth then
				self.DakHealth = self.DakMaxHealth
			end
			self.DakMass = 20000
			--self.DakModel = "models/dak/20ac.mdl"
			self.DakAmmoType = "LongTomAmmo"
			self.DakAmmoUse = "LongTomAmmoUse"
			self.DakAmmoQueue = "LongTomAmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/bigcannon.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_longtomshell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 5000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 2000
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Thumper" then
			self.IsHAG = 0
			self.DakCooldown = 5.0
			self.DakHeat = 10
			self.DakMaxHealth = 100
			if self.DakHealth > self.DakMaxHealth then
				self.DakHealth = self.DakMaxHealth
			end
			self.DakMass = 10000
			--self.DakModel = "models/dak/10ac.mdl"
			self.DakAmmoType = "ThumperAmmo"
			self.DakAmmoUse = "ThumperAmmoUse"
			self.DakAmmoQueue = "ThumperAmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/thumper.wav"
			self.DakFirePitch = 95
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_thumpershell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 7500
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 600
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Sniper Cannon" then
			self.IsHAG = 0
			self.DakCooldown = 5
			self.DakHeat = 10
			self.DakMaxHealth = 200
			if self.DakHealth > self.DakMaxHealth then
				self.DakHealth = self.DakMaxHealth
			end
			self.DakMass = 20000
			--self.DakModel = "models/dak/20ac.mdl"
			self.DakAmmoType = "SniperAmmo"
			self.DakAmmoUse = "SniperAmmoUse"
			self.DakAmmoQueue = "SniperAmmoUseQueue"
			self.DakFireEffect = "dakballisticfire"
			self.DakFireSound = "dak/bigcannon.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_snipershell"
			self.DakShellTrail = "dakshelltrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 40
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1000
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Gauss Rifles
		if self.DakName == "Magshot Gauss Rifle" then
			self.IsHAG = 0
			self.DakCooldown = 2
			self.DakHeat = 1
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/lgauss.mdl"
			self.DakAmmoType = "MagshotAmmo"
			self.DakAmmoUse = "MagshotAmmoUse"
			self.DakAmmoQueue = "MagshotAmmoUseQueue"
			self.DakFireEffect = "dakmagshotfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakmagshottrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "dakmagshotexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 125
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Light Gauss Rifle" then
			self.IsHAG = 0
			self.DakCooldown = 2.75
			self.DakHeat = 1
			self.DakMaxHealth = 60
			self.DakMass = 12000
			--self.DakModel = "models/dak/lgauss.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "daklightgaussfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "daklightgausstrail"
			self.DakShellVelocity = 70000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "daklightgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 300
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 100
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Gauss Rifle" then
			self.IsHAG = 0
			self.DakCooldown = 3.75
			self.DakHeat = 1
			self.DakMaxHealth = 75
			self.DakMass = 15000
			--self.DakModel = "models/dak/gauss.mdl"
			self.DakAmmoType = "GaussAmmo"
			self.DakAmmoUse = "GaussAmmoUse"
			self.DakAmmoQueue = "GaussAmmoUseQueue"
			self.DakFireEffect = "dakgaussfire"
			self.DakFireSound = "dak/Gauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakgausstrail"
			self.DakShellVelocity = 60000
			self.DakShellDamage = 30
			self.DakShellExplosionEffect = "dakgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 600
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end	
		if self.DakName == "Heavy Gauss Rifle" then
			self.IsHAG = 0
			self.DakCooldown = 4.5
			self.DakHeat = 1
			self.DakMaxHealth = 90
			self.DakMass = 18000
			--self.DakModel = "models/dak/hgauss.mdl"
			self.DakAmmoType = "HeavyGaussAmmo"
			self.DakAmmoUse = "HeavyGaussAmmoUse"
			self.DakAmmoQueue = "HeavyGaussAmmoUseQueue"
			self.DakFireEffect = "dakheavygaussfire"
			self.DakFireSound = "dak/HeavyGauss.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakheavygausstrail"
			self.DakShellVelocity = 50000
			self.DakShellDamage = 50
			self.DakShellExplosionEffect = "dakheavygaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1000
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Silver Bullet Gauss Rifle" then
			self.IsHAG = 0
			self.DakCooldown = 4.5
			self.DakHeat = 1
			self.DakMaxHealth = 75
			self.DakMass = 15000
			--self.DakModel = "models/dak/gauss.mdl"
			self.DakAmmoType = "SBGAmmo"
			self.DakAmmoUse = "SBGAmmoUse"
			self.DakAmmoQueue = "SBGAmmoUseQueue"
			self.DakFireEffect = "dakgaussfire"
			self.DakFireSound = "dak/Gauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_sbgpellet"
			self.DakShellTrail = "ac20trail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 80
			self.DakIsLBX = true
			self.DakLBXPellets = 10
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--PPCs
		if self.DakName == "PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3
			self.DakHeat = 7.5
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/ppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "ppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Light PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3
			self.DakHeat = 5
			self.DakMaxHealth = 30
			self.DakMass = 3000
			--self.DakModel = "models/dak/lightppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightppcfire"
			self.DakFireSound = "dak/clanppc.wav"
			self.DakFirePitch = 110
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "daklightppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Light Burst PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 0.5
			self.DakHeat = 2
			self.DakMaxHealth = 30
			self.DakMass = 3000
			--self.DakModel = "models/dak/lightppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightburstppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightburstppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 3
			self.DakShellExplosionEffect = "daklightburstppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 30
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 120
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Heavy PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3
			self.DakHeat = 12
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/heavyppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "heavyppcfire"
			self.DakFireSound = "dak/heavyppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "heavyppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 30
			self.DakShellExplosionEffect = "dakheavyppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 300
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Armored PPCs
		if self.DakName == "Armored PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3
			self.DakHeat = 7.5
			self.DakMaxHealth = 180
			self.DakMass = 9000
			--self.DakModel = "models/dak/ppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "ppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Armored Light PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3
			self.DakHeat = 4.5
			self.DakMaxHealth = 100
			self.DakMass = 5000
			--self.DakModel = "models/dak/lightppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightppcfire"
			self.DakFireSound = "dak/clanppc.wav"
			self.DakFirePitch = 110
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "daklightppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Armored Light Burst PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 0.5
			self.DakHeat = 2
			self.DakMaxHealth = 100
			self.DakMass = 5000
			--self.DakModel = "models/dak/lightppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightburstppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightburstppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 3
			self.DakShellExplosionEffect = "daklightburstppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 30
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 120
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Armored Heavy PPC" then
			self.DakIsEnergy = true
			self.DakIsPPC = true
			self.IsHAG = 0
			self.DakCooldown = 3
			self.DakHeat = 12
			self.DakMaxHealth = 240
			self.DakMass = 12000
			--self.DakModel = "models/dak/heavyppc.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "heavyppcfire"
			self.DakFireSound = "dak/heavyppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "heavyppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 30
			self.DakShellExplosionEffect = "dakheavyppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 300
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Flamer
		if self.DakName == "Heavy Flamer" then
			self.DakIsEnergy = true
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0.36
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/flamer.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_heavyflamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 2500
			self.DakShellDamage = 0.5
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self.DakName == "Flamer" then
			self.DakIsEnergy = true
			self.IsHAG = 0
			self.DakCooldown = 0.2
			self.DakHeat = 0.27
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/flamer.mdl"
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_isflamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 2500
			self.DakShellDamage = 0.2
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 2
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end

	self:SetNWFloat("Cooldown",self.DakCooldown)
	if not(self:GetModel() == self.DakModel) then
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end

	if IsValid(self.DakEngine) then
		if self.DakIsEnergy then
		 	if self.DakEngine.LaserInsulation==1 then
		 		self.DakHeat = self.DakHeat*0.75
		 		self.DakMaxHealth = self.DakMaxHealth*0.75
		 	end
		end
		if self.DakEngine.WeaponShielding==1 then
			self.DakMaxHealth = self.DakMaxHealth+10
			if self.Armored==0 then
				self.DakHealth=self.DakHealth+10
				self.Armored=1
			end
	 	end
	end

	if self.DakHealth > self.DakMaxHealth then
		self.DakHealth = self.DakMaxHealth
	end

	self:GetPhysicsObject():SetMass(self.DakMass)
	self.SlowThinkTime = CurTime()
	end


	if CurTime()>=self.MidThinkTime+0.33 then
		if self.DakIsExplosive then
			if self.DakHealth<(self.DakMaxHealth/3) then
				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
				effectdata:SetEntity(self)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(.5)
				effectdata:SetScale(200)
				util.Effect("dakppcexplosion", effectdata)

			self.DakDamageList = {}
			self.RemoveList = {}
			self.IgnoreList = {}
			local Targets = ents.FindInSphere( self:GetPos(), 500 )
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
									table.insert(self.DakDamageList,ExpTrace.Entity)
								else
									if (Targets[i]:GetClass() == "dak_bot" or Targets[i]:GetClass() == "dak_zombie") then
										Targets[i]:SetHealth(Targets[i]:Health() - self.DakShellDamage*500*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)))
										if Targets[i]:Health() <= 0 and self.revenge==0 then
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
										ExpPain:SetDamageForce( ExpTrace.Normal*self.DakShellDamage*2500 )
										ExpPain:SetDamage( self.DakShellDamage*500*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)) )
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
				end
				for i = 1, #self.DakDamageList do
					if(self.DakDamageList[i]:IsValid()) then
						if not((self.DakDamageList[i]:GetClass() == "dak_bot" or self.DakDamageList[i]:GetClass() == "dak_zombie")) then
							if(self.DakDamageList[i]:GetParent():IsValid()) then
								if(self.DakDamageList[i]:GetParent():GetParent():IsValid()) then
									self.DakDamageList[i]:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (self.DakDamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(self.DakShellDamage*5/table.Count(self.DakDamageList))*10000*2*(1-(self.DakDamageList[i]:GetPos():Distance(self:GetPos())/1000)) )
								end
							end
							if not(self.DakDamageList[i]:GetParent():IsValid()) then
								self.DakDamageList[i]:GetPhysicsObject():ApplyForceCenter( (self.DakDamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(self.DakShellDamage*5/table.Count(self.DakDamageList))*10000*2*(1-(self.DakDamageList[i]:GetPos():Distance(self:GetPos())/1000))  )
							end
						end
					end

					if not(self.DakDamageList[i]:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(self.DakDamageList[i]:GetTable().OnDieFunctions.GetCountUpdate==nil) then
						if not(self.DakDamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
							if self.DakDamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
								if (self.DakDamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..self.DakDamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
									local HPPerc = (self.DakDamageList[i].DakHealth-(self.DakShellDamage*5/table.Count(self.DakDamageList))*(1-(self.DakDamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DakDamageList[i].DakMaxHealth
									self.DakDamageList[i].DakHealth = self.DakDamageList[i].DakHealth-(self.DakShellDamage*5/table.Count(self.DakDamageList))*(1-(self.DakDamageList[i]:GetPos():Distance(self:GetPos())/1000))
									if not(self.DakDamageList[i].DakRed == nil) then
										self.DakDamageList[i]:SetColor(Color(self.DakDamageList[i].DakRed*HPPerc,self.DakDamageList[i].DakGreen*HPPerc,self.DakDamageList[i].DakBlue*HPPerc,self.DakDamageList[i]:GetColor().a))
									end
									self.DakDamageList[i].DakLastDamagePos = self:GetPhysicsObject():GetPos()
									if self.DakDamageList[i].DakHealth <= 0 and self.DakDamageList[i].DakPooled==0 then
										table.insert(self.RemoveList,self.DakDamageList[i])
									end
								end
							end
						end
					else
						local HPPerc = (self.DakDamageList[i].DakHealth-(self.DakShellDamage*5/table.Count(self.DakDamageList))*(1-(self.DakDamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DakDamageList[i].DakMaxHealth
						self.DakDamageList[i].DakHealth = self.DakDamageList[i].DakHealth-(self.DakShellDamage*5/table.Count(self.DakDamageList))*(1-(self.DakDamageList[i]:GetPos():Distance(self:GetPos())/1000))
						if not(self.DakDamageList[i].DakRed == nil) then
							self.DakDamageList[i]:SetColor(Color(self.DakDamageList[i].DakRed*HPPerc,self.DakDamageList[i].DakGreen*HPPerc,self.DakDamageList[i].DakBlue*HPPerc,self.DakDamageList[i]:GetColor().a))
						end
						self.DakDamageList[i].DakLastDamagePos = self:GetPhysicsObject():GetPos()
						if self.DakDamageList[i].DakHealth <= 0 and self.DakDamageList[i].DakPooled==0 then
							table.insert(self.RemoveList,self.DakDamageList[i])
						end
					end
				end
				for i = 1, #self.RemoveList do
					self.salvage = ents.Create( "dak_salvage" )
					self.salvage.DakModel = self.RemoveList[i]:GetModel()
					self.salvage:SetPos( self.RemoveList[i]:GetPos())
					self.salvage:SetAngles( self.RemoveList[i]:GetAngles())
					self.salvage.DakLastDamagePos = self:GetPhysicsObject():GetPos()
					self.salvage:Spawn()
					self.RemoveList[i]:Remove()
				end
			end
				self:EmitSound( "dak/ppcimpact.wav", 100, 60, 1, 6)
				self:Remove()
			end
		end

		--add fire function here
		--self:DakFire()
		self:DakGunAmmoSwap()

		WireLib.TriggerOutput(self, "Cooldown", math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100))
		WireLib.TriggerOutput(self, "CooldownPercent", 100*(math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100)/self.DakCooldown))
		WireLib.TriggerOutput(self, "Ammo", self.DakEngine[self.DakAmmoType])
		self.MidThinkTime = CurTime()
	end
	for i = 1, #self.ShellList do
		self.ShellList[i].LifeTime = self.ShellList[i].LifeTime + 0.1
		self.ShellList[i].Gravity = physenv.GetGravity()*self.ShellList[i].LifeTime

		local trace = {}
			trace.start = self.ShellList[i].Pos
			trace.endpos = self.ShellList[i].Pos + (self.ShellList[i].Ang:Forward()*self.ShellList[i].DakVelocity*0.1) + (self.ShellList[i].Gravity*0.1)
			trace.filter = self.ShellList[i].Filter
			trace.mins = Vector(-1,-1,-1)
			trace.maxs = Vector(1,1,1)
		local ShellTrace = util.TraceHull( trace )

		local effectdata = EffectData()
		effectdata:SetStart(ShellTrace.StartPos)
		effectdata:SetOrigin(ShellTrace.HitPos)
		effectdata:SetScale((self.ShellList[i].DakDamage))
		util.Effect("dakballistictracer", effectdata)

		if ShellTrace.Hit then
			DTekShellHit(ShellTrace.StartPos,ShellTrace.HitPos,ShellTrace.Entity,self.ShellList[i],ShellTrace.HitNormal)
		end

		if self.ShellList[i].DieTime then
			self.RemoveList[#self.RemoveList+1] = i
			--if self.ShellList[i].DieTime+1.5<CurTime()then
			--	self.RemoveList[#self.RemoveList+1] = i
			--end
		end

		if self.ShellList[i].RemoveNow == 1 then
			self.RemoveList[#self.RemoveList+1] = i
		end

		self.ShellList[i].Pos = self.ShellList[i].Pos + (self.ShellList[i].Ang:Forward()*self.ShellList[i].DakVelocity*0.1) + (self.ShellList[i].Gravity*0.1)
	end
	
	if #self.RemoveList > 0 then
		for i = 1, #self.RemoveList do
			table.remove( self.ShellList, self.RemoveList[i] )
		end
	end

	self.RemoveList = {}

	self:NextThink( CurTime()+0.1 )
	return true
end

function ENT:DakFire()
	if IsValid(self.DakEngine) then
		--if CurTime() > (self.timer + self.DakCooldown) then
		--	self:TriggerInput("Fire", self.Held)
		--end

		if self.DakEngine.DakHeat >= self.DakEngine.DakMaxHeat then
			self.Firing = false
		end
		if self.DakUseAmmo then
			if self.DakEngine[self.DakAmmoType] == 0 then
				self.Firing = false
			end
			WireLib.TriggerOutput(self, "Ammo", self.DakEngine[self.DakAmmoType])
		end
		
		if( self.Firing ) then
			if CurTime() > (self.timer + self.DakCooldown) then
				--FIREBULLETHERE
				self:SetNWBool("Firing",true)
				timer.Create( "NoFireTimer"..self:EntIndex(), 0.1, 1, function()
					self:SetNWBool("Firing",false)
				end)
				self.LastFireTime = CurTime()
				local Attachment = self:GetAttachment( 1 )
				local shootOrigin = Attachment.Pos
				local shootAngles = self:GetAngles()
				local shootDir = shootAngles:Forward()

				if self.DakShellEnt == "dak_baseshelllight" or self.DakShellEnt == "dak_lbxpellet" then
					if self.DakIsLBX and self.DakLBXPellets>1 then
						self:SetNWString("FireSound",self.DakFireSound)
						self:SetNWInt("FirePitch",self.DakFirePitch)
						self:SetNWBool("Firing",true)
						timer.Create( "ResoundTimer"..self:EntIndex(), 0.1, 1, function()
							self:SetNWBool("Firing",false)
						end)
						for i = 1, self.DakLBXPellets do
							local shell = {}
			 				shell.Pos = shootOrigin + ( self:GetForward() * 1 )
			 				if self.DakEngine.TightWadding == 1 then
			 					shell.Ang = shootAngles + Angle(math.Rand(-0.51,0.51),math.Rand(-0.51,0.51),math.Rand(-0.51,0.51))
							else
								shell.Ang = shootAngles + Angle(math.Rand(-0.85,0.85),math.Rand(-0.85,0.85),math.Rand(-0.85,0.85))
							end
							shell.DakTrail = self.DakShellTrail
							shell.DakVelocity = self.DakShellVelocity
							shell.DakDamage = 1.5
							shell.DakMass = 15
							shell.DakImpactSound = self.DakShellImpactSound
							shell.DakImpactPitch = self.DakShellImpactPitch
							shell.DakFireSound = self.DakFireSound
							shell.DakFirePitch = self.DakFirePitch
							shell.DakGun = self
							shell.Filter = table.Copy(self.DakEngine.Contraption)
							shell.LifeTime = 0
							shell.Gravity = 0
							self.ShellList[#self.ShellList+1] = shell
		 				end
		 			else
		 				local shell = {}
		 				shell.Pos = shootOrigin + ( self:GetForward() * 1 )
		 				if self.DakHeat == 0 then
		 					shell.Ang = shootAngles + Angle(math.Rand(-0.25,0.25),math.Rand(-0.25,0.25),math.Rand(-0.25,0.25))
						else
							shell.Ang = shootAngles + Angle(math.Rand(-0.1,0.1),math.Rand(-0.1,0.1),math.Rand(-0.1,0.1))
						end
						shell.DakTrail = self.DakShellTrail
						shell.DakVelocity = self.DakShellVelocity
						shell.DakDamage = self.DakShellDamage
						shell.DakMass = self.DakShellMass
						shell.DakImpactSound = self.DakShellImpactSound
						shell.DakImpactPitch = self.DakShellImpactPitch
						shell.DakFireSound = self.DakFireSound
						shell.DakFirePitch = self.DakFirePitch
						shell.DakGun = self
						shell.Filter = table.Copy(self.DakEngine.Contraption)
						shell.LifeTime = 0
						shell.Gravity = 0
						self.ShellList[#self.ShellList+1] = shell
		 			end
				else
					local shell = ents.Create( self.DakShellEnt )
					if ( !IsValid( shell ) ) then return end
					shell:SetPos( shootOrigin + ( self:GetForward() * 1 ))
					shell:SetAngles( shootAngles)
					if self.DakIsLBX and self.DakLBXPellets>1 then
						ShellList = {}
						for i = 1, self.DakLBXPellets do
							local shell = ents.Create( self.DakShellEnt )
							if ( !IsValid( shell ) ) then return end
							shell:SetPos( shootOrigin + ( self:GetForward() * 1 ))
							if self.DakEngine.TightWadding == 1 then
								if self.DakName == "Silver Bullet Gauss Rifle" then
									shell:SetAngles( shootAngles + Angle(math.Rand(-0.24,0.24),math.Rand(-0.24,0.24),math.Rand(-0.24,0.24)) )
								else
									shell:SetAngles( shootAngles + Angle(math.Rand(-0.51,0.51),math.Rand(-0.51,0.51),math.Rand(-0.51,0.51)) )
								end
							else
								if self.DakName == "Silver Bullet Gauss Rifle" then
									shell:SetAngles( shootAngles + Angle(math.Rand(-0.4,0.4),math.Rand(-0.4,0.4),math.Rand(-0.4,0.4)) )
								else
									shell:SetAngles( shootAngles + Angle(math.Rand(-0.85,0.85),math.Rand(-0.85,0.85),math.Rand(-0.85,0.85)) )
								end
							end
							table.insert(ShellList,table.Count(ShellList)+1,shell)
							shell.DakGun = self
							if i==1 then
								shell:SetNWString("FireSound",self.DakFireSound)
								shell:SetNWInt("FirePitch",self.DakFirePitch)
								shell:SetNWInt("Pellets",self.DakLBXPellets)
							else
								shell:SetNWString("FireSound","")
								shell:SetNWInt("FirePitch",self.DakFirePitch)
								shell:SetNWInt("Pellets",self.DakLBXPellets)
							end
							shell:Spawn()
							if(self:IsValid()) then
								if(self:GetParent():IsValid()) then
									if(self:GetParent():GetParent():IsValid()) then
										self:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*(self.DakShellMass/self.DakLBXPellets)/100 )
									end
								end
							
								if not(self:GetParent():IsValid()) then
									self:GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*(self.DakShellMass/self.DakLBXPellets)/100 )
								end
							end
		 				end
		 			else
		 				if self.IsHAG == 1 then
		 					shell.DakTrail = self.DakShellTrail
							shell.DakVelocity = self.DakShellVelocity
							shell.DakDamage = self.DakShellDamage
							shell.DakExplosionEffect = self.DakShellExplosionEffect
							shell.DakGravity = self.DakShellGravity
							shell.DakMass = self.DakShellMass
							shell.DakImpactSound = self.DakShellImpactSound
							shell.DakImpactPitch = self.DakShellImpactPitch
							shell.DakGun = self
							shell:SetNWString("FireSound",self.DakFireSound)
							shell:SetNWInt("FirePitch",self.DakFirePitch)
							shell:SetNWInt("Pellets",self.DakLBXPellets)
							shell:Spawn()
							if(self:IsValid()) then
								if(self:GetParent():IsValid()) then
									if(self:GetParent():GetParent():IsValid()) then
										self:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*self.DakShellMass/100 )
									end
								end
							
								if not(self:GetParent():IsValid()) then
									self:GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*self.DakShellMass/100 )
								end
							end
		 					timer.Create( "HAGShotTimer"..self:EntIndex(), 0.10, 9, function() local Attachment = self:GetAttachment( 1 )
		 					local Attachment = self:GetAttachment( 1 )
							local shootOrigin = Attachment.Pos
							local shootAngles = self:GetAngles()
							local shootDir = shootAngles:Forward()
							local shell = ents.Create( self.DakShellEnt )
							shell:SetPos( shootOrigin + ( self:GetForward() * 1 ))
							shell:SetAngles( shootAngles)
							shell.DakTrail = self.DakShellTrail
							shell.DakVelocity = self.DakShellVelocity
							shell.DakDamage = self.DakShellDamage
							shell.DakExplosionEffect = self.DakShellExplosionEffect
							shell.DakGravity = self.DakShellGravity
							shell.DakMass = self.DakShellMass
							shell.DakImpactSound = self.DakShellImpactSound
							shell.DakImpactPitch = self.DakShellImpactPitch
							shell.DakGun = self
							shell:SetNWString("FireSound",self.DakFireSound)
							shell:SetNWInt("FirePitch",self.DakFirePitch)
							shell:SetNWInt("Pellets",self.DakLBXPellets)
							shell:Spawn()
							if(self:IsValid()) then
								if(self:GetParent():IsValid()) then
									if(self:GetParent():GetParent():IsValid()) then
										self:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*self.DakShellMass/100 )
									end
								end
							
								if not(self:GetParent():IsValid()) then
									self:GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*self.DakShellMass/100 )
								end
							end
							local effectdata = EffectData()
							effectdata:SetOrigin( shootOrigin )
							effectdata:SetAngles( shootAngles )
							effectdata:SetEntity(self)
							effectdata:SetScale( self.DakShellDamage )
							util.Effect( self.DakFireEffect, effectdata )
							if self.DakShellEnt == "dak_baseshelllight" then
								self:EmitSound( self.DakFireSound, 100, self.DakFirePitch, 1, 1)
							end
							self.timer = CurTime() 
							self:SetNWFloat("Timer",CurTime())
							self.LastFireTime = CurTime()
							local EngineHeat = self.DakEngine.DakHeat
							local EngineHeat = EngineHeat + self.DakHeat
							self.DakEngine.DakHeat = EngineHeat
							if self.DakUseAmmo then
								self.DakEngine[self.DakAmmoUse] = true
								self.DakEngine[self.DakAmmoQueue] = self.DakEngine[self.DakAmmoQueue]+1
							end

							end )
		 				else
							if not self.DakFireSpecialShell then
								shell.DakTrail = self.DakShellTrail
								shell.DakVelocity = self.DakShellVelocity
								shell.DakDamage = self.DakShellDamage
								shell.DakExplosionEffect = self.DakShellExplosionEffect
								shell.DakGravity = self.DakShellGravity
								shell.DakMass = self.DakShellMass
								shell.DakImpactSound = self.DakShellImpactSound
								shell.DakImpactPitch = self.DakShellImpactPitch
								shell.DakInferno = self.DakShellInferno
								shell.DakBurnHeat = self.DakShellBurnHeat
								shell.DakBurnTime = self.DakShellBurnTime
							end

							shell.DakGun = self
							if self.DakIsRAC then
								if self.DakHeat == 0 then
									shell:SetAngles( shootAngles + Angle(math.Rand(-0.25,0.25),math.Rand(-0.25,0.25),math.Rand(-0.25,0.25)) )
								else
									shell:SetAngles( shootAngles + Angle(math.Rand(-0.1,0.1),math.Rand(-0.1,0.1),math.Rand(-0.1,0.1)) )
								end
							end
							shell:SetNWString("FireSound",self.DakFireSound)
							shell:SetNWInt("FirePitch",self.DakFirePitch)
							shell:SetNWInt("Pellets",self.DakLBXPellets)
							shell:Spawn()
							if(self:IsValid()) then
								if(self:GetParent():IsValid()) then
									if(self:GetParent():GetParent():IsValid()) then
										self:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*self.DakShellMass/100 )
									end
								end
							
								if not(self:GetParent():IsValid()) then
									self:GetPhysicsObject():ApplyForceCenter( -self:GetForward()*self.DakShellVelocity*self.DakShellMass/100 )
								end
							end
						end
					end
				end
				local effectdata = EffectData()
				effectdata:SetOrigin( self:GetAttachment( 1 ).Pos )
				effectdata:SetAngles( self:GetAngles() )
				effectdata:SetEntity(self)
				effectdata:SetScale( self.DakShellDamage )
				util.Effect( self.DakFireEffect, effectdata )
				if self.DakShellEnt == "dak_baseshelllight" then
					self:EmitSound( self.DakFireSound, 100, self.DakFirePitch, 1, 1)
				end
				self.timer = CurTime()
				self:SetNWFloat("Timer",CurTime())

				local EngineHeat = self.DakEngine.DakHeat
				local EngineHeat = EngineHeat + self.DakHeat
				self.DakEngine.DakHeat = EngineHeat
				if self.DakUseAmmo then
					self.DakEngine[self.DakAmmoUse] = true
					self.DakEngine[self.DakAmmoQueue] = self.DakEngine[self.DakAmmoQueue]+1
				end
			end
		else
			if self.DakIsLBX == false then
				self:SetNWBool("Firing",false)
			end
		end
	end
end

function ENT:DakGunAmmoSwap()
	if self.DakCanSwapAmmo==1 then 
		if( self.AmmoSwap ) then
			if CurTime() > self.LastSwapTime+0.5 then
				self.CurrentAmmoType = self.CurrentAmmoType+1
				if self.CurrentAmmoType>3 then
					self.CurrentAmmoType = 1
				end
				self.LastSwapTime = CurTime()
			end
		else
			self.LastSwapTime = CurTime()-1
		end

		if self.DakIsLBX then
			--Shotgun
			if self.CurrentAmmoType == 1 then
				WireLib.TriggerOutput(self, "AmmoType", "Pellet")
				if self.DakName == "LBX2" or self.DakName == "CLBX2" then
					self.DakAmmoType = "LBX2Ammo"
					self.DakAmmoUse = "LBX2AmmoUse"
					self.DakAmmoQueue = "LBX2AmmoUseQueue"
					self.DakShellEnt = "dak_lbxpellet"
					self.DakLBXPellets = 2
					self.DakShellVelocity = 45000
					self.DakShellMass = 15
				end
				if self.DakName == "LBX5" or self.DakName == "CLBX5" then
					self.DakAmmoType = "LBX5Ammo"
					self.DakAmmoUse = "LBX5AmmoUse"
					self.DakAmmoQueue = "LBX5AmmoUseQueue"
					self.DakShellEnt = "dak_lbxpellet"
					self.DakLBXPellets = 5
					self.DakShellVelocity = 45000
					self.DakShellMass = 15
				end
				if self.DakName == "LBX10" or self.DakName == "CLBX10" then
					self.DakAmmoType = "LBX10Ammo"
					self.DakAmmoUse = "LBX10AmmoUse"
					self.DakAmmoQueue = "LBX10AmmoUseQueue"
					self.DakShellEnt = "dak_lbxpellet"
					self.DakLBXPellets = 10
					self.DakShellVelocity = 45000
					self.DakShellMass = 15
				end
				if self.DakName == "LBX20" or self.DakName == "CLBX20" then
					self.DakAmmoType = "LBX20Ammo"
					self.DakAmmoUse = "LBX20AmmoUse"
					self.DakAmmoQueue = "LBX20AmmoUseQueue"
					self.DakShellEnt = "dak_lbxpellet"
					self.DakLBXPellets = 20
					self.DakShellVelocity = 45000
					self.DakShellMass = 15
				end
			end
			--Prox
			if self.CurrentAmmoType == 2 then
				WireLib.TriggerOutput(self, "AmmoType", "Anti-Air")
				if self.DakName == "LBX2" or self.DakName == "CLBX2" then
					self.DakAmmoType = "AALBX2Ammo"
					self.DakAmmoUse = "AALBX2AmmoUse"
					self.DakAmmoQueue = "AALBX2AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_lbx2prox"
					self.DakLBXPellets = 1
					self.DakShellVelocity = 45000
					self.DakShellMass = 20
				end
				if self.DakName == "LBX5" or self.DakName == "CLBX5" then
					self.DakAmmoType = "AALBX5Ammo"
					self.DakAmmoUse = "AALBX5AmmoUse"
					self.DakAmmoQueue = "AALBX5AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_lbx5prox"
					self.DakLBXPellets = 1
					self.DakShellVelocity = 40000
					self.DakShellMass = 50
				end
				if self.DakName == "LBX10" or self.DakName == "CLBX10" then
					self.DakAmmoType = "AALBX10Ammo"
					self.DakAmmoUse = "AALBX10AmmoUse"
					self.DakAmmoQueue = "AALBX10AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_lbx10prox"
					self.DakLBXPellets = 1
					self.DakShellVelocity = 35000
					self.DakShellMass = 100
				end
				if self.DakName == "LBX20" or self.DakName == "CLBX20" then
					self.DakAmmoType = "AALBX20Ammo"
					self.DakAmmoUse = "AALBX20AmmoUse"
					self.DakAmmoQueue = "AALBX20AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_lbx20prox"
					self.DakLBXPellets = 1
					self.DakShellVelocity = 30000
					self.DakShellMass = 200
				end
			end
			--Slug
			if self.CurrentAmmoType == 3 then
				WireLib.TriggerOutput(self, "AmmoType", "Slug")
				if self.DakName == "LBX2" or self.DakName == "CLBX2" then
					self.DakAmmoType = "SLBX2Ammo"
					self.DakAmmoUse = "SLBX2AmmoUse"
					self.DakAmmoQueue = "SLBX2AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 35000
					self.DakShellDamage = 2
					self.DakShellExplosionEffect = "daksmallballisticexplosion"
					self.DakShellMass = 20
					self.DakLBXPellets = 1
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
				if self.DakName == "LBX5" or self.DakName == "CLBX5" then
					self.DakAmmoType = "SLBX5Ammo"
					self.DakAmmoUse = "SLBX5AmmoUse"
					self.DakAmmoQueue = "SLBX5AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 30000
					self.DakShellDamage = 5
					self.DakShellExplosionEffect = "dakballisticexplosion"
					self.DakShellMass = 50
					self.DakLBXPellets = 1
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
				if self.DakName == "LBX10" or self.DakName == "CLBX10" then
					self.DakAmmoType = "SLBX10Ammo"
					self.DakAmmoUse = "SLBX10AmmoUse"
					self.DakAmmoQueue = "SLBX10AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 25000
					self.DakShellDamage = 10
					self.DakShellExplosionEffect = "dakmediumballisticexplosion"
					self.DakShellMass = 100
					self.DakLBXPellets = 1
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
				if self.DakName == "LBX20" or self.DakName == "CLBX20" then
					self.DakAmmoType = "SLBX20Ammo"
					self.DakAmmoUse = "SLBX20AmmoUse"
					self.DakAmmoQueue = "SLBX20AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 20000
					self.DakShellDamage = 20
					self.DakShellExplosionEffect = "daklargeballisticexplosion"
					self.DakShellMass = 200
					self.DakLBXPellets = 1
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
			end
		else
			--standard
			if self.CurrentAmmoType == 1 then
				WireLib.TriggerOutput(self, "AmmoType", "Standard")
				if self.DakName == "AC2" or self.DakName == "Armored AC2" then
					self.DakAmmoType = "AC2Ammo"
					self.DakAmmoUse = "AC2AmmoUse"
					self.DakAmmoQueue = "AC2AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 40000
					self.DakShellDamage = 2
					self.DakShellTrail = "dakshelltrail"
					self.DakShellExplosionEffect = "daksmallballisticexplosion"
					self.DakShellMass = 20
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
				if self.DakName == "AC5" or self.DakName == "Armored AC5" then
					self.DakAmmoType = "AC5Ammo"
					self.DakAmmoUse = "AC5AmmoUse"
					self.DakAmmoQueue = "AC5AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 35000
					self.DakShellDamage = 5
					self.DakShellTrail = "dakshelltrail"
					self.DakShellExplosionEffect = "dakballisticexplosion"
					self.DakShellMass = 50
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
				if self.DakName == "AC10" or self.DakName == "Armored AC10" then
					self.DakAmmoType = "AC10Ammo"
					self.DakAmmoUse = "AC10AmmoUse"
					self.DakAmmoQueue = "AC10AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 30000
					self.DakShellDamage = 10
					self.DakShellTrail = "dakshelltrail"
					self.DakShellExplosionEffect = "dakmediumballisticexplosion"
					self.DakShellMass = 100
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
				if self.DakName == "AC20" or self.DakName == "Armored AC20" then
					self.DakAmmoType = "AC20Ammo"
					self.DakAmmoUse = "AC20AmmoUse"
					self.DakAmmoQueue = "AC20AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 25000
					self.DakShellDamage = 20
					self.DakShellTrail = "dakshelltrail"
					self.DakShellExplosionEffect = "daklargeballisticexplosion"
					self.DakShellMass = 200
					self.DakShellInferno = 0
					self.DakShellBurnHeat = 0
					self.DakShellBurnTime = 0
				end
			end
			--Flak
			if self.CurrentAmmoType == 2 then
				WireLib.TriggerOutput(self, "AmmoType", "Flak")
				if self.DakName == "AC2" or self.DakName == "Armored AC2" then
					self.DakAmmoType = "FAC2Ammo"
					self.DakAmmoUse = "FAC2AmmoUse"
					self.DakAmmoQueue = "FAC2AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_ac2prox"
					self.DakShellVelocity = 45000
					self.DakShellMass = 20
				end
				if self.DakName == "AC5" or self.DakName == "Armored AC5" then
					self.DakAmmoType = "FAC5Ammo"
					self.DakAmmoUse = "FAC5AmmoUse"
					self.DakAmmoQueue = "FAC5AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_ac5prox"
					self.DakShellVelocity = 40000
					self.DakShellMass = 50
				end
				if self.DakName == "AC10" or self.DakName == "Armored AC10" then
					self.DakAmmoType = "FAC10Ammo"
					self.DakAmmoUse = "FAC10AmmoUse"
					self.DakAmmoQueue = "FAC10AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_ac10prox"
					self.DakShellVelocity = 35000
					self.DakShellMass = 100
				end
				if self.DakName == "AC20" or self.DakName == "Armored AC20" then
					self.DakAmmoType = "FAC20Ammo"
					self.DakAmmoUse = "FAC20AmmoUse"
					self.DakAmmoQueue = "FAC20AmmoUseQueue"
					self.DakFireSpecialShell = true
					self.DakShellEnt = "dak_ac20prox"
					self.DakShellVelocity = 30000
					self.DakShellMass = 200
				end
			end
			--Inferno
			if self.CurrentAmmoType == 3 then
				WireLib.TriggerOutput(self, "AmmoType", "Inferno")
				if self.DakName == "AC2" or self.DakName == "Armored AC2" then
					self.DakAmmoType = "IAC2Ammo"
					self.DakAmmoUse = "IAC2AmmoUse"
					self.DakAmmoQueue = "IAC2AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 40000
					self.DakShellDamage = 1
					self.DakShellTrail = "dakfireshelltrail"
					self.DakShellExplosionEffect = "daksmallballisticfireexplosion"
					self.DakShellMass = 10
					self.DakShellInferno = 1
					self.DakShellBurnHeat = 0.24
					self.DakShellBurnTime = 3
				end
				if self.DakName == "AC5" or self.DakName == "Armored AC5" then
					self.DakAmmoType = "IAC5Ammo"
					self.DakAmmoUse = "IAC5AmmoUse"
					self.DakAmmoQueue = "IAC5AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 35000
					self.DakShellDamage = 2.5
					self.DakShellTrail = "dakfireshelltrail"
					self.DakShellExplosionEffect = "dakballisticfireexplosion"
					self.DakShellMass = 25
					self.DakShellInferno = 1
					self.DakShellBurnHeat = 0.6
					self.DakShellBurnTime = 3
				end
				if self.DakName == "AC10" or self.DakName == "Armored AC10" then
					self.DakAmmoType = "IAC10Ammo"
					self.DakAmmoUse = "IAC10AmmoUse"
					self.DakAmmoQueue = "IAC10AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 30000
					self.DakShellDamage = 5
					self.DakShellTrail = "dakfireshelltrail"
					self.DakShellExplosionEffect = "dakmediumballisticfireexplosion"
					self.DakShellMass = 50
					self.DakShellInferno = 1
					self.DakShellBurnHeat = 1.2
					self.DakShellBurnTime = 3
				end
				if self.DakName == "AC20" or self.DakName == "Armored AC20" then
					self.DakAmmoType = "IAC20Ammo"
					self.DakAmmoUse = "IAC20AmmoUse"
					self.DakAmmoQueue = "IAC20AmmoUseQueue"
					self.DakFireSpecialShell = false
					self.DakShellEnt = "dak_baseshell"
					self.DakShellVelocity = 25000
					self.DakShellDamage = 10
					self.DakShellTrail = "dakfireshelltrail"
					self.DakShellExplosionEffect = "daklargeballisticfireexplosion"
					self.DakShellMass = 100
					self.DakShellInferno = 1
					self.DakShellBurnHeat = 2.4
					self.DakShellBurnTime = 3
				end
			end
		end
	end
	WireLib.TriggerOutput(self, "Ammo", self.DakEngine[self.DakAmmoType])
end

function ENT:TriggerInput(iname, value)
	self.Held = value
	if IsValid(self.DakEngine) then
		if (iname == "Fire") then
			if value>0 then
				self:DakFire()
				self.Firing = value > 0
				timer.Create( "RefireTimer"..self:EntIndex(), self.DakCooldown/10, 1, function()
					self:TriggerInput("Fire", value)
				end)
			else
				timer.Remove( "RefireTimer"..self:EntIndex() )
			end
		end
		if (iname == "SwapAmmo") then
			if(value) then
			self.AmmoSwap = value > 0
			self:DakGunAmmoSwap()
			end
		end
	end
end

function ENT:PreEntityCopy()

	local info = {}
	local entids = {}

	info.EngineID = self.DakEngine:EntIndex()
	info.DakName = self.DakName
	info.DakCooldown = self.DakCooldown
	info.DakHeat = self.DakHeat
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
	info.DakAmmo = self.DakAmmo
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakUseAmmo = self.DakUseAmmo
	info.DakAmmoType = self.DakAmmoType
	info.DakAmmoUse = self.DakAmmoUse
	info.DakAmmoQueue = self.DakAmmoQueue
	info.DakFireEffect = self.DakFireEffect
	info.DakFireSound = self.DakFireSound
	info.DakFirePitch = self.DakFirePitch
	info.DakFireSpecialShell = self.DakFireSpecialShell
	info.DakShellEnt = self.DakShellEnt
	info.DakIsLBX = self.DakIsLBX
	info.DakLBXPellets = self.DakLBXPellets
	info.DakIsExplosive = self.DakIsExplosive
	info.DakIsRAC = self.DakIsRAC
	info.DakIsUAC = self.DakIsUAC
	info.DakOwner = self.DakOwner
	info.DakColor = self:GetColor()
        --shell definition
	info.DakShellTrail = self.DakShellTrail
	info.DakShellVelocity = self.DakShellVelocity
	info.DakShellDamage = self.DakShellDamage
	info.DakShellExplosionEffect = self.DakShellExplosionEffect
	info.DakShellGravity = self.DakShellGravity
	info.DakShellMass = self.DakShellMass
	info.DakShellImpactSound = self.DakShellImpactSound
	info.DakShellImpactPitch = self.DakShellImpactPitch
	--Materials
	info.DakMat0 = self:GetSubMaterial(0)
	info.DakMat1 = self:GetSubMaterial(1)


	duplicator.StoreEntityModifier( self, "DakTek", info )

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then
		local Eng = CreatedEntities[ Ent.EntityMods.DakTek.EngineID ]
		if Eng and IsValid(Eng) then
			self.DakEngine = Eng
		end
		self.DakName = Ent.EntityMods.DakTek.DakName
		self.DakCooldown = Ent.EntityMods.DakTek.DakCooldown
		self.DakHeat = Ent.EntityMods.DakTek.DakHeat
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakAmmo = Ent.EntityMods.DakTek.DakAmmo
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakUseAmmo = Ent.EntityMods.DakTek.DakUseAmmo
		self.DakAmmoType = Ent.EntityMods.DakTek.DakAmmoType
		self.DakAmmoUse = Ent.EntityMods.DakTek.DakAmmoUse
		self.DakAmmoQueue = Ent.EntityMods.DakTek.DakAmmoQueue
		self.DakFireEffect = Ent.EntityMods.DakTek.DakFireEffect
		self.DakFireSound = Ent.EntityMods.DakTek.DakFireSound
		self.DakFirePitch = Ent.EntityMods.DakTek.DakFirePitch
		self.DakFireSpecialShell = Ent.EntityMods.DakTek.DakFireSpecialShell
		self.DakShellEnt = Ent.EntityMods.DakTek.DakShellEnt
		self.DakIsLBX = Ent.EntityMods.DakTek.DakIsLBX
		self.DakLBXPellets = Ent.EntityMods.DakTek.DakLBXPellets
		self.DakIsExplosive = Ent.EntityMods.DakTek.DakIsExplosive
		self.DakIsUAC = Ent.EntityMods.DakTek.DakIsUAC
		self.DakIsRAC = Ent.EntityMods.DakTek.DakIsRAC
		self.DakOwner = Player
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

        --shell definition
		self.DakShellTrail = Ent.EntityMods.DakTek.DakShellTrail
		self.DakShellVelocity = Ent.EntityMods.DakTek.DakShellVelocity
		self.DakShellDamage = Ent.EntityMods.DakTek.DakShellDamage
		self.DakShellExplosionEffect = Ent.EntityMods.DakTek.DakShellExplosionEffect
		self.DakShellGravity = Ent.EntityMods.DakTek.DakShellGravity
		self.DakShellMass = Ent.EntityMods.DakTek.DakShellMass
		self.DakShellImpactSound = Ent.EntityMods.DakTek.DakShellImpactSound
		self.DakShellImpactPitch = Ent.EntityMods.DakTek.DakShellImpactPitch

		if not(Ent.EntityMods.DakTek.DakMat1==nil) then
			self:SetSubMaterial( 0, Ent.EntityMods.DakTek.DakMat0 )
			self:SetSubMaterial( 1, Ent.EntityMods.DakTek.DakMat1 )
		end

		self:PhysicsDestroy()
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:Activate()

		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function CheckClip(Ent, HitPos)
	if not (Ent:GetClass() == "prop_physics") or (Ent.ClipData == nil) then return false end
	
	local HitClip = false
	local normal
	local origin
	for i=1, #Ent.ClipData do
		normal = Ent:LocalToWorldAngles(Ent.ClipData[i]["n"]):Forward()
		origin = Ent:LocalToWorld(Ent.ClipData[i]["n"]:Forward()*Ent.ClipData[i]["d"])
		HitClip = HitClip or normal:Dot((origin - HitPos):GetNormalized()) > 0.25
		if HitClip then return true end
	end
	return HitClip
end

function DTekShellHit(Start,End,HitEnt,Shell,Normal)
	if HitEnt:IsValid() and HitEnt:GetPhysicsObject():IsValid() and not(HitEnt:IsPlayer()) and not(HitEnt:IsNPC()) and not(HitEnt:GetClass()=="dak_bot") then
		if (CheckClip(HitEnt,End)) then
			if HitEnt.DakHealth == nil then
				DakTekSetupNewEnt(HitEnt)
			end
			Shell.Filter[#Shell.Filter+1] = HitEnt
			DTekShellContinue(Start,Shell,Normal)
		else
			if HitEnt.DakHealth == nil then
				DakTekSetupNewEnt(HitEnt)
			end
			if HitEnt.DakName == "Damaged Component" then
				if Shell.HitScrap==nil then
					HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
				end
				Shell.HitScrap = 1
				Shell.Filter[#Shell.Filter+1] = HitEnt
				DTekShellContinue(Start,Shell,Normal)
			end
			if HitEnt.DakHealth>0 then
				Shell.RemoveDamage = HitEnt.DakHealth
			else
				Shell.RemoveDamage = 0
			end
			HitEnt.DakLastDamagePos = End
			if HitEnt.DakHealth < Shell.DakDamage then
				if not(HitEnt.SPPOwner==nil) and not(HitEnt==nil) and not(HitEnt.SPPOwner:IsWorld()) then			
					if HitEnt.SPPOwner:HasGodMode()==false and HitEnt.DakIsTread == nil and HitEnt.DakName ~= "Damaged Component" then	
						if Shell.DakGun.DakIsEnergy then
							if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						else
							if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						end
					end
				else
					if Shell.DakGun.DakIsEnergy then
						if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					else
						if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					end
				end
				if(HitEnt:IsValid() and HitEnt:GetClass()~="dak_bot" and HitEnt:GetClass()~="prop_ragdoll") then
					if(HitEnt:GetParent():IsValid()) then
						if(HitEnt:GetParent():GetParent():IsValid()) then
							local Div = Vector(HitEnt:GetParent():GetParent():OBBMaxs().x/75,HitEnt:GetParent():GetParent():OBBMaxs().y/75,HitEnt:GetParent():GetParent():OBBMaxs().z/75)
							HitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetParent():GetParent():GetPhysicsObject():GetMass(),HitEnt:GetParent():GetParent():GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
						end
					end
					if not(HitEnt:GetParent():IsValid()) then
						local Div = Vector(HitEnt:OBBMaxs().x/75,HitEnt:OBBMaxs().y/75,HitEnt:OBBMaxs().z/75)
						HitEnt:GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetPhysicsObject():GetMass(),HitEnt:GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
					end
				end
				Shell.Pos = End
				Shell.DakDamage = Shell.DakDamage - Shell.RemoveDamage
				Shell.Filter[#Shell.Filter+1] = HitEnt
				DTekShellContinue(Start,Shell,Normal)
			else
				if not(HitEnt.SPPOwner==nil) and not(HitEnt==nil) and not(HitEnt.SPPOwner:IsWorld()) then			
					if HitEnt.SPPOwner:HasGodMode()==false and HitEnt.DakIsTread == nil and HitEnt.DakName ~= "Damaged Component" then	
						if Shell.DakGun.DakIsEnergy then
							if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						else
							if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						end
					end
				else
					if Shell.DakGun.DakIsEnergy then
						if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					else
						if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					end
				end
				if(HitEnt:IsValid() and HitEnt:GetClass()~="dak_bot" and HitEnt:GetClass()~="prop_ragdoll") then
					if(HitEnt:GetParent():IsValid()) then
						if(HitEnt:GetParent():GetParent():IsValid()) then
							local Div = Vector(HitEnt:GetParent():GetParent():OBBMaxs().x/75,HitEnt:GetParent():GetParent():OBBMaxs().y/75,HitEnt:GetParent():GetParent():OBBMaxs().z/75)
							HitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetParent():GetParent():GetPhysicsObject():GetMass(),HitEnt:GetParent():GetParent():GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
						end
					end
					if not(HitEnt:GetParent():IsValid()) then
						local Div = Vector(HitEnt:OBBMaxs().x/75,HitEnt:OBBMaxs().y/75,HitEnt:OBBMaxs().z/75)
						HitEnt:GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetPhysicsObject():GetMass(),HitEnt:GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
					end
				end
				--print( math.deg(math.acos(Normal:Dot( -Vel:GetNormalized() ))) ) -- hit angle
				local effectdata = EffectData()
				effectdata:SetOrigin(End)
				effectdata:SetEntity(Shell.DakGun)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(.5)
				effectdata:SetScale(200)
				util.Effect("lbxexplosion", effectdata)
				sound.Play( "dak/ballisticimpact.wav", End, 80, 120, 1 )
				Shell.DakVelocity = Shell.DakVelocity*0
				Shell.Ang = (End-Start):Angle()
				Shell.Pos = End
				Shell.DakDamage = 0
			end
			if HitEnt.DakHealth <= 0 and HitEnt.DakPooled==0 then
				local salvage = ents.Create( "dak_tesalvage" )
				salvage.DakModel = HitEnt:GetModel()
				salvage:SetPos( HitEnt:GetPos())
				salvage:SetAngles( HitEnt:GetAngles())
				salvage:Spawn()
				HitEnt:Remove()
			end
		end
	end
	if HitEnt:IsValid() then
		if HitEnt:IsPlayer() or HitEnt:IsNPC() or HitEnt:GetClass() == "dak_bot" then
				if HitEnt:GetClass() == "dak_bot" then
					HitEnt:SetHealth(HitEnt:Health() - Shell.DakDamage*500)
					if HitEnt:Health() <= 0 and HitEnt.revenge==0 then
						local body = ents.Create( "prop_ragdoll" )
						body:SetPos( HitEnt:GetPos() )
						body:SetModel( HitEnt:GetModel() )
						body:Spawn()
						body.DakHealth=1000000
						body.DakMaxHealth=1000000
						if Shell.DakIsFlame == 1 then
							body:Ignite(10,1)
						end
						HitEnt:Remove()
						local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
						body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
						timer.Simple( 5, function()
							body:Remove()
						end )
					end
				else
				local Pain = DamageInfo()
				Pain:SetDamageForce( Shell.Ang:Forward()*Shell.DakDamage*Shell.DakMass*Shell.DakVelocity )
				Pain:SetDamage( Shell.DakDamage*500 )
				Pain:SetAttacker( Shell.DakGun.DakOwner )
				Pain:SetInflictor( Shell.DakGun )
				Pain:SetReportedPosition( End )
				Pain:SetDamagePosition( HitEnt:GetPos() )
				Pain:SetDamageType(DMG_CRUSH)
				HitEnt:TakeDamageInfo( Pain )
			end
			if HitEnt:Health() <= 0 and not(Shell.DakIsFlame == 1) then
				Shell.Filter[#Shell.Filter+1] = HitEnt
				DTekShellContinue(Start,Shell,Normal)
			else
				local effectdata = EffectData()
				effectdata:SetOrigin(End)
				effectdata:SetEntity(Shell.DakGun)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(.5)
				effectdata:SetScale(200)
				util.Effect("lbxexplosion", effectdata)
				sound.Play( "dak/ballisticimpact.wav", End, 80, 120, 1 )	
				Shell.DakDamage = 0
			end
		end
	end
	if HitEnt:IsWorld() or Shell.ExplodeNow==true then
		local effectdata = EffectData()
		effectdata:SetOrigin(End)
		effectdata:SetEntity(Shell.DakGun)
		effectdata:SetAttachment(1)
		effectdata:SetMagnitude(.5)
		effectdata:SetScale(200)
		util.Effect("lbxexplosion", effectdata)
		sound.Play( "dak/ballisticimpact.wav", End, 80, 120, 1 )
		Shell.RemoveNow = 1
	end	
	if Shell.DakDamage <= 0 then
		Shell.Spent=1
		Shell.DieTime = CurTime()
	end
end

function DTekShellContinue(Start,Shell,Normal)
	local newtrace = {}
		newtrace.start = Shell.Pos
		newtrace.endpos = Shell.Pos + (Shell.Ang:Forward()*Shell.DakVelocity*0.1) + (Shell.Gravity*0.1)
		newtrace.filter = Shell.Filter
		newtrace.mins = Vector(-1,-1,-1)
		newtrace.maxs = Vector(1,1,1)
	local ContShellTrace = util.TraceHull( newtrace )

	local HitEnt = ContShellTrace.Entity
	local End = ContShellTrace.HitPos

	local effectdata = EffectData()
	effectdata:SetStart(ContShellTrace.StartPos)
	effectdata:SetOrigin(ContShellTrace.HitPos)
	effectdata:SetScale((Shell.DakDamage*2))
	util.Effect("dakballistictracer", effectdata)


	if HitEnt:IsValid() and HitEnt:GetPhysicsObject():IsValid() and not(HitEnt:IsPlayer()) and not(HitEnt:IsNPC()) and not(HitEnt:GetClass()=="dak_bot") then
		if (CheckClip(HitEnt,End)) then
			if HitEnt.DakHealth == nil then
				DakTekSetupNewEnt(HitEnt)
			end
			Shell.Filter[#Shell.Filter+1] = HitEnt
			DTekShellContinue(Start,Shell,Normal)
		else
			if HitEnt.DakHealth == nil then
				DakTekSetupNewEnt(HitEnt)
			end
			if HitEnt.DakName == "Damaged Component" then
				if Shell.HitScrap==nil then
					HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
				end
				Shell.HitScrap = 1
				Shell.Filter[#Shell.Filter+1] = HitEnt
				DTekShellContinue(Start,Shell,Normal)
			end
			if HitEnt.DakHealth>0 then
				Shell.RemoveDamage = HitEnt.DakHealth
			else
				Shell.RemoveDamage = 0
			end
			HitEnt.DakLastDamagePos = End
			if HitEnt.DakHealth < Shell.DakDamage then
				if not(HitEnt.SPPOwner==nil) and not(HitEnt==nil) and not(HitEnt.SPPOwner:IsWorld()) then			
					if HitEnt.SPPOwner:HasGodMode()==false and HitEnt.DakIsTread == nil and HitEnt.DakName ~= "Damaged Component" then	
						if Shell.DakGun.DakIsEnergy then
							if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						else
							if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						end
					end
				else
					if Shell.DakGun.DakIsEnergy then
						if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					else
						if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					end
				end
				if(HitEnt:IsValid() and HitEnt:GetClass()~="dak_bot" and HitEnt:GetClass()~="prop_ragdoll") then
					if(HitEnt:GetParent():IsValid()) then
						if(HitEnt:GetParent():GetParent():IsValid()) then
							local Div = Vector(HitEnt:GetParent():GetParent():OBBMaxs().x/75,HitEnt:GetParent():GetParent():OBBMaxs().y/75,HitEnt:GetParent():GetParent():OBBMaxs().z/75)
							HitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetParent():GetParent():GetPhysicsObject():GetMass(),HitEnt:GetParent():GetParent():GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
						end
					end
					if not(HitEnt:GetParent():IsValid()) then
						local Div = Vector(HitEnt:OBBMaxs().x/75,HitEnt:OBBMaxs().y/75,HitEnt:OBBMaxs().z/75)
						HitEnt:GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetPhysicsObject():GetMass(),HitEnt:GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
					end
				end
				Shell.Pos = End
				Shell.DakDamage = Shell.DakDamage - Shell.RemoveDamage
				Shell.Filter[#Shell.Filter+1] = HitEnt
				DTekShellContinue(Start,Shell,Normal)
			else
				if not(HitEnt.SPPOwner==nil) and not(HitEnt==nil) and not(HitEnt.SPPOwner:IsWorld()) then			
					if HitEnt.SPPOwner:HasGodMode()==false and HitEnt.DakIsTread == nil and HitEnt.DakName ~= "Damaged Component" then	
						if Shell.DakGun.DakIsEnergy then
							if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						else
							if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							else
								local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
								HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
								if not(HitEnt.DakRed == nil) then 
									HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
								end
							end
						end
					end
				else
					if Shell.DakGun.DakIsEnergy then
						if (HitEnt.DakName == "Reflective Armor")or(HitEnt.DakName == "Heavy Reflective Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					else
						if (HitEnt.DakName == "Reactive Armor")or(HitEnt.DakName == "Heavy Reactive Armor")or(HitEnt.DakName == "Reactive Reflective Armor")or(HitEnt.DakName == "Heavy Reactive Reflective Armor") then
							local HPPerc = (HitEnt.DakHealth-(Shell.DakDamage*0.5))/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-(Shell.DakDamage*0.5)
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						else
							local HPPerc = (HitEnt.DakHealth-Shell.DakDamage)/HitEnt.DakMaxHealth
							HitEnt.DakHealth = HitEnt.DakHealth-Shell.DakDamage
							if not(HitEnt.DakRed == nil) then 
								HitEnt:SetColor(Color(HitEnt.DakRed*HPPerc,HitEnt.DakGreen*HPPerc,HitEnt.DakBlue*HPPerc,HitEnt:GetColor().a))
							end
						end
					end
				end
				if(HitEnt:IsValid() and HitEnt:GetClass()~="dak_bot" and HitEnt:GetClass()~="prop_ragdoll") then
					if(HitEnt:GetParent():IsValid()) then
						if(HitEnt:GetParent():GetParent():IsValid()) then
							local Div = Vector(HitEnt:GetParent():GetParent():OBBMaxs().x/75,HitEnt:GetParent():GetParent():OBBMaxs().y/75,HitEnt:GetParent():GetParent():OBBMaxs().z/75)
							HitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetParent():GetParent():GetPhysicsObject():GetMass(),HitEnt:GetParent():GetParent():GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
						end
					end
					if not(HitEnt:GetParent():IsValid()) then
						local Div = Vector(HitEnt:OBBMaxs().x/75,HitEnt:OBBMaxs().y/75,HitEnt:OBBMaxs().z/75)
						HitEnt:GetPhysicsObject():ApplyForceOffset( Div*(Shell.DakVelocity*Shell.DakMass/50000)*HitEnt:GetPhysicsObject():GetMass(),HitEnt:GetPos()+HitEnt:WorldToLocal(End):GetNormalized() )
					end
				end
				--print( math.deg(math.acos(Normal:Dot( -Vel:GetNormalized() ))) ) -- hit angle
				local effectdata = EffectData()
				effectdata:SetOrigin(End)
				effectdata:SetEntity(Shell.DakGun)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(.5)
				effectdata:SetScale(200)
				util.Effect("lbxexplosion", effectdata)
				sound.Play( "dak/ballisticimpact.wav", End, 80, 120, 1 )
				Shell.DakVelocity = Shell.DakVelocity*0
				Shell.Ang = (End-Start):Angle()
				Shell.Pos = End
				Shell.DakDamage = 0
			end
			if HitEnt.DakHealth <= 0 and HitEnt.DakPooled==0 then
				local salvage = ents.Create( "dak_tesalvage" )
				salvage.DakModel = HitEnt:GetModel()
				salvage:SetPos( HitEnt:GetPos())
				salvage:SetAngles( HitEnt:GetAngles())
				salvage:Spawn()
				HitEnt:Remove()
			end
		end
	end
	if HitEnt:IsValid() then
		if HitEnt:IsPlayer() or HitEnt:IsNPC() or HitEnt:GetClass() == "dak_bot" then
				if HitEnt:GetClass() == "dak_bot" then
					HitEnt:SetHealth(HitEnt:Health() - Shell.DakDamage*500)
					if HitEnt:Health() <= 0 and HitEnt.revenge==0 then
						local body = ents.Create( "prop_ragdoll" )
						body:SetPos( HitEnt:GetPos() )
						body:SetModel( HitEnt:GetModel() )
						body:Spawn()
						body.DakHealth=1000000
						body.DakMaxHealth=1000000
						if Shell.DakIsFlame == 1 then
							body:Ignite(10,1)
						end
						HitEnt:Remove()
						local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
						body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
						timer.Simple( 5, function()
							body:Remove()
						end )
					end
				else
				local Pain = DamageInfo()
				Pain:SetDamageForce( Shell.Ang:Forward()*Shell.DakDamage*Shell.DakMass*Shell.DakVelocity )
				Pain:SetDamage( Shell.DakDamage*500 )
				Pain:SetAttacker( Shell.DakGun.DakOwner )
				Pain:SetInflictor( Shell.DakGun )
				Pain:SetReportedPosition( End )
				Pain:SetDamagePosition( HitEnt:GetPos() )
				Pain:SetDamageType(DMG_CRUSH)
				HitEnt:TakeDamageInfo( Pain )
			end
			if HitEnt:Health() <= 0 and not(Shell.DakIsFlame == 1) then
				Shell.Filter[#Shell.Filter+1] = HitEnt
				DTekShellContinue(Start,Shell,Normal)
			else
				local effectdata = EffectData()
				effectdata:SetOrigin(End)
				effectdata:SetEntity(Shell.DakGun)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(.5)
				effectdata:SetScale(200)
				util.Effect("lbxexplosion", effectdata)
				sound.Play( "dak/ballisticimpact.wav", End, 80, 120, 1 )	
				Shell.DakDamage = 0
			end
		end
	end
	if HitEnt:IsWorld() or Shell.ExplodeNow==true then
		local effectdata = EffectData()
		effectdata:SetOrigin(End)
		effectdata:SetEntity(Shell.DakGun)
		effectdata:SetAttachment(1)
		effectdata:SetMagnitude(.5)
		effectdata:SetScale(200)
		util.Effect("lbxexplosion", effectdata)
		sound.Play( "dak/ballisticimpact.wav", End, 80, 120, 1 )
		Shell.RemoveNow = 1
	end	
	if Shell.DakDamage <= 0 then
		Shell.Spent=1
		Shell.DieTime = CurTime()
	end
end