AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity" 

ENT.PrintName = "ArrowIV Missile"

ENT.Spawnable = false
ENT.AdminOnly = false
--ENT.RenderGroup = RENDERGROUP_OPAQUE

util.PrecacheModel("models/dak/arrowrocket.mdl")
ENT.DakGun = nil
ENT.DakTarget = nil
ENT.DakFireTime = 0
ENT.DakTargetPos = Vector(0,0,0)
function ENT:Draw()

	self:DrawModel()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetEntity(self)
	effectdata:SetAttachment(1)
	effectdata:SetMagnitude(.5)
	effectdata:SetScale(200)
	util.Effect("arrowtrail", effectdata)

end

if (CLIENT) then
	function ENT:Think()
		if self.Triggered == nil then
			if not(self:GetNWString("FireSound") == "") then
				sound.Play( self:GetNWString("FireSound"), LocalPlayer():GetPos()+((self:GetPos()-LocalPlayer():GetPos()):GetNormalized()*1000), 100, self:GetNWInt("FirePitch"), math.Clamp(1500/LocalPlayer():GetPos():Distance(self:GetPos()),0,0.5) )
				self.Triggered = 1
			end
		end
	end
	function ENT:OnRemove()
		sound.Play( "dak/longtomimpact.wav", LocalPlayer():GetPos()+((self:GetPos()-LocalPlayer():GetPos()):GetNormalized()*1000), 100, 150, math.Clamp(2000/LocalPlayer():GetPos():Distance(self:GetPos()),0,1) )
	end
end

if ( CLIENT ) then return end -- We do NOT want to execute anything below in this FILE on Cliet

