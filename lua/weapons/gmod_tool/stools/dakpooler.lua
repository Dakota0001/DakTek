 
TOOL.Category = "DakTek"
TOOL.Name = "#Tool.dakpooler.listname"
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 

if (CLIENT) then
language.Add( "Tool.dakpooler.listname", "DakTek Health Pooler" )
language.Add( "Tool.dakpooler.name", "DakTek Health Pooler" )
language.Add( "Tool.dakpooler.desc", "Pools the health of entities together to be linked to a controller." )
language.Add( "Tool.dakpooler.0", "Left click to select props. Right click to link props to a controller." )
end
TOOL.ClientConVar[ "DakChatFeedback" ] = 1
--TOOL.ClientConVar[ "myparameter" ] = "fubar"

TOOL.PropList = {}
TOOL.ColorList = {}
TOOL.LastLeftClick = CurTime()
TOOL.LastRightClick = CurTime()
TOOL.LastReload = CurTime()
 
function TOOL:LeftClick( trace )
	if CurTime()>self.LastLeftClick then
		local Target = trace.Entity
		if Target:GetClass()== "dak_hitboxcontroller" then
			if table.HasValue( self.PropList, NULL ) then
				if (CLIENT) or (game.SinglePlayer()) then
					self:GetOwner():EmitSound("npc/roller/mine/rmine_shockvehicle1.wav")
					if self:GetClientNumber( "DakChatFeedback" ) == 1 then
						self:GetOwner():ChatPrint("ERROR: Please reload tool [press R].")
					end
				end
			else
				if (SERVER) or (game.SinglePlayer()) then
					for i = 1, table.Count(Target.HitBox) do
					table.insert( self.PropList, table.Count(self.PropList)+1, Target.HitBox[i] )
					table.insert( self.ColorList, table.Count(self.ColorList)+1, Target.HitBox[i]:GetColor() )
					Target.HitBox[i]:SetColor(Color(0,255,0,255))
					end
				end
			end
		else
			if table.HasValue( self.PropList, NULL ) then
				if (CLIENT) or (game.SinglePlayer()) then
					self:GetOwner():EmitSound("npc/roller/mine/rmine_shockvehicle1.wav")
					if self:GetClientNumber( "DakChatFeedback" ) == 1 then
						self:GetOwner():ChatPrint("ERROR: Please reload tool [press R].")
					end
				end
			else
				if not(string.Explode("_",Target:GetClass(),false)[1] == "dak") and Target:IsValid() then
					if table.HasValue( self.PropList, Target ) then
						self.Ent1 = Target
						if (CLIENT) or (game.SinglePlayer()) then
							self:GetOwner():EmitSound("/items/ammocrate_open.wav")
							if self:GetClientNumber( "DakChatFeedback" ) == 1 then
								self:GetOwner():ChatPrint("Entity deselected.")
							end
						end
						self.Key = table.KeyFromValue( self.PropList, self.Ent1 )
						self.Ent1:SetColor(self.ColorList[self.Key])
						table.remove( self.PropList, self.Key )
						table.remove( self.ColorList, self.Key )
					else
						self.Ent1 = Target
						if (CLIENT) or (game.SinglePlayer()) then
							self:GetOwner():EmitSound("/items/ammocrate_open.wav")
							if self:GetClientNumber( "DakChatFeedback" ) == 1 then
								self:GetOwner():ChatPrint("Entity selected.")
							end
						end
						table.insert( self.PropList, table.Count(self.PropList)+1, self.Ent1 )
						table.insert( self.ColorList, table.Count(self.ColorList)+1, self.Ent1:GetColor() )
						self.Ent1:SetColor(Color(0,255,0,255))
					end
				end
			end
		end
	self.LastLeftClick = CurTime()
	end
end
 
