AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakOwner = NULL
ENT.DakName = "Base Launcher"
ENT.DakCooldown = 1
ENT.DakHeat = 1
ENT.DakMaxHealth = 1
ENT.DakHealth = 1
ENT.DakAmmo = 0
ENT.DakMass = 1
ENT.DakEngine = NULL
ENT.DakModel = "models/dak/6ac.mdl"
ENT.DakAmmoType = "AC2Ammo"
ENT.DakAmmoUse = "AC2AmmoUse"
ENT.DakAmmoQueue = "AC2AmmoUseQueue"
ENT.DakFireSound = "dak/AC5.wav"
ENT.DakMissileType = "dak_lrm"
ENT.DakCanSetTarget = false
ENT.DakOutputTarget = false
ENT.DakVolleySize = 1
ENT.DakFireOffset = 0
ENT.DakPooled=0
ENT.CanSwapAmmo = 0
ENT.CurrentAmmoType = 1
ENT.IsMRM = 0
ENT.Armored = 0

function ENT:Initialize()

	self:SetModel( self.DakModel )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self.timer = CurTime()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.Inputs = Wire_CreateInputs(self, { "Fire" , "Target [ENTITY]", "SwapAmmo" })
	self.Outputs = WireLib.CreateOutputs( self, { "Cooldown" , "CooldownPercent", "Target [ENTITY]" ,"Ammo", "AmmoType [STRING]"} )
 	self.Held = false
 	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.SlowThinkTime = CurTime()
 	self.LastFireTime = CurTime()
 	self.LastSwapTime = CurTime()
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
	--ATM
		if self.DakName == "ATM3 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 3
			self.DakMaxHealth = 15
			self.DakMass = 1500
			--self.DakModel = "models/dak/lrm5.mdl"
			self.DakFireSound = "dak/SRM.wav"
			--self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 3
			self.DakFireOffset = 0
			self.CanSwapAmmo = 1
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		if self.DakName == "ATM6 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 5
			self.DakMaxHealth = 35
			self.DakMass = 3500
			--self.DakModel = "models/dak/lrm5.mdl"
			self.DakFireSound = "dak/SRM.wav"
			--self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 6
			self.DakFireOffset = 9
			self.CanSwapAmmo = 1
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		if self.DakName == "ATM9 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 7
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/lrm5.mdl"
			self.DakFireSound = "dak/SRM.wav"
			--self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 9
			self.DakFireOffset = 18
			self.CanSwapAmmo = 1
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		if self.DakName == "ATM12 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 9
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/lrm5.mdl"
			self.DakFireSound = "dak/SRM.wav"
			--self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 12
			self.DakFireOffset = 9
			self.CanSwapAmmo = 1
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
	--LRM
		if self.DakName == "CLRM5 Launcher" then
			self.DakCooldown = 4.5
			self.DakHeat = 4
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/lrm5.mdl"
			self.DakAmmoType = "LRM5Ammo"
			self.DakAmmoUse = "LRM5AmmoUse"
			self.DakAmmoQueue = "LRM5AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 5
			self.DakFireOffset = 0
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		if self.DakName == "CLRM10 Launcher" then
			self.DakCooldown = 4.5
			self.DakHeat = 6
			self.DakMaxHealth = 25
			self.DakMass = 2500
			--self.DakModel = "models/dak/lrm10.mdl"
			self.DakAmmoType = "LRM10Ammo"
			self.DakAmmoUse = "LRM10AmmoUse"
			self.DakAmmoQueue = "LRM10AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 10
			self.DakFireOffset = 9
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		if self.DakName == "CLRM15 Launcher" then
			self.DakCooldown = 4.5
			self.DakHeat = 8
			self.DakMaxHealth = 35
			self.DakMass = 3500
			--self.DakModel = "models/dak/lrm15.mdl"
			self.DakAmmoType = "LRM15Ammo"
			self.DakAmmoUse = "LRM15AmmoUse"
			self.DakAmmoQueue = "LRM15AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 15
			self.DakFireOffset = 18
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		if self.DakName == "CLRM20 Launcher" then
			self.DakCooldown = 4.5
			self.DakHeat = 8
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/lrm20.mdl"
			self.DakAmmoType = "LRM20Ammo"
			self.DakAmmoUse = "LRM20AmmoUse"
			self.DakAmmoQueue = "LRM20AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 20
			self.DakFireOffset = 9
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		--SRM
		if self.DakName == "CSRM2 Launcher" then
			self.DakCooldown = 6
			self.DakHeat = 4
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/srm2.mdl"
			self.DakAmmoType = "SRM2Ammo"
			self.DakAmmoUse = "SRM2AmmoUse"
			self.DakAmmoQueue = "SRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 2
			self.DakFireOffset = 0
			self.DakSpread = 3.0
			self.DakIsArty = false
		end
		if self.DakName == "CSRM4 Launcher" then
			self.DakCooldown = 6
			self.DakHeat = 6
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/srm4.mdl"
			self.DakAmmoType = "SRM4Ammo"
			self.DakAmmoUse = "SRM4AmmoUse"
			self.DakAmmoQueue = "SRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 4
			self.DakFireOffset = 6
			self.DakSpread = 3.0
			self.DakIsArty = false
		end		
		if self.DakName == "CSRM6 Launcher" then
			self.DakCooldown = 6
			self.DakHeat = 8
			self.DakMaxHealth = 15
			self.DakMass = 1500
			--self.DakModel = "models/dak/srm6.mdl"
			self.DakAmmoType = "SRM6Ammo"
			self.DakAmmoUse = "SRM6AmmoUse"
			self.DakAmmoQueue = "SRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 6
			self.DakFireOffset = 12
			self.DakSpread = 3.0
			self.DakIsArty = false
		end	
		--SSRM
		if self.DakName == "CSSRM2 Launcher" then
			self.DakCooldown = 6
			self.DakHeat = 4
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/srm2.mdl"
			self.DakAmmoType = "SSRM2Ammo"
			self.DakAmmoUse = "SSRM2AmmoUse"
			self.DakAmmoQueue = "SSRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 2
			self.DakFireOffset = 0
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		if self.DakName == "CSSRM4 Launcher" then
			self.DakCooldown = 6
			self.DakHeat = 6
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/srm4.mdl"
			self.DakAmmoType = "SSRM4Ammo"
			self.DakAmmoUse = "SSRM4AmmoUse"
			self.DakAmmoQueue = "SSRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 4
			self.DakFireOffset = 6
			self.DakSpread = 2.5
			self.DakIsArty = false
		end		
		if self.DakName == "CSSRM6 Launcher" then
			self.DakCooldown = 6
			self.DakHeat = 8
			self.DakMaxHealth = 30
			self.DakMass = 3000
			--self.DakModel = "models/dak/srm6.mdl"
			self.DakAmmoType = "SSRM6Ammo"
			self.DakAmmoUse = "SSRM6AmmoUse"
			self.DakAmmoQueue = "SSRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 6
			self.DakFireOffset = 12
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		--NARC
		if self.DakName == "C-NARC Launcher" then
			self.DakCooldown = 5
			self.DakHeat = 0
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/srm2.mdl"
			self.DakAmmoType = "NARCAmmo"
			self.DakAmmoUse = "NARCAmmoUse"
			self.DakAmmoQueue = "NARCAmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_narc"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
			self.DakSpread = 0
			self.DakIsArty = false
		end
	--IS--
	if self.DakName == "LRM5 Launcher" then
			self.DakCooldown = 3
			self.DakHeat = 2
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/lrm5.mdl"
			self.DakAmmoType = "LRM5Ammo"
			self.DakAmmoUse = "LRM5AmmoUse"
			self.DakAmmoQueue = "LRM5AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 5
			self.DakFireOffset = 0
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		if self.DakName == "LRM10 Launcher" then
			self.DakCooldown = 3
			self.DakHeat = 3
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/lrm10.mdl"
			self.DakAmmoType = "LRM10Ammo"
			self.DakAmmoUse = "LRM10AmmoUse"
			self.DakAmmoQueue = "LRM10AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 10
			self.DakFireOffset = 9
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		if self.DakName == "LRM15 Launcher" then
			self.DakCooldown = 3
			self.DakHeat = 4
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/lrm15.mdl"
			self.DakAmmoType = "LRM15Ammo"
			self.DakAmmoUse = "LRM15AmmoUse"
			self.DakAmmoQueue = "LRM15AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 15
			self.DakFireOffset = 18
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		if self.DakName == "LRM20 Launcher" then
			self.DakCooldown = 3
			self.DakHeat = 4
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/lrm20.mdl"
			self.DakAmmoType = "LRM20Ammo"
			self.DakAmmoUse = "LRM20AmmoUse"
			self.DakAmmoQueue = "LRM20AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 20
			self.DakFireOffset = 9
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		--SRM
		if self.DakName == "SRM2 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 2
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/srm2.mdl"
			self.DakAmmoType = "SRM2Ammo"
			self.DakAmmoUse = "SRM2AmmoUse"
			self.DakAmmoQueue = "SRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 2
			self.DakFireOffset = 0
			self.DakSpread = 3.0
			self.DakIsArty = false
		end
		if self.DakName == "SRM4 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 3
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/srm4.mdl"
			self.DakAmmoType = "SRM4Ammo"
			self.DakAmmoUse = "SRM4AmmoUse"
			self.DakAmmoQueue = "SRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 4
			self.DakFireOffset = 6
			self.DakSpread = 3.0
			self.DakIsArty = false
		end		
		if self.DakName == "SRM6 Launcher" then
			self.DakCooldown = 4
			self.DakHeat = 4
			self.DakMaxHealth = 30
			self.DakMass = 3000
			--self.DakModel = "models/dak/srm6.mdl"
			self.DakAmmoType = "SRM6Ammo"
			self.DakAmmoUse = "SRM6AmmoUse"
			self.DakAmmoQueue = "SRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 6
			self.DakFireOffset = 12
			self.DakSpread = 3.0
			self.DakIsArty = false
		end	
		--SSRM
		if self.DakName == "SSRM2 Launcher" then
			self.DakCooldown = 5
			self.DakHeat = 2
			self.DakMaxHealth = 15
			self.DakMass = 1500
			--self.DakModel = "models/dak/srm2.mdl"
			self.DakAmmoType = "SSRM2Ammo"
			self.DakAmmoUse = "SSRM2AmmoUse"
			self.DakAmmoQueue = "SSRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 2
			self.DakFireOffset = 0
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		if self.DakName == "SSRM4 Launcher" then
			self.DakCooldown = 5
			self.DakHeat = 3
			self.DakMaxHealth = 30
			self.DakMass = 3000
			--self.DakModel = "models/dak/srm4.mdl"
			self.DakAmmoType = "SSRM4Ammo"
			self.DakAmmoUse = "SSRM4AmmoUse"
			self.DakAmmoQueue = "SSRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 4
			self.DakFireOffset = 6
			self.DakSpread = 2.5
			self.DakIsArty = false
		end		
		if self.DakName == "SSRM6 Launcher" then
			self.DakCooldown = 5
			self.DakHeat = 4
			self.DakMaxHealth = 45
			self.DakMass = 4500
			--self.DakModel = "models/dak/srm6.mdl"
			self.DakAmmoType = "SSRM6Ammo"
			self.DakAmmoUse = "SSRM6AmmoUse"
			self.DakAmmoQueue = "SSRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 6
			self.DakFireOffset = 12
			self.DakSpread = 2.5
			self.DakIsArty = false
		end
		--ARROWIV
		if self.DakName == "Arrow IV Launcher" then
			self.DakCooldown = 7.5
			self.DakHeat = 15
			self.DakMaxHealth = 150
			self.DakMass = 15000
			--self.DakModel = "models/dak/arrow.mdl"
			self.DakAmmoType = "ArrowAmmo"
			self.DakAmmoUse = "ArrowAmmoUse"
			self.DakAmmoQueue = "ArrowAmmoUseQueue"
			self.DakFireSound = "dak/Arrow.wav"
			self.DakMissileType = "dak_Arrow"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 5
			self.DakFireOffset = 10.8
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		--Fixes typo'd arrows
		if self.DakName == "Arrov IV Launcher" then
			self.DakName = "Arrow IV Launcher"
			self.DakCooldown = 7.5
			self.DakHeat = 15
			self.DakMaxHealth = 150
			self.DakMass = 15000
			--self.DakModel = "models/dak/arrow.mdl"
			self.DakAmmoType = "ArrowAmmo"
			self.DakAmmoUse = "ArrowAmmoUse"
			self.DakAmmoQueue = "ArrowAmmoUseQueue"
			self.DakFireSound = "dak/Arrow.wav"
			self.DakMissileType = "dak_Arrow"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 5
			self.DakFireOffset = 10.8
			self.DakSpread = 2.5
			self.DakIsArty = true
		end
		--NARC
		if self.DakName == "NARC Launcher" then
			self.DakCooldown = 2.5
			self.DakHeat = 0
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/srm2.mdl"
			self.DakAmmoType = "NARCAmmo"
			self.DakAmmoUse = "NARCAmmoUse"
			self.DakAmmoQueue = "NARCAmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_isnarc"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
			self.DakSpread = 0
			self.DakIsArty = false
		end
		if self.DakName == "MRM10 Launcher" then
			self.DakCooldown = 3.2
			self.DakHeat = 3.2
			self.DakMaxHealth = 30
			self.DakMass = 3000
			--self.DakModel = "models/dak/lrm10.mdl"
			self.DakAmmoType = "MRM10Ammo"
			self.DakAmmoUse = "MRM10AmmoUse"
			self.DakAmmoQueue = "MRM10AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 10
			self.DakFireOffset = 0
			self.IsMRM = 1
			self.DakSpread = 1.5
			self.DakIsArty = false
		end
		if self.DakName == "MRM20 Launcher" then
			self.DakCooldown = 3.2
			self.DakHeat = 4.8
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/lrm10.mdl"
			self.DakAmmoType = "MRM20Ammo"
			self.DakAmmoUse = "MRM20AmmoUse"
			self.DakAmmoQueue = "MRM20AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 20
			self.DakFireOffset = 9
			self.IsMRM = 1
			self.DakSpread = 1.5
			self.DakIsArty = false
		end
		if self.DakName == "MRM30 Launcher" then
			self.DakCooldown = 3.2
			self.DakHeat = 8
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/lrm15.mdl"
			self.DakAmmoType = "MRM30Ammo"
			self.DakAmmoUse = "MRM30AmmoUse"
			self.DakAmmoQueue = "MRM30AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 30
			self.DakFireOffset = 18
			self.IsMRM = 1
			self.DakSpread = 1.5
			self.DakIsArty = false
		end
		if self.DakName == "MRM40 Launcher" then
			self.DakCooldown = 3.2
			self.DakHeat = 9.6
			self.DakMaxHealth = 120
			self.DakMass = 12000
			--self.DakModel = "models/dak/lrm20.mdl"
			self.DakAmmoType = "MRM40Ammo"
			self.DakAmmoUse = "MRM40AmmoUse"
			self.DakAmmoQueue = "MRM40AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 40
			self.DakFireOffset = 9
			self.IsMRM = 1
			self.DakSpread = 1.5
			self.DakIsArty = false
		end

	if not(self:GetModel() == self.DakModel) then
	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	end
	
	if IsValid(self.DakEngine) then
		if self.DakEngine.DumbfireFins==1 then
	 		self.DakSpread = self.DakSpread*0.4
	 	end
	 	if self.DakEngine.MissileLoader==1 then
	 		self.DakCooldown = self.DakCooldown*0.8
	 	end
	 	if self.DakEngine.MissileExhaustVenting==1 then
	 		self.DakHeat = self.DakHeat*0.9
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

	self:DakAmmoSwap()
	--self:DakMissileFire()

	local Attachment = self:GetAttachment( 1 )
	local shootOrigin = Attachment.Pos
	local shootAngles = self:GetAngles()
	local shootDir = shootAngles:Forward()

	local trace = {}
	trace.start = shootOrigin
	trace.endpos = shootOrigin + (shootDir * 999999999)
	--if self.Filters == nil then
	if IsValid(self.DakEngine) then
		self.Filters = table.Copy(self.DakEngine.Contraption)
	else
		self.Filters = {}
	end
	if self.Filters then
		table.insert(self.Filters,self)
		trace.filter = self.Filters
	else
		trace.filter = {}
	end
	
	--end
	local trace = util.TraceEntity( trace, self )
	if self.DakCanSetTarget and self.DakIsArty then
		self:TriggerInputTarget("Target", self.Target)
		if (self.Inputs.Target.Value) == NULL then
			if not(trace.Entity:GetClass() == "dak_ssrm") and not(trace.Entity:GetClass() == "dak_srm") and not(trace.Entity:GetClass() == "dak_lrm") and not(trace.Entity:GetClass() == "dak_arrow") and not(trace.Entity:GetClass() == "dak_mrm") and not(trace.Entity:GetClass() == "dak_atmhe") and not(trace.Entity:GetClass() == "dak_atms") and not(trace.Entity:GetClass() == "dak_atmer") then
				self.Target = trace.Entity
			end
		else
			self.Target = self.Inputs.Target.Value
		end
	else
		self.Target = trace.Entity
	end
	if self.DakOutputTarget then
		WireLib.TriggerOutput(self, "Target", self.Target)
	end
	self.TargetPos = trace.HitPos

	WireLib.TriggerOutput(self, "Cooldown", math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100))
	WireLib.TriggerOutput(self, "CooldownPercent", 100*(math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100)/self.DakCooldown))
	self:NextThink( CurTime()+0.33 )
	return true
