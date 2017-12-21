AddCSLuaFile( "dak_ai_translations.lua" )
include( "dak_ai_translations.lua" )

if SERVER then
 
	--AddCSLuaFile ("shared.lua")
 

	SWEP.Weight = 5

	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
 
elseif CLIENT then
 
	SWEP.PrintName = "DT Grenade Launcher"
 
	SWEP.Slot = 4
	SWEP.SlotPos = 1

	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = true
end
 
SWEP.Author = "DakTek"
SWEP.Purpose = "Shoots Things."
SWEP.Instructions = "Point and click adventure"

SWEP.Category = "DakTek"
 
SWEP.Spawnable = true
SWEP.AdminOnly = true
 
SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1_Grenade"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 
SWEP.PrimaryNumberofShots = 1
SWEP.PrimarySpread = 0.01
SWEP.PrimaryForce = 10
SWEP.PrimaryDamage = 10
SWEP.PrimaryCooldown = 0.1
SWEP.UseHands = true

SWEP.HoldType = "SMG"
SWEP.CSMuzzleFlashes = true

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
	if self.Owner:IsNPC() then
		if SERVER then
		self.Owner:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
		self.Owner:CapabilitiesAdd( CAP_MOVE_GROUND )
		self.Owner:CapabilitiesAdd( CAP_MOVE_JUMP )
		self.Owner:CapabilitiesAdd( CAP_MOVE_CLIMB )
		self.Owner:CapabilitiesAdd( CAP_MOVE_SWIM )
		self.Owner:CapabilitiesAdd( CAP_MOVE_CRAWL )
		self.Owner:CapabilitiesAdd( CAP_MOVE_SHOOT )
		self.Owner:CapabilitiesAdd( CAP_USE )
		self.Owner:CapabilitiesAdd( CAP_USE_SHOT_REGULATOR )
		self.Owner:CapabilitiesAdd( CAP_SQUAD )
		self.Owner:CapabilitiesAdd( CAP_DUCK )
		self.Owner:CapabilitiesAdd( CAP_AIM_GUN )
		self.Owner:CapabilitiesAdd( CAP_NO_HIT_SQUADMATES )
		end
	end

	self.PrimaryLastFire = 0
	self.Fired = 0
end

function SWEP:Reload()
	if  ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		self.Weapon:DefaultReload(ACT_VM_RELOAD)	
	end
end
 
function SWEP:Think()
end
 
function SWEP:PrimaryAttack()
	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
		if self.Weapon:Clip1() > 0 then
			if SERVER then
				local shootOrigin = self.Owner:EyePos()
				local shootDir = self.Owner:GetAimVector()
				local Nade = ents.Create("prop_physics")
				Nade:SetModel("models/Items/AR2_Grenade.mdl")
				util.SpriteTrail( Nade, -1, Color(255,0,0,150), true, 5, 1, 1, 1 / ( 5 + 1 ) * 0.5, "trails/smoke.vmt" )
				Nade:SetAngles(shootDir:Angle())
				Nade:SetPos(self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_RH")).Pos)
				Nade:Spawn()
				Nade.DakHealth = 1000
				Nade.DakMaxHealth = 1000
				Nade.DakNade = 1
				Nade.DakOwner = self.Owner
				Nade:GetPhysicsObject():SetVelocity(shootDir*1500)
				timer.Simple( 1.5, function()
					if IsValid(Nade) then
						Explosion(Nade,Nade:GetPos(),250,5)
						local effectdata = EffectData()
						effectdata:SetOrigin(Nade:GetPos())
						effectdata:SetEntity(Nade)
						effectdata:SetAttachment(1)
						effectdata:SetMagnitude(.5)
						effectdata:SetScale(200)
						util.Effect("dakatmexplosion", effectdata)
						Nade:EmitSound( "dak/longtomimpact.wav", 140, 150, 1, 2)
						Nade:Remove()
					end
				end )
			end
			self:EmitSound( "npc/dog/dog_footstep_run7.wav", 140, 100, 1, 2)
			self.PrimaryLastFire = CurTime()
			self:TakePrimaryAmmo(1)
			self.Fired = 1
		else
			self:Reload()
		end
	end
	if self.Fired == 1 then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Fired = 0
	end
end


function SWEP:SecondaryAttack()
	if self.Owner:GetFOV()==40 then
		self.Owner:SetFOV( 0, 0.1 )
	else
		self.Owner:SetFOV( 40, 0.1 )
	end
end
 
function SWEP:AdjustMouseSensitivity()
	if math.Round(self.Owner:GetFOV(),0)==40 then
		return 0.40
	else
		return 1
	end
end

function SWEP:GetCapabilities()
	return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )
end


function Explosion(Ent,Pos,Radius,Damage)
	Ent.DamageList = {}
	Ent.RemoveList = {}
	local Targets = ents.FindInSphere( Pos, Radius )
	if table.Count(Targets) > 0 then
		for i = 1, #Targets do
			if (Targets[i]:IsValid() or Targets[i]:IsPlayer() or Targets[i]:IsNPC()) and Targets[i].DakNade==nil then
				local trace = {}
				trace.start = Pos
				trace.endpos = Targets[i]:GetPos()
				trace.filter = { Ent }
				local ExpTrace = util.TraceHull( trace, Ent )
				if ExpTrace.Entity == Targets[i] then
					if not(string.Explode("_",Targets[i]:GetClass(),false)[2] == "wire") and not(Targets[i]:GetClass() == "prop_ragdoll") and not(Targets[i]:IsVehicle()) and not(Targets[i]:GetClass() == "dak_salvage") then
						if (not(ExpTrace.Entity:IsPlayer())) and (not(ExpTrace.Entity:IsNPC())) then
							if ExpTrace.Entity.DakHealth == nil then
								DakTekSetupNewEnt(ExpTrace.Entity)
							end
							table.insert(Ent.DamageList,ExpTrace.Entity)
						else
							if Targets[i]:GetClass() == "dak_bot" then
								Targets[i]:SetHealth(Targets[i]:Health() - Damage*10*(1-(ExpTrace.Entity:GetPos():Distance(Pos)/1000))*Radius)
								if Targets[i]:Health() <= 0 and Ent.revenge==0 then
									local body = ents.Create( "prop_ragdoll" )
									body:SetPos( Targets[i]:GetPos() )
									body:SetModel( Targets[i]:GetModel() )
									body:Spawn()
									Targets[i]:Remove()
									local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
									body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
									timer.Simple( 5, function()
										body:Remove()
									end )
								end
							else
								local ExpPain = DamageInfo()
								--ExpPain:SetDamageForce( ExpTrace.Normal*Damage*Ent:GetPhysicsObject():GetMass()*Ent.velocity )
								ExpPain:SetDamage( Damage*10*(1-(ExpTrace.Entity:GetPos():Distance(Pos)/1000)) )
								ExpPain:SetAttacker( Ent )
								ExpPain:SetInflictor( Ent )
								ExpPain:SetReportedPosition( Ent:GetPos() )
								ExpPain:SetDamagePosition( ExpTrace.Entity:GetPhysicsObject():GetMassCenter() )
								ExpPain:SetDamageType(DMG_BLAST)
								ExpTrace.Entity:TakeDamageInfo( ExpPain )
							end
						end
					end
				end
			end
		end
		for i = 1, #Ent.DamageList do
			if(Ent.DamageList[i]:IsValid()) then
				if not(Ent.DamageList[i]:GetClass() == "dak_bot") then
					if(Ent.DamageList[i]:GetParent():IsValid()) then
						if(Ent.DamageList[i]:GetParent():GetParent():IsValid()) then
						Ent.DamageList[i]:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (Ent.DamageList[i]:GetPos()-Pos):GetNormalized()*(Damage/table.Count(Ent.DamageList))*1000*2*(1-(Ent.DamageList[i]:GetPos():Distance(Pos)/1000)) )
						end
					end
					if not(Ent.DamageList[i]:GetParent():IsValid()) then
						Ent.DamageList[i]:GetPhysicsObject():ApplyForceCenter( (Ent.DamageList[i]:GetPos()-Pos):GetNormalized()*(Damage/table.Count(Ent.DamageList))*1000*2*(1-(Ent.DamageList[i]:GetPos():Distance(Pos)/1000))  )
					end
				end
			end
			local HPPerc = 0
			if not(Ent.DamageList[i]:GetClass() == "dak_bot") then
				if not(Ent.DamageList[i]:GetTable().OnDieFunctions==nil) then
					if not(Ent.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
						if Ent.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
							if (Ent.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:GetInfo("DakTekDamagePermission"..Ent.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:SteamID64()..Ent.DakOwner:SteamID64()) == "1" or GetConVar( "DakTekDamagePermissionWarMode" ):GetInt()==1) and GetConVar( "DakTekDamagePermissionBuildMode" ):GetInt()==0 then	
								if Ent.DamageList[i]:GetPos():Distance(Pos) > 250 then
									HPPerc = (Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList))*(1-(Ent.DamageList[i]:GetPos():Distance(Pos)/1000)))/Ent.DamageList[i].DakMaxHealth
									Ent.DamageList[i].DakHealth = Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList))*(1-(Ent.DamageList[i]:GetPos():Distance(Pos)/1000))
								else
									HPPerc = (Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList)))/Ent.DamageList[i].DakMaxHealth
									Ent.DamageList[i].DakHealth = Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList))
								end
								if not(Ent.DamageList[i].DakRed == nil) then
									Ent.DamageList[i]:SetColor(Color(Ent.DamageList[i].DakRed*HPPerc,Ent.DamageList[i].DakGreen*HPPerc,Ent.DamageList[i].DakBlue*HPPerc,Ent.DamageList[i]:GetColor().a))
								end
								Ent.DamageList[i].DakLastDamagePos = Pos
								if Ent.DamageList[i].DakHealth <= 0 and Ent.DamageList[i].DakPooled==0 then
									table.insert(Ent.RemoveList,Ent.DamageList[i])
								end
							end
						end
					end
				else
					if Ent.DamageList[i]:GetPos():Distance(Pos) > 250 then
						HPPerc = (Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList))*(1-(Ent.DamageList[i]:GetPos():Distance(Pos)/1000)))/Ent.DamageList[i].DakMaxHealth
						Ent.DamageList[i].DakHealth = Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList))*(1-(Ent.DamageList[i]:GetPos():Distance(Pos)/1000))
					else
						HPPerc = (Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList)))/Ent.DamageList[i].DakMaxHealth
						Ent.DamageList[i].DakHealth = Ent.DamageList[i].DakHealth-(Damage/table.Count(Ent.DamageList))
					end
					if not(Ent.DamageList[i].DakRed == nil) then
						Ent.DamageList[i]:SetColor(Color(Ent.DamageList[i].DakRed*HPPerc,Ent.DamageList[i].DakGreen*HPPerc,Ent.DamageList[i].DakBlue*HPPerc,Ent.DamageList[i]:GetColor().a))
					end
					Ent.DamageList[i].DakLastDamagePos = Pos
					if Ent.DamageList[i].DakHealth <= 0 and Ent.DamageList[i].DakPooled==0 then
						table.insert(Ent.RemoveList,Ent.DamageList[i])
					end
				end
			end
		end
		for i = 1, #Ent.RemoveList do
			Ent.salvage = ents.Create( "dak_salvage" )
			Ent.salvage.DakModel = Ent.RemoveList[i]:GetModel()
			Ent.salvage:SetPos( Ent.RemoveList[i]:GetPos())
			Ent.salvage:SetAngles( Ent.RemoveList[i]:GetAngles())
			--Ent.salvage.DakLastDamagePos = Pos
			Ent.salvage:Spawn()
			Ent.RemoveList[i]:Remove()
		end
	end
end