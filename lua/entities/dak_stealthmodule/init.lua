AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Stealth Module"
ENT.DakModel = "models/dak/ecm.mdl"
ENT.DakMass = 4000
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
	self.Inputs = Wire_CreateInputs(self, { "Active" })
	self.LastActive=0
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
	if self.DakName == "Stealth Module" then
		self.DakMaxHealth = 10
		self.DakMass = 4000
		self.DakModel = "models/dak/ecm.mdl"	
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
	self.Active = self.Inputs.Active.Value
    
    if self.DakEngine:IsValid() then
        

    	if self.Active>0 and(not(self.Active==self.LastActive)) then
    		self.ColorList = {}
    		self.MatList = {}
    		self.RenderList = {}
    		self.deadcontraption = self.DakEngine.Contraption
    		for i = 1, table.Count(self.DakEngine.Contraption) do
    			if not(self.DakEngine.Contraption[i]==NULL) then
					if self.DakEngine.Contraption[i]:IsSolid() then
    					table.insert( self.MatList, i, self.DakEngine.Contraption[i]:GetMaterial() )
    					table.insert( self.ColorList, i, self.DakEngine.Contraption[i]:GetColor() )
    					table.insert( self.RenderList, i, self.DakEngine.Contraption[i]:GetRenderMode() )

    					if self.DakEngine.Contraption[i]:GetPhysicsObject():GetMass()>=250 then
    						self.DakEngine.Contraption[i]:SetMaterial("models/shadertest/predator")
    						self.DakEngine.Contraption[i]:DrawShadow( false )
    					else
    						self.DakEngine.Contraption[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
    						self.DakEngine.Contraption[i]:SetColor(Color( 0, 0, 0, 0 ))
    						self.DakEngine.Contraption[i]:DrawShadow( false )
    					end
    				end
				end
    		end
    		self.DakEngine.Stealthed = 1
    	end
    	if self.Active==0 and(not(self.Active==self.LastActive)) then
    		for i = 1, table.Count(self.deadcontraption) do
    			if not(self.deadcontraption[i]==NULL) then
					if self.deadcontraption[i]:IsSolid() then
    					self.deadcontraption[i]:SetMaterial(self.MatList[i])
    					self.deadcontraption[i]:SetRenderMode( self.RenderList[i] )
    					self.deadcontraption[i]:SetColor(self.ColorList[i])
    					self.deadcontraption[i]:DrawShadow( true )
    				end
    			end
    		end
    		self.DakEngine.Stealthed = 0
    	end
    else
    	if not(self.LastActive==0) then
			for i = 1, table.Count(self.deadcontraption) do
				if not(self.deadcontraption[i]==NULL) then
					if self.deadcontraption[i]:IsSolid() then
						self.deadcontraption[i]:SetMaterial(self.MatList[i])
						self.deadcontraption[i]:SetRenderMode( self.RenderList[i] )
						self.deadcontraption[i]:SetColor(self.ColorList[i])
						self.deadcontraption[i]:DrawShadow( true )
					end
				end
			end
			self.DakEngine.Stealthed = 0
		end
    end
    self.LastActive = self.Active
    

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

function ENT:OnRemove()
	if not(self.deadcontraption==nil) then
		for i = 1, table.Count(self.deadcontraption) do
			if not(self.deadcontraption[i]==NULL) then
				if self.deadcontraption[i]:IsSolid() then
					self.deadcontraption[i]:SetMaterial(self.MatList[i])
					self.deadcontraption[i]:SetRenderMode( self.RenderList[i] )
					self.deadcontraption[i]:SetColor(self.ColorList[i])
				end
			end
		end
	end
	self.DakEngine.Stealthed = 0
end