end

function ENT:DakAmmoSwap()
	if self.CanSwapAmmo==1 then 
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
		if self.CurrentAmmoType == 1 then
			self.DakMissileType = "dak_atmhe"
			WireLib.TriggerOutput(self, "AmmoType", "High Explosive")
			if self.DakName == "ATM3 Launcher" then
				self.DakAmmoType = "ATM3HEAmmo"
				self.DakAmmoUse = "ATM3HEAmmoUse"
				self.DakAmmoQueue = "ATM3HEAmmoUseQueue"
			end
			if self.DakName == "ATM6 Launcher" then
				self.DakAmmoType = "ATM6HEAmmo"
				self.DakAmmoUse = "ATM6HEAmmoUse"
				self.DakAmmoQueue = "ATM6HEAmmoUseQueue"
			end
			if self.DakName == "ATM9 Launcher" then
				self.DakAmmoType = "ATM9HEAmmo"
				self.DakAmmoUse = "ATM9HEAmmoUse"
				self.DakAmmoQueue = "ATM9HEAmmoUseQueue"
			end
			if self.DakName == "ATM12 Launcher" then
				self.DakAmmoType = "ATM12HEAmmo"
				self.DakAmmoUse = "ATM12HEAmmoUse"
				self.DakAmmoQueue = "ATM12HEAmmoUseQueue"
			end
		end
		if self.CurrentAmmoType == 2 then
			self.DakMissileType = "dak_atms"
			WireLib.TriggerOutput(self, "AmmoType", "Standard")
			if self.DakName == "ATM3 Launcher" then
				self.DakAmmoType = "ATM3SAmmo"
				self.DakAmmoUse = "ATM3SAmmoUse"
				self.DakAmmoQueue = "ATM3SAmmoUseQueue"
			end
			if self.DakName == "ATM6 Launcher" then
				self.DakAmmoType = "ATM6SAmmo"
				self.DakAmmoUse = "ATM6SAmmoUse"
				self.DakAmmoQueue = "ATM6SAmmoUseQueue"
			end
			if self.DakName == "ATM9 Launcher" then
				self.DakAmmoType = "ATM9SAmmo"
				self.DakAmmoUse = "ATM9SAmmoUse"
				self.DakAmmoQueue = "ATM9SAmmoUseQueue"
			end
			if self.DakName == "ATM12 Launcher" then
				self.DakAmmoType = "ATM12SAmmo"
				self.DakAmmoUse = "ATM12SAmmoUse"
				self.DakAmmoQueue = "ATM12SAmmoUseQueue"
			end
		end
		if self.CurrentAmmoType == 3 then
			self.DakMissileType = "dak_atmer"
			WireLib.TriggerOutput(self, "AmmoType", "Extended Range")
			if self.DakName == "ATM3 Launcher" then
				self.DakAmmoType = "ATM3ERAmmo"
				self.DakAmmoUse = "ATM3ERAmmoUse"
				self.DakAmmoQueue = "ATM3ERAmmoUseQueue"
			end
			if self.DakName == "ATM6 Launcher" then
				self.DakAmmoType = "ATM6ERAmmo"
				self.DakAmmoUse = "ATM6ERAmmoUse"
				self.DakAmmoQueue = "ATM6ERAmmoUseQueue"
			end
			if self.DakName == "ATM9 Launcher" then
				self.DakAmmoType = "ATM9ERAmmo"
				self.DakAmmoUse = "ATM9ERAmmoUse"
				self.DakAmmoQueue = "ATM9ERAmmoUseQueue"
			end
			if self.DakName == "ATM12 Launcher" then
				self.DakAmmoType = "ATM12ERAmmo"
				self.DakAmmoUse = "ATM12ERAmmoUse"
				self.DakAmmoQueue = "ATM12ERAmmoUseQueue"
			end
		end
	end
	WireLib.TriggerOutput(self, "Ammo", self.DakEngine[self.DakAmmoType])
