if SERVER then
 
	--AddCSLuaFile ("shared.lua")
 

	SWEP.Weight = 5

	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
 
elseif CLIENT then
 
	SWEP.PrintName = "SRM Launcher"
 
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
 
SWEP.ViewModel = "models/weapons/v_RPG.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "RPG_Round"
 
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 
SWEP.PrimaryCooldown = 0

SWEP.HoldType = "rpg"
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
--SWEP:SetHoldType("rpg")
--SWEP.ScopedHoldType = "rpg"
--SWEP.ViewModelFOV = 78.793969849246
--SWEP.ViewModelFlip = false

function SWEP:Reload()
	if  ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
	
		self.Weapon:EmitSound("weapons/slam/mine_mode.wav", 30, 100, 1)
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
		
	end
end
 
function SWEP:Think()
end
 
function SWEP:PrimaryAttack()
	if SERVER then
		if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
			if self.Weapon:Clip1() > 0 then
				local shootOrigin = self.Owner:EyePos()
				local shootDir = self.Owner:GetAimVector()
				local Nade = ents.Create("dak_srm")
				--Nade.DakTarget = self:GetEnemy()
				Nade.DakGun = self.Owner
				Nade.DakGun.DakOwner = self.Owner
				Nade.DakTargetPos = shootDir*100000000
				Nade.DakFireTime = CurTime()
				Nade:SetAngles(shootDir:Angle())
				Nade:SetPos(self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_RH")).Pos)
				Nade:Spawn()
				self:EmitSound( "npc/dog/dog_footstep_run7.wav", 140, 100, 1, 2)
				self.PrimaryLastFire = CurTime()
				self:TakePrimaryAmmo(1)
				self.Fired = 1
			else
				self:Reload()
			end
		end
	end
	if self.Fired == 1 then
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Fired = 0
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:GetFOV()==25 then
		self.Owner:SetFOV( 0, 0.1 )
	else
		self.Owner:SetFOV( 25, 0.1 )
	end
end
 
function SWEP:AdjustMouseSensitivity()
	if math.Round(self.Owner:GetFOV(),0)==25 then
	return 0.25
	else
	return 1
	end
end

function SWEP:GetCapabilities()

	return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )

end