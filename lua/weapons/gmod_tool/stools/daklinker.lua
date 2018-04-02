 
TOOL.Category = "DakTek"
TOOL.Name = "#Tool.daklinker.listname"
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 

TOOL.EntList = {}
TOOL.ColorList = {}
TOOL.LastLeftClick = CurTime()
TOOL.LastRightClick = CurTime()
TOOL.LastReload = CurTime()

TOOL.ClientConVar[ "DakChatFeedback" ] = 1

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
			if table.HasValue( self.EntList, Target ) then
				self.Ent1 = Target
				if (CLIENT) or (game.SinglePlayer()) then
					self:GetOwner():EmitSound("/items/ammocrate_open.wav")
					if self:GetClientNumber( "DakChatFeedback" ) == 1 then
						self:GetOwner():ChatPrint("Entity deselected.")
					end
				end
				self.Key = table.KeyFromValue( self.EntList, self.Ent1 )
				self.Ent1:SetColor(self.ColorList[self.Key])
				table.remove( self.EntList, self.Key )
				table.remove( self.ColorList, self.Key )
			else
				self.Ent1 = Target
				if (CLIENT) or (game.SinglePlayer()) then
					self:GetOwner():EmitSound("/items/ammocrate_open.wav")
					if self:GetClientNumber( "DakChatFeedback" ) == 1 then
						self:GetOwner():ChatPrint("Entity selected.")
					end
				end
				table.insert( self.EntList, table.Count(self.EntList)+1, self.Ent1 )
				table.insert( self.ColorList, table.Count(self.ColorList)+1, self.Ent1:GetColor() )
				self.Ent1:SetColor(Color(0,255,0,255))
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
				if table.Count(self.EntList)>0 then
					for i = 1, table.Count(self.EntList) do
						self.EntList[i].DakEngine = self.Ent2
						self.Key = table.KeyFromValue( self.EntList, self.EntList[i] )
						if self.EntList[self.Key]:IsValid() then
							self.EntList[self.Key]:SetColor(self.ColorList[self.Key])
						end
					end
				end
				self.EntList = {}
				self.ColorList = {}
				if (CLIENT) or (game.SinglePlayer()) then
					self:GetOwner():EmitSound("/items/ammocrate_close.wav")
					self:GetOwner():ChatPrint("Items linked.")
				end
			end	
		end
	self.LastRightClick = CurTime()
	end
end
 
function TOOL:Reload()
	if CurTime()>self.LastReload then
		if table.Count(self.EntList)>0 then
			for i = 1, table.Count(self.EntList) do
				self.Key = table.KeyFromValue( self.EntList, self.EntList[i] )
				if self.EntList[self.Key]:IsValid() then
					self.EntList[self.Key]:SetColor(self.ColorList[self.Key])
				end
			end
		end
		self.EntList = {}
		self.ColorList = {}
		if (CLIENT) or (game.SinglePlayer()) then
			self:GetOwner():EmitSound("npc/scanner/scanner_siren1.wav")
			if self:GetClientNumber( "DakChatFeedback" ) == 1 then
				self:GetOwner():ChatPrint("Tool reloaded.")
			end
		end
	self.LastReload = CurTime()
	end
end

function TOOL.BuildCPanel( panel )
	panel:AddControl("Header",{Text = "DakTek Linker", Description	= "This tool just links guns, and some other entities to engines. Ammo and heatsinks are automatically linked to engines that are part of their contraption"})	
	panel:AddControl("CheckBox", {Label = "Chat Feedback", Description ="Check for feedback in chat when actions are completed with this tool.", Command = "daklinker_DakChatFeedback"})

end
 
