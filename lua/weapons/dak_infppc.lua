if SERVER then
 
	--AddCSLuaFile ("shared.lua")
 

	SWEP.Weight = 5

	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
 
elseif CLIENT then
 
	SWEP.PrintName = "Man Portable PPC"
 
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
 
SWEP.ViewModel = "models/weapons/v_IRifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 


SWEP.DakCooldown = 5
SWEP.DakFireEffect = "infppcfire"
SWEP.DakFireSound = "dak/heavyppc.wav"
SWEP.DakFirePitch = 150
SWEP.DakShellEnt = "dak_handheldshell"

--shell definition
SWEP.DakShellTrail = "infppctrail"
SWEP.DakShellVelocity = 20000
SWEP.DakShellDamage = 5
SWEP.DakShellExplosionEffect = "dakinfppcexplosion"
SWEP.DakShellImpactSound = "dak/ppcimpact.wav"
SWEP.DakShellImpactPitch = 150
SWEP.DakShellGravity = false
SWEP.DakShellMass = 50
SWEP.timer = 0
SWEP.DakIsEnergy = true
SWEP.DakIsPPC = true

SWEP.HoldType = "ar2"
--SWEP:SetHoldType("rpg")
--SWEP.ScopedHoldType = "rpg"
--SWEP.ViewModelFOV = 78.793969849246
--SWEP.ViewModelFlip = false

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
end

function SWEP:Reload()
end
 
function SWEP:Think()
end
 
function SWEP:PrimaryAttack()
	if SERVER then
	if (CurTime() > (self.timer + self.DakCooldown)) then
		self:SetOwner(self.Owner)
		--FIREBULLETHERE
		
		local shootOrigin = self.Owner:EyePos() + (self.Owner:GetAimVector() * 16)
		local shootAngles = self.Owner:EyeAngles()
		local shootDir = shootAngles:Forward()
		local shell = ents.Create( self.DakShellEnt )
		if ( !IsValid( shell ) ) then return end

		shell:SetPos( shootOrigin )
		shell:SetAngles( shootAngles)

		shell.DakTrail = self.DakShellTrail
		shell.DakVelocity = self.DakShellVelocity
		shell.DakDamage = self.DakShellDamage
		shell.DakExplosionEffect = self.DakShellExplosionEffect
		shell.DakGravity = self.DakShellGravity
		shell.DakMass = self.DakShellMass
		shell.DakImpactSound = self.DakShellImpactSound
		shell.DakImpactPitch = self.DakShellImpactPitch

		shell.DakGun = self

		shell:Spawn()

		self:ShootEffects()
		self.Owner:MuzzleFlash()
		self:SendWeaponAnim (ACT_VM_HITCENTER)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		--local effectdata = EffectData()

		--local muzzle = self:LookupAttachment( "muzzle" )
		--print(self:GetAttachment(1).Pos)
		--print(self.Owner:WorldToLocal(self:GetAttachment(1).Pos))
		--effectdata:SetOrigin( self.Owner:EyePos() + self.Owner:WorldToLocal(self:GetAttachment(1).Pos) )
		--effectdata:SetAngles( shootAngles )
		--effectdata:SetEntity(self.Owner)
		--effectdata:SetScale( 1 )
		--util.Effect( self.DakFireEffect, effectdata )

		self.Owner:EmitSound( self.DakFireSound, 100, self.DakFirePitch, 1, 1)
		self.timer = CurTime()
		
	end
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:GetFOV()==10 then
		self.Owner:SetFOV( 0, 0.1 )
	else
		self.Owner:SetFOV( 10, 0.1 )
		self:AdjustMouseSensitivity()
	end
end

function SWEP:AdjustMouseSensitivity()
	if math.Round(self.Owner:GetFOV(),0)==10 then
	return 0.1
	else
	return 1
	end
end
 
function SWEP:GetCapabilities()

	return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )

end