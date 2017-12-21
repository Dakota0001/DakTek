AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakOwner = NULL
ENT.DakName = "Laser AMS"
ENT.DakCooldown = 0
ENT.DakHeat = 1
ENT.DakMaxHealth = 5
ENT.DakHealth = 5
ENT.DakMass = 1
ENT.DakEngine = NULL
ENT.DakModel = "models/dak/lams.mdl"
ENT.DakFireSound = "dak/AC5.wav"
ENT.DakFirePitch = 90
ENT.DakDuration = 1.5
ENT.DakDamage = 4
ENT.DakBeamEffect = "mediumlaserbeam"
ENT.DakBurnEffect = "laserburn"
ENT.DakPooled=0

function ENT:Initialize()

	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self.timer = CurTime()
	self.lastfire = CurTime()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.Inputs = Wire_CreateInputs(self, { "Fire" })
	self.Outputs = WireLib.CreateOutputs( self, { "Cooldown" } )
	WireLib.TriggerOutput(self, "Cooldown", self.DakCooldown)
	function self:SetupDataTables()
 		self:NetworkVar("Bool",0,"BeamOn")
 		self:NetworkVar("String",0,"BurnFX")
 		self:NetworkVar("String",0,"BeamFX")
 		self:NetworkVar("Entity",0,"Target")
 	end
 	self:SetNWString("BurnFX",self.DakBurnEffect)
 	self:SetNWString("BeamFX",self.DakBeamEffect)
 	self.DakHealth = self.DakMaxHealth
 	self.Held = false
 	self.lastsoundplay = CurTime()
 	self.lasttargettime = CurTime()
 	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
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
		if self.DakName == "Laser AMS" then
			self.DakCooldown = 0
			self.DakHeat = 1
			self.DakMaxHealth = 5
			self.DakMass = 500
			self.DakModel = "models/dak/lams.mdl"
			self.DakFireSound = "dak/xpulsesmall.wav"
			self.DakFirePitch = 100
			self.DakDuration = 1
			self.DakDamage = 10
			self.DakBeamEffect = "lamsbeam"
			self.DakBurnEffect = "laserburn"
		end

	if not self:GetModel() == self.DakModel then
	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	end

	if IsValid(self.DakEngine) then
	 	if self.DakEngine.EfficientLAMS==1 then
	 		self.DakHeat = self.DakHeat*0.5
	 	end
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
	if( self.Firing ) then
		self.lastfire = CurTime()
			--FIREBEAMHERE

	self.Targets = ents.FindInSphere( self:GetPos(), 2000 )
	if self.lasttargettime + 0.2 < CurTime() then
		if self.DakEngine.DakHeat < self.DakEngine.DakMaxHeat then
			for k, v in pairs(self.Targets) do
				local Class = v:GetClass()
				if Class=="dak_lrm" or Class=="dak_srm" or Class=="dak_ssrm" or Class=="dak_arrow" or Class=="dak_mrm" or Class=="dak_atmhe" or Class=="dak_atmm" or Class=="dak_atmer" then
					if not(v.DakGun.DakOwner == self.DakOwner) then
						if v.ShotDown == nil then
							self.Target = v
							print(v.ShotDown)
							v.ShotDown = true
							self:SetNWEntity("Target",v)
							self.lasttargettime = CurTime()
							timer.Create( "MissileKillTimer"..self:EntIndex(), 0.05, 1, function()
								self.Target.DakHealth=0
								local effectdata = EffectData()
								effectdata:SetOrigin(self.Target:GetPos())
								effectdata:SetEntity(self.Target)
								effectdata:SetAttachment(1)
								effectdata:SetMagnitude(.5)
								effectdata:SetScale(200)
								util.Effect("dakmediumballisticexplosion", effectdata)
								self.Target:Remove()
								local EngineHeat = self.DakEngine.DakHeat
								local EngineHeat = EngineHeat + self.DakHeat
								self.DakEngine.DakHeat = EngineHeat
							end)
							break
						end
					end
				end
			end
		end
	end
	if IsValid(self.Target) then
		local Attachment = self:GetAttachment( 1 )
		local shootOrigin = Attachment.Pos
		local shootAngles = self:GetAngles()
		local shootDir = shootAngles:Forward()
		local trace = {}
		trace.start = shootOrigin
		trace.endpos = self.Target:GetPos()
		--if self.Filters == nil then
			self.Filters = {}
			table.insert(self.Filters,self)
			table.insert(self.Filters,oldhit)
			if self.DakEngine then
				table.Add(self.Filters,self.DakEngine.Contraption)
			end
		--end

	trace.filter = self.Filters
	local Hit = util.TraceLine( trace )
	if Hit.Entity:IsValid() then
		if Hit.Entity:GetClass() == self:GetClass() then
			Hit.Entity =  NULL
		end 
	end

	local beamtime = CurTime() - self.timer
	if Hit.Entity:IsValid() and not Hit.Entity:IsPlayer() and not Hit.Entity:IsNPC() and not Hit.Entity:GetClass()=="dak_bot" then
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
			local RemoveDamage = Hit.Entity.DakHealth
			if not(Hit.Entity:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate==nil) then
				if not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
					if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
						if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1 and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
							Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
						end
					end
				end
			end

			if self.Target.DakHealth <= 0 then
				self.damage = (self.damage*beamtime/self.DakDuration) - RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = self.Target
				if Hit.Entity.DakHealth < 0 then
					self:Damage(Hit.Entity)
				end
			else
				self.damage = (self.damage*beamtime/self.DakDuration) - RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = self.Target
			end
		end
	else
		self.LastHit = Hit.HitPos
		self.LastHitEnt = Hit.Entity
	end

	if self.LastHitEnt:IsValid() then
		if self.LastHitEnt:IsPlayer() or self.LastHitEnt:IsNPC() or self.LastHitEnt:GetClass() == "dak_bot" then
			if self.LastHitEnt:GetClass() == "dak_bot" then
				local Pain = DamageInfo()
				Pain:SetDamage( (self.damage*beamtime/self.DakDuration)*50 )
				Pain:SetInflictor( self )
				Pain:SetReportedPosition( self:GetPos() )
				Pain:SetDamagePosition( self.LastHitEnt:GetPhysicsObject():GetMassCenter() )
				Pain:SetDamageType(DMG_DISSOLVE)
				self.LastHitEnt:TakeDamageInfo( Pain )
			else
				local Pain = DamageInfo()
				Pain:SetDamageForce( self:GetForward()*(self.damage*beamtime/self.DakDuration)*50 )
				Pain:SetDamage( (self.damage*beamtime/self.DakDuration)*50 )
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
		
	else
		self.timer = CurTime()
	end
	end
	end
	if IsValid(self.Target) then
		if CurTime() > self.lastsoundplay+(SoundDuration( self.DakFireSound )*0.9) then
			self:EmitSound( self.DakFireSound, 100, self.DakFirePitch, 1)
			self.lastsoundplay = CurTime()
		end
	end
	self:SetNWBool("BeamOn", IsValid(self.Target))
	self:SetNWVector("BeamPos",self.LastHit)
	if not IsValid(self.DakEngine) then
		self:SetNWBool("BeamOn", false)
	end
	self:NextThink(self.timer + 0.04)
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
	local Hit = util.TraceLine( trace )
	if Hit.Entity:IsValid() then
	if Hit.Entity:GetClass() == self:GetClass() then
		Hit.Entity =  NULL
	end 
	end

	local beamtime = CurTime() - self.timer
	if Hit.Entity:IsValid() and not Hit.Entity:IsPlayer() and not Hit.Entity:IsNPC() and not Hit.Entity:GetClass()=="dak_bot" then
		if ((self:CheckClip(Hit.Entity,Hit.HitPos)) and (self.LastHit:Distance(Hit.HitPos) > 5)) then
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
			local RemoveDamage = Hit.Entity.DakHealth
			if not(Hit.Entity:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate==nil) then
				if not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
					if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
						if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1 and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
							Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*beamtime/self.DakDuration)
						end
					end
				end
			end
			if Hit.Entity.DakHealth <= 0 and Hit.Entity.DakPooled==0 then
				Hit.Entity:Remove()
				self.damage = (self.damage*beamtime/self.DakDuration) - RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = Hit.Entity
				if Hit.Entity.DakHealth < 0 then
					self:Damage(Hit.Entity)
				end
			else
				self.damage = (self.damage*beamtime/self.DakDuration) - RemoveDamage
				self.LastHit = Hit.HitPos
				self.LastHitEnt = Hit.Entity
			end
		end
	else
		self.LastHit = Hit.HitPos
		self.LastHitEnt = Hit.Entity
	end

	if self.LastHitEnt:IsValid() then
		if self.LastHitEnt:IsPlayer() or self.LastHitEnt:IsNPC() or self.LastHitEnt:GetClass() == "dak_bot" then

			if self.LastHitEnt:GetClass() == "dak_bot" then
				local Pain = DamageInfo()
				Pain:SetDamage( (self.damage*beamtime/self.DakDuration)*50 )
				Pain:SetInflictor( self )
				Pain:SetReportedPosition( self:GetPos() )
				Pain:SetDamagePosition( self.LastHitEnt:GetPhysicsObject():GetMassCenter() )
				Pain:SetDamageType(DMG_DISSOLVE)
				self.LastHitEnt:TakeDamageInfo( Pain )
			else
				local Pain = DamageInfo()
				Pain:SetDamageForce( self:GetForward()*(self.damage*beamtime/self.DakDuration)*50 )
				Pain:SetDamage( (self.damage*beamtime/self.DakDuration)*50 )
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
			if (iname == "Fire") then
				if(value) then
					self.Firing = value > 0
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

		self:PhysicsDestroy()
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		WireLib.TriggerOutput(self, "Cooldown", self.DakCooldown)
		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end