end

function ENT:DakMissileFire()
	if IsValid(self.DakEngine) then

		if self.DakEngine.DakHeat >= self.DakEngine.DakMaxHeat then
			self.Firing = false
		end
		if self.DakEngine[self.DakAmmoType] == 0 then
			self.Firing = false
		end

		if( self.Firing ) then
			local Attachment = self:GetAttachment( 1 )
			local shootOrigin = Attachment.Pos
			local shootAngles = self:GetAngles()
			local shootDir = shootAngles:Forward()

			if CurTime() > (self.timer + self.DakCooldown) then
				--FIREBULLETHERE
				self.LastFireTime = CurTime()
				ShellList = {}
				local shell = ents.Create( self.DakMissileType )
				if ( !IsValid( shell ) ) then return end
 				shell:SetPos( shootOrigin + ( self:GetForward() * 1 ))
				shell:SetAngles( shootAngles + Angle(math.Rand(-self.DakSpread,self.DakSpread),math.Rand(-self.DakSpread,self.DakSpread),math.Rand(-self.DakSpread,self.DakSpread)) )
				table.insert(ShellList,table.Count(ShellList)+1,shell)
 				shell.DakGun = self
 				if self.DakOutputTarget then
 				shell.DakTarget = self.Target
 				shell.DakTargetPos = Attachment.Pos+self:GetForward()*99999999--Attachment.Pos:Distance(trace.HitPos)
 				else
 				shell.DakTargetPos = Attachment.Pos+self:GetForward()*99999999
 				end
				shell.DakFireTime = CurTime()
				shell:SetNWString("FireSound",self.DakFireSound)
				shell:SetNWInt("FirePitch",75+math.random(-10,10))
				shell:Spawn()
				local effectdata1 = EffectData()
				effectdata1:SetOrigin( shootOrigin + ( self:GetForward() * 1 ) )
				effectdata1:SetAngles( shootAngles )
				effectdata1:SetEntity(self)
				effectdata1:SetScale( 0.5 )
				util.Effect( "daksmallballisticfire", effectdata1 )
				--self:EmitSound( self.DakFireSound, 100, 75+math.random(-10,10), 0.5, 6)

				if self.DakVolleySize>1 then
					if self.IsMRM == 1 then
						timer.Create( "RippleTimer"..self:EntIndex(), 0.025, self.DakVolleySize-1, function() local Attachment = self:GetAttachment( 1 )
						local Attachment = self:GetAttachment( 1 )
						local shootOrigin = Attachment.Pos
						local shootAngles = self:GetAngles()
						local shootDir = shootAngles:Forward()
						--FIREBULLETHERE
						self.LastFireTime = CurTime()
						local shell = ents.Create( self.DakMissileType )
						if ( !IsValid( shell ) ) then return end
						local FirePos = shootOrigin + ( self:GetForward() * 1 ) + (self:GetRight()*math.Rand(self:OBBMins().y*0.9,self:OBBMaxs().y*0.9) + self:GetUp()*math.Rand(self:OBBMins().z*0.9,self:OBBMaxs().z*0.9)  )   
		 				local effectdata1 = EffectData()
						effectdata1:SetOrigin( FirePos )
						effectdata1:SetAngles( shootAngles )
						effectdata1:SetEntity(self)
						effectdata1:SetScale( 0.5 )
						util.Effect( "daksmallballisticfire", effectdata1 )
						--self:EmitSound( self.DakFireSound, 100, 75+math.random(-10,10), 0.5, 6)
		 				shell:SetPos(FirePos)
						shell:SetAngles( shootAngles + Angle(math.Rand(-self.DakSpread,self.DakSpread),math.Rand(-self.DakSpread,self.DakSpread),math.Rand(-self.DakSpread,self.DakSpread)) )
						table.insert(ShellList,table.Count(ShellList)+1,shell)
		 				shell.DakGun = self
		 				if self.DakOutputTarget then
		 				shell.DakTarget = self.Target
		 				shell.DakTargetPos = Attachment.Pos+self:GetForward()*99999999--Attachment.Pos:Distance(trace.HitPos)
		 				else
		 				shell.DakTargetPos = Attachment.Pos+self:GetForward()*99999999
		 				end
						shell.DakFireTime = CurTime()
						shell:SetNWString("FireSound",self.DakFireSound)
						shell:SetNWInt("FirePitch",75+math.random(-10,10))
						shell:Spawn()
						end )
					else
						timer.Create( "RippleTimer"..self:EntIndex(), 0.05, self.DakVolleySize-1, function() local Attachment = self:GetAttachment( 1 )
						local Attachment = self:GetAttachment( 1 )
						local shootOrigin = Attachment.Pos
						local shootAngles = self:GetAngles()
						local shootDir = shootAngles:Forward()
						--FIREBULLETHERE
						self.LastFireTime = CurTime()
						local shell = ents.Create( self.DakMissileType )
						if ( !IsValid( shell ) ) then return end
						local FirePos = shootOrigin + ( self:GetForward() * 1 ) + (self:GetRight()*math.Rand(self:OBBMins().y*0.9,self:OBBMaxs().y*0.9) + self:GetUp()*math.Rand(self:OBBMins().z*0.9,self:OBBMaxs().z*0.9)  )   
		 				local effectdata1 = EffectData()
						effectdata1:SetOrigin( FirePos )
						effectdata1:SetAngles( shootAngles )
						effectdata1:SetEntity(self)
						effectdata1:SetScale( 0.5 )
						util.Effect( "daksmallballisticfire", effectdata1 )
						--self:EmitSound( self.DakFireSound, 100, 75+math.random(-10,10), 0.5, 6)
		 				shell:SetPos(FirePos)
						shell:SetAngles( shootAngles + Angle(math.Rand(-self.DakSpread,self.DakSpread),math.Rand(-self.DakSpread,self.DakSpread),math.Rand(-self.DakSpread,self.DakSpread)) )
						table.insert(ShellList,table.Count(ShellList)+1,shell)
		 				shell.DakGun = self
		 				if self.DakOutputTarget then
		 				shell.DakTarget = self.Target
		 				shell.DakTargetPos = Attachment.Pos+self:GetForward()*99999999--Attachment.Pos:Distance(trace.HitPos)
		 				else
		 				shell.DakTargetPos = Attachment.Pos+self:GetForward()*99999999
		 				end
						shell.DakFireTime = CurTime()
						shell:SetNWString("FireSound",self.DakFireSound)
						shell:SetNWInt("FirePitch",75+math.random(-10,10))
						shell:Spawn()
						end )
					end
				end

				
				self.timer = CurTime()
				local EngineHeat = self.DakEngine.DakHeat
				local EngineHeat = EngineHeat + self.DakHeat
				self.DakEngine.DakHeat = EngineHeat
				self.DakEngine[self.DakAmmoUse] = true
				self.DakEngine[self.DakAmmoQueue] = self.DakEngine[self.DakAmmoQueue]+1
			end
		end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "Fire") then
		self.Held = value
	end

	if IsValid(self.DakEngine) then
		if (iname == "Fire") then
			if value>0 then
				self:DakMissileFire()
				self.Firing = value > 0
				timer.Create( "RefireTimer"..self:EntIndex(), self.DakCooldown/10, 1, function()
					self:TriggerInput("Fire", value)
				end)
			else
				timer.Remove( "RefireTimer"..self:EntIndex() )
			end
			self:SetNWBool("Firing",value > 0)
		end

		if (iname == "SwapAmmo") then
			if(value) then
			self.AmmoSwap = value > 0
			self:DakAmmoSwap()
			end
		end
	end
