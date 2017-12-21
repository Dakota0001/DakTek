include("shared.lua")

function ENT:Draw()

	self:DrawModel()
	if self:GetNWFloat("DakActiveVar") == 1 then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self)
		effectdata:SetAttachment(1)
		effectdata:SetMagnitude(.5)
		effectdata:SetScale(200)
		util.Effect("jumptrail", effectdata)
	end

end

