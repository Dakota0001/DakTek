AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakName = "AC2 Ammo"
ENT.DakIsExplosive = true
ENT.DakAmmo = 10
ENT.DakMaxAmmo = 10
ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakAmmoType = "AC2"
ENT.DakPooled=0


function ENT:Initialize()

	self:SetModel( "models/dak/Ammo.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if(IsValid(phys)) then
		phys:Wake()
	end
	self.DakAmmo = self.DakMaxAmmo
	self.Inputs = Wire_CreateInputs(self, { "EjectAmmo" })
	self.Outputs = WireLib.CreateOutputs( self, { "Ammo", "MaxAmmo" } )
	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.DumpTime = CurTime()

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
	self:GetPhysicsObject():SetMass(1000)
	WireLib.TriggerOutput(self, "Ammo", self.DakAmmo)
	WireLib.TriggerOutput(self, "MaxAmmo", self.DakMaxAmmo)


	if self.DakName == "AC2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "AC5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "AC10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "AC20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Inferno AC2 Ammo" then
		self.DakMaxAmmo = 200
		self.DakIsInferno=1
	end
	if self.DakName == "Inferno AC5 Ammo" then
		self.DakMaxAmmo = 80
		self.DakIsInferno=1
	end
	if self.DakName == "Inferno AC10 Ammo" then
		self.DakMaxAmmo = 40
		self.DakIsInferno=1
	end
	if self.DakName == "Inferno AC20 Ammo" then
		self.DakMaxAmmo = 20
		self.DakIsInferno=1
	end
	if self.DakName == "Flak AC2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Flak AC5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "Flak AC10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "Flak AC20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "UAC2 Ammo" then
		self.DakMaxAmmo = 287
	end
	if self.DakName == "UAC5 Ammo" then
		self.DakMaxAmmo = 100
	end
	if self.DakName == "UAC10 Ammo" then
		self.DakMaxAmmo = 44
	end
	if self.DakName == "UAC20 Ammo" then
		self.DakMaxAmmo = 27
	end
	if self.DakName == "RAC2 Ammo" then
		self.DakMaxAmmo = 800
	end
	if self.DakName == "RAC5 Ammo" then
		self.DakMaxAmmo = 320
	end
	if self.DakName == "RAC10 Ammo" then
		self.DakMaxAmmo = 160
	end
	if self.DakName == "RAC20 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "LBX2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "LBX5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "LBX10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "LBX20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Slug LBX2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Slug LBX5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "Slug LBX10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "Slug LBX20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Anti-Air LBX2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Anti-Air LBX5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "Anti-Air LBX10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "Anti-Air LBX20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Magshot Gauss Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Light Gauss Ammo" then
		self.DakMaxAmmo = 27
	end
	if self.DakName == "Gauss Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "Heavy Gauss Ammo" then
		self.DakMaxAmmo = 8
	end
	if self.DakName == "Railgun Ammo" then
		self.DakMaxAmmo = 4
	end
	if self.DakName == "Silver Bullet Gauss Rifle Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "Light Machine Gun Ammo" then
		self.DakMaxAmmo = 2000
	end
	if self.DakName == "Machine Gun Ammo" then
		self.DakMaxAmmo = 1000
	end
	if self.DakName == "Heavy Machine Gun Ammo" then
		self.DakMaxAmmo = 500
	end
	if self.DakName == "Long Tom Ammo" then
		self.DakMaxAmmo = 8
	end
	if self.DakName == "Thumper Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Sniper Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "LRM5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "LRM10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "LRM15 Ammo" then
		self.DakMaxAmmo = 27
	end
	if self.DakName == "LRM20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "MRM10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "MRM20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "MRM30 Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "MRM40 Ammo" then
		self.DakMaxAmmo = 10
	end
	if self.DakName == "SRM2 Ammo" then
		self.DakMaxAmmo = 100
	end
	if self.DakName == "SRM4 Ammo" then
		self.DakMaxAmmo = 51
	end
	if self.DakName == "SRM6 Ammo" then
		self.DakMaxAmmo = 34
	end
	if self.DakName == "SSRM2 Ammo" then
		self.DakMaxAmmo = 100
	end
	if self.DakName == "SSRM4 Ammo" then
		self.DakMaxAmmo = 51
	end
	if self.DakName == "SSRM6 Ammo" then
		self.DakMaxAmmo = 34
	end
	if self.DakName == "Arrow IV Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "NARC Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "ATM3HE Ammo" then
		self.DakMaxAmmo = 45
	end
	if self.DakName == "ATM6HE Ammo" then
		self.DakMaxAmmo = 23
	end
	if self.DakName == "ATM9HE Ammo" then
		self.DakMaxAmmo = 15
	end
	if self.DakName == "ATM12HE Ammo" then
		self.DakMaxAmmo = 12
	end
	if self.DakName == "ATM3S Ammo" then
		self.DakMaxAmmo = 67
	end
	if self.DakName == "ATM6S Ammo" then
		self.DakMaxAmmo = 34
	end
	if self.DakName == "ATM9S Ammo" then
		self.DakMaxAmmo = 23
	end
	if self.DakName == "ATM12S Ammo" then
		self.DakMaxAmmo = 17
	end
	if self.DakName == "ATM3ER Ammo" then
		self.DakMaxAmmo = 134
	end
	if self.DakName == "ATM6ER Ammo" then
		self.DakMaxAmmo = 67
	end
	if self.DakName == "ATM9ER Ammo" then
		self.DakMaxAmmo = 45
	end
	if self.DakName == "ATM12ER Ammo" then
		self.DakMaxAmmo = 34
	end

	self.DakEjectAmmo = self.Inputs.EjectAmmo.Value
	if self.DakEjectAmmo == 1 then
		if CurTime()>=self.DumpTime+0.5 then
			if self.DakAmmo>0 then
				self.DakAmmo = self.DakAmmo - math.Round(self.DakMaxAmmo/10,0)
				if self.DakAmmo < 0 then
					self.DakAmmo = 0
				end
				self:EmitSound( "dak/Jam.wav", 100, 75, 1)
				self.DumpTime = CurTime()
			end
		end
	end

	if self.DakIsInferno==1 then
			if self.DakAmmo>0 and self.DakHealth<10 and self.DakIsExplosive then

			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(200)
			util.Effect("dakatmexplosion", effectdata)

			self.DamageList = {}
			self.RemoveList = {}
			self.IgnoreList = {}
			local Targets = ents.FindInSphere( self:GetPos(), 250 )
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
					if Targets[i]:GetClass() == "dak_engine" then
						if Targets[i]:IsOnFire() then 
							Targets[i]:Extinguish()
						end
						Targets[i]:Ignite(5,1)
						Targets[i].DakHeat = Targets[i].DakHeat+50
					end
					if Targets[i]:IsPlayer() then
						if not Targets[i]:InVehicle() then
							if Targets[i]:IsOnFire() then 
								Targets[i]:Extinguish()
							end
							Targets[i]:Ignite(5,1)
						end
					end
					if Targets[i]:IsNPC() or (Targets[i]:GetClass()=="dak_bot" or Targets[i]:GetClass()=="dak_zombie") then
						if Targets[i]:IsOnFire() then 
							Targets[i]:Extinguish()
						end
						Targets[i]:Ignite(5,1)
					end
					if Targets[i]:IsValid() or Targets[i]:IsPlayer() or Targets[i]:IsNPC() then
						local trace = {}
						trace.start = self:GetPos()
						trace.endpos = Targets[i]:GetPos()
						trace.filter = self.IgnoreList
						local ExpTrace = util.TraceLine( trace )
						if ExpTrace.Entity == Targets[i] then
							if not(string.Explode("_",Targets[i]:GetClass(),false)[2] == "wire") and not(Targets[i]:IsVehicle()) and not(Targets[i]:GetClass() == "dak_salvage") then
								if (not(ExpTrace.Entity:IsPlayer())) and (not(ExpTrace.Entity:IsNPC())) then
									if ExpTrace.Entity.DakHealth == nil then
										DakTekSetupNewEnt(ExpTrace.Entity)
									end
									table.insert(self.DamageList,ExpTrace.Entity)
								else
									if (Targets[i]:GetClass() == "dak_bot" or Targets[i]:GetClass() == "dak_zombie") then
										Targets[i]:SetHealth(Targets[i]:Health() - (200*(self.DakAmmo/self.DakMaxAmmo))*50*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)))
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
										ExpPain:SetDamageForce( ExpTrace.Normal*(50*(self.DakAmmo/self.DakMaxAmmo))*2500 )
										ExpPain:SetDamage( (200*(self.DakAmmo/self.DakMaxAmmo))*50*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)) )
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
				for i = 1, #self.DamageList do
					if(self.DamageList[i]:IsValid()) then
						if not((self.DamageList[i]:GetClass() == "dak_bot" or self.DamageList[i]:GetClass() == "dak_zombie")) then
							if(self.DamageList[i]:GetParent():IsValid()) then
								if(self.DamageList[i]:GetParent():GetParent():IsValid()) then
									self.DamageList[i]:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(250/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*10000*2*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)) )
								end
							end
							if not(self.DamageList[i]:GetParent():IsValid()) then
								self.DamageList[i]:GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(250/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*10000*2*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))  )
							end
						end
					end
					if not(self.DamageList[i]:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate==nil) then
						if not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
							if self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
								if (self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then
									local HPPerc = (self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DamageList[i].DakMaxHealth
									self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))
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
						local HPPerc = (self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DamageList[i].DakMaxHealth
						self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))
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
					self.salvage = ents.Create( "dak_salvage" )
					self.salvage.DakModel = self.RemoveList[i]:GetModel()
					self.salvage:SetPos( self.RemoveList[i]:GetPos())
					self.salvage:SetAngles( self.RemoveList[i]:GetAngles())
					self.salvage.DakLastDamagePos = self:GetPhysicsObject():GetPos()
					self.salvage:Spawn()
					self.RemoveList[i]:Remove()
				end
			end

			self:EmitSound( "dak/ammoexplode.wav", 100, 75, 1)
			self:Remove()
		end
	else
		if self.DakAmmo>0 and self.DakHealth<5 and self.DakIsExplosive then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(200)
			util.Effect("dakthumperexplosion", effectdata)

			self.DamageList = {}
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
							if not(string.Explode("_",Targets[i]:GetClass(),false)[2] == "wire") and not(Targets[i]:IsVehicle()) and not(Targets[i]:GetClass() == "dak_salvage") then
								if (not(ExpTrace.Entity:IsPlayer())) and (not(ExpTrace.Entity:IsNPC())) then
									if ExpTrace.Entity.DakHealth == nil then
										DakTekSetupNewEnt(ExpTrace.Entity)
									end
									table.insert(self.DamageList,ExpTrace.Entity)
								else
									if (Targets[i]:GetClass() == "dak_bot" or Targets[i]:GetClass() == "dak_zombie") then
										Targets[i]:SetHealth(Targets[i]:Health() - (200*(self.DakAmmo/self.DakMaxAmmo))*50*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)))
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
										ExpPain:SetDamageForce( ExpTrace.Normal*(50*(self.DakAmmo/self.DakMaxAmmo))*2500 )
										ExpPain:SetDamage( (200*(self.DakAmmo/self.DakMaxAmmo))*50*(1-(ExpTrace.Entity:GetPos():Distance(self:GetPos())/1000)) )
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
				for i = 1, #self.DamageList do
					if(self.DamageList[i]:IsValid()) then
						if not((self.DamageList[i]:GetClass() == "dak_bot" or self.DamageList[i]:GetClass() == "dak_zombie")) then
							if(self.DamageList[i]:GetParent():IsValid()) then
								if(self.DamageList[i]:GetParent():GetParent():IsValid()) then
									self.DamageList[i]:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(250/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*10000*2*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)) )
								end
							end
							if not(self.DamageList[i]:GetParent():IsValid()) then
								self.DamageList[i]:GetPhysicsObject():ApplyForceCenter( (self.DamageList[i]:GetPos()-self:GetPos()):GetNormalized()*(250/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*10000*2*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))  )
							end
						end
					end
					if not(self.DamageList[i]:GetTable().OnDieFunctions==nil) and not(game.SinglePlayer()) and not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate==nil) then
						if not(self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
							if self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then
								if (self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..self.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..self:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then	
									local HPPerc = (self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DamageList[i].DakMaxHealth
									self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))
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
						local HPPerc = (self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000)))/self.DamageList[i].DakMaxHealth
						self.DamageList[i].DakHealth = self.DamageList[i].DakHealth-(1000/table.Count(self.DamageList)*(self.DakAmmo/self.DakMaxAmmo))*(1-(self.DamageList[i]:GetPos():Distance(self:GetPos())/1000))
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
					self.salvage = ents.Create( "dak_salvage" )
					self.salvage.DakModel = self.RemoveList[i]:GetModel()
					self.salvage:SetPos( self.RemoveList[i]:GetPos())
					self.salvage:SetAngles( self.RemoveList[i]:GetAngles())
					self.salvage.DakLastDamagePos = self:GetPhysicsObject():GetPos()
					self.salvage:Spawn()
					self.RemoveList[i]:Remove()
				end
			end

			self:EmitSound( "dak/ammoexplode.wav", 100, 75, 1)
			self:Remove()
		end
	end
	self:NextThink(CurTime()+0.25)
    return true
