include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	--Debug stuff commented out
	--local Attachment = self:GetAttachment( 1 )
	--local shootOrigin = Attachment.Pos
	--local shootAngles = self:GetAngles()
	--local shootDir = shootAngles:Forward()
	--local Dist = self:GetAttachment( 1 ).Pos:Distance(self:GetNWVector("BeamPos"))
	--render.DrawWireframeBox( shootOrigin, Angle( 0, 0, 0 ), Vector(-2.5,-2.5,-2.5), Vector(2.5,2.5,2.5), Color( 255, 255, 255 ), true )
	--render.DrawWireframeBox( shootOrigin + (shootDir * Dist), Angle( 0, 0, 0 ), Vector(-2.5,-2.5,-2.5), Vector(2.5,2.5,2.5), Color( 255, 255, 255 ), true)
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