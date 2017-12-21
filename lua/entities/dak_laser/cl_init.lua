include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if(self:GetNWBool("BeamOn")) then
		if (self:GetAttachment( 1 )) then
			local Dist = self:GetNWFloat("BeamDist")
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetAttachment( 1 ).Pos + (self:GetForward() * Dist))
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(1)
			effectdata:SetScale(200)
			util.Effect(self:GetNWString("BurnFX"), effectdata)
			local effectdata2 = EffectData()
			effectdata2:SetOrigin(LocalPlayer():GetPos() + LocalPlayer():EyeAngles():Forward()*250*math.Clamp((90/LocalPlayer():GetFOV()),1,4) )
			effectdata2:SetStart(self:GetAttachment( 1 ).Pos)
			effectdata2:SetEntity(self)
			effectdata2:SetAttachment(1)
			effectdata2:SetMagnitude(Dist)
			effectdata2:SetScale(self:GetNWFloat("Duration"))
			util.Effect(self:GetNWString("BeamFX"), effectdata2)
		end
	end
end
