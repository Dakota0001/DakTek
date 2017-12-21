AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakArmor = 0
ENT.DakName = "Salvage"
ENT.DakModel = ""
ENT.DakPooled = 0
ENT.DakLastDamagePos = Vector(0,0,0)
ENT.LastHP = 0

function ENT:Initialize()
	self:SetModel( self.DakModel )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMaterial("models/props_buildings/plasterwall021a")
	self:SetColor(Color(100,100,100,255))
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.SpawnTime = CurTime()

		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self)
		effectdata:SetAttachment(1)
		effectdata:SetMagnitude(.5)
		effectdata:SetScale(200)
		util.Effect("dakbreak", effectdata)
		self:EmitSound( "dak/break.wav", 100, 70, 1, 3)

	--self:GetPhysicsObject():ApplyForceCenter((self:GetPos()-self.DakLastDamagePos):GetNormalized()*2500*math.abs(self.LastHP))
	self:GetPhysicsObject():ApplyForceCenter( VectorRand()*70*self:GetPhysicsObject():GetMass()*math.Rand(2,10))

end

function ENT:Think()
	self:SetMaterial("models/props_buildings/plasterwall021a")
	self:SetColor(Color(100,100,100,255))
	self:GetPhysicsObject():SetMass(250)
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )

	if self.SpawnTime+20 < CurTime() then
		self:Remove()
	end

end