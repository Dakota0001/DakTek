AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 20
ENT.DakHealth = 20
ENT.DakName = "Light Hoverdrive"
ENT.DakModel = "models/dak/2motor.mdl"
ENT.DakSpeed = 0.7
ENT.DakMass = 5000
ENT.DakSound = "npc/combine_gunship/engine_whine_loop1.wav"
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
	self.Inputs = Wire_CreateInputs(self, { "Forward", "Reverse", "Left", "Right", "Activate" })
	self.Perc = 0
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
	if self.DakName == "Light Hoverdrive" then
		self.DakMaxHealth = 20
		self.DakMass = 5000
		self.DakSpeed = 1
		self.DakModel = "models/dak/2motor.mdl"
		--self.DakSound = "npc/combine_gunship/engine_whine_loop1.wav"
	end
	if self.DakName == "Standard Hoverdrive" then
		self.DakMaxHealth = 35
		self.DakMass = 10000
		self.DakSpeed = 2
		self.DakModel = "models/dak/3motor.mdl"
		--self.DakSound = "npc/combine_gunship/dropship_engine_distant_loop1.wav"
	end
	if self.DakName == "Heavy Hoverdrive" then
		self.DakMaxHealth = 50
		self.DakMass = 20000
		self.DakSpeed = 3
		self.DakModel = "models/dak/4motor.mdl"
		--self.DakSound = "npc/combine_gunship/dropship_onground_loop1.wav"
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
	self.Active = self.Inputs.Activate.Value
    
    if self.DakEngine:IsValid() then
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

			if self.Perc > 0 then
				self.Perc = self.Perc - 1
			end
			if self.Perc < 0 then
				self.Perc = self.Perc + 1
			end
			if self.TurnPerc > 0 then
				self.TurnPerc = self.TurnPerc - 1
			end
			if self.TurnPerc < 0 then
				self.TurnPerc = self.TurnPerc + 1
			end
			self.Sound:ChangePitch( (math.abs(self.Perc)*2)+50, 1 )


        	self.YawVal = 0
        	if self.MoveLeft>0 then
        		if self.TurnPerc < 50 then
        			self.TurnPerc = self.TurnPerc + 2
        		end
        	end
        	if self.MoveRight>0 then
        		if self.TurnPerc > -50 then
        			self.TurnPerc = self.TurnPerc - 2
        		end
        	end
        	if self.MoveForward>0 then
        		if self.Perc < 100 then
        			self.Perc = self.Perc + 2
        		end
        	end
        	if self.MoveReverse>0 then
        		if self.Perc > -100 then
        			self.Perc = self.Perc - 2
        		end
        	end
        	self.phy:ApplyForceCenter(Vector(self.Perc*self:GetForward()*self.phy:GetMass()*0.77*self.DakSpeed*self.DakHealth/self.DakMaxHealth))

            local GroundRay = {}
            GroundRay.start = self.base:GetPos()
            GroundRay.endpos = self.base:GetPos() + (Vector(0,0,-1) * 1000000)
            GroundRay.filter = { self.base, self.DakEngine.Contraption}
            if self.Filters == nil then
	            self.Filters = {}
				table.insert(self.Filters,self)
				table.insert(self.Filters,self.base)
				table.Add(self.Filters,self.DakEngine.Contraption)
			end
			GroundRay.filter = self.Filters

            GroundRay.mask = MASK_ALL
            self.GroundRay = util.TraceLine( GroundRay )
            self.POS=self.GroundRay.HitPos

            self.HoverPos=Vector((self.base:GetPos()).x,(self.base:GetPos()).y,self.POS.z+50)

            if ((self.HoverPos-self.base:GetPos()-self.base:GetVelocity()*0.1)*self.phy:GetMass()).z > 0 then
			self.phy:ApplyForceCenter(Vector(-self.base:GetVelocity().x*0.05*self.phy:GetMass(),-self.base:GetVelocity().y*0.05*self.phy:GetMass(),((self.HoverPos-self.base:GetPos()-self.base:GetVelocity()*0.1)*self.phy:GetMass()*10).z))            
            else
            self.phy:ApplyForceCenter(Vector(-self.base:GetVelocity().x*0.05*self.phy:GetMass(),-self.base:GetVelocity().y*0.05*self.phy:GetMass(),((self.HoverPos-self.base:GetPos()-self.base:GetVelocity()*0.1)*self.phy:GetMass()*0.2).z))            
            end
            self.phy:AddAngleVelocity(-self.phy:GetAngleVelocity())

            self.box = Vector(   (self.base:OBBMaxs().x)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) - (self.base:OBBMaxs().y)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , (self.base:OBBMaxs().x)*math.sin((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) + (self.base:OBBMaxs().y)*math.cos((self.base:GetAngles()-self:GetAngles()).yaw*math.pi/180) , 0 )

            self.phy:ApplyForceOffset( math.Clamp(self:GetAngles().pitch,-10,10)*Vector(0,0,1)*25*self.phy:GetMass(), self.phy:GetPos()+self:GetForward()*5 )
            self.phy:ApplyForceOffset( math.Clamp(self:GetAngles().roll,-10,10)*Vector(0,0,1)*25*self.phy:GetMass(), self.phy:GetPos()+self:GetRight()*5 )
            self.phy:ApplyForceOffset( self.DakSpeed*125*(24/math.abs(self.box.y))*self.TurnPerc/1*self:GetForward()*self.phy:GetMass(), self.phy:GetPos()+self:GetRight()*(24/math.abs(self.box.y)) )
            self.phy:ApplyForceOffset( -math.Clamp(self:GetAngles().pitch,-10,10)*Vector(0,0,1)*25*self.phy:GetMass(), self.phy:GetPos()-self:GetForward()*5 )
            self.phy:ApplyForceOffset( -math.Clamp(self:GetAngles().roll,-10,10)*Vector(0,0,1)*25*self.phy:GetMass(), self.phy:GetPos()-self:GetRight()*5)
            self.phy:ApplyForceOffset( -self.DakSpeed*125*(24/math.abs(self.box.y))*self.TurnPerc/1*self:GetForward()*self.phy:GetMass(), self.phy:GetPos()-self:GetRight()*(24/math.abs(self.box.y)) )

        else
        	self.Sound:ChangeVolume( 0, 2 )
        	self.Sound:ChangePitch( 0, 2 )
        end
        self.base:GetPhysicsObject():EnableGravity( true )

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