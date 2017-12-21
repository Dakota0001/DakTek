AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "HitBox Controller"
ENT.HitBox = {}
ENT.DakActive = 0
ENT.DakIsLeg = 0
ENT.LegBroke = 0
ENT.HeavyArmor = 0
ENT.ReactiveArmor = 0
ENT.ReflectiveArmor = 0
ENT.StandardEngine = 0
ENT.CompactEngine = 0

function ENT:Initialize()
	self:SetModel( "models/bull/gates/logic.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.Outputs = WireLib.CreateOutputs( self, { "Health", "HealthPercent" } )
	self.DakActive = 0
	self.CurMass = 0
	self.LastCurMass = 0
	self.DakIsLeg = 0
	self.LegBroke = 0
	self.DakArmorName = "Ferro-Fibrous Armor"
	--self.Broke = 0
	--self.ArmorWeightMod = 3.125 --lore armor value
	--self.ArmorWeightMod = 2.5 -- 20 hp per ton
	self.ArmorWeightMod = 50/35 -- 35 hp per ton
	--self.ArmorWeightMod = 1
	self.LastRemake = CurTime()
end

function ENT:Think()
	if not(self.Count == table.Count(self.HitBox)) then
		self.Remake = 1
	end

	if (self.HeavyArmor == 0)and(self.ReactiveArmor == 0)and(self.ReflectiveArmor == 0) then
		self.HealthDiv = 20
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/55)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/60)
		end
		self.DakArmorName = "Ferro-Fibrous Armor"
	end
	if (self.HeavyArmor == 1)and(self.ReactiveArmor == 0)and(self.ReflectiveArmor == 0) then
		self.HealthDiv = (1000/65)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/71.5)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/78)
		end
		self.DakArmorName = "Heavy Armor"
	end
	if (self.HeavyArmor == 0)and(self.ReactiveArmor == 1)and(self.ReflectiveArmor == 0) then
		self.HealthDiv = (1000/40)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/44)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/48)
		end
		self.DakArmorName = "Reactive Armor"
	end
	if (self.HeavyArmor == 0)and(self.ReactiveArmor == 0)and(self.ReflectiveArmor == 1) then
		self.HealthDiv = (1000/40)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/44)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/48)
		end
		self.DakArmorName = "Reflective Armor"
	end
	if (self.HeavyArmor == 1)and(self.ReactiveArmor == 1)and(self.ReflectiveArmor == 0) then
		self.HealthDiv = (1000/52)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/57.2)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/62.4)
		end
		self.DakArmorName = "Heavy Reactive Armor"
	end
	if (self.HeavyArmor == 1)and(self.ReactiveArmor == 0)and(self.ReflectiveArmor == 1) then
		self.HealthDiv = (1000/52)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/57.2)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/62.4)
		end
		self.DakArmorName = "Heavy Reflective Armor"
	end
	if (self.HeavyArmor == 0)and(self.ReactiveArmor == 1)and(self.ReflectiveArmor == 1) then
		self.HealthDiv = (1000/32)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/35.2)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/38.4)
		end
		self.DakArmorName = "Reactive Reflective Armor"
	end
	if (self.HeavyArmor == 1)and(self.ReactiveArmor == 1)and(self.ReflectiveArmor == 1) then
		self.HealthDiv = (1000/41.6)
		if self.StandardEngine == 1 then
			self.HealthDiv = (1000/45.76)
		end
		if self.CompactEngine == 1 then
			self.HealthDiv = (1000/49.92)
		end
		self.DakArmorName = "Heavy Reactive Reflective Armor"
	end
	self.HealthDiv = self.HealthDiv * self.ArmorWeightMod

	if self.Remake == 1 or self.Broke == 1 then
		self.Remake = 0
		self.Broke = 0
		self.DakPooled = 1
		self.NewHitBox = {}
		for i=1, #self.HitBox do
			if self.HitBox[i].Controller == nil or self.HitBox[i].Controller == NULL or self.HitBox[i].Controller == self then
				if not(self.HitBox[i]==NULL) then
					if not(string.Explode("_",self.HitBox[i]:GetClass(),false)[1] == "dak") then
						if self.HitBox[i]:IsSolid() then
							table.insert(self.NewHitBox,self.HitBox[i])
							self.HitBox[i].Controller = self
							self.HitBox[i].DakPooled = 1
							self.HitBox[i].DakName = self.DakArmorName
						end
					else
						self.HitBox[i].Controller = nil
						self.HitBox[i].DakPooled = 0
					end
				end
			end
		end
		self.HitBox = self.NewHitBox
		if table.Count(self.HitBox) > 0 then
			self.HitBoxMass = 0
			for i=1, table.Count(self.HitBox) do
				self.HitBoxMass = self.HitBoxMass + self.HitBox[i]:GetPhysicsObject():GetMass()
			end
			self.CurrentHealth = (self.HitBoxMass/self.HealthDiv)
			self.DakMaxHealth = self.CurrentHealth
			for i=1, table.Count(self.HitBox) do
				DakTekSetupNewEnt(self.HitBox[i])
				self.HitBox[i].DakHealth = self.CurrentHealth
				self.HitBox[i].DakMaxHealth = self.CurrentHealth
				self.HitBox[i].Controller = self
				self.HitBox[i].DakPooled = 1
				self.HitBox[i].DakName = self.DakArmorName
			end
		else
			self.CurrentHealth = 10
			self.DakMaxHealth = 10
		end
		self.DakActive = 1
		self.LastRemake = CurTime()
	end

	if not(table.Count(self.HitBox)==0) then
	else
		self.DakActive = 0
	end


	if self.DakActive == 1 then
		if table.Count(self.HitBox) > 0 then
			self.DamageCycle = 0
			self.LastCurMass = self.CurMass
			self.CurMass = 0
			for i = 1, table.Count(self.HitBox) do
				self.HitBox[i].DakName = self.DakArmorName
				if self.CurMass>=0 then
					if not(self.HitBox[i].DakHealth==nil) then
						if self.HitBox[i].DakHealth <= self.CurrentHealth then
							self.DamageCycle = self.DamageCycle+(self.CurrentHealth-self.HitBox[i].DakHealth)
							if not(self.DakLastDamagePos == nil) then
								self.DakLastDamagePos = self.HitBox[i].DakLastDamagePos	
							end
						end
					end
				end				
				if not(self.HitBox[i]==NULL) then
					if self.HitBox[i].Controller == self then
						self.CurMass = self.CurMass + self.HitBox[i]:GetPhysicsObject():GetMass()
					else
						self.DakActive = 0
						--self.DakOwner:EmitSound("npc/roller/mine/rmine_shockvehicle1.wav")
						--self.DakOwner:ChatPrint("ERROR: Hitbox contains a prop that is in multiple health pools, hitbox shut down.")
						self.Broke = 1
						self.Remake = 1
					end
				end
			end
			
			if not(self.CurMass>self.LastCurMass) then
				if self.Broke == 0 then
					if self.DamageCycle>0 then
						if self.LastRemake+3 > CurTime() then
							self.DamageCycle = 0
						end
						self.CurrentHealth = self.CurrentHealth-self.DamageCycle
					end
				end
			end
			WireLib.TriggerOutput(self, "Health", self.CurrentHealth)

			for i = 1, table.Count(self.HitBox) do
				if not(self.HitBox[i]==NULL) then
					if self.Broke == 1 then
						self.HitBox[i].DakHealth = self.HitBox[i]:GetPhysicsObject():GetMass()/self.HealthDiv
						self.HitBox[i].DakMaxHealth = self.HitBox[i]:GetPhysicsObject():GetMass()/self.HealthDiv
						self.HitBox[i].DakPooled = 0
						self.HitBox[i].DakName = "Armor"
					else
						if self.CurrentHealth >= self.DakMaxHealth then
							self.DakMaxHealth = self.CurMass/self.HealthDiv
							self.CurrentHealth = self.CurMass/self.HealthDiv
							self.HitBox[i].DakMaxHealth = self.CurMass/self.HealthDiv
							self.HitBox[i].DakRed = self.HitBox[i]:GetColor().r
							self.HitBox[i].DakGreen = self.HitBox[i]:GetColor().g
							self.HitBox[i].DakBlue = self.HitBox[i]:GetColor().b
						end
						self.HitBox[i].DakHealth = self.CurrentHealth
	 					local HPPerc = self.HitBox[i].DakHealth/self.HitBox[i].DakMaxHealth --get hp percent then set colors based on it
						self.HitBox[i]:SetColor(Color(self.HitBox[i].DakRed*HPPerc,self.HitBox[i].DakGreen*HPPerc,self.HitBox[i].DakBlue*HPPerc,self.HitBox[i]:GetColor().a))
					end
				else
					self.Remake = 1
				end
			end
			if self.Broke==0 then
				self.DakHealth = self.CurrentHealth

				WireLib.TriggerOutput(self, "HealthPercent", (self.DakHealth/self.DakMaxHealth)*100)
				if not(self.DakHealth == nil) then
					if self.DakHealth <= 0 then
						if self.DakIsLeg == 1 then
							for i = 1, table.Count(self.HitBox) do
								if self.HitBox[i].DakHealth <= 0 then
									self.HitBox[i].DakHealth = 0
									self.HitBox[i].DakName = "Damaged Component"
									self.HitBox[i]:SetColor(Color(100,100,100,self.HitBox[i]:GetColor().a))
									if self.LegBroke == 0 then
										self.HitBox[i]:SetMaterial("models/props_buildings/plasterwall021a")
										if i <= 10 then
											local effectdata = EffectData()
											effectdata:SetOrigin(self.HitBox[i]:GetPos())
											effectdata:SetEntity(self.HitBox[i])
											effectdata:SetAttachment(1)
											effectdata:SetMagnitude(.5)
											effectdata:SetScale(200)
											util.Effect("dakbreak", effectdata)
											self.HitBox[i]:EmitSound( "dak/break.wav", 100, 70, 1, 3)
										end
										if i == table.Count(self.HitBox) then
											self.LegBroke = 1
										end
									end		
								end
							end
							self.DakHealth = 0
						else
							for i = 1, table.Count(self.HitBox) do
								if self.HitBox[i].DakHealth <= 0 then
									if i <= 10 then
										self.salvage = ents.Create( "dak_salvage" )
										self.salvage.DakModel = self.HitBox[i]:GetModel()
										self.salvage:SetPos( self.HitBox[i]:GetPos())
										self.salvage:SetAngles( self.HitBox[i]:GetAngles())
										self.salvage.DakLastDamagePos = self.DakLastDamagePos
										self.salvage:Spawn()
									end
								end
								self.HitBox[i]:Remove()
							end


							self.salvage = ents.Create( "dak_salvage" )
							self.salvage.DakModel = self:GetModel()
							self.salvage:SetPos( self:GetPos())
							self.salvage:SetAngles( self:GetAngles())
							self.salvage:Spawn()
							self:Remove()
						end
					end
				else
					self:Remove()
				end
			end
		end
	end
	self.Count = table.Count(self.HitBox)
	self:NextThink(CurTime()+1)
	return true
