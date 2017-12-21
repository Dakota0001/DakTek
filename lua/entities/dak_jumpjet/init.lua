AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Micro Jump Jet"
ENT.DakMass = 250
ENT.DakJumpCapacity = 3125
ENT.DakModel = "models/dak/025jumpjet.mdl"
ENT.DakPooled=0

function ENT:Initialize()
	self.DakHealth = self.DakMaxHealth

	self:SetModel( self.DakModel )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.DakHealth = self.DakMaxHealth
	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.DakActive = 0
	self.LastActive = 0
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
	if self.DakName == "Micro Jump Jet" then
			self.DakJumpCapacity = 5000
			self.DakMaxHealth = 10
			self.DakMass = 250
			self.DakModel = "models/dak/025jumpjet.mdl"
	end
	if self.DakName == "Light Jump Jet" then
			self.DakJumpCapacity = 10000
			self.DakMaxHealth = 20
			self.DakMass = 500
			self.DakModel = "models/dak/05jumpjet.mdl"
	end
	if self.DakName == "Standard Jump Jet" then
			self.DakJumpCapacity = 20000
			self.DakMaxHealth = 40
			self.DakMass = 1000
			self.DakModel = "models/dak/1jumpjet.mdl"
	end
	if self.DakName == "Heavy Jump Jet" then
			self.DakJumpCapacity = 40000
			self.DakMaxHealth = 80
			self.DakMass = 2000
			self.DakModel = "models/dak/2jumpjet.mdl"
	end
	if self.DakName == "Ultra Jump Jet" then
			self.DakJumpCapacity = 80000
			self.DakMaxHealth = 160
			self.DakMass = 4000
			self.DakModel = "models/dak/4jumpjet.mdl"
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

	if self.DakActive > self.LastActive then
		self:EmitSound( "dak/LRM.wav", 100, 50, 1)
	end
	self.LastActive = self.DakActive
	if self.DakActive > 0 then
		self:SetNWFloat("DakActiveVar",1)
	else
		self:SetNWFloat("DakActiveVar",0)
	end
	self:NextThink(CurTime()+0.25)
    return true
end

function ENT:PreEntityCopy()

	local info = {}
	local entids = {}

	info.DakName = self.DakName
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakColor = self:GetColor()
	info.DakJumpCapacity = self.DakJumpCapacity

	duplicator.StoreEntityModifier( self, "DakTek", info )

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then
		self.DakName = Ent.EntityMods.DakTek.DakName
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakJumpCapacity = Ent.EntityMods.DakTek.DakJumpCapacity
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

		self:PhysicsDestroy()
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:Activate()

		WireLib.TriggerOutput(self, "Cooldown", self.DakCooldown)
		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end