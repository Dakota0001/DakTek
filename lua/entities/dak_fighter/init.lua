AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Light Fighter Engine"
ENT.DakModel = "models/dak/turbine2.mdl"
ENT.DakSpeed = 1.25
ENT.DakMass = 5000
ENT.DakSound = "dak/lightfighter.wav"
ENT.DakPooled=0


function ENT:Initialize()
	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.DakHealth = self.DakMaxHealth
	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.Inputs = Wire_CreateInputs(self, { "Forward", "Reverse", "PitchUp", "PitchDown", "YawLeft" ,"YawRight" ,"Level", "Activate" , "RightWingHitbox [ENTITY]", "LeftWingHitbox [ENTITY]", "BodyHitbox [ENTITY]"})

	self.ForwardPerc = 0
	self.TurnPerc = 0
	self.TurnUpPerc = 0
	self.initsound = self.DakSound
	self.Sound = CreateSound( self, self.DakSound )
	self.Sound:PlayEx(1,100)
	self.Sound:ChangePitch( 0, 0 )
	self.Sound:ChangeVolume( 0, 0 )
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
	if self.DakName == "Light Fighter Engine" then
		self.DakMaxHealth = 10
		self.DakMass = 5000
		self.DakSpeed = 1.25
		self.DakModel = "models/dak/turbine2.mdl"
		--self.DakSound = "dak/lightfighter.wav"
	end
	if self.DakName == "Standard Fighter Engine" then
		self.DakMaxHealth = 20
		self.DakMass = 10000
		self.DakSpeed = 2.5
		self.DakModel = "models/dak/turbine3.mdl"
		--self.DakSound = "dak/mediumfighter.wav"
	end
	if self.DakName == "Heavy Fighter Engine" then
		self.DakMaxHealth = 30
		self.DakMass = 20000
		self.DakSpeed = 3.5
		self.DakModel = "models/dak/turbine4.mdl"
		--self.DakSound = "dak/heavyfighter.wav"
	end
	if self.DakHealth > self.DakMaxHealth then
		self.DakHealth = self.DakMaxHealth
	end
	if not(self.initsound == self.DakSound) then
	self.initsound = self.DakSound
	self.Sound:Stop()
	self.Sound = CreateSound( self, self.DakSound )
	self.Sound:PlayEx(1,100)
	self.Sound:ChangePitch( 0, 0 )
	self.Sound:ChangeVolume( 0, 0 )
	end
	if not(self:GetModel() == self.DakModel) then
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self:GetPhysicsObject():SetMass(self.DakMass)
	self.MoveForward = self.Inputs.Forward.Value
	self.MoveReverse = self.Inputs.Reverse.Value
	self.TurnUp = self.Inputs.PitchUp.Value
	self.TurnDown = self.Inputs.PitchDown.Value
	self.TurnLeft = self.Inputs.YawLeft.Value
	self.TurnRight = self.Inputs.YawRight.Value
	self.Level = self.Inputs.Level.Value
	self.Active = self.Inputs.Activate.Value
	self.LeftWing = self.Inputs.LeftWingHitbox.Value
	self.RightWing = self.Inputs.RightWingHitbox.Value
	self.Body = self.Inputs.BodyHitbox.Value
    
    if self.DakEngine:IsValid() and self.LeftWing:IsValid() and self.RightWing:IsValid() and self.Body:IsValid() then
    	if self.LeftWing.DakMaxHealth == nil then
    		DakTekSetupNewEnt(self.LeftWing)
    	end
    	if self.RightWing.DakMaxHealth == nil then
    		DakTekSetupNewEnt(self.RightWing)
    	end
    	if self.Body.DakMaxHealth == nil then
    		DakTekSetupNewEnt(self.Body)
    	end
	    if self.LeftWing.DakMaxHealth<=250 and self.RightWing.DakMaxHealth<=250 and self.Body.DakMaxHealth<=250 and self.LeftWing:GetClass()=="dak_hitboxcontroller" and self.RightWing:GetClass()=="dak_hitboxcontroller" and self.Body:GetClass()=="dak_hitboxcontroller" then
	    	if(self:GetParent():IsValid()) then
				if(self:GetParent():GetParent():IsValid()) then
					self.phy = self:GetParent():GetParent():GetPhysicsObject()
					self.base = self:GetParent():GetParent()
				end
			end
			if not(self:GetParent():IsValid()) then
				self.phy = self:GetPhysicsObject()
				self.base = self
			end

			if not(self.DakEngine.TotalMass==nil) then
		        if ((self.Active>0) and (self.DakEngine.TotalMass <= 50000)) then
		        	self.DakSpeed = self.DakSpeed*((20000/self.DakEngine.TotalMass)*self.DakEngine.PowerMod)
		        	self.Sound:ChangeVolume( 1, 1 )
					for i=1, #self.DakEngine.Contraption do
						if not(self.DakEngine.Contraption[i]==NULL) then
							if self.DakEngine.Contraption[i]:IsSolid() then
								if self.DakEngine.Contraption[i]:GetPhysicsObject():IsGravityEnabled() then
									 self.DakEngine.Contraption[i]:GetPhysicsObject():EnableGravity( false )
								end
							end
						end
					end

					--if self.ForwardPerc > 0 then
					--	self.ForwardPerc = self.ForwardPerc - 1
					--end
					--if self.ForwardPerc < 0 then
					--	self.ForwardPerc = self.ForwardPerc + 1
					--end
					if self.Level>0 then
						if not(self.TurnUp>0) and not(self.TurnDown>0) then
							if self.TurnUpPerc > 0 then
								self.TurnUpPerc = self.TurnUpPerc - (3*self.DakSpeed)
							end
							if self.TurnUpPerc < 0 then
								self.TurnUpPerc = self.TurnUpPerc + (3*self.DakSpeed)
							end
							if math.abs(self.TurnUpPerc)<=(3*self.DakSpeed) then
								self.TurnUpPerc=0
							end
						end
					end

					if self.TurnPerc > 0 then
						self.TurnPerc = self.TurnPerc - 1
					end
					if self.TurnPerc < 0 then
						self.TurnPerc = self.TurnPerc + 1
					end
					self.Sound:ChangePitch( math.abs(self.ForwardPerc)+100, 1 )

		        	if self.TurnLeft>0 then
		        		if self.TurnPerc < 100 then
		        			self.TurnPerc = self.TurnPerc + 2
		        		end
		        	end
		        	if self.TurnRight>0 then
		        		if self.TurnPerc > -100 then
		        			self.TurnPerc = self.TurnPerc - 2
		        		end
		        	end
		        	if self.TurnUp>0 then
		        		if self.TurnUpPerc < 890 then
		        			self.TurnUpPerc = self.TurnUpPerc + (3*self.DakSpeed)
		        		end
		        	end
		        	if self.TurnDown>0 then
		        		if self.TurnUpPerc > -890 then
		        			self.TurnUpPerc = self.TurnUpPerc - (3*self.DakSpeed)
		        		end
		        	end
		        	if self.MoveForward>0 then
		        		if self.ForwardPerc < 100 then
		        			self.ForwardPerc = self.ForwardPerc + 2
		        		end
		        	end
		        	if self.MoveReverse>0 then
		        		if self.ForwardPerc > 30 then
		        			self.ForwardPerc = self.ForwardPerc - 2
		        		end
		        	end

		        	self.phy:ApplyForceCenter(Vector(self.ForwardPerc*self:GetForward()*self.phy:GetMass()*0.77*self.DakSpeed*self.DakHealth/self.DakMaxHealth))

		            self.HoverPos=Vector((self.base:GetPos()).x,(self.base:GetPos()).y,(self.base:GetPos()).z)

		            self.phy:ApplyForceCenter((self.HoverPos-self.base:GetPos())-Vector((self.base:GetVelocity()*0.05*self.phy:GetMass()).x,(self.base:GetVelocity()*0.05*self.phy:GetMass()).y,(self.base:GetVelocity()*0.05*self.phy:GetMass()).z))            

		            self.phy:AddAngleVelocity(-self.phy:GetAngleVelocity())

		            self.box = Vector(   (self.base:OBBMaxs().x)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) - (self.base:OBBMaxs().y)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , (self.base:OBBMaxs().x)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) + (self.base:OBBMaxs().y)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , 0 )

		            self.phy:ApplyForceOffset( math.Clamp(self:GetAngles().pitch+(self.TurnUpPerc/10),-360,360)*Vector(0,0,1)*10*self.phy:GetMass(), self.phy:GetPos()+self:GetForward()*5 )
		            self.phy:ApplyForceOffset( math.Clamp(self:GetAngles().roll+(self.TurnPerc/5),-25,25)*Vector(0,0,1)*10*self.phy:GetMass(), self.phy:GetPos()+self:GetRight()*5 )
		            self.phy:ApplyForceOffset( self.DakSpeed*25*(24/math.abs(self.box.y))*self.TurnPerc*self:GetForward()*self.phy:GetMass(), self.phy:GetPos()+self:GetRight()*(24/math.abs(self.box.y)) )
		            self.phy:ApplyForceOffset( -math.Clamp(self:GetAngles().pitch+(self.TurnUpPerc/10),-360,360)*Vector(0,0,1)*10*self.phy:GetMass(), self.phy:GetPos()-self:GetForward()*5 )
		            self.phy:ApplyForceOffset( -math.Clamp(self:GetAngles().roll+(self.TurnPerc/5),-25,25)*Vector(0,0,1)*10*self.phy:GetMass(), self.phy:GetPos()-self:GetRight()*5 )
		            self.phy:ApplyForceOffset( -self.DakSpeed*25*(24/math.abs(self.box.y))*self.TurnPerc*self:GetForward()*self.phy:GetMass(), self.phy:GetPos()-self:GetRight()*(24/math.abs(self.box.y)) )
		        else
		        	self.Sound:ChangeVolume( 0, 2 )
		        	self.Sound:ChangePitch( 0, 2 )
		        	self.ForwardPerc=0
		        end
		    end
	        self.base:GetPhysicsObject():EnableGravity( true )
	    end
    else
    	self.Sound:ChangeVolume( 0, 2 )
        self.Sound:ChangePitch( 0, 2 )
    end
    self:NextThink(CurTime())
    return true
end

function ENT:PreEntityCopy()

	local info = {}
	local entids = {}

	info.EngineID = self.DakEngine:EntIndex()
	info.DakName = self.DakName
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
	info.DakSpeed = self.DakSpeed
	info.DakSound = self.DakSound

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
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakSpeed = Ent.EntityMods.DakTek.DakSpeed
		self.DakSound = Ent.EntityMods.DakTek.DakSound
		self.DakOwner = Player
		self.DakHealth = self.DakMaxHealth
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

		self:PhysicsDestroy()
		--self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:Activate()

		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end