end


function ENT:PreEntityCopy()

	local info = {}
	local entids = {}


	info.DakName = self.DakName
	info.DakIsExplosive = self.DakIsExplosive
	info.DakAmmo = self.DakMaxAmmo
	info.DakMaxAmmo = self.DakMaxAmmo
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
	info.DakAmmoType = self.DakAmmoType
	info.DakOwner = self.DakOwner

	duplicator.StoreEntityModifier( self, "DakTek", info )

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then
		self.DakName = Ent.EntityMods.DakTek.DakName
		self.DakIsExplosive = Ent.EntityMods.DakTek.DakIsExplosive
		self.DakAmmo = Ent.EntityMods.DakTek.DakAmmo
		self.DakMaxAmmo = Ent.EntityMods.DakTek.DakMaxAmmo
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakAmmoType = Ent.EntityMods.DakTek.DakAmmoType
		self.DakOwner = Player

		Ent.EntityMods.DakTekLink = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

	if self.DakName == "AC2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "AC5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "AC10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "AC20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Inferno AC2 Ammo" then
		self.DakMaxAmmo = 200
		self.DakIsInferno=1
	end
	if self.DakName == "Inferno AC5 Ammo" then
		self.DakMaxAmmo = 80
		self.DakIsInferno=1
	end
	if self.DakName == "Inferno AC10 Ammo" then
		self.DakMaxAmmo = 40
		self.DakIsInferno=1
	end
	if self.DakName == "Inferno AC20 Ammo" then
		self.DakMaxAmmo = 20
		self.DakIsInferno=1
	end
	if self.DakName == "Flak AC2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Flak AC5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "Flak AC10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "Flak AC20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "UAC2 Ammo" then
		self.DakMaxAmmo = 287
	end
	if self.DakName == "UAC5 Ammo" then
		self.DakMaxAmmo = 100
	end
	if self.DakName == "UAC10 Ammo" then
		self.DakMaxAmmo = 44
	end
	if self.DakName == "UAC20 Ammo" then
		self.DakMaxAmmo = 27
	end
	if self.DakName == "RAC2 Ammo" then
		self.DakMaxAmmo = 800
	end
	if self.DakName == "RAC5 Ammo" then
		self.DakMaxAmmo = 320
	end
	if self.DakName == "RAC10 Ammo" then
		self.DakMaxAmmo = 160
	end
	if self.DakName == "RAC20 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "LBX2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "LBX5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "LBX10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "LBX20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Slug LBX2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Slug LBX5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "Slug LBX10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "Slug LBX20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Anti-Air LBX2 Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Anti-Air LBX5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "Anti-Air LBX10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "Anti-Air LBX20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Magshot Gauss Ammo" then
		self.DakMaxAmmo = 200
	end
	if self.DakName == "Light Gauss Ammo" then
		self.DakMaxAmmo = 27
	end
	if self.DakName == "Gauss Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "Heavy Gauss Ammo" then
		self.DakMaxAmmo = 8
	end
	if self.DakName == "Railgun Ammo" then
		self.DakMaxAmmo = 4
	end
	if self.DakName == "Silver Bullet Gauss Rifle Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "Light Machine Gun Ammo" then
		self.DakMaxAmmo = 2000
	end
	if self.DakName == "Machine Gun Ammo" then
		self.DakMaxAmmo = 1000
	end
	if self.DakName == "Heavy Machine Gun Ammo" then
		self.DakMaxAmmo = 500
	end
	if self.DakName == "Long Tom Ammo" then
		self.DakMaxAmmo = 8
	end
	if self.DakName == "Thumper Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "Sniper Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "LRM5 Ammo" then
		self.DakMaxAmmo = 80
	end
	if self.DakName == "LRM10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "LRM15 Ammo" then
		self.DakMaxAmmo = 27
	end
	if self.DakName == "LRM20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "MRM10 Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "MRM20 Ammo" then
		self.DakMaxAmmo = 20
	end
	if self.DakName == "MRM30 Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "MRM40 Ammo" then
		self.DakMaxAmmo = 10
	end
	if self.DakName == "SRM2 Ammo" then
		self.DakMaxAmmo = 100
	end
	if self.DakName == "SRM4 Ammo" then
		self.DakMaxAmmo = 51
	end
	if self.DakName == "SRM6 Ammo" then
		self.DakMaxAmmo = 34
	end
	if self.DakName == "SSRM2 Ammo" then
		self.DakMaxAmmo = 100
	end
	if self.DakName == "SSRM4 Ammo" then
		self.DakMaxAmmo = 51
	end
	if self.DakName == "SSRM6 Ammo" then
		self.DakMaxAmmo = 34
	end
	if self.DakName == "Arrow IV Ammo" then
		self.DakMaxAmmo = 14
	end
	if self.DakName == "NARC Ammo" then
		self.DakMaxAmmo = 40
	end
	if self.DakName == "ATM3HE Ammo" then
		self.DakMaxAmmo = 45
	end
	if self.DakName == "ATM6HE Ammo" then
		self.DakMaxAmmo = 23
	end
	if self.DakName == "ATM9HE Ammo" then
		self.DakMaxAmmo = 15
	end
	if self.DakName == "ATM12HE Ammo" then
		self.DakMaxAmmo = 12
	end
	if self.DakName == "ATM3S Ammo" then
		self.DakMaxAmmo = 67
	end
	if self.DakName == "ATM6S Ammo" then
		self.DakMaxAmmo = 34
	end
	if self.DakName == "ATM9S Ammo" then
		self.DakMaxAmmo = 23
	end
	if self.DakName == "ATM12S Ammo" then
		self.DakMaxAmmo = 17
	end
	if self.DakName == "ATM3ER Ammo" then
		self.DakMaxAmmo = 134
	end
	if self.DakName == "ATM6ER Ammo" then
		self.DakMaxAmmo = 67
	end
	if self.DakName == "ATM9ER Ammo" then
		self.DakMaxAmmo = 45
	end
	if self.DakName == "ATM12ER Ammo" then
		self.DakMaxAmmo = 34
	end
	self.DakAmmo = self.DakMaxAmmo

end