function TOOL:RightClick( trace )
	if CurTime()>self.LastRightClick then
		if table.HasValue( self.PropList, NULL ) then
			if (CLIENT) or (game.SinglePlayer()) then
				self:GetOwner():EmitSound("npc/roller/mine/rmine_shockvehicle1.wav")
				if self:GetClientNumber( "DakChatFeedback" ) == 1 then
					self:GetOwner():ChatPrint("ERROR: Please reload tool [press R].")
				end
			end
		else
			local Target = trace.Entity
			if(Target:GetClass() == "dak_hitboxcontroller") then
				if (SERVER) or (game.SinglePlayer()) then
					if table.Count(self.PropList)>0 then
						self.Ent2 = Target
						if table.Count(self.Ent2.HitBox)>0 then
							for i = 1, table.Count(self.Ent2.HitBox) do
								if not(self.Ent2.HitBox[i]==nil) then
									self.Ent2.HitBox[i].DakPooled = 0
									self.Ent2.HitBox[i].Controller = nil
								end
							end
						end
						self.Ent2.HitBox = self.PropList
						for i = 1, table.Count(self.PropList) do
							self.PropList[i].DakPooled = 1
							self.PropList[i].Controller = self.Ent2
							self.Key = table.KeyFromValue( self.PropList, self.PropList[i] )
							self.PropList[self.Key]:SetColor(self.ColorList[self.Key])
						end
						self.PropList = {}
						self.ColorList = {}
						self:GetOwner():EmitSound("/items/ammocrate_close.wav")
						if self:GetClientNumber( "DakChatFeedback" ) == 1 then
							self:GetOwner():ChatPrint("Health Pooled. Respawn for it to take effect.")
						end
					else
						self.Ent2 = Target
						--if (SERVER) or (game.SinglePlayer()) then
						if table.Count(self.Ent2.HitBox)>0 then
							for i = 1, table.Count(self.Ent2.HitBox) do
								if not(self.Ent2.HitBox[i] == nil) then
									self.Ent2.HitBox[i].DakPooled = 0
									self.Ent2.HitBox[i].Controller = nil
								end
							end
						end
						self.Ent2.HitBox = {}
						--end
						self:GetOwner():EmitSound("/items/ammocrate_close.wav")
						if self:GetClientNumber( "DakChatFeedback" ) == 1 then
							self:GetOwner():ChatPrint("Controller unlinked, hitbox unpooled. Respawn for it to take effect, otherwise errors may occur.")
						end
					end
					self.Ent2.DakActive = 0
					self.Ent2.DakHealth = 10
					self.Ent2.DakMaxHealth = 10
				end
			end	
		end
	self.LastRightClick = CurTime()
	end
end

function TOOL:Reload()
	if CurTime()>self.LastReload then
		if table.Count(self.PropList)>0 then
			for i = 1, table.Count(self.PropList) do
				self.Key = table.KeyFromValue( self.PropList, self.PropList[i] )
				if self.PropList[self.Key]:IsValid() then
					self.PropList[self.Key]:SetColor(self.ColorList[self.Key])
				end
			end
		end
		self.PropList = {}
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
	panel:AddControl("Header",{Text = "DakTek Health Pooler", Description	= "Selects entities to be linked to a hitbox controller. Right clicking on a controller with nothing selected will unlink the controller.\n\nRules:\n1. Props may not be in more than one pool\n2. You may not use this to have a single hitbox\n3. The hardpoint[prop that you parent your gun to that is contrained to the vehicle] must be grouped into the section it is part of, no keeping your weapon if you lose the whole arm. Explanation: if your hardpoint clips multiple hitboxes, it goes into the one that is infront of the direction it points. \n4. Mechs must have 8 hitboxes: 2 arms, 2 side torsos, Rear Torso, 2 legs, and Frontal Torso. Exception if you have no arms.\n5. Tanks must have 7 hitboxes: Front, Left, Right, Rear, 2 treads, Turret. Exception if you have no turret.\n6. Hover Tanks must have 5 hit boxes: Front, Left, Right, Rear, Turret. Exception if you have no turret.\n6. Aircraft must have 3 hit boxes: Body, and 2 Wings or Rotors.\n7. Roofs will be considered frontal armor."})	
	panel:AddControl("CheckBox", {Label = "Chat Feedback", Description ="Check for feedback in chat when actions are completed with this tool.", Command = "dakpooler_DakChatFeedback"})
end
 
