AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Sensor"
ENT.DakModel = "models/dak/sensor.mdl"
ENT.DakMass = 250
ENT.DakPooled=0
ENT.Initialized = false

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
	self.Inputs = Wire_CreateInputs(self, { "Next", "Previous","NoTargetToggle" })
	self.Outputs = WireLib.CreateOutputs( self, { "Target [ENTITY]", "TargetPos [VECTOR]" ,"Targets [ARRAY]", "HasTarget" } )
	self.Position = 1
	self.LastNext = 0
	self.LastPrevious = 0
	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.Initialized = true
end

function ENT:Think()
	if self.Initialized == true then
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
		if self.DakName == "Sensor" then
			self.DakMaxHealth = 10
			self.DakMass = 250
			self.DakModel = "models/dak/sensor.mdl"	
		end
		if self.DakHealth > self.DakMaxHealth then
			self.DakHealth = self.DakMaxHealth
		end
		if not(self:GetModel() == self.DakModel) then
			self:SetModel(self.DakModel)
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
		end
		self:GetPhysicsObject():SetMass(self.DakMass)
		self.Next = self.Inputs.Next.Value
		self.Previous = self.Inputs.Previous.Value
		self.Drop = self.Inputs.NoTargetToggle.Value
	    
	    if self.DakEngine:IsValid() then
	    	self.Targets = ents.FindByClass( "dak_engine" )
	    	self.PossibleTargets = {}
	    	for i = 1, #self.Targets do
	    		local SensorTrace = {}
	            SensorTrace.start = self:GetPos()
	            SensorTrace.endpos = self.Targets[i]:GetPos()
	            if self.Filters == nil then
		            self.Filters = {}
					table.insert(self.Filters,self)
					table.Add(self.Filters,self.DakEngine.Contraption)
				end
				SensorTrace.filter = self.Filters
	            SensorTrace.mask = MASK_SOLID_BRUSHONLY
	            self.SensorTrace = util.TraceLine( SensorTrace )
	            self.POS=self.SensorTrace.HitPos
	            if self.POS:Distance(self.Targets[i]:GetPos())<10 then
	            	if not(self.Targets[i]==self.DakEngine) then
	            		if (self.Targets[i].ECM==0)or(self.Targets[i].Tagged==1)or(self.Targets[i].NARCed==1) then
	            			table.insert(self.PossibleTargets,self.Targets[i])
	            		end
	            	end
	            else
	            	if not(self.Targets[i]==self.DakEngine) then
	            		if (self.Targets[i].Tagged==1)or(self.Targets[i].NARCed==1) then
	            			table.insert(self.PossibleTargets,self.Targets[i])
	            		end
	            	end
	            end
	        end

	        WireLib.TriggerOutput(self, "Targets", self.PossibleTargets)

			self.Check = 0
			if not(self.Targets[self.Position]==nil) then
				local SensorTrace = {}
	            SensorTrace.start = self:GetPos()
	            SensorTrace.endpos = self.Targets[self.Position]:GetPos()
	            if self.Filters == nil then
		            self.Filters = {}
					table.insert(self.Filters,self)
					table.Add(self.Filters,self.DakEngine.Contraption)
				end
				SensorTrace.filter = self.Filters
	            SensorTrace.mask = MASK_SOLID_BRUSHONLY
	            self.SensorTrace = util.TraceLine( SensorTrace )
	            self.POS=self.SensorTrace.HitPos
	            
	            if self.POS:Distance(self.Targets[self.Position]:GetPos())<10 then
	            	if not(self.Targets[self.Position]==self.DakEngine) then
	            		if (self.Targets[self.Position].ECM==0)or(self.Targets[self.Position].Tagged==1)or(self.Targets[self.Position].NARCed==1) then
	            			self.Check = self.Check+1
	            		end
	            	end
	            else
	            	if not(self.Targets[self.Position]==self.DakEngine) then
	            		if (self.Targets[self.Position].Tagged==1)or(self.Targets[self.Position].NARCed==1) then
	            			self.Check = self.Check+1
	            		end
	            	end
	            end
	        end

	        if self.Drop > 0 then
	        	WireLib.TriggerOutput(self, "Target", NULL )
	    		WireLib.TriggerOutput(self, "TargetPos", Vector(0,0,0) )
	    		WireLib.TriggerOutput(self, "HasTarget", 0 )
	        else
		        if table.Count(self.PossibleTargets)>0 and(self.Check>0) then
		        	WireLib.TriggerOutput(self, "Target", self.Targets[self.Position])
		        	WireLib.TriggerOutput(self, "TargetPos", self.Targets[self.Position]:GetPos() )
		        	WireLib.TriggerOutput(self, "HasTarget", 1 )
		    	else
		    		WireLib.TriggerOutput(self, "Target", NULL )
		    		WireLib.TriggerOutput(self, "TargetPos", Vector(0,0,0) )
		    		WireLib.TriggerOutput(self, "HasTarget", 0 )
		    	end
		    end

		end
		self.LastNext = self.Next
		self.LastPrevious = self.Previous
	end
	self:NextThink(CurTime()+0.25)
    return true
end

function ENT:DakCheckLegalTarget(Direction)
	self.Position=self.Position+Direction
	if self.Position > table.Count(self.Targets) then
       	self.Position = 1
    end
    if self.Position == 0 then
        self.Position = table.Count(self.Targets)
    end
	local Target = self.Targets[self.Position]
	if table.Count(self.PossibleTargets)>0 then
		local SensorTrace = {}
    	SensorTrace.start = self:GetPos()
    	SensorTrace.endpos = Target:GetPos()
    	if self.Filters == nil then
	    	self.Filters = {}
			table.insert(self.Filters,self)
			table.Add(self.Filters,self.DakEngine.Contraption)
		end
		SensorTrace.filter = self.Filters
    	SensorTrace.mask = MASK_SOLID_BRUSHONLY
    	self.SensorTrace = util.TraceLine( SensorTrace )
    	self.POS=self.SensorTrace.HitPos
    	if self.POS:Distance(Target:GetPos())<10 then
    	    if not(Target==self.DakEngine) then
    	        if (Target.ECM==0)or(Target.Tagged==1)or(Target.NARCed==1) then
     		       	return true
    	        end
    	    end
   		else
    	    if not(Target==self.DakEngine) then
    	        if (Target.Tagged==1)or(Target.NARCed==1) then
   		         	return true
    	        end
    	    end
    	end
   		self:DakCheckLegalTarget(Direction)
   	end
end

function ENT:TriggerInput(iname, value)
	if self.Initialized == true then
		if not(self.Targets == nil) then
			if table.Count(self.Targets) > 0 then
				if (iname == "Next") then
					if value>0 then
						self:DakCheckLegalTarget(1)
					end
				end
			end
			if table.Count(self.Targets) > 0 then
				if (iname == "Previous") then
					if value>0 then
						self:DakCheckLegalTarget(-1)
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
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
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
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakOwner = Player
		self.DakHealth = self.DakMaxHealth
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

		if not(Ent.EntityMods.DakTek.DakMat1==nil) then
			self:SetSubMaterial( 0, Ent.EntityMods.DakTek.DakMat0 )
			self:SetSubMaterial( 1, Ent.EntityMods.DakTek.DakMat1 )
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