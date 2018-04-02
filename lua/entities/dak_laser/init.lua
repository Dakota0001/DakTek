AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakOwner = NULL
ENT.DakName = "Base Laser"
ENT.DakCooldown = 1
ENT.DakHeat = 1
ENT.DakMaxHealth = 1
ENT.DakHealth = 1
ENT.DakMass = 1
ENT.DakEngine = NULL
ENT.DakModel = "models/dak/1laser.mdl"
ENT.DakFireSound = "dak/AC5.wav"
ENT.DakFirePitch = 90
ENT.DakDuration = 1.5
ENT.DakDamage = 4
ENT.DakBeamEffect = "mediumlaserbeam"
ENT.DakBurnEffect = "laserburn"
ENT.DakPooled=0
ENT.Armored = 0

function ENT:Initialize()
	self:SetModel( self.DakModel )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self.timer = CurTime()
	self.durtimer = CurTime()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.Inputs = Wire_CreateInputs(self, { "Fire" })
	self.Outputs = WireLib.CreateOutputs( self, { "Cooldown" , "CooldownPercent" } )
	function self:SetupDataTables()
 		self:NetworkVar("Bool",0,"BeamOn")
 		self:NetworkVar("Float",0,"BeamDist")
 		self:NetworkVar("String",0,"BurnFX")
 		self:NetworkVar("String",0,"BeamFX")
 	end
 	self.DakHealth = self.DakMaxHealth
 	self.Held = false
 	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.LastFireTime = CurTime()
 	self.HitScrap = 0

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
	--CLAN--
		if self.DakName == "C-ER Micro Laser" then
			self.DakCooldown = 1.75
			self.DakHeat = 1.35
			self.DakMaxHealth = 2.5
			self.DakMass = 250
			--self.DakModel = "models/dak/05laser.mdl"
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.5
			self.DakDamage = 1
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
	if self.DakName == "C-ER Small Laser" then
			self.DakCooldown = 1.5
			self.DakHeat = 1.8
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/05laser.mdl"
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 75
			self.DakDuration = 1
			self.DakDamage = 2
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "C-ER Medium Laser" then
			self.DakCooldown = 3
			self.DakHeat = 5.4
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/mediumlaser.wav"
			self.DakFirePitch = 70
			self.DakDuration = 1.5
			self.DakDamage = 7
			self.DakBeamEffect = "mediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "C-ER Large Laser" then
			self.DakCooldown = 3.25
			self.DakHeat = 5.4
			self.DakMaxHealth = 40
			self.DakMass = 4000
			--self.DakModel = "models/dak/4laser.mdl"
			self.DakFireSound = "dak/largelaser.wav"
			self.DakFirePitch = 65
			self.DakDuration = 1.15
			self.DakDamage = 11
			self.DakBeamEffect = "largelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self.DakName == "C-ER Assault Laser" then
			self.DakCooldown = 4
			self.DakHeat = 13.5
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/5laser.mdl"
			self.DakFireSound = "dak/assaultlaser.wav"
			self.DakFirePitch = 60
			self.DakDuration = 1
			self.DakDamage = 20
			self.DakBeamEffect = "assaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--Pulse
		if self.DakName == "C-ER Micro Pulse Laser" then
			self.DakCooldown = 0.75
			self.DakHeat = 1.35
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.25
			self.DakDamage = 1.0
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "C-ER Small Pulse Laser" then
			self.DakCooldown = 0.5
			self.DakHeat = 1.8
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.5
			self.DakDamage = 2
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "C-ER Medium Pulse Laser" then
			self.DakCooldown = 2.5
			self.DakHeat = 3.9
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/2laser.mdl"
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.75
			self.DakDamage = 8
			self.DakBeamEffect = "pulsemediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "C-ER Large Pulse Laser" then
			self.DakCooldown = 3.0
			self.DakHeat = 5.0
			self.DakMaxHealth = 60
			self.DakMass = 6000
			--self.DakModel = "models/dak/6laser.mdl"
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.5
			self.DakDamage = 13
			self.DakBeamEffect = "pulselargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self.DakName == "C-ER Assault Pulse Laser" then
			self.DakCooldown = 3.5
			self.DakHeat = 10
			self.DakMaxHealth = 80
			self.DakMass = 8000
			--self.DakModel = "models/dak/8laser.mdl"
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.5
			self.DakDamage = 25
			self.DakBeamEffect = "pulseassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--Heavy
		if self.DakName == "Heavy Small Laser" then
			self.DakCooldown = 1.5
			self.DakHeat = 4.5
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/05laser.mdl"
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 75
			self.DakDuration = 1
			self.DakDamage = 4
			self.DakBeamEffect = "heavysmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Heavy Medium Laser" then
			self.DakCooldown = 3
			self.DakHeat = 9
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/mediumlaser.wav"
			self.DakFirePitch = 70
			self.DakDuration = 1.5
			self.DakDamage = 11
			self.DakBeamEffect = "heavymediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Heavy Large Laser" then
			self.DakCooldown = 3.25
			self.DakHeat = 9.9
			self.DakMaxHealth = 40
			self.DakMass = 4000
			--self.DakModel = "models/dak/4laser.mdl"
			self.DakFireSound = "dak/largelaser.wav"
			self.DakFirePitch = 65
			self.DakDuration = 1.15
			self.DakDamage = 16
			self.DakBeamEffect = "heavylargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self.DakName == "Heavy Assault Laser" then
			self.DakCooldown = 4
			self.DakHeat = 22.5
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/5laser.mdl"
			self.DakFireSound = "dak/assaultlaser.wav"
			self.DakFirePitch = 60
			self.DakDuration = 1
			self.DakDamage = 30
			self.DakBeamEffect = "heavyassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end

	--IS--
	if self.DakName == "Micro Laser" then
			self.DakCooldown = 0.875
			self.DakHeat = 0.675
			self.DakMaxHealth = 2.5
			self.DakMass = 250
			--self.DakModel = "models/dak/05laser.mdl"
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.25
			self.DakDamage = 0.5
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
	if self.DakName == "Small Laser" then
			self.DakCooldown = 0.75
			self.DakHeat = 0.9
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/05laser.mdl"
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.5
			self.DakDamage = 1
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Medium Laser" then
			self.DakCooldown = 1.5
			self.DakHeat = 2.7
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/mediumlaser.wav"
			self.DakFirePitch = 70
			self.DakDuration = 0.75
			self.DakDamage = 3.5
			self.DakBeamEffect = "mediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Large Laser" then
			self.DakCooldown = 1.625
			self.DakHeat = 2.7
			self.DakMaxHealth = 50
			self.DakMass = 5000
			--self.DakModel = "models/dak/4laser.mdl"
			self.DakFireSound = "dak/largelaser.wav"
			self.DakFirePitch = 65
			self.DakDuration = 0.575
			self.DakDamage = 6.875
			self.DakBeamEffect = "largelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self.DakName == "Assault Laser" then
			self.DakCooldown = 2
			self.DakHeat = 6.75
			self.DakMaxHealth = 60
			self.DakMass = 6000
			--self.DakModel = "models/dak/5laser.mdl"
			self.DakFireSound = "dak/assaultlaser.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.5
			self.DakDamage = 12
			self.DakBeamEffect = "assaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--Pulse
		if self.DakName == "Micro Pulse Laser" then
			self.DakCooldown = 0.375
			self.DakHeat = 0.675
			self.DakMaxHealth = 5
			self.DakMass = 500
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.125
			self.DakDamage = 0.5
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Small Pulse Laser" then
			self.DakCooldown = 0.25
			self.DakHeat = 0.9
			self.DakMaxHealth = 10
			self.DakMass = 1000
			--self.DakModel = "models/dak/1laser.mdl"
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.25
			self.DakDamage = 1.0
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Medium Pulse Laser" then
			self.DakCooldown = 1.25
			self.DakHeat = 1.95
			self.DakMaxHealth = 20
			self.DakMass = 2000
			--self.DakModel = "models/dak/2laser.mdl"
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.375
			self.DakDamage = 4
			self.DakBeamEffect = "pulsemediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self.DakName == "Large Pulse Laser" then
			self.DakCooldown = 1.35
			self.DakHeat = 2.25
			self.DakMaxHealth = 70
			self.DakMass = 7000
			--self.DakModel = "models/dak/6laser.mdl"
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.25
			self.DakDamage = 7.5
			self.DakBeamEffect = "pulselargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self.DakName == "Assault Pulse Laser" then
			self.DakCooldown = 1.9
			self.DakHeat = 5
			self.DakMaxHealth = 100
			self.DakMass = 10000
			--self.DakModel = "models/dak/8laser.mdl"
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.25
			self.DakDamage = 15.625
			self.DakBeamEffect = "pulseassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end

	if not(self:GetModel() == self.DakModel) then
	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	end
	
	if IsValid(self.DakEngine) then
		if self.DakEngine.BeamFocus==1 then
	 		self.DakCooldown = self.DakCooldown*0.9
	 		self.DakDuration = self.DakDuration*0.9
	 	end
	 	if self.DakEngine.LaserInsulation==1 then
	 		self.DakHeat = self.DakHeat*0.75
	 		self.DakMaxHealth = self.DakMaxHealth*0.75
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

	self:SetNWString("BurnFX",self.DakBurnEffect)
 	self:SetNWString("BeamFX",self.DakBeamEffect)
	self:GetPhysicsObject():SetMass(self.DakMass)
	self.damage = self.DakDamage
	
	if CurTime() > (self.timer + self.DakCooldown) then
		self:TriggerInput("Fire", self.Held)
	end
	if IsValid(self.DakEngine) then
	if self.DakEngine.DakHeat >= self.DakEngine.DakMaxHeat then
		self.Firing = false
	end
	if CurTime() > self.durtimer + self.DakDuration  then
		self.Firing = false
	end
	self:SetNWFloat("Duration",(self.DakDuration+self.durtimer))
	if( self.Firing ) then
		--self.lastfire = CurTime()
			--FIREBEAMHERE
			self.LastFireTime = CurTime()
	local Attachment = self:GetAttachment( 1 )
	local shootOrigin = Attachment.Pos
	local shootAngles = self:GetAngles()
	local shootDir = shootAngles:Forward()
	local trace = {}
	trace.start = shootOrigin
	trace.endpos = shootOrigin + (shootDir * 9999999)
	--if self.Filters == nil then
		self.Filters = {}
		table.insert(self.Filters,self)
		if self.DakEngine then
			table.Add(self.Filters,self.DakEngine.Contraption)
		end
	--end
	trace.filter = self.Filters
	trace.mins = Vector(-2.5,-2.5,-2.5)
	trace.maxs = Vector(2.5,2.5,2.5)
	local Hit = util.TraceHull( trace )

	local beamtime = CurTime() - self.timer
	if Hit.Entity:IsValid() and not(Hit.Entity:IsPlayer()) and not(Hit.Entity:IsNPC()) and not((Hit.Entity:GetClass()=="dak_bot" or Hit.Entity:GetClass()=="dak_zombie")) then
		if(self:CheckClip(Hit.Entity,Hit.HitPos)) then
			self.LastHit = Hit.HitPos
			self.LastHitEnt = Hit.Entity
			if Hit.Entity.DakHealth == nil then
				DakTekSetupNewEnt(Hit.Entity)
			end
			self:Damage(Hit.Entity)
		else
			if Hit.Entity.DakHealth == nil then
				DakTekSetupNewEnt(Hit.Entity)
			end
			if Hit.Entity.DakName == "Damaged Component" then
				if self.HitScrap==0 then
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
				end
				self.HitScrap = 1
				self:Damage(Hit.Entity)
			end
			if Hit.Entity.DakHealth>0 then
				self.RemoveDamage = Hit.Entity.DakHealth
			else
				self.RemoveDamage = 0
			end
			if not(Hit.Entity:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate==nil) then
				if not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
					if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
						if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1 and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
							if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
								Hit.Entity.DakHealth = Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration)
								if not(Hit.Entity.DakRed == nil) then
									Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
								end
							else
								local HPPerc = (Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
								Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
								if not(Hit.Entity.DakRed == nil) then
									Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
								end
							end
						end
					end
				end
			else
				if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
					local HPPerc = (Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration)
					if not(Hit.Entity.DakRed == nil) then
						Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
					end
				else
					local HPPerc = (Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
					if not(Hit.Entity.DakRed == nil) then
						Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
					end
				end
			end
			Hit.Entity.DakLastDamagePos = Hit.HitPos
			if Hit.Entity.DakHealth <= 0 then
				self.damage = (self.damage*beamtime/self.DakDuration) - self.RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = Hit.Entity
				if Hit.Entity.DakHealth < 0 then
					self:Damage(Hit.Entity)
				end
			else
				self.damage = (self.damage*beamtime/self.DakDuration) - self.RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = Hit.Entity
			end
			if Hit.Entity.DakHealth <= 0 and Hit.Entity.DakPooled==0 then
				self.salvage = ents.Create( "dak_salvage" )
				self.salvage.DakModel = Hit.Entity:GetModel()
				self.salvage:SetPos( Hit.Entity:GetPos())
				self.salvage:SetAngles( Hit.Entity:GetAngles())
				self.salvage:Spawn()
				Hit.Entity:Remove()
			end
		end
	else
		self.LastHit = Hit.HitPos
		self.LastHitEnt = Hit.Entity
	end

	if self.LastHitEnt:IsValid() then
		if self.LastHitEnt:IsPlayer() or self.LastHitEnt:IsNPC() or (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
			if (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
				self.LastHitEnt:SetHealth(self.LastHitEnt:Health() - (self.damage*beamtime/self.DakDuration)*50 )
				if self.LastHitEnt:Health() <= 0 and self.revenge==0 then
					local body = ents.Create( "prop_ragdoll" )
					body:SetPos( self.LastHitEnt:GetPos() )
					body:SetModel( self.LastHitEnt:GetModel() )
					body:Spawn()
					self.LastHitEnt:Remove()
					local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
					body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
					timer.Simple( 5, function()
						body:Remove()
					end )
				end
			else
				local Pain = DamageInfo()
				Pain:SetDamageForce( self:GetForward()*(self.damage*beamtime/self.DakDuration)*50 )
				Pain:SetDamage( (self.damage*beamtime/self.DakDuration)*55 )
				Pain:SetAttacker( self.DakOwner )
				Pain:SetInflictor( self )
				Pain:SetReportedPosition( self:GetPos() )
				Pain:SetDamagePosition( self.LastHitEnt:GetPhysicsObject():GetMassCenter() )
				Pain:SetDamageType(DMG_DISSOLVE)
				self.LastHitEnt:TakeDamageInfo( Pain )
			end

			--self.LastHitEnt:TakeDamage( (self.damage*beamtime/self.DakDuration)*50, self.DakOwner, self )
			if self.LastHitEnt:Health() <= 0 then
				self:Damage(self.LastHitEnt)
			else
			self.damage = 0
			self.LastHit = Hit.HitPos
			self.LastHitEnt = Hit.Entity
			end
		end
	end

		self.timer = CurTime()
		local EngineHeat = self.DakEngine.DakHeat
		local EngineHeat = EngineHeat + (self.DakHeat*beamtime/self.DakDuration)
		self.DakEngine.DakHeat = EngineHeat
	end
	end
	self:SetNWBool("BeamOn", self.Firing)
	if self.Firing then
		self:SetNWFloat("BeamDist",self.LastHit:Distance(self:GetAttachment( 1 ).Pos))
	end
	if not IsValid(self.DakEngine) then
		self:SetNWBool("BeamOn", false)
	end
	self.HitScrap = 0
	WireLib.TriggerOutput(self, "Cooldown", math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100))
	WireLib.TriggerOutput(self, "CooldownPercent", 100*(math.Clamp((self.LastFireTime+self.DakCooldown)-CurTime(),0,100)/self.DakCooldown))
	if self.Firing then
		self:NextThink(self.timer + self.DakDuration/10)
	else
		self:NextThink(CurTime()+0.33)
	end
	return true
end

function ENT:Damage(oldhit)
	local Attachment = self:GetAttachment( 1 )
	local shootOrigin = Attachment.Pos
	local shootAngles = self:GetAngles()
	local shootDir = shootAngles:Forward()
	local trace = {}
	trace.start = shootOrigin
	trace.endpos = shootOrigin + (shootDir * 9999999)
	table.insert(self.Filters,oldhit)
	trace.filter = self.Filters
	trace.mins = Vector(-2.5,-2.5,-2.5)
	trace.maxs = Vector(2.5,2.5,2.5)
	local Hit = util.TraceHull( trace )

	local beamtime = CurTime() - self.timer
	if Hit.Entity:IsValid() and not(Hit.Entity:IsPlayer()) and not(Hit.Entity:IsNPC()) and not((Hit.Entity:GetClass()=="dak_bot" or Hit.Entity:GetClass()=="dak_zombie")) then
		if ((self:CheckClip(Hit.Entity,Hit.HitPos)) and (self.LastHit:Distance(Hit.HitPos) > 20)) then
			self.LastHit = Hit.HitPos
			self.LastHitEnt = Hit.Entity
			if Hit.Entity.DakHealth == nil then
				DakTekSetupNewEnt(Hit.Entity)
			end
			self:Damage(Hit.Entity)
		else
			if Hit.Entity.DakHealth == nil then
				DakTekSetupNewEnt(Hit.Entity)
			end
			if Hit.Entity.DakName == "Damaged Component" then
				if self.HitScrap==0 then
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
				end
				self.HitScrap = 1
				self:Damage(Hit.Entity)
			end
			if Hit.Entity.DakHealth>0 then
				self.RemoveDamage = Hit.Entity.DakHealth
			else
				self.RemoveDamage = 0
			end
			if not(Hit.Entity:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate==nil) then
				if not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
					if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
						if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1 and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
							if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
								local HPPerc = (Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
								Hit.Entity.DakHealth = Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration)
								if not(Hit.Entity.DakRed == nil) then
									Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
								end
							else
								local HPPerc = (Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
								Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
								if not(Hit.Entity.DakRed == nil) then
									Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
								end
							end
						end
					end
				end
			else
				if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
					local HPPerc = (Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(0.5*self.damage*beamtime/self.DakDuration)
					if not(Hit.Entity.DakRed == nil) then
						Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
					end
				else
					local HPPerc = (Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration))/Hit.Entity.DakMaxHealth
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
					if not(Hit.Entity.DakRed == nil) then
						Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
					end
				end
			end
			Hit.Entity.DakLastDamagePos = Hit.HitPos
			if Hit.Entity.DakHealth <= 0 then
				self.damage = (self.damage*beamtime/self.DakDuration) - self.RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = Hit.Entity
				if Hit.Entity.DakHealth < 0 then
					self:Damage(Hit.Entity)
				end
			else
				self.damage = (self.damage*beamtime/self.DakDuration) - self.RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = Hit.Entity
			end
			if Hit.Entity.DakHealth <= 0 and Hit.Entity.DakPooled==0 then
				self.salvage = ents.Create( "dak_salvage" )
				self.salvage.DakModel = Hit.Entity:GetModel()
				self.salvage:SetPos( Hit.Entity:GetPos())
				self.salvage:SetAngles( Hit.Entity:GetAngles())
				self.salvage:Spawn()
				Hit.Entity:Remove()
			end
		end
	else
		self.LastHit = Hit.HitPos
		self.LastHitEnt = Hit.Entity
	end

	if self.LastHitEnt:IsValid() then
		if self.LastHitEnt:IsPlayer() or self.LastHitEnt:IsNPC() or (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
			if (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
				self.LastHitEnt:SetHealth(self.LastHitEnt:Health() - (self.damage*beamtime/self.DakDuration)*50 )
				if self.LastHitEnt:Health() <= 0 and self.revenge==0 then
					local body = ents.Create( "prop_ragdoll" )
					body:SetPos( self.LastHitEnt:GetPos() )
					body:SetModel( self.LastHitEnt:GetModel() )
					body:Spawn()
					self.LastHitEnt:Remove()
					local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
					body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
					timer.Simple( 5, function()
						body:Remove()
					end )
				end
			else
				local Pain = DamageInfo()
				Pain:SetDamageForce( self:GetForward()*(self.damage*beamtime/self.DakDuration)*50 )
				Pain:SetDamage( (self.damage*beamtime/self.DakDuration)*55 )
				Pain:SetAttacker( self.DakOwner )
				Pain:SetInflictor( self )
				Pain:SetReportedPosition( self:GetPos() )
				Pain:SetDamagePosition( self.LastHitEnt:GetPhysicsObject():GetMassCenter() )
				Pain:SetDamageType(DMG_DISSOLVE)
				self.LastHitEnt:TakeDamageInfo( Pain )
			end

			--self.LastHitEnt:TakeDamage( (self.damage*beamtime/self.DakDuration)*50, self.DakOwner, self )
			if self.LastHitEnt:Health() <= 0 then
				self:Damage(self.LastHitEnt)
			else
			self.damage = 0
			self.LastHit = Hit.HitPos
			self.LastHitEnt = Hit.Entity
			end
		end
	end


end


function ENT:CheckClip(Ent, HitPos)
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
function ENT:TriggerInput(iname, value)

	self.Held = value

	if IsValid(self.DakEngine) then
		if self.DakEngine.DakHeat < self.DakEngine.DakMaxHeat then
			if CurTime() > (self.timer + self.DakCooldown) then
				if (iname == "Fire") then
					if(value) then
					if(value >= 1) then
					self.Firing = value > 0
					self.durtimer = CurTime()
					self.timer = CurTime()
					self:EmitSound( self.DakFireSound, 100, self.DakFirePitch, 1, 6)
					end
				end
				end
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
	info.DakDuration = self.DakDuration
	info.DakDamage = self.DakDamage
	info.DakBeamEffect = self.DakBeamEffect
	info.DakBurnEffect = self.DakBurnEffect
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakFireSound = self.DakFireSound
	info.DakFirePitch = self.DakFirePitch
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
		self.DakDuration = Ent.EntityMods.DakTek.DakDuration
		self.DakDamage = Ent.EntityMods.DakTek.DakDamage
		self.DakBeamEffect = Ent.EntityMods.DakTek.DakBeamEffect
		self.DakBurnEffect = Ent.EntityMods.DakTek.DakBurnEffect
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakFireSound = Ent.EntityMods.DakTek.DakFireSound
		self.DakFirePitch = Ent.EntityMods.DakTek.DakFirePitch
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