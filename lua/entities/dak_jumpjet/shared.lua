ENT.Type = "anim"
ENT.Base = "base_wire_entity"

ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 0, "DakActiveVar" )

end