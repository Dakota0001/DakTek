AddCSLuaFile( "dak_ai_translations.lua" )
include( "dak_ai_translations.lua" )

if SERVER then
 
	--AddCSLuaFile ("shared.lua")
 

	SWEP.Weight = 5

	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
 
elseif CLIENT then
 
	SWEP.PrintName = "Gauss SMG"
 
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
 
SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 250
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "CombineCannon"

 
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
 


SWEP.DakCooldown = 0.075
SWEP.DakFireEffect = "dakinfgaussfire"
SWEP.DakFireSound = "dak/LightGauss.wav"
SWEP.DakFirePitch = 125
SWEP.DakShellEnt = "dak_handheldshell"

--shell definition
SWEP.DakShellTrail = "dakinfgausstrail"
SWEP.DakShellVelocity = 35000
SWEP.DakShellDamage = 0.1
SWEP.DakShellExplosionEffect = "dakinfgaussexplosion"
SWEP.DakShellImpactSound = "dak/gaussimpact.wav"
SWEP.DakShellImpactPitch = 150
SWEP.DakShellGravity = true
SWEP.DakShellMass = 1
SWEP.timer = 0
SWEP.DakIsEnergy = false
SWEP.DakIsPPC = false

SWEP.HoldType = "smg"

--AccessorFunc( SWEP, "fNPCMinBurst", 		"NPCMinBurst" )
--AccessorFunc( SWEP, "fNPCMaxBurst", 		"NPCMaxBurst" )
--AccessorFunc( SWEP, "fNPCFireRate", 		"NPCFireRate" )
--AccessorFunc( SWEP, "fNPCMinRestTime", 	"NPCMinRest" )
--AccessorFunc( SWEP, "fNPCMaxRestTime", 	"NPCMaxRest" )

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
	if CurTime() > (self.timer + self.DakCooldown) then
		self:SetOwner(self.Owner)
		--FIREBULLETHERE
		if self.Weapon:Clip1() > 0 then
		local shootOrigin = self.Owner:EyePos() + (self.Owner:GetAimVector() * 16)
		local shootAngles = self.Owner:GetAimVector():Angle()--self.Owner:EyeAngles()
		local shootDir = self.Owner:GetAimVector()--shootAngles:Forward()
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
		self:TakePrimaryAmmo(1)

		self.Owner:EmitSound( self.DakFireSound, 100, self.DakFirePitch, 1, 1)
		self.timer = CurTime()
		end
	end
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