function ENT:Initialize()
	self:SetModel( "models/dak/arrowrocket.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		--phys:Wake()
	end
	self.velocity = 3000
	self.damage = 5
	self.splashdamage = 15
	phys:SetVelocity(self:GetForward()*self.velocity)
	phys:EnableGravity( false )
	self:GetPhysicsObject():SetMass(50)
	self:GetPhysicsObject():EnableCollisions(false)
	self.LastPos = self:GetPos()-self:GetForward()*25
	self.DakHealth=500
 	self.DakMaxHealth=500
 	self.RanVec = Vector(math.Rand(-250,250),math.Rand(-250,250),math.Rand(-250,250))
	--util.SpriteTrail( self, 0, Color(255,255,255,150), false, 10, 0, 5, 1 / ( 10 + 0 ) * 0.5, "particles/smokey.vmt" )
end

	function ENT:Think()
		if(self.DakFireTime+1.5>CurTime()) then
			if IsValid(self.DakTarget) then
				if IsValid(self.DakTarget) then
					self.TargetPos = self.DakTarget:LocalToWorld(self.DakTarget:OBBCenter())
				else
					if self.DakGun:IsValid() then
						self.TargetPos = self.DakTargetPos
					end
				end
				if self.TargetPos:Distance( self:GetPos() ) > 1500 then
					local FlightAngle = self:GetPhysicsObject():GetAngles()
					FlightAngle = FlightAngle + Angle(-20,0,0)
					self:GetPhysicsObject():SetAngles(FlightAngle)
					self:GetPhysicsObject():SetVelocity(self:GetForward()*self.velocity)
				else
					self.DakFireTime = self.DakFireTime-1.5
				end
			else
				self:GetPhysicsObject():SetVelocity(self:GetForward()*self.velocity)
			end
		else
			if IsValid(self.DakTarget) then
				self.TargetPos = self.DakTarget:LocalToWorld(self.DakTarget:OBBCenter())
			else
				if self.DakGun:IsValid() then
					self.TargetPos = self.DakTargetPos + self.RanVec
				end
			end
			local Pitch = math.Clamp(self:WorldToLocalAngles((self.TargetPos-self:GetPos()):Angle()).p,-50,50)
			local Yaw = math.Clamp(self:WorldToLocalAngles((self.TargetPos-self:GetPos()):Angle()).y,-50,50)
			local Roll = math.Clamp(self:WorldToLocalAngles((self.TargetPos-self:GetPos()):Angle()).r,-50,50)
			local FlightAngle = self:LocalToWorldAngles(Angle(Pitch,Yaw,Roll))
			self:GetPhysicsObject():SetAngles(FlightAngle)
			self:GetPhysicsObject():SetVelocityInstantaneous(FlightAngle:Forward()*self.velocity)
		end

	
	trace = {}
	trace.start = self.LastPos
	trace.endpos = self:GetPos() + self:GetForward()*self.LastPos:Distance(self:GetPos())
	self.Filters = ents.FindByClass( self:GetClass() )
	table.insert(self.Filters,self)
	table.insert(self.Filters,self.DakGun)
	if self.DakGun.DakEngine then
		table.Add(self.Filters,self.DakGun.DakEngine.Contraption)
	end
	trace.filter = self.Filters
	local Hit = util.TraceEntity( trace, self )
	if Hit.Entity:IsValid() then
	if Hit.Entity:GetClass() == self:GetClass() then
		Hit.Entity =  NULL
	end 
	end


	if Hit.Entity:IsValid() and not(Hit.Entity:IsPlayer()) and not(Hit.Entity:IsNPC()) and not((Hit.Entity:GetClass()=="dak_bot" or Hit.Entity:GetClass()=="dak_zombie")) then
		if(self:CheckClip(Hit.Entity,Hit.HitPos)) then
			self.LastHit = Hit.HitPos-(self:GetForward()*75)
			self.LastHitEnt = Hit.Entity
			if Hit.Entity.DakHealth == nil then
				DakTekSetupNewEnt(Hit.Entity)
			end
			self:Damage(Hit.Entity)
		else
			if Hit.Entity.DakHealth == nil then
			DakTekSetupNewEnt(Hit.Entity)
			end
			if Hit.Entity.DakHealth>0 then
				self.RemoveDamage = Hit.Entity.DakHealth
			else
				self.RemoveDamage = 0
			end
						
			if not(Hit.Entity:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate==nil) then
				if not(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then			
					if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
						if (Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakGun.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
							if self.DakGun.DakIsEnergy then
								if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
									local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								else
									local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								end
							else
								if (Hit.Entity.DakName == "Reactive Armor")or(Hit.Entity.DakName == "Heavy Reactive Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
									local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								else
									local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								end
							end
						end
					end
				end
			else
				if self.DakGun.DakIsEnergy then
					if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
						local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					else
						local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					end
				else
					if (Hit.Entity.DakName == "Reactive Armor")or(Hit.Entity.DakName == "Heavy Reactive Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
						local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					else
						local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					end
				end
			end
			
			Hit.Entity.DakLastDamagePos = Hit.HitPos
			if Hit.Entity.DakHealth <= 0 then
				self.TargetPos = self:GetForward()*100000000
				self.damage = self.damage - self.RemoveDamage
				self.LastHit = Hit.HitPos-(self:GetForward()*75)
				self.LastHitEnt = Hit.Entity
				if Hit.Entity.DakHealth < 0 then
					self:Damage(Hit.Entity)
				end
			else
				self.damage = self.damage - self.RemoveDamage
				self.LastHit = Hit.HitPos-(self:GetForward()*75)
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
		self.LastHit = Hit.HitPos-(self:GetForward()*75)
		self.LastHitEnt = Hit.Entity
	end
	if self.LastHitEnt:IsValid() then
		if self.LastHitEnt:IsPlayer() or self.LastHitEnt:IsNPC() or (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
				if (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
					self.LastHitEnt:SetHealth(self.LastHitEnt:Health() - self.damage*50)
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
				Pain:SetDamageForce( self:GetVelocity():GetNormalized()*self.damage*self:GetPhysicsObject():GetMass()*self.velocity )
				Pain:SetDamage( self.damage*50 )
				Pain:SetAttacker( self.DakGun.DakOwner )
				Pain:SetInflictor( self.DakGun )
				Pain:SetReportedPosition( self:GetPos() )
				Pain:SetDamagePosition( self.LastHitEnt:GetPhysicsObject():GetMassCenter() )
				Pain:SetDamageType(DMG_CRUSH)
				self.LastHitEnt:TakeDamageInfo( Pain )
			end

			--self.LastHitEnt:TakeDamage( self.damage*50, self.DakGun.DakOwner, self.DakGun )
			if self.LastHitEnt:Health() <= 0 then
				self:Damage(self.LastHitEnt)
			else
			self.damage = 0
			self.LastHit = Hit.HitPos-(self:GetVelocity():GetNormalized()*75)
			self.LastHitEnt = Hit.Entity
			end
		end
	end
	if self.damage <= 0 or self.LastHitEnt:IsWorld() or (CurTime()>self.DakFireTime+30) then
		local effectdata = EffectData()

		effectdata:SetOrigin(self.LastHit)
		effectdata:SetEntity(self)
		effectdata:SetAttachment(1)
		effectdata:SetMagnitude(.5)
		effectdata:SetScale(200)
		util.Effect("dakthumperexplosion", effectdata)

		self.DamageList = {}
		self.RemoveList = {}
		self.IgnoreList = {}
		local Targets = ents.FindInSphere( self.LastHit, 500 )
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
					trace.start = self.LastHit
					trace.endpos = Targets[i]:GetPos()
					trace.filter = self.IgnoreList
					local ExpTrace = util.TraceHull( trace, self )
					if ExpTrace.Entity == Targets[i] then
						if not(string.Explode("_",Targets[i]:GetClass(),false)[2] == "wire") and not(Targets[i]:GetClass() == self:GetClass()) and not(Targets[i]:IsVehicle()) and not(Targets[i]:GetClass() == "dak_salvage") then
							if (not(ExpTrace.Entity:IsPlayer()))and(not(ExpTrace.Entity:IsNPC()))and(not((ExpTrace.Entity:GetClass() == "dak_bot" or ExpTrace.Entity:GetClass() == "dak_zombie"))) then
								if ExpTrace.Entity.DakHealth == nil then
									DakTekSetupNewEnt(ExpTrace.Entity)
								end
								table.insert(self.DamageList,ExpTrace.Entity)
							else
								if (ExpTrace.Entity:GetClass() == "dak_bot" or ExpTrace.Entity:GetClass() == "dak_zombie") then
									ExpTrace.Entity:SetHealth(ExpTrace.Entity:Health() - self.splashdamage*500*(1-(ExpTrace.Entity:GetPos():Distance(self.LastHit)/1000))*50)
									if ExpTrace.Entity:Health() <= 0 and self.revenge==0 then
										local body = ents.Create( "prop_ragdoll" )
										body:SetPos( ExpTrace.Entity:GetPos() )
										body:SetModel( ExpTrace.Entity:GetModel() )
										body:Spawn()
										ExpTrace.Entity:Remove()
										local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
										body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
										timer.Simple( 5, function()
											body:Remove()
										end )
									end
								else
									local ExpPain = DamageInfo()
									ExpPain:SetDamageForce( ExpTrace.Normal*self.splashdamage*self:GetPhysicsObject():GetMass()*self.velocity )
									ExpPain:SetDamage( self.splashdamage*500*(1-(ExpTrace.Entity:GetPos():Distance(self.LastHit)/1000)) )
									ExpPain:SetAttacker( self.DakGun.DakOwner )
									ExpPain:SetInflictor( self.DakGun )
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
			for i = 1, #self.DamageList do
				if(self.DamageList[i]:IsValid()) then
					if not((self.DamageList[i]:GetClass() == "dak_bot" or self.DamageList[i]:GetClass() == "dak_zombie")) then
						if(self.DamageList[i]:GetParent():IsValid()) then
							if(self.DamageList[i]:GetParent():GetParent():IsValid()) then
							self.DamageList[i]:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self.LastHit):GetNormalized()*(self.splashdamage/table.Count(self.DamageList))*1000*2*(1-(self.DamageList[i]:GetPos():Distance(self.LastHit)/1000)) )
							end
						end
						if not(self.DamageList[i]:GetParent():IsValid()) then
							self.DamageList[i]:GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self.LastHit):GetNormalized()*(self.splashdamage/table.Count(self.DamageList))*1000*2*(1-(self.DamageList[i]:GetPos():Distance(self.LastHit)/1000))  )
						end
					end
				end
				local HPPerc = 0
				if not(self.DamageList[i]:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate==nil) then
					if not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
						if self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then
							if (self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakGun.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
								if self.DamageList[i]:GetPos():Distance(self.LastHit) > 250 then
									HPPerc = (self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList))*(1-(self.DamageList[i]:GetPos():Distance(self.LastHit)/1000)))/self.DamageList[i].DakMaxHealth
									self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList))*(1-(self.DamageList[i]:GetPos():Distance(self.LastHit)/1000))
								else
									HPPerc = (self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList)))/self.DamageList[i].DakMaxHealth
									self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList))
								end
								if not(self.DamageList[i].DakRed == nil) then
									self.DamageList[i]:SetColor(Color(self.DamageList[i].DakRed*HPPerc,self.DamageList[i].DakGreen*HPPerc,self.DamageList[i].DakBlue*HPPerc,self.DamageList[i]:GetColor().a))
								end
								self.DamageList[i].DakLastDamagePos = self.LastHit
								if self.DamageList[i].DakHealth <= 0 and self.DamageList[i].DakPooled==0 then
									table.insert(self.RemoveList,self.DamageList[i])
								end
							end
						end
					end
				else
					if self.DamageList[i]:GetPos():Distance(self.LastHit) > 250 then
						HPPerc = (self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList))*(1-(self.DamageList[i]:GetPos():Distance(self.LastHit)/1000)))/self.DamageList[i].DakMaxHealth
						self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList))*(1-(self.DamageList[i]:GetPos():Distance(self.LastHit)/1000))
					else
						HPPerc = (self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList)))/self.DamageList[i].DakMaxHealth
						self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(self.splashdamage/table.Count(self.DamageList))
					end
					if not(self.DamageList[i].DakRed == nil) then
						self.DamageList[i]:SetColor(Color(self.DamageList[i].DakRed*HPPerc,self.DamageList[i].DakGreen*HPPerc,self.DamageList[i].DakBlue*HPPerc,self.DamageList[i]:GetColor().a))
					end
					self.DamageList[i].DakLastDamagePos = self.LastHit
					if self.DamageList[i].DakHealth <= 0 and self.DamageList[i].DakPooled==0 then
						table.insert(self.RemoveList,self.DamageList[i])
					end
				end
			end
			for i = 1, #self.RemoveList do
				self.salvage = ents.Create( "dak_salvage" )
				self.salvage.DakModel = self.RemoveList[i]:GetModel()
				self.salvage:SetPos( self.RemoveList[i]:GetPos())
				self.salvage:SetAngles( self.RemoveList[i]:GetAngles())
				self.salvage.DakLastDamagePos = self.LastHit
				self.salvage:Spawn()
				self.RemoveList[i]:Remove()
			end
		end
			if(self.LastHitEnt:IsValid()) then
				if not((self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie")) then
					if(self.LastHitEnt:GetParent():IsValid()) then
						if(self.LastHitEnt:GetParent():GetParent():IsValid()) then
							local Div = Vector(self.LastHitEnt:GetParent():GetParent():OBBMaxs().x/75,self.LastHitEnt:GetParent():GetParent():OBBMaxs().y/75,self.LastHitEnt:GetParent():GetParent():OBBMaxs().z/75)
							if self.LastHitEnt.DakPooled==1 then 
								if self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():GetMass()>=1000 then
									self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000/(self.LastHitEnt.Controller.DakEngine.TotalMass/10000),self.LastHitEnt:GetParent():GetParent():GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
								else
									self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000*(self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():GetMass()*2/1000)/(self.LastHitEnt.Controller.DakEngine.TotalMass/10000),self.LastHitEnt:GetParent():GetParent():GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
								end
							else
								if self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():GetMass()>=1000 then
									self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000,self.LastHitEnt:GetParent():GetParent():GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
								else
									self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000*(self.LastHitEnt:GetParent():GetParent():GetPhysicsObject():GetMass()*2/1000),self.LastHitEnt:GetParent():GetParent():GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
								end
							end
						end
					end
					if not(self.LastHitEnt:GetParent():IsValid()) then
						local Div = Vector(self.LastHitEnt:OBBMaxs().x/75,self.LastHitEnt:OBBMaxs().y/75,self.LastHitEnt:OBBMaxs().z/75)
						if self.LastHitEnt.DakPooled==1 then 
							if self.LastHitEnt:GetPhysicsObject():GetMass()>=1000 then
								self.LastHitEnt:GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000/(self.LastHitEnt.Controller.DakEngine.TotalMass/10000),self.LastHitEnt:GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
							else
								self.LastHitEnt:GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000/(self.LastHitEnt.Controller.DakEngine.TotalMass/10000)*(self.LastHitEnt:GetPhysicsObject():GetMass()*2/1000),self.LastHitEnt:GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
							end
						else
							if self.LastHitEnt:GetPhysicsObject():GetMass()>=1000 then
								self.LastHitEnt:GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000,self.LastHitEnt:GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
							else
								self.LastHitEnt:GetPhysicsObject():ApplyForceOffset( Div*(self:GetVelocity()*self:GetPhysicsObject():GetMass()/20000)*1000*(self.LastHitEnt:GetPhysicsObject():GetMass()*2/1000),self.LastHitEnt:GetPos()+self.LastHitEnt:WorldToLocal(self.LastHit):GetNormalized() )
							end
						end
					end
				end
			end
		--sound.Play( "dak/longtomimpact.wav", Hit.HitPos, 100, 150, 1 )
		self:Remove()
	end	
	self.LastPos = self:GetPos()
	--self:NextThink(CurTime()+0.25)
	--return true
end

function ENT:Damage(oldhit)
	trace = {}
	trace.start = self.LastPos
	trace.endpos = self:GetPos() + self:GetForward()*self.LastPos:Distance(self:GetPos())
	table.insert(self.Filters,oldhit)
	trace.filter = self.Filters
	local Hit = util.TraceEntity( trace, self )
	if Hit.Entity:IsValid() then
	if Hit.Entity:GetClass() == self:GetClass() then
		Hit.Entity =  NULL
	end 
	end

	if Hit.Entity:IsValid() and not(Hit.Entity:IsPlayer()) and not(Hit.Entity:IsNPC()) and not((Hit.Entity:GetClass()=="dak_bot" or Hit.Entity:GetClass()=="dak_zombie")) then
		if ((self:CheckClip(Hit.Entity,Hit.HitPos)) and (self.LastHit:Distance(Hit.HitPos) > 5)) then
			self.LastHit = Hit.HitPos-(self:GetForward()*75)
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
						if (Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self.DakGun.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
							if self.DakGun.DakIsEnergy then
								if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
									local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								else
									local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								end
							else
								if (Hit.Entity.DakName == "Reactive Armor")or(Hit.Entity.DakName == "Heavy Reactive Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
									local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								else
									local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
									Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
									if not(Hit.Entity.DakRed == nil) then 
										Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
									end
								end
							end
						end
					end
				end
			else
				if self.DakGun.DakIsEnergy then
					if (Hit.Entity.DakName == "Reflective Armor")or(Hit.Entity.DakName == "Heavy Reflective Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
						local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					else
						local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					end
				else
					if (Hit.Entity.DakName == "Reactive Armor")or(Hit.Entity.DakName == "Heavy Reactive Armor")or(Hit.Entity.DakName == "Reactive Reflective Armor")or(Hit.Entity.DakName == "Heavy Reactive Reflective Armor") then
						local HPPerc = (Hit.Entity.DakHealth-(self.damage*0.5))/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.damage*0.5)
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					else
						local HPPerc = (Hit.Entity.DakHealth-self.damage)/Hit.Entity.DakMaxHealth
						Hit.Entity.DakHealth = Hit.Entity.DakHealth-self.damage
						if not(Hit.Entity.DakRed == nil) then 
							Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
						end
					end
				end
			end
			
			Hit.Entity.DakLastDamagePos = Hit.HitPos
			if Hit.Entity.DakHealth <= 0 then
				self.TargetPos = self:GetForward()*100000000
				self.damage = self.damage - self.RemoveDamage
				self.LastHit = Hit.HitPos-(self:GetForward()*75)
				self.LastHitEnt = Hit.Entity
				if Hit.Entity.DakHealth < 0 then
					self:Damage(Hit.Entity)
				end
			else
				self.damage = self.damage - self.RemoveDamage
				self.LastHit = Hit.HitPos-(self:GetForward()*75)
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
		self.LastHit = Hit.HitPos-(self:GetForward()*75)
		self.LastHitEnt = Hit.Entity
	end

	if self.LastHitEnt:IsValid() then
		if self.LastHitEnt:IsPlayer() or self.LastHitEnt:IsNPC() or (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then

				if (self.LastHitEnt:GetClass() == "dak_bot" or self.LastHitEnt:GetClass() == "dak_zombie") then
					self.LastHitEnt:SetHealth(self.LastHitEnt:Health() - self.damage*50)
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
				Pain:SetDamageForce( self:GetVelocity():GetNormalized()*self.damage*self:GetPhysicsObject():GetMass()*self.velocity )
				Pain:SetDamage( self.damage*50 )
				Pain:SetAttacker( self.DakGun.DakOwner )
				Pain:SetInflictor( self.DakGun )
				Pain:SetReportedPosition( self:GetPos() )
				Pain:SetDamagePosition( self.LastHitEnt:GetPhysicsObject():GetMassCenter() )
				Pain:SetDamageType(DMG_CRUSH)
				self.LastHitEnt:TakeDamageInfo( Pain )
			end

			--self.LastHitEnt:TakeDamage( self.damage*50, self.DakGun.DakOwner, self.DakGun )
			if self.LastHitEnt:Health() <= 0 then
				self:Damage(self.LastHitEnt)
			else
			self.damage = 0
			self.LastHit = Hit.HitPos-(self:GetForward()*75)
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