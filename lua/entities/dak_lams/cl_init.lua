include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if(self:GetNWBool("BeamOn")) then
		if IsValid(self:GetNWEntity("Target")) then
			if (self:GetAttachment( 1 )) then
				local Dist = self:GetAttachment( 1 ).Pos:Distance(self:GetNWEntity("Target"):GetPos())
				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetNWEntity("Target"):GetPos())
				effectdata:SetEntity(self)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(1)
				effectdata:SetScale(200)
				util.Effect(self:GetNWString("BurnFX"), effectdata)
				local effectdata2 = EffectData()
				effectdata2:SetOrigin(LocalPlayer():GetPos() + LocalPlayer():EyeAngles():Forward()*100)
				effectdata2:SetStart(self:GetAttachment( 1 ).Pos)
				effectdata2:SetEntity(self:GetNWEntity("Target"))
				effectdata2:SetAttachment(1)
				effectdata2:SetMagnitude(1)
				effectdata2:SetScale(200)
				util.Effect(self:GetNWString("BeamFX"), effectdata2)
			end
		end
	end
end