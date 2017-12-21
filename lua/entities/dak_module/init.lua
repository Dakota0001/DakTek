AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Module"
ENT.DakModel = "models/dak/microstandardengine.mdl"
ENT.DakMass = 1000
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
	self.DakMaxHealth = 10
	self.DakMass = 1000
	self.DakModel = "models/dak/microstandardengine.mdl"	
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

    if IsValid(self.DakEngine) then
    	if self.DakName == "High Yield Payloads Module" then
	    	self.DakEngine.HighYieldPayloads = 1
	    end
	    if self.DakName == "Missile Loader Module" then
	    	self.DakEngine.MissileLoader = 1
	    end
	    if self.DakName == "Beam Focus Module" then
	    	self.DakEngine.BeamFocus = 1
	    end
	    if self.DakName == "Tight Wadding Module" then
	    	self.DakEngine.TightWadding = 1
	    end
	    if self.DakName == "Dumbfire Fins Module" then
	    	self.DakEngine.DumbfireFins = 1
	    end
	    if self.DakName == "Missile Exhaust Venting Module" then
	    	self.DakEngine.MissileExhaustVenting = 1
	    end
	    if self.DakName == "Laser Insulation Module" then
	    	self.DakEngine.LaserInsulation = 1
	    end
	    if self.DakName == "PPC Frequency Scrambler Module" then
	    	self.DakEngine.PPCFrequencyScrambler = 1
	    end
	    if self.DakName == "Weapon Shielding Module" then
	    	self.DakEngine.WeaponShielding = 1
	    end
	    if self.DakName == "Heavy Armor Module" then
	    	self.DakEngine.HeavyArmor = 1
	    end
	    if self.DakName == "Reactive Armor Module" then
	    	self.DakEngine.ReactiveArmor = 1
	    end
	    if self.DakName == "Reflective Armor Module" then
	    	self.DakEngine.ReflectiveArmor = 1
	    end
	    if self.DakName == "Enhanced BAP Module" then
	    	self.DakEngine.EnhancedBAP = 1
	    end
	    if self.DakName == "Heatsink Supercooling Module" then
	    	self.DakEngine.HeatsinkSupercooling = 1
	    end
	    if self.DakName == "Reinforced Heatsinks Module" then
	    	self.DakEngine.ReinforcedHeatsinks = 1
	    end
	    if self.DakName == "Efficient LAMS Module" then
	    	self.DakEngine.EfficientLAMS = 1
	    end
    end
    self:NextThink(CurTime()+0.25)
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
	if IsValid(self.DakEngine) then
    	if self.DakName == "High Yield Payloads Module" then
	    	self.DakEngine.HighYieldPayloads = 0
	    end
	    if self.DakName == "Missile Loader Module" then
	    	self.DakEngine.MissileLoader = 0
	    end
	    if self.DakName == "Beam Focus Module" then
	    	self.DakEngine.BeamFocus = 0
	    end
	    if self.DakName == "Tight Wadding Module" then
	    	self.DakEngine.TightWadding = 0
	    end
	    if self.DakName == "Dumbfire Fins Module" then
	    	self.DakEngine.DumbfireFins = 0
	    end
	    if self.DakName == "Missile Exhaust Venting Module" then
	    	self.DakEngine.MissileExhaustVenting = 0
	    end
	    if self.DakName == "Laser Insulation Module" then
	    	self.DakEngine.LaserInsulation = 0
	    end
	    if self.DakName == "PPC Frequency Scrambler Module" then
	    	self.DakEngine.PPCFrequencyScrambler = 0
	    end
	    if self.DakName == "Weapon Shielding Module" then
	    	self.DakEngine.WeaponShielding = 0
	    end
	    if self.DakName == "Heavy Armor Module" then
	    	self.DakEngine.HeavyArmor = 0
	    end
	    if self.DakName == "Reactive Armor Module" then
	    	self.DakEngine.ReactiveArmor = 0
	    end
	    if self.DakName == "Reflective Armor Module" then
	    	self.DakEngine.ReflectiveArmor = 0
	    end
	    if self.DakName == "Enhanced BAP Module" then
	    	self.DakEngine.EnhancedBAP = 0
	    end
	    if self.DakName == "Heatsink Supercooling Module" then
	    	self.DakEngine.HeatsinkSupercooling = 0
	    end
	    if self.DakName == "Reinforced Heatsinks Module" then
	    	self.DakEngine.ReinforcedHeatsinks = 0
	    end
	    if self.DakName == "Efficient LAMS Module" then
	    	self.DakEngine.EfficientLAMS = 0
	    end
    end
end