ENT.Type = "anim"
ENT.Base = "base_wire_entity"

ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Editable = true

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 	0, "WalkStrideLength", 	{ KeyName = "walkstridelength", 	Edit = { type = "Float", 		order = 1, min = 0.01, max = 10 } } )
	self:NetworkVar( "Float", 	1, "WalkStrideHeight", 	{ KeyName = "walkstrideheight", 	Edit = { type = "Float", 		order = 2, min = 0.01, max = 10 } } )
	self:NetworkVar( "Float", 	2, "WalkHipBobMultiplier", 	{ KeyName = "walkhipbobmultiplier", 	Edit = { type = "Float", 		order = 3, min = 0, max = 5 } } )
	self:NetworkVar( "Float", 	3, "SprintStrideLength", 	{ KeyName = "sprintstridelength", 	Edit = { type = "Float", 		order = 4, min = 0.01, max = 10 } } )
	self:NetworkVar( "Float", 	4, "SprintStrideHeight", 	{ KeyName = "sprintstrideheight", 	Edit = { type = "Float", 		order = 5, min = 0.01, max = 10 } } )
	self:NetworkVar( "Float", 	5, "SprintHipBobMultiplier", 	{ KeyName = "sprinthipbobmultiplier", 	Edit = { type = "Float", 		order = 6, min = 0, max = 5 } } )
	self:NetworkVar( "Float", 	6, "CrouchPercent", 	{ KeyName = "crouchpercent", 	Edit = { type = "Float", 		order = 7, min = 0, max = 0.5 } } )
	self:NetworkVar( "Float", 	7, "JumpForwardBias", 	{ KeyName = "jumpforwardbias", 	Edit = { type = "Float", 		order = 8, min = 0, max = 0.5 } } )
	self:NetworkVar( "Float", 	8, "ExtraHeight", 	{ KeyName = "extraheight", 	Edit = { type = "Float", 		order = 9, min = 0, max = 100 } } )
	self:NetworkVar( "Float", 	9, "StrideCenter", 	{ KeyName = "stridecenter", 	Edit = { type = "Float", 		order = 10, min = -100, max = 100 } } )

		--self.StrideLength = 2.2
        --self.StrideHeight = 0.3
        --self.HipBobMultiplier = 1
       	--self.CrouchPercent = 0.9

end
