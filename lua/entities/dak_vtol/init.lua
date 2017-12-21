AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Light VTOL Engine"
ENT.DakModel = "models/dak/turbine1.mdl"
ENT.DakSpeed = 0.75
ENT.DakMass = 2000
ENT.DakSound = "dak/lightheli.wav"
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
	self.Inputs = Wire_CreateInputs(self, { "Forward", "Reverse", "Left", "Right", "Up", "Down", "YawLeft" ,"YawRight" , "Activate" , "Rotor1Hitbox [ENTITY]", "Rotor2Hitbox [ENTITY]", "BodyHitbox [ENTITY]"})

	self.ForwardPerc = 0
	self.RightPerc = 0
	self.UpPerc = 0
	self.TurnPerc = 0
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
	if self.DakName == "Light VTOL Engine" then
		self.DakMaxHealth = 10
		self.DakMass = 2000
		self.DakSpeed = 0.75
		self.DakModel = "models/dak/turbine1.mdl"
		--self.DakSound = "dak/lightheli.wav"
	end
	if self.DakName == "Standard VTOL Engine" then
		self.DakMaxHealth = 20
		self.DakMass = 6000
		self.DakSpeed = 1.5
		self.DakModel = "models/dak/turbine2.mdl"
		--self.DakSound = "dak/mediumheli.wav"
	end
	if self.DakName == "Heavy VTOL Engine" then
		self.DakMaxHealth = 30
		self.DakMass = 10000
		self.DakSpeed = 2
		self.DakModel = "models/dak/turbine3.mdl"
		--self.DakSound = "dak/heavyheli.wav"
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
	self.MoveLeft = self.Inputs.Left.Value
	self.MoveRight = self.Inputs.Right.Value
	self.MoveUp = self.Inputs.Up.Value
	self.MoveDown = self.Inputs.Down.Value
	self.TurnLeft = self.Inputs.YawLeft.Value
	self.TurnRight = self.Inputs.YawRight.Value
	self.Active = self.Inputs.Activate.Value
	self.Rotor1 = self.Inputs.Rotor1Hitbox.Value
	self.Rotor2 = self.Inputs.Rotor2Hitbox.Value
	self.Body = self.Inputs.BodyHitbox.Value
    
    if self.DakEngine:IsValid() and self.Rotor1:IsValid() and self.Rotor2:IsValid() and self.Body:IsValid() then
    	if self.Rotor1.DakMaxHealth == nil then
    		DakTekSetupNewEnt(self.Rotor1)
    	end
    	if self.Rotor2.DakMaxHealth == nil then
    		DakTekSetupNewEnt(self.Rotor2)
    	end
    	if self.Body.DakMaxHealth == nil then
    		DakTekSetupNewEnt(self.Body)
    	end
    	if self.Rotor1.DakMaxHealth<=250 and self.Rotor2.DakMaxHealth<=250 and self.Body.DakMaxHealth<=250 and self.Rotor1:GetClass()=="dak_hitboxcontroller" and self.Rotor2:GetClass()=="dak_hitboxcontroller" and self.Body:GetClass()=="dak_hitboxcontroller" then
			if(self:GetParent():IsValid()) then
				if(self:GetParent():GetParent():IsValid()) then
					self.phy = self:GetParent():GetParent():GetPhysicsObject()
					self.base = self:GetParent():GetParent()
					if (self.box == nil) or (self.box == NULL) then
						self.box = Vector(   (self.base:OBBMaxs().x)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) - (self.base:OBBMaxs().y)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , (self.base:OBBMaxs().x)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) + (self.base:OBBMaxs().y)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , 0 )
					end
				end
			end
			if not(self:GetParent():IsValid()) then
				self.phy = self:GetPhysicsObject()
				self.base = self
			end

			if not(self.DakEngine.TotalMass==nil) then
		        if ((self.Active>0) and (self.DakEngine.TotalMass <= 30000)) then
		        	self.DakSpeed = self.DakSpeed*((20000/self.DakEngine.TotalMass)*self.DakEngine.PowerMod)
		        	self.Sound:ChangeVolume( 1, 1 )
					local hash = {}
					local res = {}
					for _,v in ipairs(self.DakEngine.Contraption) do
		   				if (not hash[v]) then
		    				res[#res+1] = v
		       				hash[v] = true
		   				end
					end
					for i=1, #res do
						if not(res[i]==NULL) then
							if res[i]:IsSolid() then
								if res[i]:GetPhysicsObject():IsGravityEnabled() then
									 res[i]:GetPhysicsObject():EnableGravity( false )
								end
							end
						end
					end

					if self.ForwardPerc > 0 then
						self.ForwardPerc = self.ForwardPerc - 1
					end
					if self.ForwardPerc < 0 then
						self.ForwardPerc = self.ForwardPerc + 1
					end
					if self.RightPerc > 0 then
						self.RightPerc = self.RightPerc - 1
					end
					if self.RightPerc < 0 then
						self.RightPerc = self.RightPerc + 1
					end
					if self.UpPerc > 0 then
						self.UpPerc = self.UpPerc - 1
					end
					if self.UpPerc < 0 then
						self.UpPerc = self.UpPerc + 1
					end
					if self.TurnPerc > 0 then
						self.TurnPerc = self.TurnPerc - 1
					end
					if self.TurnPerc < 0 then
						self.TurnPerc = self.TurnPerc + 1
					end
					self.Sound:ChangePitch( (math.max(math.abs(self.ForwardPerc),math.abs(self.RightPerc),math.abs(self.UpPerc)))+100, 1 )

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
		        	if self.MoveForward>0 then
		        		if self.ForwardPerc < 100 then
		        			self.ForwardPerc = self.ForwardPerc + 2
		        		end
		        	end
		        	if self.MoveReverse>0 then
		        		if self.ForwardPerc > -100 then
		        			self.ForwardPerc = self.ForwardPerc - 2
		        		end
		        	end

		        	if self.MoveRight>0 then
		        		if self.RightPerc < 100 then
		        			self.RightPerc = self.RightPerc + 2
		        		end
		        	end
		        	if self.MoveLeft>0 then
		        		if self.RightPerc > -100 then
		        			self.RightPerc = self.RightPerc - 2
		        		end
		        	end

		        	if self.MoveUp>0 then
		        		if self.UpPerc < 100 then
		        			self.UpPerc = self.UpPerc + 2
		        		end
		        	end
		        	if self.MoveDown>0 then
		        		if self.UpPerc > -100 then
		        			self.UpPerc = self.UpPerc - 2
		        		end
		        	end

		        	self.phy:ApplyForceCenter(Vector(self.ForwardPerc*self:GetForward()*self.phy:GetMass()*0.77*self.DakSpeed*self.DakHealth/self.DakMaxHealth)+Vector(self.RightPerc*self:GetRight()*self.phy:GetMass()*0.77*self.DakSpeed*0.5*self.DakHealth/self.DakMaxHealth)+Vector(self.UpPerc*self:GetUp()*self.phy:GetMass()*0.77*self.DakSpeed*2.5*self.DakHealth/self.DakMaxHealth))

		            self.HoverPos=Vector((self.base:GetPos()).x,(self.base:GetPos()).y,(self.base:GetPos()).z)

		            self.phy:ApplyForceCenter((self.HoverPos-self.base:GetPos())-Vector((self.base:GetVelocity()*0.05*self.phy:GetMass()).x,(self.base:GetVelocity()*0.05*self.phy:GetMass()).y,(self.base:GetVelocity()*0.2*self.phy:GetMass()).z))            

		            self.phy:AddAngleVelocity(-self.phy:GetAngleVelocity())

		            self.box = Vector(   (self.base:OBBMaxs().x)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) - (self.base:OBBMaxs().y)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , (self.base:OBBMaxs().x)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) + (self.base:OBBMaxs().y)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , 0 )
		            self.phy:ApplyForceOffset( (math.Clamp(self:GetAngles().pitch,-2.5,2.5)-(self.ForwardPerc/10-self:GetAngles().pitch))*self:GetUp()*25*self.phy:GetMass(), self.phy:GetPos()+self:GetForward()*5 )
		            self.phy:ApplyForceOffset( (math.Clamp(self:GetAngles().roll,-2.5,2.5)-(self.RightPerc/10-self:GetAngles().roll))*self:GetUp()*15*self.phy:GetMass(), self.phy:GetPos()+self:GetRight()*5 )
		            self.phy:ApplyForceOffset( self.DakSpeed*50*(24/math.abs(self.box.y))*self.TurnPerc*self:GetForward()*self.phy:GetMass(), self.phy:GetPos()+self:GetRight()*24/math.abs(self.box.y))
		            self.phy:ApplyForceOffset( -(math.Clamp(self:GetAngles().pitch,-2.5,2.5)-(self.ForwardPerc/10-self:GetAngles().pitch))*self:GetUp()*25*self.phy:GetMass(), self.phy:GetPos()-self:GetForward()*5 )
		            self.phy:ApplyForceOffset( -(math.Clamp(self:GetAngles().roll,-2.5,2.5)-(self.RightPerc/10-self:GetAngles().roll))*self:GetUp()*15*self.phy:GetMass(), self.phy:GetPos()-self:GetRight()*5 )
		            self.phy:ApplyForceOffset( -self.DakSpeed*50*(24/math.abs(self.box.y))*self.TurnPerc*self:GetForward()*self.phy:GetMass(), self.phy:GetPos()-self:GetRight()*24/math.abs(self.box.y) )
		        else
		        	self.Sound:ChangeVolume( 0, 2 )
		        	self.Sound:ChangePitch( 0, 2 )
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