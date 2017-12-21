AddCSLuaFile( "dak_ai_translations.lua" )
include( "dak_ai_translations.lua" )

if SERVER then
 
	--AddCSLuaFile ("shared.lua")
 

	SWEP.Weight = 5

	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
 
elseif CLIENT then
 
	SWEP.PrintName = "DT Sniper Rifle"
 
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
SWEP.AdminOnly = false
 
SWEP.ViewModel = "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel = "models/weapons/w_snip_g3sg1.mdl"

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 
SWEP.PrimaryNumberofShots = 1
SWEP.PrimarySpread = 0.0
SWEP.PrimaryForce = 75
SWEP.PrimaryDamage = 75
SWEP.PrimaryCooldown = 0.1
SWEP.UseHands = true

SWEP.HoldType = "ar2"
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
	if ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		self.Weapon:DefaultReload(ACT_VM_RELOAD)	
	end
end
 
function SWEP:Think()
end
 
function SWEP:PrimaryAttack()
	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
		if self.Weapon:Clip1() > 0 then
			local shootOrigin = self.Owner:EyePos()
			local shootDir = self.Owner:GetAimVector()
			local bullet = {} 
			bullet.Num = self.PrimaryNumberofShots 
			bullet.Src = shootOrigin
			bullet.Dir = shootDir
			bullet.Spread = Vector( self.PrimarySpread , self.PrimarySpread, 0) 
			bullet.Tracer = 1
			bullet.TracerName = "Tracer" 
			bullet.Force = self.PrimaryForce 
			bullet.Damage = self.PrimaryDamage
			bullet.Attacker = self.Owner
			self.Owner:LagCompensation( true )
			self:FireBullets(bullet)
			self.Owner:LagCompensation( false )
			self:EmitSound( "weapons/g3sg1/g3sg1-1.wav", 140, 100, 1, 2)
			self.PrimaryLastFire = CurTime()
			self:TakePrimaryAmmo(1)
			if CLIENT or game.SinglePlayer() then
				self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			end
		else
			self:Reload()
		end
	end
end


function SWEP:SecondaryAttack()
	if self.Owner:GetFOV()==30 then
		self.Owner:SetFOV( 0, 0.1 )
		self.Owner:DrawViewModel( true )
	else
		self.Owner:SetFOV( 30, 0.1 )
		self.Owner:DrawViewModel( false )
	end
end
 
function SWEP:AdjustMouseSensitivity()
	if math.Round(self.Owner:GetFOV(),0)==30 then
		return 0.30
	else
		return 1
	end
end

function SWEP:GetCapabilities()
	return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )
end