end

function ENT:TriggerInputTarget(iname, value)
	if (iname == "Target") then
		self.Target = value
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
	info.DakAmmoType = self.DakAmmoType
	info.DakAmmoUse = self.DakAmmoUse
	info.DakAmmoQueue = self.DakAmmoQueue
	info.DakFireSound = self.DakFireSound
	info.DakMissileType = self.DakMissileType
	info.DakCanSetTarget = self.DakCanSetTarget
	info.DakOutputTarget = self.DakOutputTarget
	info.DakVolleySize = self.DakVolleySize
	info.DakFireOffset = self.DakFireOffset
	info.DakOwner = self.DakOwner
	info.DakColor = self:GetColor()
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
		self.DakAmmoType = Ent.EntityMods.DakTek.DakAmmoType
		self.DakAmmoUse = Ent.EntityMods.DakTek.DakAmmoUse
		self.DakAmmoQueue = Ent.EntityMods.DakTek.DakAmmoQueue
		self.DakFireSound = Ent.EntityMods.DakTek.DakFireSound
		self.DakMissileType = Ent.EntityMods.DakTek.DakMissileType
		self.DakCanSetTarget = Ent.EntityMods.DakTek.DakCanSetTarget
		self.DakOutputTarget = Ent.EntityMods.DakTek.DakOutputTarget
		self.DakVolleySize = Ent.EntityMods.DakTek.DakVolleySize
		self.DakFireOffset = Ent.EntityMods.DakTek.DakFireOffset
		self.DakOwner = Player
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

		if not(Ent.EntityMods.DakTek.DakMat1==nil) then
			self:SetSubMaterial( 0, Ent.EntityMods.DakTek.DakMat0 )
			self:SetSubMaterial( 1, Ent.EntityMods.DakTek.DakMat1 )
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