end

function ENT:PreEntityCopy()

	local info = {}
	local entids = {}

	local HitBoxIDs = {}
	if table.Count(self.HitBox)>0 then
		for i = 1, table.Count(self.HitBox) do
			if not(self.HitBox[i]==nil) then
				table.insert(HitBoxIDs,self.HitBox[i]:EntIndex())
			end
		end
	end
	info.DakName = self.DakName
	info.DakModel = self.DakModel
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
	info.HitBoxCount = table.Count(self.HitBox)
	info.DakColor = self:GetColor()

	duplicator.StoreEntityModifier( self, "DakTek", info )
	duplicator.StoreEntityModifier( self, "DTHitBox", HitBoxIDs )

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then
		if Ent.EntityMods.DakTek.HitBoxCount == nil then
			self.NewHitBox = {}
			for i = 1, table.Count(Ent.EntityMods.DTHitBox) do
				self.Ent = CreatedEntities[ Ent.EntityMods.DTHitBox[i]]
				if self.Ent and IsValid(self.Ent) then
					table.insert(self.NewHitBox,self.Ent)
				end
			end
			self.HitBox = self.NewHitBox
		else
			if Ent.EntityMods.DakTek.HitBoxCount > 0 then

				self.NewHitBox = {}
				for i = 1, Ent.EntityMods.DakTek.HitBoxCount do
					local hitEnt = CreatedEntities[ Ent.EntityMods.DTHitBox[i]]
					if IsValid(hitEnt) then
						table.insert(self.NewHitBox,hitEnt)
					end
				end
				self.HitBox = self.NewHitBox
			else
				self.HitBox = {}
			end
		end

		self.DakName = Ent.EntityMods.DakTek.DakName
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		--self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakOwner = Player
		self.DakHealth = self.DakMaxHealth
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

		self:PhysicsDestroy()
		--self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:Activate()

		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )
	self.Broke = 0
	if table.Count(self.HitBox) > 0 then
		self.TotalMass = 0
		self.TotalHealth = 0
		for i = 1, table.Count(self.HitBox) do
			if not(string.Explode("_",self.HitBox[i]:GetClass(),false)[1] == "dak") then
				self.HitBox[i].Controller = nil
				self.HitBox[i].DakPooled = 0
			end
			if not(self.HitBox[i]==nil) then
				if self.HitBox[i].Controller == nil or self.HitBox[i].Controller == NULL or self.HitBox[i].Controller:GetClass() == "dak_engine" or self.HitBox[i].Controller == self then
					self.HitBox[i].Controller = self
				else
					--print(self.HitBox[i].Controller)
					self.HitBox[i].Controller = self
					--self.HitBox[i].Controller = NULL
					--self.Broke = 1
					--Player:EmitSound("vo/npc/male01/vanswer14.wav")
					--Player:ChatPrint("ERROR: Hitbox contains a prop that is in multiple health pools, hitbox unlinked. Hitbox controller colored red.")
					--Player:ChatPrint("How To Repair: Please copy the broken contraption and respawn then carefully redo the Hitboxes that were broken, copy then respawn.")
					--self:SetColor(Color(255,0,0,255))
				end
				self.TotalMass = self.TotalMass + self.HitBox[i]:GetPhysicsObject():GetMass()
				if self.HitBox[i].DakHealth == nil and(self.Broke == 0) then
					DakTekSetupNewEnt(self.HitBox[i])
					self.HitBox[i].DakPooled = 1
					self.HitBox[i].DakName = self.DakArmorName
				end
			end
		end

		self.TotalHealth = self.TotalMass/20
		for i = 1, table.Count(self.HitBox) do
			if not(self.HitBox[i]==nil) then
				if self.Broke == 1 then
					self.HitBox[i].DakPooled = 0
					self.HitBox[i].DakName = "armor"
				else
					self.HitBox[i].DakMaxHealth = self.TotalHealth
					self.HitBox[i].DakHealth = self.HitBox[i].DakMaxHealth
				end
			end
		end
		self.DakMaxHealth = self.TotalHealth
		self.CurrentHealth = self.DakMaxHealth
		if self.Broke == 0 then
			self.DakActive = 1
		else
			self.DakActive = 0
			self.HitBox = {}
		end
	else
		self.DakActive = 0
	end
end

function ENT:OnRemove()
	if self.DakHealth <= 0 then
		for i = 1, table.Count(self.HitBox) do
			if not(self.HitBox==NULL) then
				if i <= 10 then
					self.salvage = ents.Create( "dak_salvage" )
					self.salvage.DakModel = self.HitBox[i]:GetModel()
					self.salvage:SetPos( self.HitBox[i]:GetPos())
					self.salvage:SetAngles( self.HitBox[i]:GetAngles())
					self.salvage.DakLastDamagePos = self.DakLastDamagePos
					self.salvage:Spawn()
				end
				self.HitBox[i]:Remove()
			end
		end
		self.salvage = ents.Create( "dak_salvage" )
		self.salvage.DakModel = self:GetModel()
		self.salvage:SetPos( self:GetPos())
		self.salvage:SetAngles( self:GetAngles())
		self.salvage:Spawn()
		self:Remove()
	end
	if table.Count(self.HitBox)>0 then
		for i = 1, table.Count(self.HitBox) do
			self.HitBox[i].DakPooled = 0
			self.HitBox[i].DakName = "Armor"
			self.HitBox[i].DakController = nil
		end
	end
end