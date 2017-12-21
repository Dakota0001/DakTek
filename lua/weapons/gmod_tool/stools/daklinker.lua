 
TOOL.Category = "DakTek"
TOOL.Name = "#Tool.daklinker.listname"
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 
TOOL.LastLeftClick = CurTime()
TOOL.LastRightClick = CurTime()

if (CLIENT) then
language.Add( "Tool.daklinker.listname", "DakTek Linker" )
language.Add( "Tool.daklinker.name", "DakTek Linker" )
language.Add( "Tool.daklinker.desc", "Links DekTek guns to engines." )
language.Add( "Tool.daklinker.0", "Left click to select the gun. Right click to link the gun to the selected engine." )
end
--TOOL.ClientConVar[ "myparameter" ] = "fubar"
 
function TOOL:LeftClick( trace )
	if CurTime()>self.LastLeftClick then
		local Target = trace.Entity
		if(string.Explode("_",Target:GetClass(),false)[1] == "dak") then
			self.Ent1 = Target
			if (CLIENT) or (game.SinglePlayer()) then
				self:GetOwner():EmitSound("/items/ammocrate_open.wav")
				self:GetOwner():ChatPrint("Entity selected.")
			end
		end
	self.LastLeftClick = CurTime()
	end
end
 
function TOOL:RightClick( trace )
	if CurTime()>self.LastRightClick then
		local Target = trace.Entity
		if not(self.Ent1==NULL) then
			if(Target:GetClass() == "dak_engine") then
				self.Ent2 = Target
				self.Ent1.DakEngine = self.Ent2
				if (CLIENT) or (game.SinglePlayer()) then
					self:GetOwner():EmitSound("/items/ammocrate_close.wav")
					self:GetOwner():ChatPrint("Items linked.")
				end
			end	
		end
	self.LastRightClick = CurTime()
	end
end
 
function TOOL.BuildCPanel( panel )
	panel:AddControl("Header", { Text = "DakTek Linker", Description = "Links DakTek Entities to engines" })

	local DLabel = vgui.Create( "DLabel", panel )
	DLabel:SetPos( 17, 50 )
	DLabel:SetAutoStretchVertical( true )
	DLabel:SetText( "This tool just links guns to engines. Ammo and heatsinks are automatically linked to engines that are part of their contraption" )
	DLabel:SetTextColor(Color(0,0,0,255))
	DLabel:SetWide( 225 )
	DLabel:SetWrap( true )
end
 
