 
TOOL.Category = "DakTek"
TOOL.Name = "#Tool.dakspawner.listname"
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 
if CLIENT then
language.Add( "Tool.dakspawner.listname", "DakTek Spawner" )
language.Add( "Tool.dakspawner.name", "DakTek Spawner" )
language.Add( "Tool.dakspawner.desc", "Spawns DakTek entities." )
language.Add( "Tool.dakspawner.0", "Left click to spawn or update valid entities. Right click to check health of target. Reload to get contraption total mass." )
end
TOOL.ClientConVar[ "SpawnEnt" ] = ""
TOOL.ClientConVar[ "SpawnSettings" ] = ""
TOOL.ClientConVar[ "SpawnMod" ] = 1
TOOL.ClientConVar[ "PTSpawnMod" ] = 1
TOOL.ClientConVar[ "STSpawnMod" ] = 1

//setup gun info requirements
TOOL.DakName = "Base Ammo Gun"
TOOL.DakCooldown = 1
TOOL.DakHeat = 1
TOOL.DakMaxHealth = 1
TOOL.DakHealth = 1
TOOL.DakAmmo = 0
TOOL.DakMass = 1
TOOL.DakEngine = NULL
TOOL.DakModel = "models/dak/6ac.mdl"
TOOL.DakUseAmmo = true
TOOL.DakAmmoType = "AC2Ammo"
TOOL.DakAmmoUse = "AC2AmmoUse"
TOOL.DakAmmoQueue = "AC2AmmoUseQueue"
TOOL.DakFireEffect = "dakac5fire"
TOOL.DakShellType = "dak_baseshell"
TOOL.DakFireSound = "dak/AC5.wav"
TOOL.DakFirePitch = 90
TOOL.DakFireSpecialShell = false
TOOL.DakShellEnt = "dak_baseshell"
TOOL.DakIsLBX = false
TOOL.DakLBXPellets = 1
TOOL.DakIsExplosive = false
TOOL.DakIsRAC = false
TOOL.DakIsUAC = false
//setup laser info requirements
TOOL.DakName = "Base Laser"
TOOL.DakCooldown = 1
TOOL.DakHeat = 1
TOOL.DakMaxHealth = 1
TOOL.DakHealth = 1
TOOL.DakMass = 1
TOOL.DakEngine = NULL
TOOL.DakModel = "models/dak/1laser.mdl"
TOOL.DakFireSound = "dak/AC5.wav"
TOOL.DakFirePitch = 90
TOOL.DakDuration = 1.5
TOOL.DakDamage = 4
TOOL.DakBeamEffect = "mediumlaserbeam"
TOOL.DakBurnEffect = "laserburn"
//setup missile launcher info requirements
TOOL.DakName = "Base Launcher"
TOOL.DakCooldown = 1
TOOL.DakHeat = 1
TOOL.DakMaxHealth = 1
TOOL.DakHealth = 1
TOOL.DakAmmo = 0
TOOL.DakMass = 1
TOOL.DakEngine = NULL
TOOL.DakModel = "models/dak/6ac.mdl"
TOOL.DakAmmoType = "AC2Ammo"
TOOL.DakAmmoUse = "AC2AmmoUse"
TOOL.DakAmmoQueue = "AC2AmmoUseQueue"
TOOL.DakFireSound = "dak/AC5.wav"
TOOL.DakMissileType = "dak_lrm"
TOOL.DakCanSetTarget = false
TOOL.DakOutputTarget = false
TOOL.DakVolleySize = 1
TOOL.DakFireOffset = 0
//setup gun shell info requirements
TOOL.DakShellTrail = "ac2trail"
TOOL.DakShellVelocity = 25000
TOOL.DakShellDamage = 2
TOOL.DakShellExplosionEffect = "daksmallballisticexplosion"
TOOL.DakShellGravity = true
TOOL.DakShellMass = 20
TOOL.DakShellImpactSound = "dak/ballisticimpact.wav"
TOOL.DakShellImpactPitch = 75
//setup ammo box info requirements
TOOL.DakName = "AC2 Ammo"
TOOL.DakIsExplosive = true
TOOL.DakAmmo = 10
TOOL.DakMaxAmmo = 10
TOOL.DakAmmoType = "AC2"
//setup engine info requirements
TOOL.DakName = "Small Standard Engine"
TOOL.DakTonnageLimit = 40000
TOOL.DakCooling = 1
TOOL.DakBaseCooling = 1
TOOL.DakMaxHeat = 20
TOOL.DakBaseMaxHeat = 20
TOOL.DakHeat = 0
TOOL.DakHealth = 75
TOOL.DakMaxHealth = 75
TOOL.DakMass = 5000
TOOL.DakModel = "models/dak/smallstandardengine.mdl"
//setup hoverdrive and motor info requirements
TOOL.DakName = "Light Hoverdrive"
TOOL.DakMaxHealth = 50
TOOL.DakHealth = 50
TOOL.DakModel = "models/dak/1laser2.mdl"
TOOL.DakSpeed = 0.5
TOOL.DakMass = 5000
TOOL.DakSound = "npc/combine_gunship/engine_whine_loop1.wav"
//setup jump jet info requirements
TOOL.DakJumpCapacity = 3125
 
function TOOL:LeftClick( trace )
	if SERVER then
	if not(trace.Entity:GetClass() == self:GetClientInfo("SpawnEnt")) and not(trace.Entity:GetClass() == "dak_gun") and not(trace.Entity:GetClass() == "dak_laser") and not(trace.Entity:GetClass() == "dak_xpulselaser") and not(trace.Entity:GetClass() == "dak_launcher") and not(trace.Entity:GetClass() == "dak_lams") then
		local Target = trace.HitPos
		local spawnent = self:GetClientInfo("SpawnEnt")
		self.spawnedent = ents.Create(spawnent)
		if ( !IsValid( self.spawnedent ) ) then return end
		self.spawnedent:SetPos(Target+Vector(0,0,100))
		self.spawnedent:SetAngles( Angle(0,0,0))
	end
	if (trace.Entity:GetClass() == "dak_gun") or (trace.Entity:GetClass() == "dak_laser") or (trace.Entity:GetClass() == "dak_xpulselaser") or (trace.Entity:GetClass() == "dak_launcher") or (trace.Entity:GetClass() == "dak_lams") then
		if (self:GetClientInfo("SpawnEnt") == "dak_gun") or (self:GetClientInfo("SpawnEnt") == "dak_laser") or (self:GetClientInfo("SpawnEnt") == "dak_xpulselaser") or (self:GetClientInfo("SpawnEnt") == "dak_launcher") or (self:GetClientInfo("SpawnEnt") == "dak_lams") then
			local Target = trace.HitPos
			local spawnent = self:GetClientInfo("SpawnEnt")
			self.spawnedent = ents.Create(spawnent)
			if ( !IsValid( self.spawnedent ) ) then return end
			self.spawnedent:SetPos(trace.Entity:GetPos())
			self.spawnedent:SetAngles(trace.Entity:GetAngles())		
			if trace.Entity:GetParent():IsValid() then
				self.spawnedent:SetMoveType(MOVETYPE_NONE)
				self.spawnedent:SetParent(trace.Entity:GetParent())
			end
		end
	end
	--MOBILITY--
	--Modules
		if self:GetClientInfo("SpawnSettings") == "HighYieldPayloads" then
			self.DakName = "High Yield Payloads Module"
		end
		if self:GetClientInfo("SpawnSettings") == "MissileLoader" then
			self.DakName = "Missile Loader Module"
		end
		if self:GetClientInfo("SpawnSettings") == "BeamFocus" then
			self.DakName = "Beam Focus Module"
		end
		if self:GetClientInfo("SpawnSettings") == "TightWadding" then
			self.DakName = "Tight Wadding Module"
		end
		if self:GetClientInfo("SpawnSettings") == "DumbfireFins" then
			self.DakName = "Dumbfire Fins Module"
		end
		if self:GetClientInfo("SpawnSettings") == "MissileExhaustVenting" then
			self.DakName = "Missile Exhaust Venting Module"
		end
		if self:GetClientInfo("SpawnSettings") == "LaserInsulation" then
			self.DakName = "Laser Insulation Module"
		end
		if self:GetClientInfo("SpawnSettings") == "PPCFrequencyScrambler" then
			self.DakName = "PPC Frequency Scrambler Module"
		end
		if self:GetClientInfo("SpawnSettings") == "WeaponShielding" then
			self.DakName = "Weapon Shielding Module"
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyArmor" then
			self.DakName = "Heavy Armor Module"
		end
		if self:GetClientInfo("SpawnSettings") == "ReactiveArmor" then
			self.DakName = "Reactive Armor Module"
		end
		if self:GetClientInfo("SpawnSettings") == "ReflectiveArmor" then
			self.DakName = "Reflective Armor Module"
		end
		if self:GetClientInfo("SpawnSettings") == "EnhancedBAP" then
			self.DakName = "Enhanced BAP Module"
		end
		if self:GetClientInfo("SpawnSettings") == "HeatsinkSupercooling" then
			self.DakName = "Heatsink Supercooling Module"
		end
		if self:GetClientInfo("SpawnSettings") == "ReinforcedHeatsinks" then
			self.DakName = "Reinforced Heatsinks Module"
		end
		if self:GetClientInfo("SpawnSettings") == "EfficientLAMS" then
			self.DakName = "Efficient LAMS Module"
		end
	--Fighter
		if self:GetClientInfo("SpawnSettings") == "LFighter" then
			self.DakName = "Light Fighter Engine"
			self.DakHealth = 20
			self.DakMaxHealth = 20
			self.DakMass = 5000
			self.DakSpeed = 0.7
			self.DakEngine = NULL
			self.DakModel = "models/dak/turbine2.mdl"
			self.DakSound = "dak/lightfighter.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "MFighter" then
			self.DakName = "Standard Fighter Engine"
			self.DakHealth = 35
			self.DakMaxHealth = 35
			self.DakMass = 10000
			self.DakSpeed = 1
			self.DakEngine = NULL
			self.DakModel = "models/dak/turbine3.mdl"
			self.DakSound = "dak/mediumfighter.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "HFighter" then
			self.DakName = "Heavy Fighter Engine"
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 20000
			self.DakSpeed = 1.4
			self.DakEngine = NULL
			self.DakModel = "models/dak/turbine4.mdl"
			self.DakSound = "dak/heavyfighter.wav"
		end
	--VTOL
		if self:GetClientInfo("SpawnSettings") == "LVTOL" then
			self.DakName = "Light VTOL Engine"
			self.DakHealth = 20
			self.DakMaxHealth = 20
			self.DakMass = 5000
			self.DakSpeed = 0.7
			self.DakEngine = NULL
			self.DakModel = "models/dak/turbine1.mdl"
			self.DakSound = "dak/lightheli.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "MVTOL" then
			self.DakName = "Standard VTOL Engine"
			self.DakHealth = 35
			self.DakMaxHealth = 35
			self.DakMass = 10000
			self.DakSpeed = 1
			self.DakEngine = NULL
			self.DakModel = "models/dak/turbine2.mdl"
			self.DakSound = "dak/mediumheli.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "HVTOL" then
			self.DakName = "Heavy VTOL Engine"
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 20000
			self.DakSpeed = 1.4
			self.DakEngine = NULL
			self.DakModel = "models/dak/turbine3.mdl"
			self.DakSound = "dak/heavyheli.wav"
		end
		--Quad Gyros
		if self:GetClientInfo("SpawnSettings") == "LQGyro" then
			self.DakName = "Light Quad Gyro"
			self.DakHealth = 100
			self.DakMaxHealth = 100
			self.DakMass = 500
			self.DakSpeed = 2.6
			self.DakEngine = NULL
			self.DakModel = "models/dak/1gyro.mdl"
			self.DakSound = "vehicles/apc/apc_idle1.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "MQGyro" then
			self.DakName = "Standard Quad Gyro"
			self.DakHealth = 150
			self.DakMaxHealth = 150
			self.DakMass = 1500
			self.DakSpeed = 6.4
			self.DakEngine = NULL
			self.DakModel = "models/dak/2gyro.mdl"
			self.DakSound = "npc/scanner/combat_scan_loop2.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "HQGyro" then
			self.DakName = "Heavy Quad Gyro"
			self.DakHealth = 200
			self.DakMaxHealth = 200
			self.DakMass = 3500
			self.DakSpeed = 9
			self.DakEngine = NULL
			self.DakModel = "models/dak/3gyro.mdl"
			self.DakSound = "npc/combine_gunship/dropship_engine_distant_loop1.wav"
		end
	--Gyros
		if self:GetClientInfo("SpawnSettings") == "LGyro" then
			self.DakName = "Light Gyro"
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 1000
			self.DakSpeed = 2.6
			self.DakEngine = NULL
			self.DakModel = "models/dak/1gyro.mdl"
			self.DakSound = "vehicles/apc/apc_idle1.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "MGyro" then
			self.DakName = "Standard Gyro"
			self.DakHealth = 100
			self.DakMaxHealth = 100
			self.DakMass = 3000
			self.DakSpeed = 6.4
			self.DakEngine = NULL
			self.DakModel = "models/dak/2gyro.mdl"
			self.DakSound = "npc/scanner/combat_scan_loop2.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "HGyro" then
			self.DakName = "Heavy Gyro"
			self.DakHealth = 150
			self.DakMaxHealth = 150
			self.DakMass = 7000
			self.DakSpeed = 9
			self.DakEngine = NULL
			self.DakModel = "models/dak/3gyro.mdl"
			self.DakSound = "npc/combine_gunship/dropship_engine_distant_loop1.wav"
		end
	--JumpJets
		if self:GetClientInfo("SpawnSettings") == "JumpJet5" then
			self.DakName = "Micro Jump Jet"
			self.DakJumpCapacity = 5000
			self.DakHealth = 10
			self.DakMaxHealth = 10
			self.DakMass = 250
			self.DakModel = "models/dak/025jumpjet.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "JumpJet4" then
			self.DakName = "Light Jump Jet"
			self.DakJumpCapacity = 10000
			self.DakHealth = 20
			self.DakMaxHealth = 20
			self.DakMass = 500
			self.DakModel = "models/dak/05jumpjet.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "JumpJet3" then
			self.DakName = "Standard Jump Jet"
			self.DakJumpCapacity = 20000
			self.DakHealth = 40
			self.DakMaxHealth = 40
			self.DakMass = 1000
			self.DakModel = "models/dak/1jumpjet.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "JumpJet2" then
			self.DakName = "Heavy Jump Jet"
			self.DakJumpCapacity = 40000
			self.DakHealth = 80
			self.DakMaxHealth = 80
			self.DakMass = 2000
			self.DakModel = "models/dak/2jumpjet.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "JumpJet1" then
			self.DakName = "Ultra Jump Jet"
			self.DakJumpCapacity = 80000
			self.DakHealth = 160
			self.DakMaxHealth = 160
			self.DakMass = 4000
			self.DakModel = "models/dak/4jumpjet.mdl"
		end
	--Hoverdrives
		if self:GetClientInfo("SpawnSettings") == "LHoverdrive" then
			self.DakName = "Light Hoverdrive"
			self.DakHealth = 20
			self.DakMaxHealth = 20
			self.DakMass = 5000
			self.DakSpeed = 0.7
			self.DakEngine = NULL
			self.DakModel = "models/dak/2motor.mdl"
			self.DakSound = "npc/combine_gunship/engine_whine_loop1.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "MHoverdrive" then
			self.DakName = "Standard Hoverdrive"
			self.DakHealth = 35
			self.DakMaxHealth = 35
			self.DakMass = 10000
			self.DakSpeed = 1
			self.DakEngine = NULL
			self.DakModel = "models/dak/3motor.mdl"
			self.DakSound = "npc/combine_gunship/dropship_engine_distant_loop1.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "HHoverdrive" then
			self.DakName = "Heavy Hoverdrive"
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 20000
			self.DakSpeed = 1.4
			self.DakEngine = NULL
			self.DakModel = "models/dak/4motor.mdl"
			self.DakSound = "npc/combine_gunship/dropship_onground_loop1.wav"
		end
		--Motors
		if self:GetClientInfo("SpawnSettings") == "LMotor" then
			self.DakName = "Light Motor"
			self.DakHealth = 25
			self.DakMaxHealth = 25
			self.DakMass = 1000
			self.DakSpeed = 1.675
			self.DakEngine = NULL
			self.DakModel = "models/dak/1motor.mdl"
			self.DakSound = "vehicles/apc/apc_cruise_loop3.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "MMotor" then
			self.DakName = "Standard Motor"
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 2000
			self.DakSpeed = 2.5125
			self.DakEngine = NULL
			self.DakModel = "models/dak/2motor.mdl"
			self.DakSound = "vehicles/airboat/fan_motor_idle_loop1.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "HMotor" then
			self.DakName = "Heavy Motor"
			self.DakHealth = 100
			self.DakMaxHealth = 100
			self.DakMass = 4000
			self.DakSpeed = 3.35
			self.DakEngine = NULL
			self.DakModel = "models/dak/3motor.mdl"
			self.DakSound = "vehicles/crane/crane_idle_loop3.wav"
		end
		if self:GetClientInfo("SpawnSettings") == "UMotor" then
			self.DakName = "Ultra Motor"
			self.DakHealth = 150
			self.DakMaxHealth = 150
			self.DakMass = 6000
			self.DakSpeed = 5.025
			self.DakEngine = NULL
			self.DakModel = "models/dak/4motor.mdl"
			self.DakSound = "vehicles/airboat/fan_motor_fullthrottle_loop1.wav"
		end
		--GUNS--
		--CLAN--
		--Ultra AutoCannons
		if self:GetClientInfo("SpawnSettings") == "CUAC2" then
			self.DakName = "CUAC2"
			self.DakCooldown = 0.1875
			self.DakHeat = 0.395
			self.DakMaxHealth = 50
			self.DakHealth= 50
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/5cuac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/5cuac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/5crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/5cuac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/5uac4.mdl"
			end
			self.DakAmmoType = "UAC2Ammo"
			self.DakAmmoUse = "UAC2AmmoUse"
			self.DakAmmoQueue = "UAC2AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 1.4
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 14
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 110
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self:GetClientInfo("SpawnSettings") == "CUAC5" then
			self.DakName = "CUAC5"
			self.DakCooldown = 0.4375
			self.DakHeat = 1.05
			self.DakMaxHealth = 70
			self.DakHealth= 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/7cuac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/7cuac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/7crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/7cuac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/7uac4.mdl"
			end
			self.DakAmmoType = "UAC5Ammo"
			self.DakAmmoUse = "UAC5AmmoUse"
			self.DakAmmoQueue = "UAC5AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self:GetClientInfo("SpawnSettings") == "CUAC10" then
			self.DakName = "CUAC10"
			self.DakCooldown = 0.75
			self.DakHeat = 2.925
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/10cuac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/10cuac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10cuac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10uac4.mdl"
			end
			self.DakAmmoType = "UAC10Ammo"
			self.DakAmmoUse = "UAC10AmmoUse"
			self.DakAmmoQueue = "UAC10AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 9
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 90
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self:GetClientInfo("SpawnSettings") == "CUAC20" then
			self.DakName = "CUAC20"
			self.DakCooldown = 1
			self.DakHeat = 4.6875
			self.DakMaxHealth = 120
			self.DakHealth= 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12cuac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12cuac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/12crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12cuac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/12uac4.mdl"
			end
			self.DakAmmoType = "UAC20Ammo"
			self.DakAmmoUse = "UAC20AmmoUse"
			self.DakAmmoQueue = "UAC20AmmoUseQueue"
			self.DakFireEffect = "dakac10fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac10trail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		--Rotary AutoCannons
		if self:GetClientInfo("SpawnSettings") == "CRAC2" then
			self.DakName = "CRAC2"
			self.DakCooldown = 0.05
			self.DakHeat = 0.13
			self.DakMaxHealth = 60
			self.DakHealth= 60
			self.DakAmmo = 0
			self.DakMass = 6000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6crac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/6crac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6crac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6crac4.mdl"
			end
			self.DakAmmoType = "RAC2Ammo"
			self.DakAmmoUse = "RAC2AmmoUse"
			self.DakAmmoQueue = "RAC2AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 0.5
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 150
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "CRAC5" then
			self.DakName = "CRAC5"
			self.DakCooldown = 0.1
			self.DakHeat = 0.3125
			self.DakMaxHealth = 80
			self.DakHealth= 80
			self.DakAmmo = 0
			self.DakMass = 8000
			self.DakEngine = NULL
			self.DakModel = "models/dak/8crac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/8crac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/8crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/8crac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/8crac4.mdl"
			end
			self.DakAmmoType = "RAC5Ammo"
			self.DakAmmoUse = "RAC5AmmoUse"
			self.DakAmmoQueue = "RAC5AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 1.25
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 12.5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 130
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "CRAC10" then
			self.DakName = "CRAC10"
			self.DakCooldown = 0.15
			self.DakHeat = 0.8
			self.DakMaxHealth = 110
			self.DakHealth= 110
			self.DakAmmo = 0
			self.DakMass = 11000
			self.DakEngine = NULL
			self.DakModel = "models/dak/11crac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/11crac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/11crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/11crac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/11crac4.mdl"
			end
			self.DakAmmoType = "RAC10Ammo"
			self.DakAmmoUse = "RAC10AmmoUse"
			self.DakAmmoQueue = "RAC10AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 2.5
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 25
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "CRAC20" then
			self.DakName = "CRAC20"
			self.DakCooldown = 0.25
			self.DakHeat = 1.54
			self.DakMaxHealth = 130
			self.DakHealth= 130
			self.DakAmmo = 0
			self.DakMass = 13000
			self.DakEngine = NULL
			self.DakModel = "models/dak/13crac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/13crac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/13crac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/13crac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/13crac4.mdl"
			end
			self.DakAmmoType = "RAC20Ammo"
			self.DakAmmoUse = "RAC20AmmoUse"
			self.DakAmmoQueue = "RAC20AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		--LBX AutoCannons
		if self:GetClientInfo("SpawnSettings") == "CLBX2" then
			self.DakName = "CLBX2"
			self.DakCooldown = 0.45
			self.DakHeat = 0.5
			self.DakMaxHealth = 50
			self.DakHealth= 50
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/5ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/5ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/5lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/5ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/5uac4.mdl"
			end
			self.DakAmmoType = "LBX2Ammo"
			self.DakAmmoUse = "LBX2AmmoUse"
			self.DakAmmoQueue = "LBX2AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/LBX2.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = true
			self.DakLBXPellets = 2
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "CLBX5" then
			self.DakName = "CLBX5"
			self.DakCooldown = 1
			self.DakHeat = 1.15
			self.DakMaxHealth = 70
			self.DakHealth= 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/7ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/7ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/7lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/7ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/7uac4.mdl"
			end
			self.DakAmmoType = "LBX5Ammo"
			self.DakAmmoUse = "LBX5AmmoUse"
			self.DakAmmoQueue = "LBX5AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/LBX5.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = true
			self.DakLBXPellets = 5
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "CLBX10" then
			self.DakName = "CLBX10"
			self.DakCooldown = 1.375
			self.DakHeat = 2.75
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/10ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/10ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10uac4.mdl"
			end
			self.DakAmmoType = "LBX10Ammo"
			self.DakAmmoUse = "LBX10AmmoUse"
			self.DakAmmoQueue = "LBX10AmmoUseQueue"
			self.DakFireEffect = "dakac10fire"
			self.DakFireSound = "dak/LBX10.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac10trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = true
			self.DakLBXPellets = 10
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "CLBX20" then
			self.DakName = "CLBX20"
			self.DakCooldown = 2.33
			self.DakHeat = 5.85
			self.DakMaxHealth = 120
			self.DakHealth= 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/12lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/12uac4.mdl"
			end
			self.DakAmmoType = "LBX20Ammo"
			self.DakAmmoUse = "LBX20AmmoUse"
			self.DakAmmoQueue = "LBX20AmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/LBX20.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac20trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = true
			self.DakLBXPellets = 20
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Machine Gun
		if self:GetClientInfo("SpawnSettings") == "CLightMachineGun" then
			self.DakName = "C-Light Machine Gun"
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 1.25
			self.DakHealth= 1.25
			self.DakAmmo = 0
			self.DakMass = 125
			self.DakEngine = NULL
			self.DakModel = "models/dak/0125crac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/0125crac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/0125crac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/0125ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/0125uac4.mdl"
			end
			self.DakAmmoType = "LightMachineGunAmmo"
			self.DakAmmoUse = "LightMachineGunAmmoUse"
			self.DakAmmoQueue = "LightMachineGunAmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 110
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 0.05
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "CMachineGun" then
			self.DakName = "C-Machine Gun"
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 2.5
			self.DakHealth= 2.5
			self.DakAmmo = 0
			self.DakMass = 250
			self.DakEngine = NULL
			self.DakModel = "models/dak/025rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/025rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/025rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/025ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/025uac4.mdl"
			end
			self.DakAmmoType = "MachineGunAmmo"
			self.DakAmmoUse = "MachineGunAmmoUse"
			self.DakAmmoQueue = "MachineGunAmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 0.1
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 225
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "CHeavyMachineGun" then
			self.DakName = "C-Heavy Machine Gun"
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 5
			self.DakHealth= 5
			self.DakAmmo = 0
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05uac4.mdl"
			end
			self.DakAmmoType = "HeavyMachineGunAmmo"
			self.DakAmmoUse = "HeavyMachineGunAmmoUse"
			self.DakAmmoQueue = "HeavyMachineGunAmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 0.2
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 2
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 200
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--HAGs
		if self:GetClientInfo("SpawnSettings") == "HAG20" then
			self.DakName = "Hyper-Assault Gauss Rifle 20"
			self.DakCooldown = 1
			self.DakHeat = 0.4
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/10ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/10ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10gauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10gauss4.mdl"
			end
			self.DakAmmoType = "HAG20Ammo"
			self.DakAmmoUse = "HAG20AmmoUse"
			self.DakAmmoQueue = "HAG20AmmoUseQueue"
			self.DakFireEffect = "dakmagshotfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakmagshottrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "dakmagshotexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 125
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "HAG30" then
			self.DakName = "Hyper-Assault Gauss Rifle 30"
			self.DakCooldown = 1
			self.DakHeat = 0.6
			self.DakMaxHealth = 130
			self.DakHealth= 130
			self.DakAmmo = 0
			self.DakMass = 13000
			self.DakEngine = NULL
			self.DakModel = "models/dak/13ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/13ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/13gauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/13ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/13gauss4.mdl"
			end
			self.DakAmmoType = "HAG30Ammo"
			self.DakAmmoUse = "HAG30AmmoUse"
			self.DakAmmoQueue = "HAG30AmmoUseQueue"
			self.DakFireEffect = "dakmagshotfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakmagshottrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 3
			self.DakShellExplosionEffect = "dakmagshotexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 60
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 125
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "HAG40" then
			self.DakName = "Hyper-Assault Gauss Rifle 40"
			self.DakCooldown = 1
			self.DakHeat = 0.8
			self.DakMaxHealth = 160
			self.DakHealth= 160
			self.DakAmmo = 0
			self.DakMass = 16000
			self.DakEngine = NULL
			self.DakModel = "models/dak/16ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/16ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/16gauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/16ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/16gauss4.mdl"
			end
			self.DakAmmoType = "HAG40Ammo"
			self.DakAmmoUse = "HAG40AmmoUse"
			self.DakAmmoQueue = "HAG40AmmoUseQueue"
			self.DakFireEffect = "dakmagshotfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakmagshottrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "dakmagshotexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 80
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 125
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Gauss Rifles
		if self:GetClientInfo("SpawnSettings") == "CGauss" then
			self.DakName = "Clan Gauss Rifle"
			self.DakCooldown = 2.5
			self.DakHeat = 1
			self.DakMaxHealth = 120
			self.DakHealth= 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lgauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lgauss4.mdl"
			end
			self.DakAmmoType = "GaussAmmo"
			self.DakAmmoUse = "GaussAmmoUse"
			self.DakAmmoQueue = "GaussAmmoUseQueue"
			self.DakFireEffect = "dakgaussfire"
			self.DakFireSound = "dak/Gauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakgausstrail"
			self.DakShellVelocity = 60000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end	
		if self:GetClientInfo("SpawnSettings") == "Railgun" then
			self.DakName = "Railgun"
			self.DakCooldown = 6
			self.DakHeat = 10
			self.DakMaxHealth = 280
			self.DakHealth= 280
			self.DakAmmo = 0
			self.DakMass = 28000
			self.DakEngine = NULL
			self.DakModel = "models/dak/28ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/28ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/rgauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/28ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/rgauss4.mdl"
			end
			self.DakAmmoType = "RailgunAmmo"
			self.DakAmmoUse = "RailgunAmmoUse"
			self.DakAmmoQueue = "RailgunAmmoUseQueue"
			self.DakFireEffect = "dakrailgunfire"
			self.DakFireSound = "dak/railgun.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakrailguntrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 75
			self.DakShellExplosionEffect = "dakrailgunexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 750
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end	
		--PPCs
		if self:GetClientInfo("SpawnSettings") == "CPPC" then
			self.DakName = "CERPPC"
			self.DakCooldown = 3
			self.DakHeat = 10
			self.DakMaxHealth = 60
			self.DakHealth= 60
			self.DakAmmo = 0
			self.DakMass = 6000
			self.DakEngine = NULL
			self.DakModel = "models/dak/cppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/cppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "ppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Plasma Cannon
		if self:GetClientInfo("SpawnSettings") == "PlasmaCannon" then
			self.DakName = "Plasma Cannon"
			self.DakCooldown = 5
			self.DakHeat = 15
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/plasmacannon.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/plasmacannon.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10plasmacannon2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10plasmacannon3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10plasmacannon4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "PlasmaCannonFire"
			self.DakFireSound = "dak/plasmacannon.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_plasmabolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Flamer
		if self:GetClientInfo("SpawnSettings") == "CERFlamer" then
			self.DakName = "C-ER Flamer"
			self.DakCooldown = 1
			self.DakHeat = 2
			self.DakMaxHealth = 5
			self.DakHealth= 5
			self.DakAmmo = 0
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/flamer.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/flamer.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05plasmacannon2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05plasmacannon3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05plasmacannon4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_erflamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "CFlamer" then
			self.DakName = "C-Flamer"
			self.DakCooldown = 1
			self.DakHeat = 2
			self.DakMaxHealth = 5
			self.DakHealth= 5
			self.DakAmmo = 0
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/flamer.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/flamer.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05plasmacannon2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05plasmacannon3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05plasmacannon4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_flamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--LASERS--
		--Standard
		if self:GetClientInfo("SpawnSettings") == "CMicroLaser" then
			self.DakName = "C-ER Micro Laser"
			self.DakCooldown = 1.75
			self.DakHeat = 1.5
			self.DakMaxHealth = 2.5
			self.DakHealth = 2.5
			self.DakMass = 250
			self.DakEngine = NULL
			self.DakModel = "models/dak/025laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/025laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/025laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/025laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/025laser4.mdl"
			end
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.5
			self.DakDamage = 1
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CSmallLaser" then
			self.DakName = "C-ER Small Laser"
			self.DakCooldown = 1.5
			self.DakHeat = 2
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05laser4.mdl"
			end
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 75
			self.DakDuration = 1
			self.DakDamage = 2
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CMediumLaser" then
			self.DakName = "C-ER Medium Laser"
			self.DakCooldown = 3
			self.DakHeat = 6
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1laser4.mdl"
			end
			self.DakFireSound = "dak/mediumlaser.wav"
			self.DakFirePitch = 70
			self.DakDuration = 1.5
			self.DakDamage = 7
			self.DakBeamEffect = "mediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CLargeLaser" then
			self.DakName = "C-ER Large Laser"
			self.DakCooldown = 3.25
			self.DakHeat = 6
			self.DakMaxHealth = 40
			self.DakHealth = 40
			self.DakMass = 4000
			self.DakEngine = NULL
			self.DakModel = "models/dak/4laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/4laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/4laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/4laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/4laser4.mdl"
			end
			self.DakFireSound = "dak/largelaser.wav"
			self.DakFirePitch = 65
			self.DakDuration = 1.15
			self.DakDamage = 11
			self.DakBeamEffect = "largelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CAssaultLaser" then
			self.DakName = "C-ER Assault Laser"
			self.DakCooldown = 4
			self.DakHeat = 15
			self.DakMaxHealth = 50
			self.DakHealth = 50
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/5laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/5laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/5laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/5laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/5laser4.mdl"
			end
			self.DakFireSound = "dak/assaultlaser.wav"
			self.DakFirePitch = 60
			self.DakDuration = 1
			self.DakDamage = 20
			self.DakBeamEffect = "assaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--Pulse
		if self:GetClientInfo("SpawnSettings") == "CMicropulseLaser" then
			self.DakName = "C-ER Micro Pulse Laser"
			self.DakCooldown = 1.75
			self.DakHeat = 2
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05laser4.mdl"
			end
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.25
			self.DakDamage = 1.5
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CSmallPulseLaser" then
			self.DakName = "C-ER Small Pulse Laser"
			self.DakCooldown = 1.75
			self.DakHeat = 3
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1laser4.mdl"
			end
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.25
			self.DakDamage = 3
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CMediumPulseLaser" then
			self.DakName = "C-ER Medium Pulse Laser"
			self.DakCooldown = 3
			self.DakHeat = 6
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/2laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/2laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/2laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/2laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/2laser4.mdl"
			end
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.75
			self.DakDamage = 8
			self.DakBeamEffect = "pulsemediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CLargePulseLaser" then
			self.DakName = "C-ER Large Pulse Laser"
			self.DakCooldown = 3.25
			self.DakHeat = 6
			self.DakMaxHealth = 60
			self.DakHealth = 60
			self.DakMass = 6000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/6laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6laser4.mdl"
			end
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.575
			self.DakDamage = 13
			self.DakBeamEffect = "pulselargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "CAssaultPulseLaser" then
			self.DakName = "C-ER Assault Pulse Laser"
			self.DakCooldown = 4
			self.DakHeat = 15
			self.DakMaxHealth = 80
			self.DakHealth = 80
			self.DakMass = 8000
			self.DakEngine = NULL
			self.DakModel = "models/dak/8laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/8laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/8laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/8laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/8laser4.mdl"
			end
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.5
			self.DakDamage = 25
			self.DakBeamEffect = "pulseassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--Heavy
		if self:GetClientInfo("SpawnSettings") == "HeavySmallLaser" then
			self.DakName = "Heavy Small Laser"
			self.DakCooldown = 1.5
			self.DakHeat = 5
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05laser4.mdl"
			end
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 75
			self.DakDuration = 1
			self.DakDamage = 4
			self.DakBeamEffect = "heavysmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyMediumLaser" then
			self.DakName = "Heavy Medium Laser"
			self.DakCooldown = 3
			self.DakHeat = 10
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1laser4.mdl"
			end
			self.DakFireSound = "dak/mediumlaser.wav"
			self.DakFirePitch = 70
			self.DakDuration = 1.5
			self.DakDamage = 11
			self.DakBeamEffect = "heavymediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyLargeLaser" then
			self.DakName = "Heavy Large Laser"
			self.DakCooldown = 3.25
			self.DakHeat = 11
			self.DakMaxHealth = 40
			self.DakHealth = 40
			self.DakMass = 4000
			self.DakEngine = NULL
			self.DakModel = "models/dak/4laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/4laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/4laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/4laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/4laser4.mdl"
			end
			self.DakFireSound = "dak/largelaser.wav"
			self.DakFirePitch = 65
			self.DakDuration = 1.15
			self.DakDamage = 16
			self.DakBeamEffect = "heavylargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyAssaultLaser" then
			self.DakName = "Heavy Assault Laser"
			self.DakCooldown = 4
			self.DakHeat = 25
			self.DakMaxHealth = 50
			self.DakHealth = 50
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/5laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/5laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/5laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/5laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/5laser4.mdl"
			end
			self.DakFireSound = "dak/assaultlaser.wav"
			self.DakFirePitch = 60
			self.DakDuration = 1
			self.DakDamage = 30
			self.DakBeamEffect = "heavyassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--MISSILES--
		--ATM
		if self:GetClientInfo("SpawnSettings") == "ATM3" then
			self.DakName = "ATM3 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 2
			self.DakMaxHealth = 15
			self.DakHealth = 15
			self.DakAmmo = 0
			self.DakMass = 1500
			self.DakEngine = NULL
			self.DakModel = "models/dak/atm31.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/atm31.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/atm32.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/atm33.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/atm34.mdl"
			end
			self.DakAmmoType = "ATM3Ammo"
			self.DakAmmoUse = "ATM3AmmoUse"
			self.DakAmmoQueue = "ATM3AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "ATM6" then
			self.DakName = "ATM6 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 4
			self.DakMaxHealth = 35
			self.DakHealth = 35
			self.DakAmmo = 0
			self.DakMass = 3500
			self.DakEngine = NULL
			self.DakModel = "models/dak/atm61.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/atm61.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/atm62.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/atm63.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/atm64.mdl"
			end
			self.DakAmmoType = "ATM6Ammo"
			self.DakAmmoUse = "ATM6AmmoUse"
			self.DakAmmoQueue = "ATM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "ATM9" then
			self.DakName = "ATM9 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 6
			self.DakMaxHealth = 50
			self.DakHealth = 50
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/atm91.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/atm91.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/atm92.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/atm93.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/atm94.mdl"
			end
			self.DakAmmoType = "ATM9Ammo"
			self.DakAmmoUse = "ATM9AmmoUse"
			self.DakAmmoQueue = "ATM9AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "ATM12" then
			self.DakName = "ATM12 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 8
			self.DakMaxHealth = 70
			self.DakHealth = 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/atm121.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/atm121.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/atm122.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/atm123.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/atm124.mdl"
			end
			self.DakAmmoType = "ATM12Ammo"
			self.DakAmmoUse = "ATM12AmmoUse"
			self.DakAmmoQueue = "ATM12AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_atms"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		--LRM
		if self:GetClientInfo("SpawnSettings") == "CLRM5" then
			self.DakName = "CLRM5 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 6
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakAmmo = 0
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm5.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm5.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm52.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm53.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm54.mdl"
			end
			self.DakAmmoType = "LRM5Ammo"
			self.DakAmmoUse = "LRM5AmmoUse"
			self.DakAmmoQueue = "LRM5AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "CLRM10" then
			self.DakName = "CLRM10 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 8
			self.DakMaxHealth = 25
			self.DakHealth = 25
			self.DakAmmo = 0
			self.DakMass = 2500
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm10.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm10.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm102.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm103.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm104.mdl"
			end
			self.DakAmmoType = "LRM10Ammo"
			self.DakAmmoUse = "LRM10AmmoUse"
			self.DakAmmoQueue = "LRM10AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 2
			self.DakFireOffset = 9
		end
		if self:GetClientInfo("SpawnSettings") == "CLRM15" then
			self.DakName = "CLRM15 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 10
			self.DakMaxHealth = 35
			self.DakHealth = 35
			self.DakAmmo = 0
			self.DakMass = 3500
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm15.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm15.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm152.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm153.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm154.mdl"
			end
			self.DakAmmoType = "LRM15Ammo"
			self.DakAmmoUse = "LRM15AmmoUse"
			self.DakAmmoQueue = "LRM15AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 3
			self.DakFireOffset = 18
		end
		if self:GetClientInfo("SpawnSettings") == "CLRM20" then
			self.DakName = "CLRM20 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 10
			self.DakMaxHealth = 50
			self.DakHealth = 50
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm20.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm20.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm202.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm203.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm204.mdl"
			end
			self.DakAmmoType = "LRM20Ammo"
			self.DakAmmoUse = "LRM20AmmoUse"
			self.DakAmmoQueue = "LRM20AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 4
			self.DakFireOffset = 9
		end
		--SRM
		if self:GetClientInfo("SpawnSettings") == "CSRM2" then
			self.DakName = "CSRM2 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 4
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakAmmo = 0
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm2.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm22.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm23.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm24.mdl"
			end
			self.DakAmmoType = "SRM2Ammo"
			self.DakAmmoUse = "SRM2AmmoUse"
			self.DakAmmoQueue = "SRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "CSRM4" then
			self.DakName = "CSRM4 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 6
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakAmmo = 0
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm4.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm4.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm42.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm43.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm44.mdl"
			end
			self.DakAmmoType = "SRM4Ammo"
			self.DakAmmoUse = "SRM4AmmoUse"
			self.DakAmmoQueue = "SRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 2
			self.DakFireOffset = 6
		end		
		if self:GetClientInfo("SpawnSettings") == "CSRM6" then
			self.DakName = "CSRM6 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 8
			self.DakMaxHealth = 15
			self.DakHealth = 15
			self.DakAmmo = 0
			self.DakMass = 1500
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm6.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm6.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm62.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm63.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm64.mdl"
			end
			self.DakAmmoType = "SRM6Ammo"
			self.DakAmmoUse = "SRM6AmmoUse"
			self.DakAmmoQueue = "SRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 3
			self.DakFireOffset = 12
		end	
		--SSRM
		if self:GetClientInfo("SpawnSettings") == "CSSRM2" then
			self.DakName = "CSSRM2 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 4
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakAmmo = 0
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm2.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm22.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm23.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm24.mdl"
			end
			self.DakAmmoType = "SSRM2Ammo"
			self.DakAmmoUse = "SSRM2AmmoUse"
			self.DakAmmoQueue = "SSRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "CSSRM4" then
			self.DakName = "CSSRM4 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 6
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakAmmo = 0
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm4.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm4.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm42.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm43.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm44.mdl"
			end
			self.DakAmmoType = "SSRM4Ammo"
			self.DakAmmoUse = "SSRM4AmmoUse"
			self.DakAmmoQueue = "SSRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 2
			self.DakFireOffset = 6
		end		
		if self:GetClientInfo("SpawnSettings") == "CSSRM6" then
			self.DakName = "CSSRM6 Launcher"
			self.DakCooldown = 6
			self.DakHeat = 8
			self.DakMaxHealth = 30
			self.DakHealth = 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm6.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm6.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm62.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm63.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm64.mdl"
			end
			self.DakAmmoType = "SSRM6Ammo"
			self.DakAmmoUse = "SSRM6AmmoUse"
			self.DakAmmoQueue = "SSRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 3
			self.DakFireOffset = 12
		end	
		--NARC
		if self:GetClientInfo("SpawnSettings") == "CNARC" then
			self.DakName = "C-NARC Launcher"
			self.DakCooldown = 5
			self.DakHeat = 0
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakAmmo = 0
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/narc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/narc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/narc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/narc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/narc4.mdl"
			end
			self.DakAmmoType = "NARCAmmo"
			self.DakAmmoUse = "NARCAmmoUse"
			self.DakAmmoQueue = "NARCAmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_narc"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		--IS--
		--AutoCannons
		if self:GetClientInfo("SpawnSettings") == "AC2" then
			self.DakName = "AC2"
			self.DakCooldown = 0.375
			self.DakHeat = 0.4
			self.DakMaxHealth = 60
			self.DakHealth= 60
			self.DakAmmo = 0
			self.DakMass = 6000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/6ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6ac4.mdl"
			end
			self.DakAmmoType = "AC2Ammo"
			self.DakAmmoUse = "AC2AmmoUse"
			self.DakAmmoQueue = "AC2AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/AC5.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 40000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "AC5" then
			self.DakName = "AC5"
			self.DakCooldown = 0.875
			self.DakHeat = 1
			self.DakMaxHealth = 80
			self.DakHealth= 80
			self.DakAmmo = 0
			self.DakMass = 8000
			self.DakEngine = NULL
			self.DakModel = "models/dak/8ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/8ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/8ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/8ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/8ac4.mdl"
			end
			self.DakAmmoType = "AC5Ammo"
			self.DakAmmoUse = "AC5AmmoUse"
			self.DakAmmoQueue = "AC5AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/AC5.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "AC10" then
			self.DakName = "AC10"
			self.DakCooldown = 1.25
			self.DakHeat = 2.5
			self.DakMaxHealth = 120
			self.DakHealth= 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/12ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/12ac4.mdl"
			end
			self.DakAmmoType = "AC10Ammo"
			self.DakAmmoUse = "AC10AmmoUse"
			self.DakAmmoQueue = "AC10AmmoUseQueue"
			self.DakFireEffect = "dakac10fire"
			self.DakFireSound = "dak/AC10.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac10trail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "AC20" then
			self.DakName = "AC20"
			self.DakCooldown = 2
			self.DakHeat = 5
			self.DakMaxHealth = 140
			self.DakHealth= 140
			self.DakAmmo = 0
			self.DakMass = 14000
			self.DakEngine = NULL
			self.DakModel = "models/dak/14ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/14ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/14ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/14ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/14ac4.mdl"
			end
			self.DakAmmoType = "AC20Ammo"
			self.DakAmmoUse = "AC20AmmoUse"
			self.DakAmmoQueue = "AC20AmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/AC20.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac20trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Armored AutoCannons
		if self:GetClientInfo("SpawnSettings") == "AAC2" then
			self.DakName = "Armored AC2"
			self.DakCooldown = 0.375
			self.DakHeat = 0.4
			self.DakMaxHealth = 160
			self.DakHealth= 160
			self.DakAmmo = 0
			self.DakMass = 8000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/6ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6ac4.mdl"
			end
			self.DakAmmoType = "AC2Ammo"
			self.DakAmmoUse = "AC2AmmoUse"
			self.DakAmmoQueue = "AC2AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/AC5.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 40000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "AAC5" then
			self.DakName = "Armored AC5"
			self.DakCooldown = 0.875
			self.DakHeat = 1
			self.DakMaxHealth = 200
			self.DakHealth= 200
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/8ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/8ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/8ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/8ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/8ac4.mdl"
			end
			self.DakAmmoType = "AC5Ammo"
			self.DakAmmoUse = "AC5AmmoUse"
			self.DakAmmoQueue = "AC5AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/AC5.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "AAC10" then
			self.DakName = "Armored AC10"
			self.DakCooldown = 1.25
			self.DakHeat = 2.5
			self.DakMaxHealth = 280
			self.DakHealth= 280
			self.DakAmmo = 0
			self.DakMass = 14000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/12ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/12ac4.mdl"
			end
			self.DakAmmoType = "AC10Ammo"
			self.DakAmmoUse = "AC10AmmoUse"
			self.DakAmmoQueue = "AC10AmmoUseQueue"
			self.DakFireEffect = "dakac10fire"
			self.DakFireSound = "dak/AC10.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac10trail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "AAC20" then
			self.DakName = "Armored AC20"
			self.DakCooldown = 2
			self.DakHeat = 5
			self.DakMaxHealth = 320
			self.DakHealth= 320
			self.DakAmmo = 0
			self.DakMass = 16000
			self.DakEngine = NULL
			self.DakModel = "models/dak/14ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/14ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/14ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/14ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/14ac4.mdl"
			end
			self.DakAmmoType = "AC20Ammo"
			self.DakAmmoUse = "AC20AmmoUse"
			self.DakAmmoQueue = "AC20AmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/AC20.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac20trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Ultra AutoCannons
		if self:GetClientInfo("SpawnSettings") == "UAC2" then
			self.DakName = "UAC2"
			self.DakCooldown = 0.1875
			self.DakHeat = 0.28
			self.DakMaxHealth = 70
			self.DakHealth= 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/7uac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/7uac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/7rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/7uac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/7uac4.mdl"
			end
			self.DakAmmoType = "UAC2Ammo"
			self.DakAmmoUse = "UAC2AmmoUse"
			self.DakAmmoQueue = "UAC2AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 1.4
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 14
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 110
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self:GetClientInfo("SpawnSettings") == "UAC5" then
			self.DakName = "UAC5"
			self.DakCooldown = 0.4375
			self.DakHeat = 0.8
			self.DakMaxHealth = 90
			self.DakHealth= 90
			self.DakAmmo = 0
			self.DakMass = 9000
			self.DakEngine = NULL
			self.DakModel = "models/dak/9uac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/9uac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/9rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/9uac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/9uac4.mdl"
			end
			self.DakAmmoType = "UAC5Ammo"
			self.DakAmmoUse = "UAC5AmmoUse"
			self.DakAmmoQueue = "UAC5AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 4
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 40
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self:GetClientInfo("SpawnSettings") == "UAC10" then
			self.DakName = "UAC10"
			self.DakCooldown = 0.75
			self.DakHeat = 2.25
			self.DakMaxHealth = 130
			self.DakHealth= 130
			self.DakAmmo = 0
			self.DakMass = 13000
			self.DakEngine = NULL
			self.DakModel = "models/dak/13uac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/13uac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/13rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/13uac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/13uac4.mdl"
			end
			self.DakAmmoType = "UAC10Ammo"
			self.DakAmmoUse = "UAC10AmmoUse"
			self.DakAmmoQueue = "UAC10AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 9
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 90
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		if self:GetClientInfo("SpawnSettings") == "UAC20" then
			self.DakName = "UAC20"
			self.DakCooldown = 1
			self.DakHeat = 3.75
			self.DakMaxHealth = 150
			self.DakHealth= 150
			self.DakAmmo = 0
			self.DakMass = 15000
			self.DakEngine = NULL
			self.DakModel = "models/dak/15uac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/15uac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/15rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/15uac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/15uac4.mdl"
			end
			self.DakAmmoType = "UAC20Ammo"
			self.DakAmmoUse = "UAC20AmmoUse"
			self.DakAmmoQueue = "UAC20AmmoUseQueue"
			self.DakFireEffect = "dakac10fire"
			self.DakFireSound = "dak/UAC.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac10trail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 70
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = true
		end
		--Rotary AutoCannons
		if self:GetClientInfo("SpawnSettings") == "RAC2" then
			self.DakName = "RAC2"
			self.DakCooldown = 0.05
			self.DakHeat = 0.1
			self.DakMaxHealth = 80
			self.DakHealth= 80
			self.DakAmmo = 0
			self.DakMass = 8000
			self.DakEngine = NULL
			self.DakModel = "models/dak/8rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/8rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/8rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/8rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/8rac4.mdl"
			end
			self.DakAmmoType = "RAC2Ammo"
			self.DakAmmoUse = "RAC2AmmoUse"
			self.DakAmmoQueue = "RAC2AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 0.5
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 150
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "RAC5" then
			self.DakName = "RAC5"
			self.DakCooldown = 0.1
			self.DakHeat = 0.25
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/10rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/10rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10rac4.mdl"
			end
			self.DakAmmoType = "RAC5Ammo"
			self.DakAmmoUse = "RAC5AmmoUse"
			self.DakAmmoQueue = "RAC5AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 1.25
			self.DakShellExplosionEffect = "daktinyballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 12.5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 130
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "RAC10" then
			self.DakName = "RAC10"
			self.DakCooldown = 0.15
			self.DakHeat = 0.625
			self.DakMaxHealth = 140
			self.DakHealth= 140
			self.DakAmmo = 0
			self.DakMass = 14000
			self.DakEngine = NULL
			self.DakModel = "models/dak/14rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/14rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/14rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/14rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/14rac4.mdl"
			end
			self.DakAmmoType = "RAC10Ammo"
			self.DakAmmoUse = "RAC10AmmoUse"
			self.DakAmmoQueue = "RAC10AmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 20000
			self.DakShellDamage = 2.5
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 25
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 85
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "RAC20" then
			self.DakName = "RAC20"
			self.DakCooldown = 0.25
			self.DakHeat = 1.25
			self.DakMaxHealth = 160
			self.DakHealth= 160
			self.DakAmmo = 0
			self.DakMass = 16000
			self.DakEngine = NULL
			self.DakModel = "models/dak/16rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/16rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/16rac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/16rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/16rac4.mdl"
			end
			self.DakAmmoType = "RAC20Ammo"
			self.DakAmmoUse = "RAC20AmmoUse"
			self.DakAmmoQueue = "RAC20AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 80
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = true
			self.DakIsUAC = false
		end
		--LBX AutoCannons
		if self:GetClientInfo("SpawnSettings") == "LBX2" then
			self.DakName = "LBX2"
			self.DakCooldown = 0.375
			self.DakHeat = 0.4
			self.DakMaxHealth = 60
			self.DakHealth= 60
			self.DakAmmo = 0
			self.DakMass = 6000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/6ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6uac4.mdl"
			end
			self.DakAmmoType = "LBX2Ammo"
			self.DakAmmoUse = "LBX2AmmoUse"
			self.DakAmmoQueue = "LBX2AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/LBX2.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac2trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daksmallballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = true
			self.DakLBXPellets = 2
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "LBX5" then
			self.DakName = "LBX5"
			self.DakCooldown = 0.875
			self.DakHeat = 1
			self.DakMaxHealth = 80
			self.DakHealth= 80
			self.DakAmmo = 0
			self.DakMass = 8000
			self.DakEngine = NULL
			self.DakModel = "models/dak/8ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/8ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/8lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/8ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/8uac4.mdl"
			end
			self.DakAmmoType = "LBX5Ammo"
			self.DakAmmoUse = "LBX5AmmoUse"
			self.DakAmmoQueue = "LBX5AmmoUseQueue"
			self.DakFireEffect = "dakac5fire"
			self.DakFireSound = "dak/LBX5.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac5trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 5
			self.DakShellExplosionEffect = "dakballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 50
			self.DakIsLBX = true
			self.DakLBXPellets = 5
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "LBX10" then
			self.DakName = "LBX10"
			self.DakCooldown = 1.25
			self.DakHeat = 2.5
			self.DakMaxHealth = 120
			self.DakHealth= 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/12lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/12uac4.mdl"
			end
			self.DakAmmoType = "LBX10Ammo"
			self.DakAmmoUse = "LBX10AmmoUse"
			self.DakAmmoQueue = "LBX10AmmoUseQueue"
			self.DakFireEffect = "dakac10fire"
			self.DakFireSound = "dak/LBX10.wav"
			self.DakFirePitch = 65
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac10trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakmediumballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 100
			self.DakIsLBX = true
			self.DakLBXPellets = 10
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		if self:GetClientInfo("SpawnSettings") == "LBX20" then
			self.DakName = "LBX20"
			self.DakCooldown = 2
			self.DakHeat = 5
			self.DakMaxHealth = 140
			self.DakHealth= 140
			self.DakAmmo = 0
			self.DakMass = 14000
			self.DakEngine = NULL
			self.DakModel = "models/dak/14ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/14ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/14lbx.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/14ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/14uac4.mdl"
			end
			self.DakAmmoType = "LBX20Ammo"
			self.DakAmmoUse = "LBX20AmmoUse"
			self.DakAmmoQueue = "LBX20AmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/LBX20.wav"
			self.DakFirePitch = 60
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ac20trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = true
			self.DakLBXPellets = 20
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			self.DakCanSwapAmmo = 1
		end
		--Machine Gun
		if self:GetClientInfo("SpawnSettings") == "LightMachineGun" then
			self.DakName = "Light Machine Gun"
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 2.5
			self.DakHealth= 2.5
			self.DakAmmo = 0
			self.DakMass = 250
			self.DakEngine = NULL
			self.DakModel = "models/dak/025rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/025rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/025rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/025ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/025uac4.mdl"
			end
			self.DakAmmoType = "LightMachineGunAmmo"
			self.DakAmmoUse = "LightMachineGunAmmoUse"
			self.DakAmmoQueue = "LightMachineGunAmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 110
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 0.075
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "MachineGun" then
			self.DakName = "Machine Gun"
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 5
			self.DakHealth= 5
			self.DakAmmo = 0
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05uac4.mdl"
			end
			self.DakAmmoType = "MachineGunAmmo"
			self.DakAmmoUse = "MachineGunAmmoUse"
			self.DakAmmoQueue = "MachineGunAmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 0.15
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1.5
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 225
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyMachineGun" then
			self.DakName = "Heavy Machine Gun"
			self.DakCooldown = 0.2
			self.DakHeat = 0
			self.DakMaxHealth = 10
			self.DakHealth= 10
			self.DakAmmo = 0
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1rac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1rac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1rac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1uac4.mdl"
			end
			self.DakAmmoType = "HeavyMachineGunAmmo"
			self.DakAmmoUse = "HeavyMachineGunAmmoUse"
			self.DakAmmoQueue = "HeavyMachineGunAmmoUseQueue"
			self.DakFireEffect = "dakac2fire"
			self.DakFireSound = "dak/RAC.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 0.3
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 3
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 200
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Long Tom
		if self:GetClientInfo("SpawnSettings") == "LongTom" then
			self.DakName = "Long Tom"
			self.DakCooldown = 7.5
			self.DakHeat = 20
			self.DakMaxHealth = 200
			self.DakHealth= 200
			self.DakAmmo = 0
			self.DakMass = 20000
			self.DakEngine = NULL
			self.DakModel = "models/dak/20ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/20ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/20ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/20longtom.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/20longtom4.mdl"
			end
			self.DakAmmoType = "LongTomAmmo"
			self.DakAmmoUse = "LongTomAmmoUse"
			self.DakAmmoQueue = "LongTomAmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/LBX20.wav"
			self.DakFirePitch = 50
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_longtomshell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 0.1
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "Thumper" then
			self.DakName = "Thumper"
			self.DakCooldown = 5.0
			self.DakHeat = 10
			self.DakMaxHealth = 100
			self.DakHealth = 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/10ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/10ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10longtom.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10longtom4.mdl"
			end
			self.DakAmmoType = "ThumperAmmo"
			self.DakAmmoUse = "ThumperAmmoUse"
			self.DakAmmoQueue = "ThumperAmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/LBX20.wav"
			self.DakFirePitch = 85
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_thumpershell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 0.1
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			WireLib.TriggerOutput(self, "Cooldown", self.DakCooldown)
		end
		if self:GetClientInfo("SpawnSettings") == "Sniper" then
			self.DakName = "Sniper Cannon"
			self.DakCooldown = 5
			self.DakHeat = 10
			self.DakMaxHealth = 200
			self.DakHealth= 200
			self.DakAmmo = 0
			self.DakMass = 20000
			self.DakEngine = NULL
			self.DakModel = "models/dak/20ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/20ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/20ac2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/20longtom.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/sniper4.mdl"
			end
			self.DakAmmoType = "SniperAmmo"
			self.DakAmmoUse = "SniperAmmoUse"
			self.DakAmmoQueue = "SniperAmmoUseQueue"
			self.DakFireEffect = "dakac20fire"
			self.DakFireSound = "dak/LBX20.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_snipershell"
			self.DakShellTrail = "lbxtrail"
			self.DakShellVelocity = 15000
			self.DakShellDamage = 0.1
			self.DakShellExplosionEffect = "lbxexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 1
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 255
			self.DakIsExplosive = false
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Gauss Rifles
		if self:GetClientInfo("SpawnSettings") == "Magshot" then
			self.DakName = "Magshot Gauss Rifle"
			self.DakCooldown = 2
			self.DakHeat = 1
			self.DakMaxHealth = 5
			self.DakHealth= 5
			self.DakAmmo = 0
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/mgauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/mgauss4.mdl"
			end
			self.DakAmmoType = "MagshotAmmo"
			self.DakAmmoUse = "MagshotAmmoUse"
			self.DakAmmoQueue = "MagshotAmmoUseQueue"
			self.DakFireEffect = "dakmagshotfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 100
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakmagshottrail"
			self.DakShellVelocity = 75000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "dakmagshotexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 20
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 125
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "LightGauss" then
			self.DakName = "Light Gauss Rifle"
			self.DakCooldown = 1.5
			self.DakHeat = 1
			self.DakMaxHealth = 120
			self.DakHealth= 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lgauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lgauss4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "daklightgaussfire"
			self.DakFireSound = "dak/LightGauss.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "daklightgausstrail"
			self.DakShellVelocity = 70000
			self.DakShellDamage = 8
			self.DakShellExplosionEffect = "daklightgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 80
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 100
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "Gauss" then
			self.DakName = "Gauss Rifle"
			self.DakCooldown = 2
			self.DakHeat = 1
			self.DakMaxHealth = 150
			self.DakHealth= 150
			self.DakAmmo = 0
			self.DakMass = 15000
			self.DakEngine = NULL
			self.DakModel = "models/dak/15ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/15ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/gauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/15ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/gauss4.mdl"
			end
			self.DakAmmoType = "GaussAmmo"
			self.DakAmmoUse = "GaussAmmoUse"
			self.DakAmmoQueue = "GaussAmmoUseQueue"
			self.DakFireEffect = "dakgaussfire"
			self.DakFireSound = "dak/Gauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakgausstrail"
			self.DakShellVelocity = 60000
			self.DakShellDamage = 15
			self.DakShellExplosionEffect = "dakgaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 150
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end	
		if self:GetClientInfo("SpawnSettings") == "HeavyGauss" then
			self.DakName = "Heavy Gauss Rifle"
			self.DakCooldown = 2.5
			self.DakHeat = 1
			self.DakMaxHealth = 180
			self.DakHealth= 180
			self.DakAmmo = 0
			self.DakMass = 18000
			self.DakEngine = NULL
			self.DakModel = "models/dak/18ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/18ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/hgauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/18ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/hgauss4.mdl"
			end
			self.DakAmmoType = "HeavyGaussAmmo"
			self.DakAmmoUse = "HeavyGaussAmmoUse"
			self.DakAmmoQueue = "HeavyGaussAmmoUseQueue"
			self.DakFireEffect = "dakheavygaussfire"
			self.DakFireSound = "dak/HeavyGauss.wav"
			self.DakFirePitch = 50
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "dakheavygausstrail"
			self.DakShellVelocity = 50000
			self.DakShellDamage = 25
			self.DakShellExplosionEffect = "dakheavygaussexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 250
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/gaussimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "SBG" then
			self.DakName = "Silver Bullet Gauss Rifle"
			self.DakCooldown = 2
			self.DakHeat = 1
			self.DakMaxHealth = 150
			self.DakHealth = 150
			self.DakAmmo = 0
			self.DakMass = 15000
			self.DakEngine = NULL
			self.DakModel = "models/dak/15ac.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/15ac.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/gauss.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/15ac3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/gauss4.mdl"
			end
			self.DakAmmoType = "SBGAmmo"
			self.DakAmmoUse = "SBGAmmoUse"
			self.DakAmmoQueue = "SBGAmmoUseQueue"
			self.DakFireEffect = "dakgaussfire"
			self.DakFireSound = "dak/Gauss.wav"
			self.DakFirePitch = 70
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_sbgpellet"
			self.DakShellTrail = "ac20trail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "daklargeballisticexplosion"
			self.DakShellGravity = true
			self.DakShellMass = 200
			self.DakIsLBX = true
			self.DakLBXPellets = 15
			self.DakShellImpactSound = "dak/ballisticimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = true
			self.DakUseAmmo = true
			self.DakIsRAC = false
			self.DakIsUAC = false
			WireLib.TriggerOutput(self, "Cooldown", self.DakCooldown)
		end
		--PPCs
		if self:GetClientInfo("SpawnSettings") == "PPC" then
			self.DakName = "PPC"
			self.DakCooldown = 3
			self.DakHeat = 8
			self.DakMaxHealth = 70
			self.DakHealth= 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/ppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/ppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/7ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/7ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/7ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "ppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 14
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 140
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "LightPPC" then
			self.DakName = "Light PPC"
			self.DakCooldown = 3
			self.DakHeat = 4.5
			self.DakMaxHealth = 30
			self.DakHealth= 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lightppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lightppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/3ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/3ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/3ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightppcfire"
			self.DakFireSound = "dak/heavyppc.wav"
			self.DakFirePitch = 110
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 7
			self.DakShellExplosionEffect = "daklightppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 70
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "LightPPCBurst" then
			self.DakName = "Light Burst PPC"
			self.DakCooldown = 0.5
			self.DakHeat = 2
			self.DakMaxHealth = 30
			self.DakHealth= 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lightppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lightppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/3ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/3ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/3ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightburstppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightburstppctrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daklightburstppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 20
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 120
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyPPC" then
			self.DakName = "Heavy PPC"
			self.DakCooldown = 3
			self.DakHeat = 12
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/heavyppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/heavyppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "heavyppcfire"
			self.DakFireSound = "dak/heavyppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "heavyppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "dakheavyppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Armored PPCs
		if self:GetClientInfo("SpawnSettings") == "APPC" then
			self.DakName = "Armored PPC"
			self.DakCooldown = 3
			self.DakHeat = 8
			self.DakMaxHealth = 180
			self.DakHealth= 180
			self.DakAmmo = 0
			self.DakMass = 9000
			self.DakEngine = NULL
			self.DakModel = "models/dak/ppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/ppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/7ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/7ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/7ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "ppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 14
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 140
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "ALightPPC" then
			self.DakName = "Armored Light PPC"
			self.DakCooldown = 3
			self.DakHeat = 4.5
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lightppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lightppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/3ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/3ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/3ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightppcfire"
			self.DakFireSound = "dak/heavyppc.wav"
			self.DakFirePitch = 110
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 7
			self.DakShellExplosionEffect = "daklightppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 70
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 90
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "ALightPPCBurst" then
			self.DakName = "Armored Light Burst PPC"
			self.DakCooldown = 0.5
			self.DakHeat = 2
			self.DakMaxHealth = 100
			self.DakHealth= 100
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lightppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lightppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/3ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/3ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/3ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "lightburstppcfire"
			self.DakFireSound = "dak/ppc.wav"
			self.DakFirePitch = 90
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "lightburstppctrail"
			self.DakShellVelocity = 30000
			self.DakShellDamage = 2
			self.DakShellExplosionEffect = "daklightburstppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 20
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 120
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "AHeavyPPC" then
			self.DakName = "Armored Heavy PPC"
			self.DakCooldown = 3
			self.DakHeat = 12
			self.DakMaxHealth = 240
			self.DakHealth= 240
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/heavyppc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/heavyppc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10ppc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10ppc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10ppc4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "heavyppcfire"
			self.DakFireSound = "dak/heavyppc.wav"
			self.DakFirePitch = 75
			self.DakFireSpecialShell = false
			self.DakShellEnt = "dak_baseshell"
			self.DakShellTrail = "heavyppctrail"
			self.DakShellVelocity = 35000
			self.DakShellDamage = 20
			self.DakShellExplosionEffect = "dakheavyppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 200
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 60
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--Flamer
		if self:GetClientInfo("SpawnSettings") == "HeavyFlamer" then
			self.DakName = "Heavy Flamer"
			self.DakCooldown = 1
			self.DakHeat = 2
			self.DakMaxHealth = 20
			self.DakHealth= 20
			self.DakAmmo = 0
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/2flamer.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/2flamer.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/2plasmacannon2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/2plasmacannon3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/2plasmacannon4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_heavyflamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		if self:GetClientInfo("SpawnSettings") == "Flamer" then
			self.DakName = "Flamer"
			self.DakCooldown = 1
			self.DakHeat = 2
			self.DakMaxHealth = 10
			self.DakHealth= 10
			self.DakAmmo = 0
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1flamer.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1flamer.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1plasmacannon2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1plasmacannon3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1plasmacannon4.mdl"
			end
			self.DakAmmoType = "LightGaussAmmo"
			self.DakAmmoUse = "LightGaussAmmoUse"
			self.DakAmmoQueue = "LightGaussAmmoUseQueue"
			self.DakFireEffect = "flamerfire"
			self.DakFireSound = "dak/flamerfire.wav"
			self.DakFirePitch = 80
			self.DakFireSpecialShell = true
			self.DakShellEnt = "dak_isflamerbolt"
			self.DakShellTrail = "ppctrail"
			self.DakShellVelocity = 25000
			self.DakShellDamage = 10
			self.DakShellExplosionEffect = "dakppcexplosion"
			self.DakShellGravity = false
			self.DakShellMass = 100
			self.DakIsLBX = false
			self.DakLBXPellets = 1
			self.DakShellImpactSound = "dak/ppcimpact.wav"
			self.DakShellImpactPitch = 75
			self.DakIsExplosive = false
			self.DakUseAmmo = false
			self.DakIsRAC = false
			self.DakIsUAC = false
		end
		--LASERS--
		--Standard
		if self:GetClientInfo("SpawnSettings") == "MicroLaser" then
			self.DakName = "Micro Laser"
			self.DakCooldown = 0.875
			self.DakHeat = 0.75
			self.DakMaxHealth = 2.5
			self.DakHealth = 2.5
			self.DakMass = 250
			self.DakEngine = NULL
			self.DakModel = "models/dak/025laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/025laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/025laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/025laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/025laser4.mdl"
			end
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.25
			self.DakDamage = 0.5
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "SmallLaser" then
			self.DakName = "Small Laser"
			self.DakCooldown = 0.75
			self.DakHeat = 1
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05laser4.mdl"
			end
			self.DakFireSound = "dak/smalllaser.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.5
			self.DakDamage = 1
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "MediumLaser" then
			self.DakName = "Medium Laser"
			self.DakCooldown = 1.5
			self.DakHeat = 3
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1laser4.mdl"
			end
			self.DakFireSound = "dak/mediumlaser.wav"
			self.DakFirePitch = 70
			self.DakDuration = 0.75
			self.DakDamage = 3.5
			self.DakBeamEffect = "mediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "LargeLaser" then
			self.DakName = "Large Laser"
			self.DakCooldown = 1.625
			self.DakHeat = 3
			self.DakMaxHealth = 50
			self.DakHealth = 50
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/5laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/5laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/5laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/5laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/5laser4.mdl"
			end
			self.DakFireSound = "dak/largelaser.wav"
			self.DakFirePitch = 65
			self.DakDuration = 5.75
			self.DakDamage = 6.875
			self.DakBeamEffect = "largelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "AssaultLaser" then
			self.DakName = "Assault Laser"
			self.DakCooldown = 2
			self.DakHeat = 7.5
			self.DakMaxHealth = 60
			self.DakHealth = 60
			self.DakMass = 6000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/6laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/6laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/6laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/6laser4.mdl"
			end
			self.DakFireSound = "dak/assaultlaser.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.5
			self.DakDamage = 12
			self.DakBeamEffect = "assaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--Pulse
		if self:GetClientInfo("SpawnSettings") == "MicropulseLaser" then
			self.DakName = "Micro Pulse Laser"
			self.DakCooldown = 0.875
			self.DakHeat = 1
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/05laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/05laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/05laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/05laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/05laser4.mdl"
			end
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 90
			self.DakDuration = 0.125
			self.DakDamage = 0.75
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "SmallPulseLaser" then
			self.DakName = "Small Pulse Laser"
			self.DakCooldown = 0.875
			self.DakHeat = 1.5
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1laser4.mdl"
			end
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.125
			self.DakDamage = 1.5
			self.DakBeamEffect = "pulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "MediumPulseLaser" then
			self.DakName = "Medium Pulse Laser"
			self.DakCooldown = 1.5
			self.DakHeat = 3
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/2laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/2laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/2laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/2laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/2laser4.mdl"
			end
			self.DakFireSound = "dak/pulsesmall.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.375
			self.DakDamage = 4
			self.DakBeamEffect = "pulsemediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "LargePulseLaser" then
			self.DakName = "Large Pulse Laser"
			self.DakCooldown = 1.625
			self.DakHeat = 3
			self.DakMaxHealth = 70
			self.DakHealth = 70
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/6laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/7laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/7laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/7laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/7laser4.mdl"
			end
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 75
			self.DakDuration = 0.2875
			self.DakDamage = 7.5
			self.DakBeamEffect = "pulselargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "AssaultPulseLaser" then
			self.DakName = "Assault Pulse Laser"
			self.DakCooldown = 2
			self.DakHeat = 7.5
			self.DakMaxHealth = 100
			self.DakHealth = 100
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/10laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/10laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/10laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/10laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/10laser4.mdl"
			end
			self.DakFireSound = "dak/pulselarge.wav"
			self.DakFirePitch = 60
			self.DakDuration = 0.25
			self.DakDamage = 15.625
			self.DakBeamEffect = "pulseassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		--X-Pulse
		if self:GetClientInfo("SpawnSettings") == "SmallXPulseLaser" then
			self.DakName = "Small X-Pulse Laser"
			self.DakCooldown = 0
			self.DakHeat = 2
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/2laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/2laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/2laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/2laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/2laser4.mdl"
			end
			self.DakFireSound = "dak/xpulse.wav"
			self.DakFirePitch = 75
			self.DakDuration = 1
			self.DakDamage = 2.5
			self.DakBeamEffect = "xpulsesmalllaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "MediumXPulseLaser" then
			self.DakName = "Medium X-Pulse Laser"
			self.DakCooldown = 0
			self.DakHeat = 6
			self.DakMaxHealth = 40
			self.DakHealth = 40
			self.DakMass = 4000
			self.DakEngine = NULL
			self.DakModel = "models/dak/4laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/4laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/4laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/4laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/4laser4.mdl"
			end
			self.DakFireSound = "dak/xpulse.wav"
			self.DakFirePitch = 70
			self.DakDuration = 1.5
			self.DakDamage = 7
			self.DakBeamEffect = "xpulsemediumlaserbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "LargeXPulseLaser" then
			self.DakName = "Large X-Pulse Laser"
			self.DakCooldown = 0
			self.DakHeat = 6
			self.DakMaxHealth = 120
			self.DakHealth = 120
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/12laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/12laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/12laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/12laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/12laser4.mdl"
			end
			self.DakFireSound = "dak/xpulse.wav"
			self.DakFirePitch = 65
			self.DakDuration = 1.15
			self.DakDamage = 13
			self.DakBeamEffect = "xpulselargelaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "AssaultXPulseLaser" then
			self.DakName = "Assault X-Pulse Laser"
			self.DakCooldown = 0
			self.DakHeat = 15
			self.DakMaxHealth = 200
			self.DakHealth = 200
			self.DakMass = 20000
			self.DakEngine = NULL
			self.DakModel = "models/dak/20laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/20laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/20laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/20laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/20laser4.mdl"
			end
			self.DakFireSound = "dak/xpulse.wav"
			self.DakFirePitch = 60
			self.DakDuration = 1
			self.DakDamage = 25
			self.DakBeamEffect = "xpulseassaultlaserbeam"
			self.DakBurnEffect = "largelaserburn"
		end
		if self:GetClientInfo("SpawnSettings") == "TAG" then
			self.DakName = "TAG Laser"
			self.DakCooldown = 0
			self.DakHeat = 0
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/1laser.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/1laser.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/1laser2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/1laser3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/1laser4.mdl"
			end
			self.DakFireSound = ""
			self.DakFirePitch = 60
			self.DakDuration = 2.5
			self.DakDamage = 0
			self.DakBeamEffect = "smalllaserbeam"
			self.DakBurnEffect = ""
		end
		--MISSILES--
		--LRM
		if self:GetClientInfo("SpawnSettings") == "LRM5" then
			self.DakName = "LRM5 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 3
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakAmmo = 0
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm5.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm5.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm52.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm53.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm54.mdl"
			end
			self.DakAmmoType = "LRM5Ammo"
			self.DakAmmoUse = "LRM5AmmoUse"
			self.DakAmmoQueue = "LRM5AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "LRM10" then
			self.DakName = "LRM10 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 4
			self.DakMaxHealth = 50
			self.DakHealth = 50
			self.DakAmmo = 0
			self.DakMass = 5000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm10.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm10.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm102.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm103.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm104.mdl"
			end
			self.DakAmmoType = "LRM10Ammo"
			self.DakAmmoUse = "LRM10AmmoUse"
			self.DakAmmoQueue = "LRM10AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 2
			self.DakFireOffset = 9
		end
		if self:GetClientInfo("SpawnSettings") == "LRM15" then
			self.DakName = "LRM15 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 5
			self.DakMaxHealth = 70
			self.DakHealth = 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm15.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm15.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm152.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm153.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm154.mdl"
			end
			self.DakAmmoType = "LRM15Ammo"
			self.DakAmmoUse = "LRM15AmmoUse"
			self.DakAmmoQueue = "LRM15AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 3
			self.DakFireOffset = 18
		end
		if self:GetClientInfo("SpawnSettings") == "LRM20" then
			self.DakName = "LRM20 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 5
			self.DakMaxHealth = 100
			self.DakHealth = 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/lrm20.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/lrm20.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/lrm202.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/lrm203.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/lrm204.mdl"
			end
			self.DakAmmoType = "LRM20Ammo"
			self.DakAmmoUse = "LRM20AmmoUse"
			self.DakAmmoQueue = "LRM20AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_lrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 4
			self.DakFireOffset = 9
		end
		--SRM
		if self:GetClientInfo("SpawnSettings") == "SRM2" then
			self.DakName = "SRM2 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 2
			self.DakMaxHealth = 10
			self.DakHealth = 10
			self.DakAmmo = 0
			self.DakMass = 1000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm2.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm22.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm23.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm24.mdl"
			end
			self.DakAmmoType = "SRM2Ammo"
			self.DakAmmoUse = "SRM2AmmoUse"
			self.DakAmmoQueue = "SRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "SRM4" then
			self.DakName = "SRM4 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 3
			self.DakMaxHealth = 20
			self.DakHealth = 20
			self.DakAmmo = 0
			self.DakMass = 2000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm4.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm4.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm42.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm43.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm44.mdl"
			end
			self.DakAmmoType = "SRM4Ammo"
			self.DakAmmoUse = "SRM4AmmoUse"
			self.DakAmmoQueue = "SRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 2
			self.DakFireOffset = 6
		end		
		if self:GetClientInfo("SpawnSettings") == "SRM6" then
			self.DakName = "SRM6 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 4
			self.DakMaxHealth = 30
			self.DakHealth = 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm6.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm6.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm62.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm63.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm64.mdl"
			end
			self.DakAmmoType = "SRM6Ammo"
			self.DakAmmoUse = "SRM6AmmoUse"
			self.DakAmmoQueue = "SRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_srm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 3
			self.DakFireOffset = 12
		end	
		--SSRM
		if self:GetClientInfo("SpawnSettings") == "SSRM2" then
			self.DakName = "SSRM2 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 2
			self.DakMaxHealth = 15
			self.DakHealth = 15
			self.DakAmmo = 0
			self.DakMass = 1500
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm2.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm22.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm23.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm24.mdl"
			end
			self.DakAmmoType = "SSRM2Ammo"
			self.DakAmmoUse = "SSRM2AmmoUse"
			self.DakAmmoQueue = "SSRM2AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "SSRM4" then
			self.DakName = "SSRM4 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 3
			self.DakMaxHealth = 30
			self.DakHealth = 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm4.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm4.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm42.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm43.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm44.mdl"
			end
			self.DakAmmoType = "SSRM4Ammo"
			self.DakAmmoUse = "SSRM4AmmoUse"
			self.DakAmmoQueue = "SSRM4AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 2
			self.DakFireOffset = 6
		end		
		if self:GetClientInfo("SpawnSettings") == "SSRM6" then
			self.DakName = "SSRM6 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 4
			self.DakMaxHealth = 45
			self.DakHealth = 45
			self.DakAmmo = 0
			self.DakMass = 4500
			self.DakEngine = NULL
			self.DakModel = "models/dak/srm6.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/srm6.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/srm62.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/srm63.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/srm64.mdl"
			end
			self.DakAmmoType = "SSRM6Ammo"
			self.DakAmmoUse = "SSRM6AmmoUse"
			self.DakAmmoQueue = "SSRM6AmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_ssrm"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 3
			self.DakFireOffset = 12
		end	
		--ARROWIV
		if self:GetClientInfo("SpawnSettings") == "Arrow" then
			self.DakName = "Arrow IV Launcher"
			self.DakCooldown = 7.5
			self.DakHeat = 15
			self.DakMaxHealth = 150
			self.DakHealth = 150
			self.DakAmmo = 0
			self.DakMass = 15000
			self.DakEngine = NULL
			self.DakModel = "models/dak/arrow.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/arrow.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/arrow2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/arrow3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/arrow4.mdl"
			end
			self.DakAmmoType = "ArrowAmmo"
			self.DakAmmoUse = "ArrowAmmoUse"
			self.DakAmmoQueue = "ArrowAmmoUseQueue"
			self.DakFireSound = "dak/Arrow.wav"
			self.DakMissileType = "dak_arrow"
			self.DakCanSetTarget = true
			self.DakOutputTarget = true
			self.DakVolleySize = 5
			self.DakFireOffset = 10.8
		end		
		--NARC
		if self:GetClientInfo("SpawnSettings") == "NARC" then
			self.DakName = "NARC Launcher"
			self.DakCooldown = 2.5
			self.DakHeat = 0
			self.DakMaxHealth = 30
			self.DakHealth = 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/narc.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/narc.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/narc2.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/narc3.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/narc4.mdl"
			end
			self.DakAmmoType = "NARCAmmo"
			self.DakAmmoUse = "NARCAmmoUse"
			self.DakAmmoQueue = "NARCAmmoUseQueue"
			self.DakFireSound = "dak/SRM.wav"
			self.DakMissileType = "dak_isnarc"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "MRM10" then
			self.DakName = "MRM10 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 4
			self.DakMaxHealth = 30
			self.DakHealth = 30
			self.DakAmmo = 0
			self.DakMass = 3000
			self.DakEngine = NULL
			self.DakModel = "models/dak/mrm101.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/mrm101.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/mrm102.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/mrm103.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/mrm104.mdl"
			end
			self.DakAmmoType = "MRM10Ammo"
			self.DakAmmoUse = "MRM10AmmoUse"
			self.DakAmmoQueue = "MRM10AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 1
			self.DakFireOffset = 0
		end
		if self:GetClientInfo("SpawnSettings") == "MRM20" then
			self.DakName = "MRM20 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 6
			self.DakMaxHealth = 70
			self.DakHealth = 70
			self.DakAmmo = 0
			self.DakMass = 7000
			self.DakEngine = NULL
			self.DakModel = "models/dak/mrm201.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/mrm201.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/mrm202.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/mrm203.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/mrm204.mdl"
			end
			self.DakAmmoType = "MRM20Ammo"
			self.DakAmmoUse = "MRM20AmmoUse"
			self.DakAmmoQueue = "MRM20AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 2
			self.DakFireOffset = 9
		end
		if self:GetClientInfo("SpawnSettings") == "MRM30" then
			self.DakName = "MRM30 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 10
			self.DakMaxHealth = 100
			self.DakHealth = 100
			self.DakAmmo = 0
			self.DakMass = 10000
			self.DakEngine = NULL
			self.DakModel = "models/dak/mrm301.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/mrm301.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/mrm302.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/mrm303.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/mrm304.mdl"
			end
			self.DakAmmoType = "MRM30Ammo"
			self.DakAmmoUse = "MRM30AmmoUse"
			self.DakAmmoQueue = "MRM30AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 3
			self.DakFireOffset = 18
		end
		if self:GetClientInfo("SpawnSettings") == "MRM40" then
			self.DakName = "MRM40 Launcher"
			self.DakCooldown = 4
			self.DakHeat = 12
			self.DakMaxHealth = 120
			self.DakHealth = 120
			self.DakAmmo = 0
			self.DakMass = 12000
			self.DakEngine = NULL
			self.DakModel = "models/dak/mrm401.mdl"
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 1 then
				self.DakModel = "models/dak/mrm401.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 2 then
				self.DakModel = "models/dak/mrm402.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 3 then
				self.DakModel = "models/dak/mrm403.mdl"
			end
			if math.Round( self:GetClientInfo("SpawnMod"), 0 ) == 4 then
				self.DakModel = "models/dak/mrm404.mdl"
			end
			self.DakAmmoType = "MRM40Ammo"
			self.DakAmmoUse = "MRM40AmmoUse"
			self.DakAmmoQueue = "MRM40AmmoUseQueue"
			self.DakFireSound = "dak/LRM.wav"
			self.DakMissileType = "dak_mrm"
			self.DakCanSetTarget = false
			self.DakOutputTarget = false
			self.DakVolleySize = 4
			self.DakFireOffset = 9
		end	
		--AMMO--
		--Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "AC2Ammo" then
			self.DakName = "AC2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "AC2"
		end
		if self:GetClientInfo("SpawnSettings") == "AC5Ammo" then
			self.DakName = "AC5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "AC5"
		end
		if self:GetClientInfo("SpawnSettings") == "AC10Ammo" then
			self.DakName = "AC10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "AC10"
		end
		if self:GetClientInfo("SpawnSettings") == "AC20Ammo" then
			self.DakName = "AC20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "AC20"
		end
		--Inferno Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "IAC2Ammo" then
			self.DakName = "Inferno AC2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "IAC2"
			self.DakIsInferno = 1
		end
		if self:GetClientInfo("SpawnSettings") == "IAC5Ammo" then
			self.DakName = "Inferno AC5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "IAC5"
			self.DakIsInferno = 1
		end
		if self:GetClientInfo("SpawnSettings") == "IAC10Ammo" then
			self.DakName = "Inferno AC10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "IAC10"
			self.DakIsInferno = 1
		end
		if self:GetClientInfo("SpawnSettings") == "IAC20Ammo" then
			self.DakName = "Inferno AC20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "IAC20"
			self.DakIsInferno = 1
		end
		--Flak Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "FAC2Ammo" then
			self.DakName = "Flak AC2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "FAC2"
		end
		if self:GetClientInfo("SpawnSettings") == "FAC5Ammo" then
			self.DakName = "Flak AC5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "FAC5"
		end
		if self:GetClientInfo("SpawnSettings") == "FAC10Ammo" then
			self.DakName = "Flak AC10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "FAC10"
		end
		if self:GetClientInfo("SpawnSettings") == "FAC20Ammo" then
			self.DakName = "Flak AC20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "FAC20"
		end
		--Ultra Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "UAC2Ammo" then
			self.DakName = "UAC2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 287
			self.DakMaxAmmo = 287
			self.DakAmmoType = "UAC2"
		end
		if self:GetClientInfo("SpawnSettings") == "UAC5Ammo" then
			self.DakName = "UAC5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 100
			self.DakMaxAmmo = 100
			self.DakAmmoType = "UAC5"
		end
		if self:GetClientInfo("SpawnSettings") == "UAC10Ammo" then
			self.DakName = "UAC10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 44
			self.DakMaxAmmo = 44
			self.DakAmmoType = "UAC10"
		end
		if self:GetClientInfo("SpawnSettings") == "UAC20Ammo" then
			self.DakName = "UAC20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 27
			self.DakMaxAmmo = 27
			self.DakAmmoType = "UAC20"
		end
		--Rotary Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "RAC2Ammo" then
			self.DakName = "RAC2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 800
			self.DakMaxAmmo = 800
			self.DakAmmoType = "RAC2"
		end
		if self:GetClientInfo("SpawnSettings") == "RAC5Ammo" then
			self.DakName = "RAC5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 320
			self.DakMaxAmmo = 320
			self.DakAmmoType = "RAC5"
		end
		if self:GetClientInfo("SpawnSettings") == "RAC10Ammo" then
			self.DakName = "RAC10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 160
			self.DakMaxAmmo = 160
			self.DakAmmoType = "RAC10"
		end
		if self:GetClientInfo("SpawnSettings") == "RAC20Ammo" then
			self.DakName = "RAC20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "RAC20"
		end
		--LBX Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "LBX2Ammo" then
			self.DakName = "LBX2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "LBX2"
		end
		if self:GetClientInfo("SpawnSettings") == "LBX5Ammo" then
			self.DakName = "LBX5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "LBX5"
		end
		if self:GetClientInfo("SpawnSettings") == "LBX10Ammo" then
			self.DakName = "LBX10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "LBX10"
		end
		if self:GetClientInfo("SpawnSettings") == "LBX20Ammo" then
			self.DakName = "LBX20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "LBX20"
		end
		--AALBX Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "AALBX2Ammo" then
			self.DakName = "Anti-Air LBX2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "AALBX2"
		end
		if self:GetClientInfo("SpawnSettings") == "AALBX5Ammo" then
			self.DakName = "Anti-Air LBX5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "AALBX5"
		end
		if self:GetClientInfo("SpawnSettings") == "AALBX10Ammo" then
			self.DakName = "Anti-Air LBX10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "AALBX10"
		end
		if self:GetClientInfo("SpawnSettings") == "AALBX20Ammo" then
			self.DakName = "Anti-Air LBX20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "AALBX20"
		end
		--Slug LBX Autocannon Ammo
		if self:GetClientInfo("SpawnSettings") == "SLBX2Ammo" then
			self.DakName = "Slug LBX2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "SLBX2"
		end
		if self:GetClientInfo("SpawnSettings") == "SLBX5Ammo" then
			self.DakName = "Slug LBX5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "SLBX5"
		end
		if self:GetClientInfo("SpawnSettings") == "SLBX10Ammo" then
			self.DakName = "Slug LBX10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "SLBX10"
		end
		if self:GetClientInfo("SpawnSettings") == "SLBX20Ammo" then
			self.DakName = "Slug LBX20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "SLBX20"
		end
		--HAG Ammo
		if self:GetClientInfo("SpawnSettings") == "HAG20Ammo" then
			self.DakName = "HAG20 Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "HAG20"
		end
		if self:GetClientInfo("SpawnSettings") == "HAG30Ammo" then
			self.DakName = "HAG30 Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 134
			self.DakMaxAmmo = 134
			self.DakAmmoType = "HAG30"
		end
		if self:GetClientInfo("SpawnSettings") == "HAG40Ammo" then
			self.DakName = "HAG40 Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 100
			self.DakMaxAmmo = 100
			self.DakAmmoType = "HAG40"
		end
		--Gauss Ammo
		if self:GetClientInfo("SpawnSettings") == "MagshotAmmo" then
			self.DakName = "Magshot Gauss Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 200
			self.DakMaxAmmo = 200
			self.DakAmmoType = "Magshot"
		end
		if self:GetClientInfo("SpawnSettings") == "LightGaussAmmo" then
			self.DakName = "Light Gauss Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 27
			self.DakMaxAmmo = 27
			self.DakAmmoType = "LightGauss"
		end
		if self:GetClientInfo("SpawnSettings") == "GaussAmmo" then
			self.DakName = "Gauss Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 14
			self.DakMaxAmmo = 14
			self.DakAmmoType = "Gauss"
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyGaussAmmo" then
			self.DakName = "Heavy Gauss Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 8
			self.DakMaxAmmo = 8
			self.DakAmmoType = "HeavyGauss"
		end
		if self:GetClientInfo("SpawnSettings") == "RailgunAmmo" then
			self.DakName = "Railgun Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 4
			self.DakMaxAmmo = 4
			self.DakAmmoType = "Railgun"
		end
		if self:GetClientInfo("SpawnSettings") == "SBGAmmo" then
			self.DakName = "Silver Bullet Gauss Rifle Ammo"
			self.DakIsExplosive = false
			self.DakAmmo = 14
			self.DakMaxAmmo = 14
			self.DakAmmoType = "SBG"
		end
		--Machine Gun Ammo
		if self:GetClientInfo("SpawnSettings") == "LightMachineGunAmmo" then
			self.DakName = "Light Machine Gun Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 2000
			self.DakMaxAmmo = 2000
			self.DakAmmoType = "LightMachineGun"
		end
		if self:GetClientInfo("SpawnSettings") == "MachineGunAmmo" then
			self.DakName = "Machine Gun Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 1000
			self.DakMaxAmmo = 1000
			self.DakAmmoType = "MachineGun"
		end
		if self:GetClientInfo("SpawnSettings") == "HeavyMachineGunAmmo" then
			self.DakName = "Heavy Machine Gun Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 500
			self.DakMaxAmmo = 500
			self.DakAmmoType = "HeavyMachineGun"
		end
		--Long Tom Ammo
		if self:GetClientInfo("SpawnSettings") == "LongTomAmmo" then
			self.DakName = "Long Tom Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 8
			self.DakMaxAmmo = 8
			self.DakAmmoType = "LongTom"
		end
		if self:GetClientInfo("SpawnSettings") == "ThumperAmmo" then
			self.DakName = "Thumper Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "Thumper"
		end
		if self:GetClientInfo("SpawnSettings") == "SniperAmmo" then
			self.DakName = "Sniper Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 14
			self.DakMaxAmmo = 14
			self.DakAmmoType = "Sniper"
		end
		--ATMHE Ammo
		if self:GetClientInfo("SpawnSettings") == "ATM3HEAmmo" then
			self.DakName = "ATM3HE Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 45
			self.DakMaxAmmo = 45
			self.DakAmmoType = "ATM3HE"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM6HEAmmo" then
			self.DakName = "ATM6HE Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 23
			self.DakMaxAmmo = 23
			self.DakAmmoType = "ATM6HE"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM9HEAmmo" then
			self.DakName = "ATM9HE Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 15
			self.DakMaxAmmo = 15
			self.DakAmmoType = "ATM9HE"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM12HEAmmo" then
			self.DakName = "ATM12HE Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 12
			self.DakMaxAmmo = 12
			self.DakAmmoType = "ATM12HE"
		end
		--ATMS Ammo
		if self:GetClientInfo("SpawnSettings") == "ATM3SAmmo" then
			self.DakName = "ATM3S Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 67
			self.DakMaxAmmo = 67
			self.DakAmmoType = "ATM3S"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM6SAmmo" then
			self.DakName = "ATM6S Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 34
			self.DakMaxAmmo = 34
			self.DakAmmoType = "ATM6S"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM9SAmmo" then
			self.DakName = "ATM9S Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 23
			self.DakMaxAmmo = 23
			self.DakAmmoType = "ATM9S"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM12SAmmo" then
			self.DakName = "ATM12S Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 17
			self.DakMaxAmmo = 17
			self.DakAmmoType = "ATM12S"
		end
		--ATMER Ammo
		if self:GetClientInfo("SpawnSettings") == "ATM3ERAmmo" then
			self.DakName = "ATM3ER Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 134
			self.DakMaxAmmo = 134
			self.DakAmmoType = "ATM3ER"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM6ERAmmo" then
			self.DakName = "ATM6ER Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 67
			self.DakMaxAmmo = 67
			self.DakAmmoType = "ATM6ER"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM9ERAmmo" then
			self.DakName = "ATM9ER Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 45
			self.DakMaxAmmo = 45
			self.DakAmmoType = "ATM9ER"
		end
		if self:GetClientInfo("SpawnSettings") == "ATM12ERAmmo" then
			self.DakName = "ATM12ER Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 34
			self.DakMaxAmmo = 34
			self.DakAmmoType = "ATM12ER"
		end
		--LRM Ammo
		if self:GetClientInfo("SpawnSettings") == "LRM5Ammo" then
			self.DakName = "LRM5 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 80
			self.DakMaxAmmo = 80
			self.DakAmmoType = "LRM5"
		end
		if self:GetClientInfo("SpawnSettings") == "LRM10Ammo" then
			self.DakName = "LRM10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "LRM10"
		end
		if self:GetClientInfo("SpawnSettings") == "LRM15Ammo" then
			self.DakName = "LRM15 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 27
			self.DakMaxAmmo = 27
			self.DakAmmoType = "LRM15"
		end
		if self:GetClientInfo("SpawnSettings") == "LRM20Ammo" then
			self.DakName = "LRM20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "LRM20"
		end
		--MRM Ammo
		if self:GetClientInfo("SpawnSettings") == "MRM10Ammo" then
			self.DakName = "MRM10 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "MRM10"
		end
		if self:GetClientInfo("SpawnSettings") == "MRM20Ammo" then
			self.DakName = "MRM20 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 20
			self.DakMaxAmmo = 20
			self.DakAmmoType = "MRM20"
		end
		if self:GetClientInfo("SpawnSettings") == "MRM30Ammo" then
			self.DakName = "MRM30 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 14
			self.DakMaxAmmo = 14
			self.DakAmmoType = "MRM30"
		end
		if self:GetClientInfo("SpawnSettings") == "MRM40Ammo" then
			self.DakName = "MRM40 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 10
			self.DakMaxAmmo = 10
			self.DakAmmoType = "MRM40"
		end
		--SRM Ammo
		if self:GetClientInfo("SpawnSettings") == "SRM2Ammo" then
			self.DakName = "SRM2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 100
			self.DakMaxAmmo = 100
			self.DakAmmoType = "SRM2"
		end
		if self:GetClientInfo("SpawnSettings") == "SRM4Ammo" then
			self.DakName = "SRM4 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 51
			self.DakMaxAmmo = 51
			self.DakAmmoType = "SRM4"
		end
		if self:GetClientInfo("SpawnSettings") == "SRM6Ammo" then
			self.DakName = "SRM6 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 34
			self.DakMaxAmmo = 34
			self.DakAmmoType = "SRM6"
		end
		--SSRM Ammo
		if self:GetClientInfo("SpawnSettings") == "SSRM2Ammo" then
			self.DakName = "SSRM2 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 100
			self.DakMaxAmmo = 100
			self.DakAmmoType = "SSRM2"
		end
		if self:GetClientInfo("SpawnSettings") == "SSRM4Ammo" then
			self.DakName = "SSRM4 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 51
			self.DakMaxAmmo = 51
			self.DakAmmoType = "SSRM4"
		end
		if self:GetClientInfo("SpawnSettings") == "SSRM6Ammo" then
			self.DakName = "SSRM6 Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 34
			self.DakMaxAmmo = 34
			self.DakAmmoType = "SSRM6"
		end
		--ArrowIV Ammo
		if self:GetClientInfo("SpawnSettings") == "ArrowAmmo" then
			self.DakName = "Arrow IV Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 14
			self.DakMaxAmmo = 14
			self.DakAmmoType = "Arrow"
		end
		--NARC Ammo
		if self:GetClientInfo("SpawnSettings") == "NARCAmmo" then
			self.DakName = "NARC Ammo"
			self.DakIsExplosive = true
			self.DakAmmo = 40
			self.DakMaxAmmo = 40
			self.DakAmmoType = "NARC"
		end
		--ENGINES--
		--Micro Engines
		if self:GetClientInfo("SpawnSettings") == "MicroCompact" then
			self.DakName = "Micro Compact Engine"
			self.DakTonnageLimit = 10000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 15
			self.DakBaseMaxHeat = 15
			self.DakHeat = 0
			self.DakHealth = 10
			self.DakMaxHealth = 10
			self.DakMass = 1000
			self.DakModel = "models/dak/microcompactengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "MicroStandard" then
			self.DakName = "Micro Standard Engine"
			self.DakTonnageLimit = 10000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 12.5
			self.DakBaseMaxHeat = 12.5
			self.DakHeat = 0
			self.DakHealth = 7.5
			self.DakMaxHealth = 7.5
			self.DakMass = 750
			self.DakModel = "models/dak/microstandardengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "MicroXL" then
			self.DakName = "Micro XL Engine"
			self.DakTonnageLimit = 10000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 10
			self.DakBaseMaxHeat = 10
			self.DakHeat = 0
			self.DakHealth = 5
			self.DakMaxHealth = 5
			self.DakMass = 500
			self.DakModel = "models/dak/microxlengine.mdl"
		end
        --Small Engines
		if self:GetClientInfo("SpawnSettings") == "SmallCompact" then
			self.DakName = "Small Compact Engine"
			self.DakTonnageLimit = 40000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 30
			self.DakBaseMaxHeat = 30
			self.DakHeat = 0
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 5000
			self.DakModel = "models/dak/smallcompactengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "SmallStandard" then
			self.DakName = "Small Standard Engine"
			self.DakTonnageLimit = 40000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 25
			self.DakBaseMaxHeat = 25
			self.DakHeat = 0
			self.DakHealth = 37.5
			self.DakMaxHealth = 37.5
			self.DakMass = 3750
			self.DakModel = "models/dak/smallstandardengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "SmallXL" then
			self.DakName = "Small XL Engine"
			self.DakTonnageLimit = 40000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 20
			self.DakBaseMaxHeat = 20
			self.DakHeat = 0
			self.DakHealth = 25
			self.DakMaxHealth = 25
			self.DakMass = 2500
			self.DakModel = "models/dak/smallxlengine.mdl"
		end
        --Medium Engines
		if self:GetClientInfo("SpawnSettings") == "MediumCompact" then
			self.DakName = "Medium Compact Engine"
			self.DakTonnageLimit = 75000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 50
			self.DakBaseMaxHeat = 50
			self.DakHeat = 0
			self.DakHealth = 100
			self.DakMaxHealth = 100
			self.DakMass = 10000
			self.DakModel = "models/dak/mediumcompactengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "MediumStandard" then
			self.DakName = "Medium Standard Engine"
			self.DakTonnageLimit = 75000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 40
			self.DakBaseMaxHeat = 40
			self.DakHeat = 0
			self.DakHealth = 75
			self.DakMaxHealth = 75
			self.DakMass = 7500
			self.DakModel = "models/dak/mediumstandardengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "MediumXL" then
			self.DakName = "Medium XL Engine"
			self.DakTonnageLimit = 75000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 30
			self.DakBaseMaxHeat = 30
			self.DakHeat = 0
			self.DakHealth = 50
			self.DakMaxHealth = 50
			self.DakMass = 5000
			self.DakModel = "models/dak/mediumxlengine.mdl"
		end
        --Large Engines
		if self:GetClientInfo("SpawnSettings") == "LargeCompact" then
			self.DakName = "Large Compact Engine"
			self.DakTonnageLimit = 100000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 60
			self.DakBaseMaxHeat = 60
			self.DakHeat = 0
			self.DakHealth = 150
			self.DakMaxHealth = 150
			self.DakMass = 15000
			self.DakModel = "models/dak/largecompactengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "LargeStandard" then
			self.DakName = "Large Standard Engine"
			self.DakTonnageLimit = 100000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 50
			self.DakBaseMaxHeat = 50
			self.DakHeat = 0
			self.DakHealth = 112.5
			self.DakMaxHealth = 112.5
			self.DakMass = 11250
			self.DakModel = "models/dak/largestandardengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "LargeXL" then
			self.DakName = "Large XL Engine"
			self.DakTonnageLimit = 100000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 40
			self.DakBaseMaxHeat = 40
			self.DakHeat = 0
			self.DakHealth = 75
			self.DakMaxHealth = 75
			self.DakMass = 7500
			self.DakModel = "models/dak/largexlengine.mdl"
		end
        --Ultra Engines
		if self:GetClientInfo("SpawnSettings") == "UltraCompact" then
			self.DakName = "Ultra Compact Engine"
			self.DakTonnageLimit = 200000
			self.DakCooling = 4
			self.DakBaseCooling = 4
			self.DakMaxHeat = 80
			self.DakBaseMaxHeat = 80
			self.DakHeat = 0
			self.DakHealth = 300
			self.DakMaxHealth = 300
			self.DakMass = 30000
			self.DakModel = "models/dak/ultracompactengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "UltraStandard" then
			self.DakName = "Ultra Standard Engine"
			self.DakTonnageLimit = 200000
			self.DakCooling = 3.5
			self.DakBaseCooling = 3.5
			self.DakMaxHeat = 70
			self.DakBaseMaxHeat = 70
			self.DakHeat = 0
			self.DakHealth = 225
			self.DakMaxHealth = 225
			self.DakMass = 22500
			self.DakModel = "models/dak/ultrastandardengine.mdl"
		end
		if self:GetClientInfo("SpawnSettings") == "UltraXL" then
			self.DakName = "Ultra XL Engine"
			self.DakTonnageLimit = 200000
			self.DakCooling = 3
			self.DakBaseCooling = 3
			self.DakMaxHeat = 60
			self.DakBaseMaxHeat = 60
			self.DakHeat = 0
			self.DakHealth = 150
			self.DakMaxHealth = 150
			self.DakMass = 15000
			self.DakModel = "models/dak/ultraxlengine.mdl"
		end
		--LAMS
		if self:GetClientInfo("SpawnSettings") == "LAMS" then
			self.DakName = "Laser AMS"
			self.DakCooldown = 0
			self.DakHeat = 5
			self.DakMaxHealth = 5
			self.DakHealth = 5
			self.DakMass = 500
			self.DakEngine = NULL
			self.DakModel = "models/dak/lams.mdl"
			self.DakFireSound = "dak/xpulsesmall.wav"
			self.DakFirePitch = 100
			self.DakDuration = 1
			self.DakDamage = 25
			self.DakBeamEffect = "lamsbeam"
			self.DakBurnEffect = "laserburn"
		end
		if self:GetClientInfo("SpawnEnt") == "dak_gun" then
				self.spawnedent.DakOwner = self:GetOwner()
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakCooldown = self.DakCooldown
				self.spawnedent.DakHeat = self.DakHeat
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakAmmo = self.DakAmmo
				self.spawnedent.DakMass = self.DakMass
				self.spawnedent.DakEngine = self.DakEngine
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakAmmoType = self.DakAmmoType
				self.spawnedent.DakAmmoUse = self.DakAmmoUse
				self.spawnedent.DakAmmoQueue = self.DakAmmoQueue
				self.spawnedent.DakFireEffect = self.DakFireEffect
				self.spawnedent.DakFireSound = self.DakFireSound
				self.spawnedent.DakFirePitch = self.DakFirePitch
				self.spawnedent.DakFireSpecialShell = self.DakFireSpecialShell
				self.spawnedent.DakShellEnt = self.DakShellEnt
				self.spawnedent.DakIsExplosive = self.DakIsExplosive
				self.spawnedent.DakShellTrail = self.DakShellTrail
				self.spawnedent.DakShellVelocity = self.DakShellVelocity
				self.spawnedent.DakShellDamage = self.DakShellDamage
				self.spawnedent.DakShellExplosionEffect = self.DakShellExplosionEffect
				self.spawnedent.DakShellGravity = self.DakShellGravity
				self.spawnedent.DakShellMass = self.DakShellMass
				self.spawnedent.DakIsLBX = self.DakIsLBX
				self.spawnedent.DakLBXPellets = self.DakLBXPellets
				self.spawnedent.DakShellImpactSound = self.DakShellImpactSound
				self.spawnedent.DakShellImpactPitch = self.DakShellImpactPitch
				self.spawnedent.DakUseAmmo = self.DakUseAmmo
				self.spawnedent.DakIsRAC = self.DakIsRAC
				self.spawnedent.DakIsUAC = self.DakIsUAC
				self.spawnedent:SetModel(self.spawnedent.DakModel)
		end
		if self:GetClientInfo("SpawnEnt") == "dak_ammo" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_ammo" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakIsExplosive = self.DakIsExplosive
					trace.Entity.DakAmmo = self.DakAmmo
					trace.Entity.DakMaxAmmo = self.DakMaxAmmo
					trace.Entity.DakAmmoType = self.DakAmmoType
					trace.Entity.DakOwner = self:GetOwner()
					self:GetOwner():ChatPrint("Ammo updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakIsExplosive = self.DakIsExplosive
				self.spawnedent.DakAmmo = self.DakAmmo
				self.spawnedent.DakMaxAmmo = self.DakMaxAmmo
				self.spawnedent.DakAmmoType = self.DakAmmoType
				self.spawnedent.DakOwner = self:GetOwner()
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_engine" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_engine" then
					trace.Entity.DakOwner = self:GetOwner()
					trace.Entity.DakName = self.DakName
					trace.Entity.DakTonnageLimit = self.DakTonnageLimit
					trace.Entity.DakCooling = self.DakCooling
					trace.Entity.DakBaseCooling = self.DakBaseCooling
					trace.Entity.DakMaxHeat = self.DakMaxHeat
					trace.Entity.DakBaseMaxHeat = self.DakBaseMaxHeat
					trace.Entity.DakHeat = self.DakHeat
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakMass = self.DakMass
					trace.Entity.DakModel = self.DakModel
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("Engine updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakOwner = self:GetOwner()
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakTonnageLimit = self.DakTonnageLimit
				self.spawnedent.DakCooling = self.DakCooling
				self.spawnedent.DakBaseCooling = self.DakBaseCooling
				self.spawnedent.DakMaxHeat = self.DakMaxHeat
				self.spawnedent.DakBaseMaxHeat = self.DakBaseMaxHeat
				self.spawnedent.DakHeat = self.DakHeat
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakMass = self.DakMass
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_xpulselaser" then
				self.spawnedent.DakOwner = self:GetOwner()
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakCooldown = self.DakCooldown
				self.spawnedent.DakHeat = self.DakHeat
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakMass = self.DakMass
				self.spawnedent.DakEngine = self.DakEngine
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakFireSound = self.DakFireSound
				self.spawnedent.DakFirePitch = self.DakFirePitch
				self.spawnedent.DakDuration = self.DakDuration
				self.spawnedent.DakDamage = self.DakDamage
				self.spawnedent.DakBeamEffect = self.DakBeamEffect
				self.spawnedent.DakBurnEffect = self.DakBurnEffect
				self.spawnedent:SetModel(self.spawnedent.DakModel)
		end
		if self:GetClientInfo("SpawnEnt") == "dak_lams" then
				self.spawnedent.DakOwner = self:GetOwner()
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakCooldown = self.DakCooldown
				self.spawnedent.DakHeat = self.DakHeat
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakMass = self.DakMass
				self.spawnedent.DakEngine = self.DakEngine
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakFireSound = self.DakFireSound
				self.spawnedent.DakFirePitch = self.DakFirePitch
				self.spawnedent.DakDuration = self.DakDuration
				self.spawnedent.DakDamage = self.DakDamage
				self.spawnedent.DakBeamEffect = self.DakBeamEffect
				self.spawnedent.DakBurnEffect = self.DakBurnEffect
				self.spawnedent:SetModel(self.spawnedent.DakModel)
		end
		if self:GetClientInfo("SpawnEnt") == "dak_laser" then
				self.spawnedent.DakOwner = self:GetOwner()
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakCooldown = self.DakCooldown
				self.spawnedent.DakHeat = self.DakHeat
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakMass = self.DakMass
				self.spawnedent.DakEngine = self.DakEngine
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakFireSound = self.DakFireSound
				self.spawnedent.DakFirePitch = self.DakFirePitch
				self.spawnedent.DakDuration = self.DakDuration
				self.spawnedent.DakDamage = self.DakDamage
				self.spawnedent.DakBeamEffect = self.DakBeamEffect
				self.spawnedent.DakBurnEffect = self.DakBurnEffect
				self.spawnedent:SetModel(self.spawnedent.DakModel)
		end
		if self:GetClientInfo("SpawnEnt") == "dak_launcher" then
				self.spawnedent.DakOwner = self:GetOwner()
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakCooldown = self.DakCooldown
				self.spawnedent.DakHeat = self.DakHeat
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakAmmo = self.DakAmmo
				self.spawnedent.DakMass = self.DakMass
				self.spawnedent.DakEngine = self.DakEngine
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakAmmoType = self.DakAmmoType
				self.spawnedent.DakAmmoUse = self.DakAmmoUse
				self.spawnedent.DakAmmoQueue = self.DakAmmoQueue
				self.spawnedent.DakFireSound = self.DakFireSound
				self.spawnedent.DakMissileType = self.DakMissileType
				self.spawnedent.DakCanSetTarget = self.DakCanSetTarget
				self.spawnedent.DakOutputTarget = self.DakOutputTarget
				self.spawnedent.DakVolleySize = self.DakVolleySize
				self.spawnedent.DakFireOffset = self.DakFireOffset
				self.spawnedent:SetModel(self.spawnedent.DakModel)
		end
		if self:GetClientInfo("SpawnEnt") == "dak_fighter" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_fighter" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakSpeed = self.DakSpeed
					trace.Entity.DakModel = self.DakModel
					trace.Entity.DakSound = self.DakSound
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("Fighter updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakSpeed = self.DakSpeed
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakSound = self.DakSound
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_vtol" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_vtol" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakSpeed = self.DakSpeed
					trace.Entity.DakModel = self.DakModel
					trace.Entity.DakSound = self.DakSound
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("VTOL updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakSpeed = self.DakSpeed
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakSound = self.DakSound
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_hoverdrive" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_hoverdrive" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakSpeed = self.DakSpeed
					trace.Entity.DakModel = self.DakModel
					trace.Entity.DakSound = self.DakSound
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("Hoverdrive updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakSpeed = self.DakSpeed
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakSound = self.DakSound
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_motor" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_motor" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakSpeed = self.DakSpeed
					trace.Entity.DakModel = self.DakModel
					trace.Entity.DakSound = self.DakSound
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint( "Motor updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakSpeed = self.DakSpeed
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakSound = self.DakSound
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_module" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_module" then
					trace.Entity.DakName = self.DakName
					self:GetOwner():ChatPrint("Module updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_jumpjet" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_jumpjet" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakJumpCapacity = self.DakJumpCapacity
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("Jump Jet updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakJumpCapacity = self.DakJumpCapacity
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_quadgyro" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_quadgyro" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakSpeed = self.DakSpeed
					trace.Entity.DakModel = self.DakModel
					trace.Entity.DakSound = self.DakSound
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("Quad Gyro updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakSpeed = self.DakSpeed
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakSound = self.DakSound
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if self:GetClientInfo("SpawnEnt") == "dak_gyro" then
			if trace.Entity then
				if trace.Entity:GetClass() == "dak_gyro" then
					trace.Entity.DakName = self.DakName
					trace.Entity.DakMaxHealth = self.DakMaxHealth
					trace.Entity.DakHealth = self.DakHealth
					trace.Entity.DakSpeed = self.DakSpeed
					trace.Entity.DakModel = self.DakModel
					trace.Entity.DakSound = self.DakSound
					trace.Entity:PhysicsDestroy()
					trace.Entity:SetModel(trace.Entity.DakModel)
					trace.Entity:PhysicsInit(SOLID_VPHYSICS)
					trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
					trace.Entity:SetSolid(SOLID_VPHYSICS)
					self:GetOwner():ChatPrint("Gyro updated.")
				end
			end
			if not(trace.Entity:IsValid()) then
				self.spawnedent.DakName = self.DakName
				self.spawnedent.DakMaxHealth = self.DakMaxHealth
				self.spawnedent.DakHealth = self.DakHealth
				self.spawnedent.DakSpeed = self.DakSpeed
				self.spawnedent.DakModel = self.DakModel
				self.spawnedent.DakSound = self.DakSound
				self.spawnedent:SetModel(self.spawnedent.DakModel)
			end
		end
		if not(trace.Entity:GetClass() == self:GetClientInfo("SpawnEnt")) and not(trace.Entity:GetClass() == "dak_gun") and not(trace.Entity:GetClass() == "dak_laser") and not(trace.Entity:GetClass() == "dak_xpulselaser") and not(trace.Entity:GetClass() == "dak_launcher") and not(trace.Entity:GetClass() == "dak_lams") then
			self.spawnedent:Spawn()
			self.spawnedent:GetPhysicsObject():EnableMotion( false )
			self.spawnedent:SetPos(trace.HitPos+Vector(0,0,-self.spawnedent:OBBMins().z))
			if not(self.spawnedent:GetClass() == "dak_engine") and not(self.spawnedent:GetClass() == "dak_module") and not(self.spawnedent:GetClass() == "dak_ammo") and not(self.spawnedent:GetClass() == "dak_heatsink") and not(self.spawnedent:GetClass() == "dak_hitboxcontroller") and not(self.spawnedent:GetClass() == "dak_masc") and not(self.spawnedent:GetClass() == "dak_supercharger") and not(self.spawnedent:GetClass() == "dak_motor") and not(self.spawnedent:GetClass() == "dak_vtol") and not(self.spawnedent:GetClass() == "dak_fighter") and not(self.spawnedent:GetClass() == "dak_hoverdrive") and not(self.spawnedent:GetClass() == "dak_gyro") and not(self.spawnedent:GetClass() == "dak_quadgyro") and not(self.spawnedent:GetClass() == "dak_lams") and not(self.spawnedent:GetClass() == "dak_jumpjet") then
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 1 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakplainmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 2 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakplainmetaldark" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 3 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakscratchedmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 4 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakscratchedmetaldark" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 5 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakpittedmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 6 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakpittedmetaldark" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 7 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakrustedmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 8 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakrustedmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 2 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakplainmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 1 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakplainmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 4 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakscratchedmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 3 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakscratchedmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 6 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakpittedmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 5 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakpittedmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 8 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakrustedmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 7 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakrustedmetaldark" )
				end
			end
			local ply = self:GetOwner()
			ply:AddCount( "daktek", self.spawnedent)
			undo.Create( "daktek" )
			undo.AddEntity( self.spawnedent )
			undo.SetPlayer( ply )
			undo.Finish()
			ply:AddCleanup( "daktek", self.spawnedent )
			cleanup.Register("daktek")
		end
		if (trace.Entity:GetClass() == "dak_gun") or (trace.Entity:GetClass() == "dak_laser") or (trace.Entity:GetClass() == "dak_xpulselaser") or (trace.Entity:GetClass() == "dak_launcher") or (trace.Entity:GetClass() == "dak_lams") then
			if (self:GetClientInfo("SpawnEnt") == "dak_gun") or (self:GetClientInfo("SpawnEnt") == "dak_laser") or (self:GetClientInfo("SpawnEnt") == "dak_xpulselaser") or (self:GetClientInfo("SpawnEnt") == "dak_launcher") or (self:GetClientInfo("SpawnEnt") == "dak_lams") then
			self.spawnedent:Spawn()
			self.spawnedent:GetPhysicsObject():EnableMotion( false )
			if not(self.spawnedent:GetClass() == "dak_engine") and not(self.spawnedent:GetClass() == "dak_module") and not(self.spawnedent:GetClass() == "dak_ammo") and not(self.spawnedent:GetClass() == "dak_heatsink") and not(self.spawnedent:GetClass() == "dak_hitboxcontroller") and not(self.spawnedent:GetClass() == "dak_masc") and not(self.spawnedent:GetClass() == "dak_supercharger") and not(self.spawnedent:GetClass() == "dak_motor") and not(self.spawnedent:GetClass() == "dak_vtol") and not(self.spawnedent:GetClass() == "dak_fighter") and not(self.spawnedent:GetClass() == "dak_hoverdrive") and not(self.spawnedent:GetClass() == "dak_gyro") and not(self.spawnedent:GetClass() == "dak_quadgyro") and not(self.spawnedent:GetClass() == "dak_lams") and not(self.spawnedent:GetClass() == "dak_jumpjet") then
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 1 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakplainmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 2 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakplainmetaldark" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 3 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakscratchedmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 4 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakscratchedmetaldark" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 5 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakpittedmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 6 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakpittedmetaldark" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 7 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakrustedmetallight" )
				end
				if math.Round( self:GetClientInfo("PTSpawnMod"), 0 ) == 8 then
					self.spawnedent:SetSubMaterial( 0, "dak/dakrustedmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 2 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakplainmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 1 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakplainmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 4 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakscratchedmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 3 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakscratchedmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 6 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakpittedmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 5 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakpittedmetaldark" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 8 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakrustedmetallight" )
				end
				if math.Round( self:GetClientInfo("STSpawnMod"), 0 ) == 7 then
					self.spawnedent:SetSubMaterial( 1, "dak/dakrustedmetaldark" )
				end
			end
			local ply = self:GetOwner()
			ply:AddCount( "daktek", self.spawnedent)
			undo.Create( "daktek" )
			undo.AddEntity( self.spawnedent )
			undo.SetPlayer( ply )
			undo.Finish()
			ply:AddCleanup( "daktek", self.spawnedent )
			cleanup.Register("daktek")
			self.spawnedent:GetPhysicsObject():EnableMotion(false)

		local Constraints = constraint.GetTable( trace.Entity )
			for k, v in pairs(Constraints) do
				if v.Ent1 == trace.Entity then
					v.Ent1 = self.spawnedent
				end
				if v.Ent2 == trace.Entity then
					v.Ent2 = self.spawnedent
				end
				if v.Type == "AdvBallsocket" then
					constraint.AdvBallsocket( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.forcelimit, v.torquelimit, v.xmin, v.ymin, v.zmin, v.xmax, v.ymax, v.zmax, v.xfric, v.yfric, v.zfric, v.onlyrotation, v.nocollide )
				end
				if v.Type == "Axis" then
					constraint.Axis( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.forcelimit, v.torquelimit, v.friction, v.nocollide, v.LocalAxis, v.DontAddTable )
				end
				if v.Type == "Ballsocket" then
					constraint.Ballsocket( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LocalPos, v.forcelimit, v.torquelimit, v.nocollide )
				end
				if v.Type == "Elastic" then
					constraint.Elastic( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.constant, v.damping, v.rdamping, v.material, v.width, v.stretchonly )
				end
				if v.Type == "Hydraulic" then
					constraint.Hydraulic( v.pl, v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.Length1, v.Length2, v.width, v.key, v.fixed, v.speed, v.material )
				end
				if v.Type == "Motor" then
					constraint.Motor( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.friction, v.torque, v.forcetime, v.nocollide, v.toggle, v.pl, v.forcelimit, v.numpadkey_fwd, v.numpadkey_bwd, v.direction, v.LocalAxis )
				end
				if v.Type == "Muscle" then
					constraint.Muscle( v.pl, v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.Length1, v.Length2, v.width, v.key, v.fixed, v.period, v.amplitude, v.starton, v.material )
				end
				if v.Type == "NoCollide" then
					constraint.NoCollide( v.Ent1, v.Ent2, v.Bone1, v.Bone2 )
				end
				if v.Type == "Pulley" then
					constraint.Pulley( v.Ent1, v.Ent4, v.Bone1, v.Bone4, v.LPos1, v.LPos4, v.WPos2, v.WPos3, v.forcelimit, v.rigid, v.width, v.material )
				end
				if v.Type == "Rope" then
					constraint.Rope( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.length, v.addlength, v.forcelimit, v.width, v.material, v.rigid )
				end
				if v.Type == "Slider" then
					constraint.Slider( v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.width, v.material )
				end
				if v.Type == "Weld" then
					constraint.Weld( v.ent1, v.ent2, v.bone1, v.bone2, v.forcelimit, v.nocollide, v.deleteent1onbreak )
				end
				if v.Type == "Winch" then
					constraint.Winch( v.pl, v.Ent1, v.Ent2, v.Bone1, v.Bone2, v.LPos1, v.LPos2, v.width, v.key, v.key, v.fwd_speed, v.bwd_speed, v.material, v.toggle )
				end
			end

				self.spawnedent.Inputs.Fire.Path = trace.Entity.Inputs.Fire.Path
				self.spawnedent.Inputs.Fire.Entity = self.spawnedent
				self.spawnedent.Inputs.Fire.SrcId = trace.Entity.Inputs.Fire.SrcId
				self.spawnedent.Inputs.Fire.Name = trace.Entity.Inputs.Fire.Name
				self.spawnedent.Inputs.Fire.Src = trace.Entity.Inputs.Fire.Src
				self.spawnedent.Inputs.Fire.Num = trace.Entity.Inputs.Fire.Num	
				self.spawnedent.Inputs.Fire.Material = trace.Entity.Inputs.Fire.Material
				self.spawnedent.Inputs.Fire.Width = trace.Entity.Inputs.Fire.Width
				self.spawnedent.Inputs.Fire.Value = trace.Entity.Inputs.Fire.Value
				self.spawnedent.Inputs.Fire.Color = trace.Entity.Inputs.Fire.Color
				--self.spawnedent.Inputs.Fire.Idx = trace.Entity.Inputs.Fire.Idx
				self.spawnedent.Inputs.Fire.StartPos = trace.Entity.Inputs.Fire.StartPos
				self.spawnedent.Inputs.Fire.Type = trace.Entity.Inputs.Fire.Type

			self.spawnedent:SetColor(trace.Entity:GetColor())
			self.spawnedent.DakEngine = trace.Entity.DakEngine
			trace.Entity:Remove()
			local ply = self:GetOwner()
			ply:AddCount( "daktek", self.spawnedent)
			ply:AddCleanup( "daktek", self.spawnedent )

			undo.Create( "daktek" )
				undo.AddEntity( self.spawnedent )
				undo.SetPlayer( ply )
			undo.Finish()
			ply:AddCleanup( "DakTek", self.spawnedent )
			self:GetOwner():ChatPrint("Weapon updated, respawn with duplicator to apply wiring.")
		end
		end


	end
end
 
function TOOL:RightClick( trace )
	if SERVER then
	if IsValid(trace.Entity) then
		if trace.Entity.DakHealth == nil then
			DakTekSetupNewEnt(trace.Entity)
		end
		local Target = trace.Entity
		local ply = self:GetOwner()
		local TarName = Target.DakName
		local HP = math.Round(Target.DakHealth, 1 )
		local MHP = math.Round(Target.DakMaxHealth, 1 )
		local PHP = math.Round((HP/MHP)*100, 1 )
		if Target:GetClass() == "dak_engine" then
			ply:ChatPrint(TarName..", ".. HP.." Health, "..MHP.." Max Health, "..PHP.."% Health")
			ply:ChatPrint("Alpha strike max heat percent: "..math.Round((Target.DakAlphaHeatThreshhold*100),0).."%")
			ply:ChatPrint("Heat Efficiency: "..math.Round((Target.DakHeatEfficiency*100),0).."%")
			ply:ChatPrint("Alpha strike heat: "..math.Round(Target.DakWeaponHeat,2).." Heat")
			ply:ChatPrint("Heat per second: "..math.Round(Target.DakWeaponHPS,2).." HPS")
			ply:ChatPrint("Max Heat: "..math.Round(Target.DakMaxHeat,2).." Heat")
			ply:ChatPrint("Cooling: "..math.Round(Target.DakCooling,2).." HPS")
			if Target.DakOverheatTime < 0 then
				ply:ChatPrint("Time to overheat: Never")
			else
				ply:ChatPrint("Time to overheat: "..math.Round(Target.DakOverheatTime,1).." seconds")
			end
		else
			ply:ChatPrint(TarName..", ".. HP.." Health, "..MHP.." Max Health, "..PHP.."% Health")
		end
	end
	end
end

local function GetPhysCons( ent, Results )
	local Results = Results or {}
	if not IsValid( ent ) then return end
		if Results[ ent ] then return end
		Results[ ent ] = ent
		local Constraints = constraint.GetTable( ent )
		for k, v in ipairs( Constraints ) do
			if not (v.Type == "NoCollide") then
				for i, Ent in pairs( v.Entity ) do
					GetPhysCons( Ent.Entity, Results )
				end
			end
		end
	return Results
end

local function GetParents( ent, Results )
	local Results = Results or {}
	local Parent = ent:GetParent()
	Results[ ent ] = ent
	if IsValid(Parent) then
		GetParents(Parent, Results)
	end
	return Results
end

function TOOL:Reload( trace )
	if SERVER then
		if IsValid(trace.Entity) then
		local Contraption = {}
		table.Add(Contraption,GetParents(trace.Entity))
		for k, v in pairs(GetParents(trace.Entity)) do
			table.Add(Contraption,GetPhysCons(v))
		end
		local Mass = 0
		for i=1, #Contraption do
			table.Add( Contraption, Contraption[i]:GetChildren() )
			table.Add( Contraption, Contraption[i]:GetParent() )
		end
		local Children = {}
		for i2=1, #Contraption do
			if table.Count(Contraption[i2]:GetChildren()) > 0 then
				table.Add( Children, Contraption[i2]:GetChildren() )
			end
		end
		table.Add( Contraption, Children )
		local hash = {}
		local res = {}
		for _,v in ipairs(Contraption) do
   			if (not hash[v]) then
    			res[#res+1] = v
    	   		hash[v] = true
   			end
		end
		for i=1, #res do
			if res[i]:IsSolid() then
				Mass = Mass + res[i]:GetPhysicsObject():GetMass()
			end
		end
		local ply = self:GetOwner()
		ply:ChatPrint("This Contraption weighs "..Mass.." kg")
		end
	end
end



 
function TOOL.BuildCPanel( panel )
panel:SetMouseInputEnabled( true )
local ctrl = vgui.Create( "DTree", panel )
ctrl:SetPos( 5, 30 )
ctrl:SetPadding( 5 )
ctrl:SetSize( 300, 300 )
ctrl:SetShowIcons( false )

local DLabel = vgui.Create( "DLabel", panel )
DLabel:SetPos( 17, 410 )
DLabel:SetAutoStretchVertical( true )
DLabel:SetText( "Select an entity and information for it will appear here" )
DLabel:SetTextColor(Color(0,0,0,255))
DLabel:SetWide( 200 )
DLabel:SetWrap( true )

local ModOption = vgui.Create( "DComboBox", panel )
ModOption:SetPos( 17, 340 )
ModOption:SetSize( 100, 20 )
ModOption:SetValue( "Model Options" )
ModOption:AddChoice( "Model 1" )
ModOption:AddChoice( "Model 2" )
ModOption:AddChoice( "Model 3" )
ModOption:AddChoice( "Model 4" )

local ModOption2 = vgui.Create( "DComboBox", panel )
ModOption2:SetPos( 17, 375 )
ModOption2:SetSize( 125, 20 )
ModOption2:SetValue( "Primary Texture" )
ModOption2:AddChoice( "Plain Light" )
ModOption2:AddChoice( "Plain Dark" )
ModOption2:AddChoice( "Scratched Light" )
ModOption2:AddChoice( "Scratched Dark" )
ModOption2:AddChoice( "Pitted Light" )
ModOption2:AddChoice( "Pitted Dark" )
ModOption2:AddChoice( "Rusted Light" )
ModOption2:AddChoice( "Rusted Dark" )

local ModOption3 = vgui.Create( "DComboBox", panel )
ModOption3:SetPos( 145, 375 )
ModOption3:SetSize( 125, 20 )
ModOption3:SetValue( "Secondary Texture" )
ModOption3:AddChoice( "Plain Dark" )
ModOption3:AddChoice( "Plain Light" )
ModOption3:AddChoice( "Scratched Dark" )
ModOption3:AddChoice( "Scratched Light" )
ModOption3:AddChoice( "Pitted Dark" )
ModOption3:AddChoice( "Pitted Light" )
ModOption3:AddChoice( "Rusted Dark" )
ModOption3:AddChoice( "Rusted Light" )


NodeList={}
NodeList["Utilities"] = ctrl:AddNode( "Utilities" )
	NodeList["Mobility"] = NodeList["Utilities"]:AddNode( "Mobility" )
		NodeList["VTOL"] = NodeList["Mobility"]:AddNode( "VTOL Engine" )
			NodeList["LVTOL"] = NodeList["VTOL"]:AddNode( "Light VTOL Engine" )
			NodeList["MVTOL"] = NodeList["VTOL"]:AddNode( "Standard VTOL Engine" )
			NodeList["HVTOL"] = NodeList["VTOL"]:AddNode( "Heavy VTOL Engine" )
		NodeList["Fighter"] = NodeList["Mobility"]:AddNode( "Fighter Engine" )
			NodeList["LFighter"] = NodeList["Fighter"]:AddNode( "Light Fighter Engine" )
			NodeList["MFighter"] = NodeList["Fighter"]:AddNode( "Standard Fighter Engine" )
			NodeList["HFighter"] = NodeList["Fighter"]:AddNode( "Heavy Fighter Engine" )
		NodeList["Gyro"] = NodeList["Mobility"]:AddNode( "Gyro" )
			NodeList["LGyro"] = NodeList["Gyro"]:AddNode( "Light Gyro" )
			NodeList["MGyro"] = NodeList["Gyro"]:AddNode( "Standard Gyro" )
			NodeList["HGyro"] = NodeList["Gyro"]:AddNode( "Heavy Gyro" )
		NodeList["QGyro"] = NodeList["Mobility"]:AddNode( "Quad Gyro" )
			NodeList["LQGyro"] = NodeList["QGyro"]:AddNode( "Light Quad Gyro" )
			NodeList["MQGyro"] = NodeList["QGyro"]:AddNode( "Standard Quad Gyro" )
			NodeList["HQGyro"] = NodeList["QGyro"]:AddNode( "Heavy Quad Gyro" )
		NodeList["JumpJet"] = NodeList["Mobility"]:AddNode( "Jump Jet" )
			NodeList["JumpJet5"] = NodeList["JumpJet"]:AddNode( "Micro Jump Jet" )
			NodeList["JumpJet4"] = NodeList["JumpJet"]:AddNode( "Light Jump Jet" )
			NodeList["JumpJet3"] = NodeList["JumpJet"]:AddNode( "Standard Jump Jet" )
			NodeList["JumpJet2"] = NodeList["JumpJet"]:AddNode( "Heavy Jump Jet" )
			NodeList["JumpJet1"] = NodeList["JumpJet"]:AddNode( "Ultra Jump Jet" )
		NodeList["ExtraMobility"] = NodeList["Mobility"]:AddNode( "Extra Mobility" )
			NodeList["MASC"] = NodeList["ExtraMobility"]:AddNode( "MASC" )
			NodeList["Supercharger"] = NodeList["ExtraMobility"]:AddNode( "Supercharger" )
		NodeList["Hoverdrive"] = NodeList["Mobility"]:AddNode( "Hoverdrive" )
			NodeList["LHoverdrive"] = NodeList["Hoverdrive"]:AddNode( "Light Hoverdrive" )
			NodeList["MHoverdrive"] = NodeList["Hoverdrive"]:AddNode( "Standard Hoverdrive" )
			NodeList["HHoverdrive"] = NodeList["Hoverdrive"]:AddNode( "Heavy Hoverdrive" )
		NodeList["Motor"] = NodeList["Mobility"]:AddNode( "Motor" )
			NodeList["LMotor"] = NodeList["Motor"]:AddNode( "Light Motor" )
			NodeList["MMotor"] = NodeList["Motor"]:AddNode( "Standard Motor" )
			NodeList["HMotor"] = NodeList["Motor"]:AddNode( "Heavy Motor" )
			NodeList["UMotor"] = NodeList["Motor"]:AddNode( "Ultra Motor" )
	NodeList["Engines"] = NodeList["Utilities"]:AddNode( "Reactors" )
		NodeList["Compact"] = NodeList["Engines"]:AddNode( "Compact" )
			NodeList["CMicro"] = NodeList["Compact"]:AddNode( "Micro" )
			NodeList["CSmall"] = NodeList["Compact"]:AddNode( "Small" )
			NodeList["CMedium"] = NodeList["Compact"]:AddNode( "Medium" )
			NodeList["CLarge"] = NodeList["Compact"]:AddNode( "Large" )
			NodeList["CUltra"] = NodeList["Compact"]:AddNode( "Ultra" )
		NodeList["Standard"] = NodeList["Engines"]:AddNode( "Standard" )
			NodeList["SMicro"] = NodeList["Standard"]:AddNode( "Micro" )
			NodeList["SSmall"] = NodeList["Standard"]:AddNode( "Small" )
			NodeList["SMedium"] = NodeList["Standard"]:AddNode( "Medium" )
			NodeList["SLarge"] = NodeList["Standard"]:AddNode( "Large" )
			NodeList["SUltra"] = NodeList["Standard"]:AddNode( "Ultra" )
		NodeList["XL"] = NodeList["Engines"]:AddNode( "XL" )
			NodeList["XMicro"] = NodeList["XL"]:AddNode( "Micro" )
			NodeList["XSmall"] = NodeList["XL"]:AddNode( "Small" )
			NodeList["XMedium"] = NodeList["XL"]:AddNode( "Medium" )
			NodeList["XLarge"] = NodeList["XL"]:AddNode( "Large" )
			NodeList["XUltra"] = NodeList["XL"]:AddNode( "Ultra" )
	NodeList["Modules"] = NodeList["Utilities"]:AddNode( "Modules" )
		NodeList["ArmorModules"] = NodeList["Modules"]:AddNode( "Armor Modules" )
			NodeList["HeavyArmor"] = NodeList["ArmorModules"]:AddNode( "Heavy Armor Module" )
			NodeList["ReactiveArmor"] = NodeList["ArmorModules"]:AddNode( "Reactive Armor Module" )
			NodeList["ReflectiveArmor"] = NodeList["ArmorModules"]:AddNode( "Reflective Armor Module" )
		NodeList["WeaponModules"] = NodeList["Modules"]:AddNode( "Weapon Modules" )
			NodeList["HighYieldPayloads"] = NodeList["WeaponModules"]:AddNode( "High Yield Payloads Module" )
			NodeList["MissileLoader"] = NodeList["WeaponModules"]:AddNode( "Missile Loader Module" )
			NodeList["BeamFocus"] = NodeList["WeaponModules"]:AddNode( "Beam Focus Module" )
			NodeList["TightWadding"] = NodeList["WeaponModules"]:AddNode( "Tight Wadding Module" )
			NodeList["DumbfireFins"] = NodeList["WeaponModules"]:AddNode( "Dumbfire Fins Module" )
			NodeList["MissileExhaustVenting"] = NodeList["WeaponModules"]:AddNode( "Missile Exhaust Venting Module" )
			NodeList["LaserInsulation"] = NodeList["WeaponModules"]:AddNode( "Laser Insulation Module" )
			NodeList["PPCFrequencyScrambler"] = NodeList["WeaponModules"]:AddNode( "PPC Frequency Scrambler Module" )
			NodeList["WeaponShielding"] = NodeList["WeaponModules"]:AddNode( "Weapon Shielding Module" )
		NodeList["UtilityModules"] = NodeList["Modules"]:AddNode( "Utility Modules" )
			NodeList["EnhancedBAP"] = NodeList["UtilityModules"]:AddNode( "Enhanced BAP Module" )
			NodeList["HeatsinkSupercooling"] = NodeList["UtilityModules"]:AddNode( "Heatsink Supercooling Module" )
			NodeList["ReinforcedHeatsinks"] = NodeList["UtilityModules"]:AddNode( "Reinforced Heatsinks Module" )
			NodeList["EfficientLAMS"] = NodeList["UtilityModules"]:AddNode( "Efficient LAMS Module" )
	NodeList["Heatsink"] = NodeList["Utilities"]:AddNode( "Heatsink" )
	NodeList["Sensor"] = NodeList["Utilities"]:AddNode( "Sensor" )
	NodeList["ECM"] = NodeList["Utilities"]:AddNode( "ECM" )
	NodeList["BAP"] = NodeList["Utilities"]:AddNode( "BAP" )
	NodeList["LAMS"] = NodeList["Utilities"]:AddNode( "Laser AMS" )
	NodeList["StealthModule"] = NodeList["Utilities"]:AddNode( "Stealth Module" )
	NodeList["HitBoxControl"] = NodeList["Utilities"]:AddNode( "HitBox Controller" )

NodeList["Weapons"] = ctrl:AddNode( "Weapons" )
	NodeList["Clan"] = NodeList["Weapons"]:AddNode( "Clan" )
		NodeList["CEnergy"] = NodeList["Clan"]:AddNode( "Energy" )
				NodeList["CTAG"] = NodeList["CEnergy"]:AddNode( "TAG Laser" )
				NodeList["CMicroLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Micro Laser" )
				NodeList["CSmallLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Small Laser" )
				NodeList["CMediumLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Medium Laser" )
				NodeList["CLargeLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Large Laser" )
				NodeList["CAssaultLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Assault Laser" )
				NodeList["CMicropulseLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Micro Pulse Laser" )
				NodeList["CSmallpulseLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Small Pulse Laser" )
				NodeList["CMediumpulseLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Medium Pulse Laser" )
				NodeList["CLargepulseLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Large Pulse Laser" )
				NodeList["CAssaultpulseLaser"] = NodeList["CEnergy"]:AddNode( "C-ER Assault Pulse Laser" )
				NodeList["HeavySmallLaser"] = NodeList["CEnergy"]:AddNode( "Heavy Small Laser" )
				NodeList["HeavyMediumLaser"] = NodeList["CEnergy"]:AddNode( "Heavy Medium Laser" )
				NodeList["HeavyLargeLaser"] = NodeList["CEnergy"]:AddNode( "Heavy Large Laser" )
				NodeList["HeavyAssaultLaser"] = NodeList["CEnergy"]:AddNode( "Heavy Assault Laser" )
				NodeList["CFlamer"] = NodeList["CEnergy"]:AddNode( "C-Flamer" )
				NodeList["CERFlamer"] = NodeList["CEnergy"]:AddNode( "C-ER Flamer" )
				NodeList["PlasmaCannon"] = NodeList["CEnergy"]:AddNode( "Plasma Cannon" )
				NodeList["CPPC"] = NodeList["CEnergy"]:AddNode( "CERPPC" )
			NodeList["CBallistic"] = NodeList["Clan"]:AddNode( "Ballistic" )
				NodeList["CUAC2"] = NodeList["CBallistic"]:AddNode( "CUAC-2" )
				NodeList["CUAC5"] = NodeList["CBallistic"]:AddNode( "CUAC-5" )
				NodeList["CUAC10"] = NodeList["CBallistic"]:AddNode( "CUAC-10" )
				NodeList["CUAC20"] = NodeList["CBallistic"]:AddNode( "CUAC-20" )
				NodeList["CRAC2"] = NodeList["CBallistic"]:AddNode( "CRAC-2" )
				NodeList["CRAC5"] = NodeList["CBallistic"]:AddNode( "CRAC-5" )
				NodeList["CRAC10"] = NodeList["CBallistic"]:AddNode( "CRAC-10" )
				NodeList["CRAC20"] = NodeList["CBallistic"]:AddNode( "CRAC-20" )
				NodeList["CLBX2"] = NodeList["CBallistic"]:AddNode( "CLBX-2" )
				NodeList["CLBX5"] = NodeList["CBallistic"]:AddNode( "CLBX-5" )
				NodeList["CLBX10"] = NodeList["CBallistic"]:AddNode( "CLBX-10" )
				NodeList["CLBX20"] = NodeList["CBallistic"]:AddNode( "CLBX-20" )
				NodeList["CGauss"] = NodeList["CBallistic"]:AddNode( "Clan Gauss Rifle" )
				NodeList["Railgun"] = NodeList["CBallistic"]:AddNode( "Railgun" )
				NodeList["HAG20"] = NodeList["CBallistic"]:AddNode( "Hyper-Assault Gauss Rifle 20" )
				NodeList["HAG30"] = NodeList["CBallistic"]:AddNode( "Hyper-Assault Gauss Rifle 30" )
				NodeList["HAG40"] = NodeList["CBallistic"]:AddNode( "Hyper-Assault Gauss Rifle 40" )
				NodeList["CLightMachineGun"] = NodeList["CBallistic"]:AddNode( "C-Light Machine Gun" )
				NodeList["CMachineGun"] = NodeList["CBallistic"]:AddNode( "C-Machine Gun" )
				NodeList["CHeavyMachineGun"] = NodeList["CBallistic"]:AddNode( "C-Heavy Machine Gun" )
			NodeList["CMissile"] = NodeList["Clan"]:AddNode( "Missile" )
				NodeList["CSRM2"] = NodeList["CMissile"]:AddNode( "CSRM-2" )
				NodeList["CSRM4"] = NodeList["CMissile"]:AddNode( "CSRM-4" )
				NodeList["CSRM6"] = NodeList["CMissile"]:AddNode( "CSRM-6" )
				NodeList["CSSRM2"] = NodeList["CMissile"]:AddNode( "Clan Streak SRM-2" )
				NodeList["CSSRM4"] = NodeList["CMissile"]:AddNode( "Clan Streak SRM-4" )
				NodeList["CSSRM6"] = NodeList["CMissile"]:AddNode( "Clan Streak SRM-6" )
				NodeList["CLRM5"] = NodeList["CMissile"]:AddNode( "CLRM-5" )
				NodeList["CLRM10"] = NodeList["CMissile"]:AddNode( "CLRM-10" )
				NodeList["CLRM15"] = NodeList["CMissile"]:AddNode( "CLRM-15" )
				NodeList["CLRM20"] = NodeList["CMissile"]:AddNode( "CLRM-20" )
				NodeList["ATM3"] = NodeList["CMissile"]:AddNode( "ATM-3" )
				NodeList["ATM6"] = NodeList["CMissile"]:AddNode( "ATM-6" )
				NodeList["ATM9"] = NodeList["CMissile"]:AddNode( "ATM-9" )
				NodeList["ATM12"] = NodeList["CMissile"]:AddNode( "ATM-12" )
				NodeList["CNARC"] = NodeList["CMissile"]:AddNode( "Clan NARC" )

	NodeList["IS"] = NodeList["Weapons"]:AddNode( "IS" )
		NodeList["Energy"] = NodeList["IS"]:AddNode( "Energy" )
			NodeList["TAG"] = NodeList["Energy"]:AddNode( "TAG Laser" )
			NodeList["MicroLaser"] = NodeList["Energy"]:AddNode( "Micro Laser" )
			NodeList["SmallLaser"] = NodeList["Energy"]:AddNode( "Small Laser" )
			NodeList["MediumLaser"] = NodeList["Energy"]:AddNode( "Medium Laser" )
			NodeList["LargeLaser"] = NodeList["Energy"]:AddNode( "Large Laser" )
			NodeList["AssaultLaser"] = NodeList["Energy"]:AddNode( "Assault Laser" )
			NodeList["MicropulseLaser"] = NodeList["Energy"]:AddNode( "Micro Pulse Laser" )
			NodeList["SmallpulseLaser"] = NodeList["Energy"]:AddNode( "Small Pulse Laser" )
			NodeList["MediumpulseLaser"] = NodeList["Energy"]:AddNode( "Medium Pulse Laser" )
			NodeList["LargepulseLaser"] = NodeList["Energy"]:AddNode( "Large Pulse Laser" )
			NodeList["AssaultpulseLaser"] = NodeList["Energy"]:AddNode( "Assault Pulse Laser" )
			NodeList["SmallxpulseLaser"] = NodeList["Energy"]:AddNode( "Small X-Pulse Laser" )
			NodeList["MediumxpulseLaser"] = NodeList["Energy"]:AddNode( "Medium X-Pulse Laser" )
			NodeList["LargexpulseLaser"] = NodeList["Energy"]:AddNode( "Large X-Pulse Laser" )
			NodeList["AssaultxpulseLaser"] = NodeList["Energy"]:AddNode( "Assault X-Pulse Laser" )
			NodeList["Flamer"] = NodeList["Energy"]:AddNode( "Flamer" )
			NodeList["HeavyFlamer"] = NodeList["Energy"]:AddNode( "Heavy Flamer" )
			NodeList["LightPPC"] = NodeList["Energy"]:AddNode( "Light PPC" )
			NodeList["LightPPCBurst"] = NodeList["Energy"]:AddNode( "Light Burst PPC" )
			NodeList["PPC"] = NodeList["Energy"]:AddNode( "PPC" )
			NodeList["HeavyPPC"] = NodeList["Energy"]:AddNode( "Heavy PPC" )
			NodeList["ALightPPC"] = NodeList["Energy"]:AddNode( "Armored Light PPC" )
			NodeList["ALightPPCBurst"] = NodeList["Energy"]:AddNode( "Armored Light Burst PPC" )
			NodeList["APPC"] = NodeList["Energy"]:AddNode( "Armored PPC" )
			NodeList["AHeavyPPC"] = NodeList["Energy"]:AddNode( "Armored Heavy PPC" )
		NodeList["Ballistic"] = NodeList["IS"]:AddNode( "Ballistic" )
			NodeList["AC2"] = NodeList["Ballistic"]:AddNode( "AC-2" )
			NodeList["AC5"] = NodeList["Ballistic"]:AddNode( "AC-5" )
			NodeList["AC10"] = NodeList["Ballistic"]:AddNode( "AC-10" )
			NodeList["AC20"] = NodeList["Ballistic"]:AddNode( "AC-20" )
			NodeList["AAC2"] = NodeList["Ballistic"]:AddNode( "Armored AC-2" )
			NodeList["AAC5"] = NodeList["Ballistic"]:AddNode( "Armored AC-5" )
			NodeList["AAC10"] = NodeList["Ballistic"]:AddNode( "Armored AC-10" )
			NodeList["AAC20"] = NodeList["Ballistic"]:AddNode( "Armored AC-20" )
			NodeList["UAC2"] = NodeList["Ballistic"]:AddNode( "UAC-2" )
			NodeList["UAC5"] = NodeList["Ballistic"]:AddNode( "UAC-5" )
			NodeList["UAC10"] = NodeList["Ballistic"]:AddNode( "UAC-10" )
			NodeList["UAC20"] = NodeList["Ballistic"]:AddNode( "UAC-20" )
			NodeList["RAC2"] = NodeList["Ballistic"]:AddNode( "RAC-2" )
			NodeList["RAC5"] = NodeList["Ballistic"]:AddNode( "RAC-5" )
			NodeList["RAC10"] = NodeList["Ballistic"]:AddNode( "RAC-10" )
			NodeList["RAC20"] = NodeList["Ballistic"]:AddNode( "RAC-20" )
			NodeList["LBX2"] = NodeList["Ballistic"]:AddNode( "LBX-2" )
			NodeList["LBX5"] = NodeList["Ballistic"]:AddNode( "LBX-5" )
			NodeList["LBX10"] = NodeList["Ballistic"]:AddNode( "LBX-10" )
			NodeList["LBX20"] = NodeList["Ballistic"]:AddNode( "LBX-20" )
			NodeList["Magshot"] = NodeList["Ballistic"]:AddNode( "Magshot Gauss Rifle" )
			NodeList["LightGauss"] = NodeList["Ballistic"]:AddNode( "Light Gauss Rifle" )
			NodeList["Gauss"] = NodeList["Ballistic"]:AddNode( "Gauss Rifle" )
			NodeList["HeavyGauss"] = NodeList["Ballistic"]:AddNode( "Heavy Gauss Rifle" )
			NodeList["SBG"] = NodeList["Ballistic"]:AddNode( "Silver Bullet Gauss Rifle" )
			NodeList["LongTom"] = NodeList["Ballistic"]:AddNode( "Long Tom Cannon" )
			NodeList["Thumper"] = NodeList["Ballistic"]:AddNode( "Thumper Cannon" )
			NodeList["Sniper"] = NodeList["Ballistic"]:AddNode( "Sniper Cannon" )
			NodeList["LightMachineGun"] = NodeList["Ballistic"]:AddNode( "Light Machine Gun" )
			NodeList["MachineGun"] = NodeList["Ballistic"]:AddNode( "Machine Gun" )
			NodeList["HeavyMachineGun"] = NodeList["Ballistic"]:AddNode( "Heavy Machine Gun" )
		NodeList["Missile"] = NodeList["IS"]:AddNode( "Missile" )
			NodeList["SRM2"] = NodeList["Missile"]:AddNode( "SRM-2" )
			NodeList["SRM4"] = NodeList["Missile"]:AddNode( "SRM-4" )
			NodeList["SRM6"] = NodeList["Missile"]:AddNode( "SRM-6" )
			NodeList["SSRM2"] = NodeList["Missile"]:AddNode( "Streak SRM-2" )
			NodeList["SSRM4"] = NodeList["Missile"]:AddNode( "Streak SRM-4" )
			NodeList["SSRM6"] = NodeList["Missile"]:AddNode( "Streak SRM-6" )
			NodeList["MRM10"] = NodeList["Missile"]:AddNode( "MRM-10" )
			NodeList["MRM20"] = NodeList["Missile"]:AddNode( "MRM-20" )
			NodeList["MRM30"] = NodeList["Missile"]:AddNode( "MRM-30" )
			NodeList["MRM40"] = NodeList["Missile"]:AddNode( "MRM-40" )
			NodeList["LRM5"] = NodeList["Missile"]:AddNode( "LRM-5" )
			NodeList["LRM10"] = NodeList["Missile"]:AddNode( "LRM-10" )
			NodeList["LRM15"] = NodeList["Missile"]:AddNode( "LRM-15" )
			NodeList["LRM20"] = NodeList["Missile"]:AddNode( "LRM-20" )
			NodeList["Arrow"] = NodeList["Missile"]:AddNode( "Arrow IV" )
			NodeList["NARC"] = NodeList["Missile"]:AddNode( "NARC" )

NodeList["Ammo"] = ctrl:AddNode( "Ammo" )
	NodeList["BallisticAmmo"] = NodeList["Ammo"]:AddNode( "Ballistic" )
		NodeList["AC2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "AC-2 Ammo" )
		NodeList["AC5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "AC-5 Ammo" )
		NodeList["AC10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "AC-10 Ammo" )
		NodeList["AC20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "AC-20 Ammo" )
		NodeList["IAC2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Inferno AC-2 Ammo" )
		NodeList["IAC5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Inferno AC-5 Ammo" )
		NodeList["IAC10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Inferno AC-10 Ammo" )
		NodeList["IAC20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Inferno AC-20 Ammo" )
		NodeList["FAC2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Flak AC-2 Ammo" )
		NodeList["FAC5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Flak AC-5 Ammo" )
		NodeList["FAC10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Flak AC-10 Ammo" )
		NodeList["FAC20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Flak AC-20 Ammo" )
		NodeList["UAC2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "UAC-2 Ammo" )
		NodeList["UAC5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "UAC-5 Ammo" )
		NodeList["UAC10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "UAC-10 Ammo" )
		NodeList["UAC20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "UAC-20 Ammo" )
		NodeList["RAC2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "RAC-2 Ammo" )
		NodeList["RAC5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "RAC-5 Ammo" )
		NodeList["RAC10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "RAC-10 Ammo" )
		NodeList["RAC20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "RAC-20 Ammo" )
		NodeList["LBX2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "LBX-2 Ammo" )
		NodeList["LBX5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "LBX-5 Ammo" )
		NodeList["LBX10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "LBX-10 Ammo" )
		NodeList["LBX20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "LBX-20 Ammo" )
		NodeList["AALBX2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Anti-Air LBX-2 Ammo" )
		NodeList["AALBX5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Anti-Air LBX-5 Ammo" )
		NodeList["AALBX10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Anti-Air LBX-10 Ammo" )
		NodeList["AALBX20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Anti-Air LBX-20 Ammo" )
		NodeList["SLBX2Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Slug LBX-2 Ammo" )
		NodeList["SLBX5Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Slug LBX-5 Ammo" )
		NodeList["SLBX10Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Slug LBX-10 Ammo" )
		NodeList["SLBX20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "Slug LBX-20 Ammo" )
		NodeList["MagshotAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Magshot Gauss Rifle Ammo" )
		NodeList["LightGaussAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Light Gauss Rifle Ammo" )
		NodeList["GaussAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Gauss Rifle Ammo" )
		NodeList["HeavyGaussAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Heavy Gauss Rifle Ammo" )
		NodeList["RailgunAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Railgun Ammo" )
		NodeList["SBGAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Silver Bullet Gauss Rifle Ammo" )
		NodeList["HAG20Ammo"] = NodeList["BallisticAmmo"]:AddNode( "HAG20 Ammo" )
		NodeList["HAG30Ammo"] = NodeList["BallisticAmmo"]:AddNode( "HAG30 Ammo" )
		NodeList["HAG40Ammo"] = NodeList["BallisticAmmo"]:AddNode( "HAG40 Ammo" )
		NodeList["LongTomAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Long Tom Cannon Ammo" )
		NodeList["ThumperAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Thumper Cannon Ammo" )
		NodeList["SniperAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Sniper Cannon Ammo" )
		NodeList["LightMachineGunAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Light Machine Gun Ammo" )
		NodeList["MachineGunAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Machine Gun Ammo" )
		NodeList["HeavyMachineGunAmmo"] = NodeList["BallisticAmmo"]:AddNode( "Heavy Machine Gun Ammo" )
	NodeList["MissileAmmo"] = NodeList["Ammo"]:AddNode( "Missile" )
		NodeList["SRM2Ammo"] = NodeList["MissileAmmo"]:AddNode( "SRM-2 Ammo" )
		NodeList["SRM4Ammo"] = NodeList["MissileAmmo"]:AddNode( "SRM-4 Ammo" )
		NodeList["SRM6Ammo"] = NodeList["MissileAmmo"]:AddNode( "SRM-6 Ammo" )
		NodeList["SSRM2Ammo"] = NodeList["MissileAmmo"]:AddNode( "Streak SRM-2 Ammo" )
		NodeList["SSRM4Ammo"] = NodeList["MissileAmmo"]:AddNode( "Streak SRM-4 Ammo" )
		NodeList["SSRM6Ammo"] = NodeList["MissileAmmo"]:AddNode( "Streak SRM-6 Ammo" )
		NodeList["MRM10Ammo"] = NodeList["MissileAmmo"]:AddNode( "MRM-10 Ammo" )
		NodeList["MRM20Ammo"] = NodeList["MissileAmmo"]:AddNode( "MRM-20 Ammo" )
		NodeList["MRM30Ammo"] = NodeList["MissileAmmo"]:AddNode( "MRM-30 Ammo" )
		NodeList["MRM40Ammo"] = NodeList["MissileAmmo"]:AddNode( "MRM-40 Ammo" )
		NodeList["LRM5Ammo"] = NodeList["MissileAmmo"]:AddNode( "LRM-5 Ammo" )
		NodeList["LRM10Ammo"] = NodeList["MissileAmmo"]:AddNode( "LRM-10 Ammo" )
		NodeList["LRM15Ammo"] = NodeList["MissileAmmo"]:AddNode( "LRM-15 Ammo" )
		NodeList["LRM20Ammo"] = NodeList["MissileAmmo"]:AddNode( "LRM-20 Ammo" )
		NodeList["ArrowAmmo"] = NodeList["MissileAmmo"]:AddNode( "ArrowIV Ammo" )
		NodeList["ATM3HEAmmo"] = NodeList["MissileAmmo"]:AddNode( "High Explosive ATM-3 Ammo" )
		NodeList["ATM6HEAmmo"] = NodeList["MissileAmmo"]:AddNode( "High Explosive ATM-6 Ammo" )
		NodeList["ATM9HEAmmo"] = NodeList["MissileAmmo"]:AddNode( "High Explosive ATM-9 Ammo" )
		NodeList["ATM12HEAmmo"] = NodeList["MissileAmmo"]:AddNode( "High Explosive ATM-12 Ammo" )
		NodeList["ATM3SAmmo"] = NodeList["MissileAmmo"]:AddNode( "Standard ATM-3 Ammo" )
		NodeList["ATM6SAmmo"] = NodeList["MissileAmmo"]:AddNode( "Standard ATM-6 Ammo" )
		NodeList["ATM9SAmmo"] = NodeList["MissileAmmo"]:AddNode( "Standard ATM-9 Ammo" )
		NodeList["ATM12SAmmo"] = NodeList["MissileAmmo"]:AddNode( "Standard ATM-12 Ammo" )
		NodeList["ATM3ERAmmo"] = NodeList["MissileAmmo"]:AddNode( "Extended Range ATM-3 Ammo" )
		NodeList["ATM6ERAmmo"] = NodeList["MissileAmmo"]:AddNode( "Extended Range ATM-6 Ammo" )
		NodeList["ATM9ERAmmo"] = NodeList["MissileAmmo"]:AddNode( "Extended Range ATM-9 Ammo" )
		NodeList["ATM12ERAmmo"] = NodeList["MissileAmmo"]:AddNode( "Extended Range ATM-12 Ammo" )
		NodeList["NARCAmmo"] = NodeList["MissileAmmo"]:AddNode( "NARC Ammo" )

	function ModOption:OnSelect( index, value, data )
		if value=="Model 1" then
			RunConsoleCommand("dakspawner_SpawnMod", 1)
		end
		if value=="Model 2" then
			RunConsoleCommand("dakspawner_SpawnMod", 2)
		end
		if value=="Model 3" then
			RunConsoleCommand("dakspawner_SpawnMod", 3)
		end
		if value=="Model 4" then
			RunConsoleCommand("dakspawner_SpawnMod", 4)
		end
	end
	function ModOption2:OnSelect( index, value, data )
		if value=="Plain Light" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 1)
		end
		if value=="Plain Dark" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 2)
		end
		if value=="Scratched Light" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 3)
		end
		if value=="Scratched Dark" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 4)
		end
		if value=="Pitted Light" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 5)
		end
		if value=="Pitted Dark" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 6)
		end
		if value=="Rusted Light" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 7)
		end
		if value=="Rusted Dark" then
			RunConsoleCommand("dakspawner_PTSpawnMod", 8)
		end
	end
	function ModOption3:OnSelect( index, value, data )
		if value=="Plain Dark" then
			RunConsoleCommand("dakspawner_STSpawnMod", 1)
		end
		if value=="Plain Light" then
			RunConsoleCommand("dakspawner_STSpawnMod", 2)
		end
		if value=="Scratched Dark" then
			RunConsoleCommand("dakspawner_STSpawnMod", 3)
		end
		if value=="Scratched Light" then
			RunConsoleCommand("dakspawner_STSpawnMod", 4)
		end
		if value=="Pitted Dark" then
			RunConsoleCommand("dakspawner_STSpawnMod", 5)
		end
		if value=="Pitted Light" then
			RunConsoleCommand("dakspawner_STSpawnMod", 6)
		end
		if value=="Rusted Dark" then
			RunConsoleCommand("dakspawner_STSpawnMod", 7)
		end
		if value=="Rusted Light" then
			RunConsoleCommand("dakspawner_STSpawnMod", 8)
		end
	end
	function ctrl:DoClick( node )
		----ENGINES/Heatsink
		if (node == NodeList["Base"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_baseengine")
		end
		if (node == NodeList["Heatsink"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_heatsink")
		DLabel:SetText( "Heatsink\n\nHealth: 10\nWeight: 1 Ton\nCooling: +0.5 Dissipation\nMaxHeat: +1\n\nDescription: Helps cool down your mech so you can keep firing without suddenly finding yourself in the center of a new solar system." )
		end
		----ENERGY WEAPONS
		if (node == NodeList["SmallLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "SmallLaser")
		DLabel:SetText( "Small Laser\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 1\nHeat: 0.9\nCooldown: 0.75s\nDuration: 0.5s\nDPS: 0.8 \nHPS: 0.72\nDPH: 1.11\n\nDescription: You ever want a guardsman in mech form? Well this is the weapon you want." )
		end
		if (node == NodeList["MediumLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "MediumLaser")
		DLabel:SetText( "Medium Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 3.5\nHeat: 2.7\nCooldown: 1.5s\nDuration: 0.75s\nDPS: 1.56\nHPS: 1.20\nDPH: 1.30\n\nDescription: Standard laser, good for massing, efficient when killing infantry, fine main gun for a light micro vehicle." )
		end
		if (node == NodeList["LargeLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "LargeLaser")
		DLabel:SetText( "Large Laser\n\nHealth: 50\nWeight: 5 Tons\nDamage: 6.875\nHeat: 2.7\nCooldown: 1.625s\nDuration: 1.15s\nDPS: 3.125\nHPS: 1.224\nDPH: 2.55\n\nDescription: Powerful laser on the lighter side of weaponry, trades tonnage for cold firepower." )
		end
		if (node == NodeList["AssaultLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "AssaultLaser")
		DLabel:SetText( "Assault Laser\n\nHealth: 60\nWeight: 6 Tons\nDamage: 12\nHeat: 6.75\nCooldown: 2s\nDuration: 0.5s\nDPS: 4.8\nHPS: 2.7\nDPH: 1.78\n\nDescription: hot but powerful with a short duration, this laser packs a powerful punch if you have the proper cooling." )
		end
		if (node == NodeList["SmallpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "SmallPulseLaser")
		DLabel:SetText( "Small Pulse Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 1\nHeat: 0.9\nCooldown: 0.25s\nDuration: 0.25s\nDPS: 2\nHPS: 1.8\nDPH: 1.11\n\nDescription: Small laser set up to fire weak but focused beams able to make quick work of infantry." )
		end
		if (node == NodeList["MediumpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "MediumPulseLaser")
		DLabel:SetText( "Medium Pulse Laser\n\nHealth: 20\nWeight: 2 Tons\nDamage: 4\nHeat: 1.95\nCooldown: 1.25s\nDuration: 0.375s\nDPS: 2.46\nHPS: 1.2\nDPH: 2.05\n\nDescription: A very precise laser for its weight, it focuses its damage into a target in under half a second." )
		end
		if (node == NodeList["LargepulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "LargePulseLaser")
		DLabel:SetText( "Large Pulse Laser\n\nHealth: 70\nWeight: 7 Tons\nDamage: 7.5\nHeat: 2.25\nCooldown: 1.35s\nDuration: 0.25s\nDPS: 4.69\nHPS: 1.41\nDPH: 3.33\n\nDescription: Less tonnage efficient than the lighter lasers, but much more efficient with its energy transfer causing a higher damage to heat ratio than lighter lasers and very focused beam durations." )
		end
		if (node == NodeList["AssaultpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "AssaultPulseLaser")
		DLabel:SetText( "Assault Pulse Laser\n\nHealth: 100\nWeight: 10 Tons\nDamage: 15.625\nHeat: 5\nCooldown: 1.9s\nDuration: 0.25s\nDPS: 7.27\nHPS: 2.33\nDPH: 3.125\n\nDescription: Ultra focused laser beam with a quarter second duration, great for burning holes through things." )
		end
		if (node == NodeList["SmallxpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_xpulselaser")
		RunConsoleCommand("dakspawner_SpawnSettings", "SmallXPulseLaser")
		DLabel:SetText( "Small X-Pulse Laser\n\nHealth: 20\nWeight: 2 Tons\nDamage: 3 per second\nHeat: 2.5 per second\nDPH: 1.2\n\nDescription: Experimental small pulse laser with the duration limiter removed, able to fry infantry with just a few passes." )
		end
		if (node == NodeList["MediumxpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_xpulselaser")
		RunConsoleCommand("dakspawner_SpawnSettings", "MediumXPulseLaser")
		DLabel:SetText( "Medium X-Pulse Laser\n\nHealth: 40\nWeight: 4 Tons\nDamage: 5 per second\nHeat: 3.5 per second\nDPH: 1.43\n\nDescription: Experimental medium pulse laser with the duration limiter removed, actually hurts yo." )
		end
		if (node == NodeList["LargexpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_xpulselaser")
		RunConsoleCommand("dakspawner_SpawnSettings", "LargeXPulseLaser")
		DLabel:SetText( "Large X-Pulse Laser\n\nHealth: 120\nWeight: 12 Tons\nDamage: 12 per second\nHeat: 4.5 per second\nDPH: 2.67\n\nDescription: Experimental large pulse laser with the duration limiter removed, makes things dead quick but requires massive cooling equipment for maximum use." )
		end
		if (node == NodeList["AssaultxpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_xpulselaser")
		RunConsoleCommand("dakspawner_SpawnSettings", "AssaultXPulseLaser")
		DLabel:SetText( "Assault X-Pulse Laser\n\nHealth: 200\nWeight: 20 Tons\nDamage: 35 per second\nHeat: 12.5 per second\nDPH: 2.8\n\nDescription: Experimental assault pulse laser with the duration limiter removed, point it at things you want to remove from this plane of existance." )
		end
		if (node == NodeList["Flamer"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "Flamer")
		DLabel:SetText( "Flamer\n\nHealth: 10\nWeight: 1 Ton\nDamage: 0.2\nHeat Damage: 0.6\nHeat: 0.27\nCooldown: 0.2s\nVelocity: 2500\nCooling Reduction Time: 0s \nHeatDPS: 3\nDPS: 1\nHPS: 1.35\nDPH: 0.74\n\nDescription: Flamethrower great for increasing enemy heat and igniting exposed infantry, does minimal damage other than heat. Can overpower enemy cooling entirely in masses." )
		end
		if (node == NodeList["PlasmaCannon"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "PlasmaCannon")
		DLabel:SetText( "Plasma Cannon\n\nHealth: 100\nWeight: 10 Tons\nDamage: 10\nHeat Damage: 5\nHeat: 13.5\nCooldown: 5s\nVelocity: 25000\nCooling Reduction Time: 10s \nHeatDPS: 1\nDPS: 2\nHPS: 2.7\nDPH: 0.74\n\nDescription: Fires a superheated burst of plasma causing engines in the impact zone to ignite along with any exposed infantry. The plasma cloud superheats the target's vents, causing them to only cool at 20% for a duration." )
		end
		if (node == NodeList["LightPPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LightPPC")
		DLabel:SetText( "Light PPC\n\nHealth: 30\nWeight: 3 Tons\nDamage: 10\nHeat: 5\nCooldown: 3s\nVelocity: 35000\nDPS: 3.33\nHPS: 1.67\nDPH: 2\n\nDescription: A light but relatively weak particle cannon, it still packs a considerable punch for its weight class. The lighter nature of the gun leads to less efficient energy transfer and and a lower damage to heat ratio on the user than a normal PPC." )
		end
		if (node == NodeList["PPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "PPC")
		DLabel:SetText( "PPC\n\nHealth: 70\nWeight: 7 Tons\nDamage: 20\nHeat: 7.5\nCooldown: 3s\nVelocity: 35000\nDPS: 6.67\nHPS: 2.5\nDPH: 2.67\n\nDescription: An advanced cannon able to fire condensed charged particles at great velocities." )
		end
		if (node == NodeList["HeavyPPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyPPC")
		DLabel:SetText( "Heavy PPC\n\nHealth: 100\nWeight: 10 Tons\nDamage: 30\nHeat: 12\nCooldown: 3s\nVelocity: 35000\nDPS: 10\nHPS: 4\nDPH: 2.5\n\nDescription: Further ramps up damage and heat while keeping the same cooldown as a normal PPC, powerful if the heat can be handled." )
		end
		----BALLISTICS
		if (node == NodeList["AC2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC2")
		DLabel:SetText( "AC-2\n\nHealth: 60\nWeight: 6 Tons\nHeat: 0.4\nCooldown: 0.35s\n\nStandard Rounds:\nDamage: 2\nVelocity: 40000\nDPS: 5.71\nHPS: 1.14\nDPH: 5\n\nFlak Rounds:\nSplash Damage: 2\nVelocity: 45000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 5.71\nHPS: 1.14\nDPH: 5\n\nInferno Rounds:\nDamage: 1\nHeat Damage: 0.24\nVelocity: 40000\nCooling Reduction Time: 3s \nHeatDPS: 0.69\nDPS: 2.86\nHPS: 1.14\nDPH: 2.5\n\nDescription: Light autocannon with low damage per shot but a short cooldown, great for plinking away at light armor." )
		end
		if (node == NodeList["AC5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC5")
		DLabel:SetText( "AC-5\n\nHealth: 80\nWeight: 8 Tons\nHeat: 1\nCooldown: 0.7s\n\nStandard Rounds:\nDamage: 5\nVelocity: 35000\nDPS: 7.14\nHPS: 1.43\nDPH: 5\n\nFlak Rounds:\nSplash Damage: 5\nVelocity: 40000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 7.14\nHPS: 1.43\nDPH: 5\n\nInferno Rounds:\nDamage: 2.5\nHeat Damage: 0.6\nVelocity: 35000\nCooling Reduction Time: 3s \nHeatDPS: 0.86\nDPS: 3.57\nHPS: 1.43\nDPH: 2.5\n\nDescription: Mid-tier autocannon with a great damage to heat ratio, great if you need cold DPS with good velocity." )
		end
		if (node == NodeList["AC10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC10")
		DLabel:SetText( "AC-10\n\nHealth: 120\nWeight: 12 Tons\nHeat: 2.5\nCooldown: 1s\n\nStandard Rounds:\nDamage: 10\nVelocity: 30000\nDPS: 10\nHPS: 2.5\nDPH: 4\n\nFlak Rounds:\nSplash Damage: 10\nVelocity: 35000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 10\nHPS: 2.5\nDPH: 4\n\nInferno Rounds:\nDamage: 5\nHeat Damage: 1.2\nVelocity: 30000\nCooling Reduction Time: 3s \nHeatDPS: 1.2\nDPS: 5\nHPS: 2.5\nDPH: 2\n\nDescription: Heavy autocannon with a punch to match, a decent base to build your DPS off of." )
		end
		if (node == NodeList["AC20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC20")
		DLabel:SetText( "AC-20\n\nHealth: 140\nWeight: 14 Tons\nHeat: 5\nCooldown: 1.6s\n\nStandard Rounds:\nDamage: 20\nVelocity: 25000\nDPS: 12.5\nHPS: 3.125\nDPH: 4\n\nFlak Rounds:\nSplash Damage: 20\nVelocity: 30000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 12.5\nHPS: 3.125\nDPH: 4\n\nInferno Rounds:\nDamage: 10\nHeat Damage: 2.4\nVelocity: 25000\nCooling Reduction Time: 3s \nHeatDPS: 1.5\nDPS: 6.25\nHPS: 3.125\nDPH: 2\n\nDescription: Massive autocannon heavy enough to punch right through light armor, a fearsome and accurate gun for heavy strikers." )
		end
		if (node == NodeList["UAC2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC2")
		DLabel:SetText( "Ultra AC-2\n\nHealth: 70\nWeight: 7 Tons\nDamage: 1.4\nHeat: 0.28\nCooldown: 0.1875s\nVelocity: 35000\nDPS: 7.47\nHPS: 1.49\nDPH: 5\n\nDescription: An AC2 that trades velocity, weight savings, and per shot damage for more DPS, this can be a powerful weapon if you can keep your damage focused." )
		end
		if (node == NodeList["UAC5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC5")
		DLabel:SetText( "Ultra AC-5\n\nHealth: 90\nWeight: 9 Tons\nDamage: 4\nHeat: 0.8\nCooldown: 0.4375s\nVelocity: 30000\nDPS: 9.14\nHPS: 1.83\nDPH: 5\n\nDescription: Double the rate of fire of an AC5 but with slightly less damage per shot, you won't be punching big holes in armor with each shot, but your shellstorm will be withering." )
		end
		if (node == NodeList["UAC10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC10")
		DLabel:SetText( "Ultra AC-10\n\nHealth: 130\nWeight: 13 Tons\nDamage: 9\nHeat: 2.25\nCooldown: 0.75s\nVelocity: 25000\nDPS: 12\nHPS: 3\nDPH: 4\n\nDescription: At 9 damage per shell, you'll sand enemy armor away quickly with focused fire." )
		end
		if (node == NodeList["UAC20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC20")
		DLabel:SetText( "Ultra AC-20\n\nHealth: 150\nWeight: 15 Tons\nDamage: 15\nHeat: 3.75\nCooldown: 1s\nVelocity: 20000\nDPS: 15\nHPS: 3.75\nDPH: 4\n\nDescription: This weapon will make short work of any light vehicles if you can handle the ammo and cooling requirements." )
		end
		if (node == NodeList["RAC2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC2")
		DLabel:SetText( "Rotary AC-2\n\nHealth: 80\nWeight: 8 Tons\nDamage: 0.55\nHeat: 0.1\nCooldown: 0.05s\nVelocity: 35000\nDPS: 11\nHPS: 2\nDPH: 5.5\n\nDescription: At 20 rounds fired per second this weapon has suprising DPS but rather weak damage per shell." )
		end
		if (node == NodeList["RAC5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC5")
		DLabel:SetText( "Rotary AC-5\n\nHealth: 100\nWeight: 10 Tons\nDamage: 1.375\nHeat: 0.25\nCooldown: 0.1s\nVelocity: 30000\nDPS: 13.75\nHPS: 2.5\nDPH: 5.5\n\nDescription: More DPS than the RAC2 at the cost of weight and rate of fire, further suited for work against armored targets." )
		end
		if (node == NodeList["RAC10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC10")
		DLabel:SetText( "Rotary AC-10\n\nHealth: 140\nWeight: 14 Tons\nDamage: 2.75\nHeat: 0.625\nCooldown: 0.15s\nVelocity: 25000\nDPS: 18.33\nHPS: 4.17\nDPH: 4.4\n\nDescription: A powerful destroyer of light and medium vehicles alike, and able to take out even the heaviest vehicles given the time." )
		end
		if (node == NodeList["RAC20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC20")
		DLabel:SetText( "Rotary AC-20\n\nHealth: 160\nWeight: 16 Tons\nDamage: 5.5\nHeat: 1.25\nCooldown: 0.25s\nVelocity: 20000\nDPS: 22\nHPS: 5\nDPH: 4.4\n\nDescription: Fires a devastating barrage of shells that little can survive for long against but generates high heat and devours ammo quickly." )
		end
		if (node == NodeList["LBX2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX2")
		DLabel:SetText( "LBX-2\n\nHealth: 60\nWeight: 6 Tons\nHeat: 0.4\nCooldown: 0.375s\n\nPellet Rounds:\nDamage: 3\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 2\nDPS: 8\nHPS: 1.07\nDPH: 7.5\n\nSlug Rounds:\nDamage: 2\nVelocity: 35000\nDPS: 5.33\nHPS: 1.07\nDPH: 5\n\nAnti-Air Rounds:\nDamage: 2\nVelocity: 45000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 4\nDPS: 5.33\nHPS: 1.07\nDPH: 5\n\nDescription: A light shotgun like cannon that deals 50% more damage than a standard AC2 at the cost of spread." )
		end
		if (node == NodeList["LBX5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX5")
		DLabel:SetText( "LBX-5\n\nHealth: 80\nWeight: 8 Tons\nHeat: 1\nCooldown: 0.875s\n\nPellet Rounds:\nDamage: 7.5\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 5\nDPS: 8.57\nHPS: 1.14\nDPH: 7.5\n\nSlug Rounds:\nDamage: 5\nVelocity: 30000\nDPS: 5.71\nHPS: 1.14\nDPH: 5\n\nAnti-Air Rounds:\nDamage: 5\nVelocity: 40000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 10\nDPS: 5.71\nHPS: 1.14\nDPH: 5\n\nDescription: A shotgun like cannon that splits its damage between 5 projectiles, spreading damage over the target area." )
		end
		if (node == NodeList["LBX10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX10")
		DLabel:SetText( "LBX-10\n\nHealth: 110\nWeight: 11 Tons\nHeat: 2.5\nCooldown: 1.25s\n\nPellet Rounds:\nDamage: 15\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 10\nDPS: 12\nHPS: 2\nDPH: 6\n\nSlug Rounds:\nDamage: 10\nVelocity: 25000\nDPS: 8\nHPS: 2\nDPH: 4\n\nAnti-Air Rounds:\nDamage: 10\nVelocity: 35000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 20\nDPS: 8\nHPS: 2\nDPH: 4\n\nDescription: A large shotgun like cannon quite powerful up close." )
		end
		if (node == NodeList["LBX20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX20")
		DLabel:SetText( "LBX-20\n\nHealth: 140\nWeight: 14 Tons\nHeat: 5\nCooldown: 2s\n\nPellet Rounds:\nDamage: 30\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 20\nDPS: 15\nHPS: 2.5\nDPH: 6\n\nSlug Rounds:\nDamage: 20\nVelocity: 20000\nDPS: 10\nHPS: 2.5\nDPH: 4\n\nAnti-Air Rounds:\nDamage: 20\nVelocity: 30000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 40\nDPS: 10\nHPS: 2.5\nDPH: 4\n\nDescription: A massive shotgun like cannon capable of devastating bursts up close, but rather lacking at range." )
		end
		if (node == NodeList["LightGauss"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LightGauss")
		DLabel:SetText( "Light Gauss Rifle\n\nHealth: 60\nWeight: 12 Tons\nDamage: 15\nHeat: 1\nCooldown: 2.75s\nVelocity: 70000\nDPS: 5.45\nHPS: 0.36\nDPH: 15\n\nDescription: A light coilgun capable of spitting out high damage projectiles at high velocity for little heat, its reload is slow however. It explodes when heavily damaged, though its ammo doesn't." )
		end
		if (node == NodeList["Gauss"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "Gauss")
		DLabel:SetText( "Gauss Rifle\n\nHealth: 75\nWeight: 15 Tons\nDamage: 30\nHeat: 1\nCooldown: 3.75s\nVelocity: 60000\nDPS: 8\nHPS: 0.27\nDPH: 30\n\nDescription: A coilgun capable of dealing very heavy damage per shot with high velocity for nearly no heat, though it takes awhile to recharge between shots. It explodes when heavily damaged, though its ammo doesn't." )
		end
		if (node == NodeList["HeavyGauss"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyGauss")
		DLabel:SetText( "Heavy Gauss Rifle\n\nHealth: 90\nWeight: 18 Tons\nDamage: 50\nHeat: 1\nCooldown: 4.5s\nVelocity: 50000\nDPS: 11.11\nHPS: 0.22\nDPH: 50\n\nDescription: A massive coilgun that puts out devastating damage per shot, held back only by its reload times. It explodes when heavily damaged, though its ammo doesn't" )
		end
		if (node == NodeList["LongTom"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LongTom")
		DLabel:SetText( "Long Tom Cannon\n\nHealth: 200\nWeight: 20 Tons\nDamage: 20 +180 splash\nHeat: 20\nCooldown: 7.5s\nVelocity: 5000\nBlast Radius: 1000 units\nDPS: 26.67\nHPS: 2.67\nDPH: 10\n\nDescription: A lightened artillery piece with devastating direct damage coupled with a powerful explosion. This gun is quite capable of crippling light vehicles in a single hit." )
		end
		if (node == NodeList["MachineGun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "MachineGun")
		DLabel:SetText( "Machine Gun\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 0.225\nHeat: 0\nCooldown: 0.2s\nVelocity: 30000\nDPS: 1.125\nHPS: 0\nDPH: inf\n\nDescription: Light weapon able to deal constant DPS for no heat, can be devastating when massed, and remains powerful against unarmored troops even as a single gun." )
		end
		----MISSILES
		if (node == NodeList["SRM2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "SRM2")
		DLabel:SetText( "SRM-2\n\nHealth: 10\nWeight: 1 Ton\nDamage: 4\nHeat: 2\nCooldown: 4s\nVelocity: 10000\nDPS: 1\nHPS: 0.5\nDPH: 2\nProjectile Count: 2\n\nDescription: Small dumbfire missile launcher with a small, but decent DPS for its weight with minimal spread and no projectile drop." )
		end
		if (node == NodeList["SRM4"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "SRM4")
		DLabel:SetText( "SRM-4\n\nHealth: 20\nWeight: 2 Tons\nDamage: 8\nHeat: 3\nCooldown: 4s\nVelocity: 10000\nDPS: 2\nHPS: 0.75\nDPH: 2.67\nProjectile Count: 4\n\nDescription: Medium dumbfire missile launcher with a respectable DPS for its weight with minimal spread and no projectile drop." )
		end
		if (node == NodeList["SRM6"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "SRM6")
		DLabel:SetText( "SRM-6\n\nHealth: 30\nWeight: 3 Tons\nDamage: 12\nHeat: 4\nCooldown: 4s\nVelocity: 10000\nDPS: 3\nHPS: 1\nDPH: 3\nProjectile Count: 6\n\nDescription: Large dumbfire missile launcher with good DPS for its weight with minimal spread and no projectile drop." )
		end
		if (node == NodeList["SSRM2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "SSRM2")
		DLabel:SetText( "Streak SRM-2\n\nHealth: 15\nWeight: 1.5 Tons\nDamage: 4\nHeat: 2\nCooldown: 4s\nVelocity: 12500\nDPS: 1\nHPS: 0.5\nDPH: 2\nProjectile Count: 2\n\nDescription: Small missile launcher that locks onto a target it is pointed at, trades tonnage efficiency for accuracy." )
		end
		if (node == NodeList["SSRM4"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "SSRM4")
		DLabel:SetText( "Streak SRM-4\n\nHealth: 30\nWeight: 3 Tons\nDamage: 8\nHeat: 3\nCooldown: 4s\nVelocity: 12500\nDPS: 2\nHPS: 0.75\nDPH: 2.67\nProjectile Count: 4\n\nDescription: Medium missile launcher that locks onto a target it is pointed at, trades tonnage efficiency for accuracy." )
		end
		if (node == NodeList["SSRM6"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "SSRM6")
		DLabel:SetText( "Streak SRM-6\n\nHealth: 45\nWeight: 4.5 Tons\nDamage: 12\nHeat: 4\nCooldown: 4s\nVelocity: 12500\nDPS: 3\nHPS: 1\nDPH: 3\nProjectile Count: 6\n\nDescription: Large missile launcher that locks onto a target it is pointed at, trades tonnage efficiency for accuracy." )
		end
		if (node == NodeList["LRM5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM5")
		DLabel:SetText( "LRM-5\n\nHealth: 20\nWeight: 2 Tons\nDamage: 5\nHeat: 2\nCooldown: 3s\nVelocity: 4000\nDPS: 1.67\nHPS: 0.67\nDPH: 2.5\nProjectile Count: 5\n\nDescription: Tiny long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["LRM10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM10")
		DLabel:SetText( "LRM-10\n\nHealth: 50\nWeight: 5 Tons\nDamage: 10\nHeat: 3\nCooldown: 3s\nVelocity: 4000\nDPS: 3.33\nHPS: 1\nDPH: 3.33\nProjectile Count: 10\n\nDescription: Small long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["LRM15"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM15")
		DLabel:SetText( "LRM-15\n\nHealth: 70\nWeight: 7 Tons\nDamage: 15\nHeat: 4\nCooldown: 3s\nVelocity: 4000\nDPS: 5\nHPS: 1.33\nDPH: 3.75\nProjectile Count: 15\n\nDescription: Medium long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["LRM20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM20")
		DLabel:SetText( "LRM-20\n\nHealth: 100\nWeight: 10 Tons\nDamage: 20\nHeat: 4\nCooldown: 3s\nVelocity: 4000\nDPS: 6.67\nHPS: 1.33\nDPH: 5\nProjectile Count: 20\n\nDescription: Large long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["MRM10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM10")
		DLabel:SetText( "MRM-10\n\nHealth: 30\nWeight: 3 Tons\nDamage: 10\nHeat: 3.2\nCooldown: 3.2s\nVelocity: 20000\nDPS: 2.5\nHPS: 1\nDPH: 2.5\nProjectile Count: 10\n\nDescription: Small medium range missile system that dumbfires rockets at relatively high velocities." )
		end
		if (node == NodeList["MRM20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM20")
		DLabel:SetText( "MRM-20\n\nHealth: 70\nWeight: 7 Tons\nDamage: 20\nHeat: 4.8\nCooldown: 3.2s\nVelocity: 20000\nDPS: 5\nHPS: 1.5\nDPH: 3.33\nProjectile Count: 20\n\nDescription: Mid-sized medium range missile system that dumbfires rockets at relatively high velocities." )
		end
		if (node == NodeList["MRM30"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM30")
		DLabel:SetText( "MRM-30\n\nHealth: 100\nWeight: 10 Tons\nDamage: 30\nHeat: 8\nCooldown: 3.2s\nVelocity: 20000\nDPS: 7.5\nHPS: 2.5\nDPH: 3\nProjectile Count: 30\n\nDescription: Large medium range missile system that dumbfires rockets at relatively high velocities." )
		end
		if (node == NodeList["MRM40"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM40")
		DLabel:SetText( "MRM-40\n\nHealth: 120\nWeight: 12 Tons\nDamage: 40\nHeat: 9.6\nCooldown: 3.2s\nVelocity: 20000\nDPS: 10\nHPS: 3\nDPH: 3.33\nProjectile Count: 40\n\nDescription: Huge medium range missile system that dumbfires rockets at relatively high velocities." )
		end

		----BALLISTIC AMMO
		if (node == NodeList["AC2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC2Ammo")
		DLabel:SetText( "AC-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AC5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC5Ammo")
		DLabel:SetText( "AC-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AC10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC10Ammo")
		DLabel:SetText( "AC-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AC20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AC20Ammo")
		DLabel:SetText( "AC-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["IAC2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "IAC2Ammo")
		DLabel:SetText( "Inferno AC-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, also explodes. WARNING: Extremely Volitile!" )
		end
		if (node == NodeList["IAC5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "IAC5Ammo")
		DLabel:SetText( "Inferno AC-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes. WARNING: Extremely Volitile!" )
		end
		if (node == NodeList["IAC10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "IAC10Ammo")
		DLabel:SetText( "Inferno AC-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes. WARNING: Extremely Volitile!" )
		end
		if (node == NodeList["IAC20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "IAC20Ammo")
		DLabel:SetText( "Inferno AC-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes. WARNING: Extremely Volitile!" )
		end
		if (node == NodeList["FAC2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "FAC2Ammo")
		DLabel:SetText( "Flak AC-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["FAC5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "FAC5Ammo")
		DLabel:SetText( "Flak AC-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["FAC10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "FAC10Ammo")
		DLabel:SetText( "Flak AC-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["FAC20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "FAC20Ammo")
		DLabel:SetText( "Flak AC-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["UAC2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC2Ammo")
		DLabel:SetText( "Ultra AC-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 287\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["UAC5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC5Ammo")
		DLabel:SetText( "Ultra AC-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 100\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["UAC10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC10Ammo")
		DLabel:SetText( "Ultra AC-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 44\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["UAC20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "UAC20Ammo")
		DLabel:SetText( "Ultra AC-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 27\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["RAC2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC2Ammo")
		DLabel:SetText( "Rotary AC-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 800\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["RAC5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC5Ammo")
		DLabel:SetText( "Rotary AC-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 320\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["RAC10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC10Ammo")
		DLabel:SetText( "Rotary AC-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 160\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["RAC20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "RAC20Ammo")
		DLabel:SetText( "Rotary AC-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LBX2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX2Ammo")
		DLabel:SetText( "LBX-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LBX5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX5Ammo")
		DLabel:SetText( "LBX-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LBX10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX10Ammo")
		DLabel:SetText( "LBX-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LBX20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LBX20Ammo")
		DLabel:SetText( "LBX-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AALBX2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AALBX2Ammo")
		DLabel:SetText( "Anti-Air LBX-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AALBX5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AALBX5Ammo")
		DLabel:SetText( "Anti-Air LBX-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AALBX10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AALBX10Ammo")
		DLabel:SetText( "Anti-Air LBX-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["AALBX20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "AALBX20Ammo")
		DLabel:SetText( "Anti-Air LBX-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SLBX2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SLBX2Ammo")
		DLabel:SetText( "Slug LBX-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SLBX5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SLBX5Ammo")
		DLabel:SetText( "Slug LBX-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SLBX10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SLBX10Ammo")
		DLabel:SetText( "Slug LBX-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SLBX20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SLBX20Ammo")
		DLabel:SetText( "Slug LBX-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LightGaussAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LightGaussAmmo")
		DLabel:SetText( "Light Gauss Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 27\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["GaussAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "GaussAmmo")
		DLabel:SetText( "Gauss Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 14\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["HeavyGaussAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyGaussAmmo")
		DLabel:SetText( "Heavy Gauss Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 8\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["LongTomAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LongTomAmmo")
		DLabel:SetText( "Long Tom Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 8\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["MachineGunAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "MachineGunAmmo")
		DLabel:SetText( "Machine Gun Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 1000\n\nDescription: Makes guns shootier, also explodes." )
		end
		----MISSILE AMMO
		if (node == NodeList["SRM2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SRM2Ammo")
		DLabel:SetText( "SRM-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 100\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SRM4Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SRM4Ammo")
		DLabel:SetText( "SRM-4 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 51\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SRM6Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SRM6Ammo")
		DLabel:SetText( "SRM-6 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 34\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SSRM2Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SSRM2Ammo")
		DLabel:SetText( "Streak SRM-2 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 100\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SSRM4Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SSRM4Ammo")
		DLabel:SetText( "Streak SRM-4 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 51\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["SSRM6Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SSRM6Ammo")
		DLabel:SetText( "Streak SRM-6 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 34\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LRM5Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM5Ammo")
		DLabel:SetText( "LRM-5 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 80\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LRM10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM10Ammo")
		DLabel:SetText( "LRM-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LRM15Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM15Ammo")
		DLabel:SetText( "LRM-15 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 27\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LRM20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LRM20Ammo")
		DLabel:SetText( "LRM-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["MRM10Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM10Ammo")
		DLabel:SetText( "MRM-10 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["MRM20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM20Ammo")
		DLabel:SetText( "MRM-20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["MRM30Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM30Ammo")
		DLabel:SetText( "MRM-30 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 14\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["MRM40Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "MRM40Ammo")
		DLabel:SetText( "MRM-40 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 10\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["CMicro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "MicroCompact")
		DLabel:SetText( "Micro Compact Engine\n\nWeight Limit: 10 tons\nWeight: 1 Ton\nCooling: 4 Dissipation\nMaxHeat: 15\nHealth: 10\n\nDescription: Compact but heavy engine for very light vehicles. Multiplies mobility speed by 0.25." )
		end
		if (node == NodeList["CSmall"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "SmallCompact")
		DLabel:SetText( "Small Compact Engine\n\nWeight Limit: 40 tons\nWeight: 5 Tons\nCooling: 4 Dissipation\nMaxHeat: 30\nHealth: 50\n\nDescription: Compact but heavy engine for light vehicles. Multiplies mobility speed by 1." )
		end
		if (node == NodeList["CMedium"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "MediumCompact")
		DLabel:SetText( "Medium Compact Engine\n\nWeight Limit: 75 tons\nWeight: 10 Tons\nCooling: 4 Dissipation\nMaxHeat: 50\nHealth: 100\n\nDescription: Compact but heavy engine for medium vehicles. Multiplies mobility speed by 1.15." )
		end
		if (node == NodeList["CLarge"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "LargeCompact")
		DLabel:SetText( "Large Compact Engine\n\nWeight Limit: 100 tons\nWeight: 15 Tons\nCooling: 4 Dissipation\nMaxHeat: 60\nHealth: 150\n\nDescription: Compact but heavy engine for large vehicles. Multiplies mobility speed by 1.35." )
		end
		if (node == NodeList["CUltra"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "UltraCompact")
		DLabel:SetText( "Ultra Compact Engine\n\nWeight Limit: 200 tons\nWeight: 30 Tons\nCooling: 4 Dissipation\nMaxHeat: 80\nHealth: 300\n\nDescription: Compact but heavy engine for massive vehicles. Multiplies mobility speed by 1.7." )
		end
		if (node == NodeList["SMicro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "MicroStandard")
		DLabel:SetText( "Micro Standard Engine\n\nWeight Limit: 10 tons\nWeight: 0.75 Tons\nCooling: 3.5 Dissipation\nMaxHeat: 12.5\nHealth: 7.5\n\nDescription: Mid sized and mid weight engine for very light vehicles. Multiplies mobility speed by 0.25." )
		end
		if (node == NodeList["SSmall"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "SmallStandard")
		DLabel:SetText( "Small Standard Engine\n\nWeight Limit: 40 tons\nWeight: 3.75 Tons\nCooling: 3.5 Dissipation\nMaxHeat: 25\nHealth: 37.5\n\nDescription: Mid sized and mid weight engine for light vehicles. Multiplies mobility speed by 1." )
		end
		if (node == NodeList["SMedium"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "MediumStandard")
		DLabel:SetText( "Medium Standard Engine\n\nWeight Limit: 75 tons\nWeight: 7.5 Tons\nCooling: 3.5 Dissipation\nMaxHeat: 40\nHealth: 75\n\nDescription: Mid sized and mid weight engine for medium vehicles. Multiplies mobility speed by 1.15." )
		end
		if (node == NodeList["SLarge"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "LargeStandard")
		DLabel:SetText( "Large Standard Engine\n\nWeight Limit: 100 tons\nWeight: 11.25 Tons\nCooling: 3.5 Dissipation\nMaxHeat: 50\nHealth: 112.5\n\nDescription: Mid sized and mid weight engine for large vehicles. Multiplies mobility speed by 1.35." )
		end
		if (node == NodeList["SUltra"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "UltraStandard")
		DLabel:SetText( "Ultra Standard Engine\n\nWeight Limit: 200 tons\nWeight: 22.5 Tons\nCooling: 3.5 Dissipation\nMaxHeat: 70\nHealth: 225\n\nDescription: Mid sized and mid weight engine for massive vehicles. Multiplies mobility speed by 1.7." )
		end
		if (node == NodeList["XMicro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "MicroXL")
		DLabel:SetText( "Micro XL Engine\n\nWeight Limit: 10 tons\nWeight: 0.5 Tons\nCooling: 3 Dissipation\nMaxHeat: 10\nHealth: 5\n\nDescription: A large but light engine for very light vehicles. Multiplies mobility speed by 0.25." )
		end
		if (node == NodeList["XSmall"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "SmallXL")
		DLabel:SetText( "Small XL Engine\n\nWeight Limit: 40 tons\nWeight: 2.5 Tons\nCooling: 3 Dissipation\nMaxHeat: 20\nHealth: 25\n\nDescription: A large but light engine for light vehicles. Multiplies mobility speed by 1." )
		end
		if (node == NodeList["XMedium"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "MediumXL")
		DLabel:SetText( "Medium XL Engine\n\nWeight Limit: 75 tons\nWeight: 5 Tons\nCooling: 3 Dissipation\nMaxHeat: 30\nHealth: 50\n\nDescription: A large but light engine for medium vehicles. Multiplies mobility speed by 1.15." )
		end
		if (node == NodeList["XLarge"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "LargeXL")
		DLabel:SetText( "Large XL Engine\n\nWeight Limit: 100 tons\nWeight: 7.5 Tons\nCooling: 3 Dissipation\nMaxHeat: 40\nHealth: 75\n\nDescription: A large but light engine for large vehicles. Multiplies mobility speed by 1.35." )
		end
		if (node == NodeList["XUltra"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_engine")
		RunConsoleCommand("dakspawner_SpawnSettings", "UltraXL")
		DLabel:SetText( "Ultra XL Engine\n\nWeight Limit: 200 tons\nWeight: 15 Tons\nCooling: 3 Dissipation\nMaxHeat: 60\nHealth: 150\n\nDescription: A large but light engine for massive vehicles. Multiplies mobility speed by 1.7." )
		end
		if (node == NodeList["LAMS"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_lams")
		RunConsoleCommand("dakspawner_SpawnSettings", "LAMS")
		DLabel:SetText( "Laser AMS\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 5 missiles per second\nHeat: 5 per second\n\nDescription: Anti missile system that fires a laser at nearby missiles, will not shoot down your own missiles, but may shoot down the missiles of your allies if you don't toggle it off. Its heat generation may become dangerous if massed." )
		end
		if (node == NodeList["SBG"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "SBG")
		DLabel:SetText( "Silver Bullet Gauss Rifle\n\nHealth: 75\nWeight: 15 Tons\nDamage: 40\nHeat: 1\nCooldown: 4.5s\nVelocity: 75000\nSpread: +-0.4 Degrees\nDPS: 8.89\nHPS: 0.22\nDPH: 40\nProjectile Count: 10\n\nDescription: A gauss rifle built to fire the mech equivalent of buckshot. It explodes when heavily damaged, though its ammo doesn't." )
		end
		if (node == NodeList["Thumper"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "Thumper")
		DLabel:SetText( "Thumper Cannon\n\nHealth: 100\nWeight: 10 Tons\nDamage: 10 +50 splash\nHeat: 10\nCooldown: 5s\nVelocity: 7500\nBlast Radius: 500 units\nDPS: 12\nHPS: 2\nDPH: 6\n\nDescription: A light artillery gun good at breaking fragile equipment off of vehicles and blasting away armor. Works best on direct hits, as its fall off is quick." )
		end
		if (node == NodeList["SBGAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SBGAmmo")
		DLabel:SetText( "Silver Bullet Gauss Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 14\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ThumperAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ThumperAmmo")
		DLabel:SetText( "Thumper Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 20\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["Railgun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "Railgun")
		DLabel:SetText( "Railgun\n\nHealth: 140\nWeight: 28 Tons\nDamage: 100\nHeat: 5\nCooldown: 5s\nVelocity: 75000\nDPS: 20\nHPS: 1\nDPH: 20\n\nDescription: A Massively oversized gauss rifle, this weapon was deemed too unwieldy and high maintenance for common use. Those that do use it will find its weight and low ammo per ton to be costly and its recoil immense, but those who can handle that will be able to hit foes with enough power to rip off entire sections in a single shot. If destroyed it will deal damage to all around it, but its ammo will not." )
		end
		if (node == NodeList["RailgunAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "RailgunAmmo")
		DLabel:SetText( "Railgun Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 4\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["Sniper"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "Sniper")
		DLabel:SetText( "Sniper Cannon\n\nHealth: 200\nWeight: 20 Tons\nDamage: 60 +40 splash\nHeat: 10\nCooldown: 5s\nVelocity: 25000\nBlast Radius: 500 units\nDPS: 20\nHPS: 2\nDPH: 10\n\nDescription: An artillery piece built for direct long range bombardment. Delivers high damage on hit and has an explosion powerful enough to destroy internal equipment, light weaponry, and weak or unarmored combatants." )
		end
		if (node == NodeList["SniperAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "SniperAmmo")
		DLabel:SetText( "Sniper Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 14\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["Arrow"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "Arrow")
		DLabel:SetText( "Arrow IV Launcher\n\nHealth: 150\nWeight: 15 Tons\nDamage: 25 +75 splash\nHeat: 15\nCooldown: 7.5s\nVelocity: 2000\nBlast Radius: 500 units\nDPS: 13.33\nHPS: 2\nDPH: 6.67\nProjectile Count: 5\n\nDescription: A rocket artillery system that fires similarly to an LRM, but has large explosive warheads. When unguided they will fire a spread of rockets at an area, when guided they'll home in on the requested target. These rockets are stronger than normal LRMs, but are still vulnerable to AMS systems and may prove ineffective against heavy AMS." )
		end
		if (node == NodeList["ArrowAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ArrowAmmo")
		DLabel:SetText( "Arrow IV Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 14\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["MicroLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "MicroLaser")
		DLabel:SetText( "Micro Laser\n\nHealth: 2.5\nWeight: 0.25 Tons\nDamage: 0.5\nHeat: 0.675\nCooldown: 0.875s\nDuration: 0.25s\nDPS: 0.44\nHPS: 0.6\nDPH: 0.74\n\nDescription: Tiny laser often found on battlearmor and protomechs, it can be useful against infantry and light vehicles in mass." )
		end
		if (node == NodeList["MicropulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "MicropulseLaser")
		DLabel:SetText( "Micro Pulse Laser\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 0.5\nHeat: 0.675\nCooldown: 0.375s\nDuration: 0.125s\nDPS: 1\nHPS: 1.35\nDPH: 0.74\n\nDescription: Tiny pulse laser able to focus a small burst of damage into an enemy quickly with minimal heat." )
		end
		if (node == NodeList["LightMachineGun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LightMachineGun")
		DLabel:SetText( "Light Machine Gun\n\nHealth: 2.5\nWeight: 0.25 Tons\nDamage: 0.1125\nHeat: 0\nCooldown: 0.2s\nVelocity: 35000\nDPS: 0.5625\nHPS: 0\nDPH: inf\n\nDescription: A lightened version of the machine gun with a higher velocity but weaker projectiles." )
		end
		if (node == NodeList["HeavyMachineGun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyMachineGun")
		DLabel:SetText( "Heavy Machine Gun\n\nHealth: 10\nWeight: 1 Ton\nDamage: 0.45\nHeat: 0\nCooldown: 0.2s\nVelocity: 25000\nDPS: 2.25\nHPS: 0\nDPH: inf\n\nDescription: Heavy duty machine gun able to kill most infantry in a single shot, suffers from low velocity, but can be powerful against armor." )
		end
		if (node == NodeList["LightMachineGunAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "LightMachineGunAmmo")
		DLabel:SetText( "Light Machine Gun Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 2000\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["HeavyMachineGunAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyMachineGunAmmo")
		DLabel:SetText( "Heavy Machine Gun Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 500\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["LightPPCBurst"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "LightPPCBurst")
		DLabel:SetText( "Light Burst PPC\n\nHealth: 30\nWeight: 3 Tons\nDamage: 3\nHeat: 2\nCooldown: 0.5s\nVelocity: 30000\nDPS: 6\nHPS: 4\nDPH: 1.5\n\nDescription: A light but relatively weak particle cannon, decreases damage per shot to allow for more rapid fire pulses, allowing it more anti infantry capability. The lighter nature of the gun leads to less efficient energy transfer and and a lower damage to heat ratio on the user than a normal PPC." )
		end
		if (node == NodeList["ALightPPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "ALightPPC")
		DLabel:SetText( "Armored Light PPC\n\nHealth: 100\nWeight: 5 Tons\nDamage: 10\nHeat: 5\nCooldown: 3s\nVelocity: 35000\nDPS: 3.33\nHPS: 1.67\nDPH: 2\n\nDescription: Functionally the same as a normal light PPC, but made from significantly denser materials to improve durability." )
		end
		if (node == NodeList["ALightPPCBurst"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "ALightPPCBurst")
		DLabel:SetText( "Armored Light Burst PPC\n\nHealth: 100\nWeight: 5 Tons\nDamage: 3\nHeat: 2\nCooldown: 0.5s\nVelocity: 30000\nDPS: 6\nHPS: 4\nDPH: 1.5\n\nDescription: Functionally the same as a normal light burst PPC, but made from significantly denser materials to improve durability." )
		end
		if (node == NodeList["APPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "APPC")
		DLabel:SetText( "Armored PPC\n\nHealth: 180\nWeight: 9 Tons\nDamage: 20\nHeat: 7.5\nCooldown: 3s\nVelocity: 35000\nDPS: 6.67\nHPS: 2.5\nDPH: 2.67\n\nDescription: Functionally the same as a normal PPC, but made from significantly denser materials to improve durability." )
		end
		if (node == NodeList["AHeavyPPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AHeavyPPC")
		DLabel:SetText( "Armored Heavy PPC\n\nHealth: 240\nWeight: 12 Tons\nDamage: 30\nHeat: 12\nCooldown: 3s\nVelocity: 35000\nDPS: 10\nHPS: 4\nDPH: 2.5\n\nDescription: Functionally the same as a normal heavy PPC, but made from significantly denser materials to improve durability." )
		end
		----BALLISTICS
		if (node == NodeList["AAC2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AAC2")
		DLabel:SetText( "Armored AC-2\n\nHealth: 160\nWeight: 8 Tons\nHeat: 0.4\nCooldown: 0.35s\n\nStandard Rounds:\nDamage: 2\nVelocity: 40000\nDPS: 5.71\nHPS: 1.14\nDPH: 5\n\nFlak Rounds:\nSplash Damage: 2\nVelocity: 45000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 5.71\nHPS: 1.14\nDPH: 5\n\nInferno Rounds:\nDamage: 1\nHeat Damage: 0.24\nVelocity: 40000\nCooling Reduction Time: 3s \nHeatDPS: 0.69\nDPS: 2.86\nHPS: 1.14\nDPH: 2.5\n\nDescription: Functionally the same as a normal AC2, but made from significantly denser materials to improve durability. It uses the same ammo." )
		end
		if (node == NodeList["AAC5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AAC5")
		DLabel:SetText( "Armored AC-5\n\nHealth: 200\nWeight: 10 Tons\nHeat: 1\nCooldown: 0.7s\n\nStandard Rounds:\nDamage: 5\nVelocity: 35000\nDPS: 7.14\nHPS: 1.43\nDPH: 5\n\nFlak Rounds:\nSplash Damage: 5\nVelocity: 40000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 7.14\nHPS: 1.43\nDPH: 5\n\nInferno Rounds:\nDamage: 2.5\nHeat Damage: 0.6\nVelocity: 35000\nCooling Reduction Time: 3s \nHeatDPS: 0.86\nDPS: 3.57\nHPS: 1.43\nDPH: 2.5\n\nDescription: Functionally the same as a normal AC5, but made from significantly denser materials to improve durability. It uses the same ammo." )
		end
		if (node == NodeList["AAC10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AAC10")
		DLabel:SetText( "Armored AC-10\n\nHealth: 280\nWeight: 14 Tons\nHeat: 2.5\nCooldown: 1s\n\nStandard Rounds:\nDamage: 10\nVelocity: 30000\nDPS: 10\nHPS: 2.5\nDPH: 4\n\nFlak Rounds:\nSplash Damage: 10\nVelocity: 35000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 10\nHPS: 2.5\nDPH: 4\n\nInferno Rounds:\nDamage: 5\nHeat Damage: 1.2\nVelocity: 30000\nCooling Reduction Time: 3s \nHeatDPS: 1.2\nDPS: 5\nHPS: 2.5\nDPH: 2\n\nDescription: Functionally the same as a normal AC10, but made from significantly denser materials to improve durability. It uses the same ammo." )
		end
		if (node == NodeList["AAC20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "AAC20")
		DLabel:SetText( "Armored AC-20\n\nHealth: 320\nWeight: 16 Tons\nHeat: 5\nCooldown: 1.6s\n\nStandard Rounds:\nDamage: 20\nVelocity: 25000\nDPS: 12.5\nHPS: 3.125\nDPH: 4\n\nFlak Rounds:\nSplash Damage: 20\nVelocity: 30000\nProximity Range: 250 units\nBlast Radius: 250 units\nDPS: 12.5\nHPS: 3.125\nDPH: 4\n\nInferno Rounds:\nDamage: 10\nHeat Damage: 2.4\nVelocity: 25000\nCooling Reduction Time: 3s \nHeatDPS: 1.5\nDPS: 6.25\nHPS: 3.125\nDPH: 2\n\nDescription: Functionally the same as a normal AC20, but made from significantly denser materials to improve durability. It uses the same ammo." )
		end
		if (node == NodeList["LHoverdrive"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_hoverdrive")
		RunConsoleCommand("dakspawner_SpawnSettings", "LHoverdrive")
		DLabel:SetText( "Light Hoverdrive\n\nHealth: 20\nWeight: 5 Tons\nSpeed: 100 kph at 20 ton total mass\n\nDescription: The slowest and lightest of the hoverdrive systems, good for weight savings if you don't need the speed." )
		end
		if (node == NodeList["MHoverdrive"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_hoverdrive")
		RunConsoleCommand("dakspawner_SpawnSettings", "MHoverdrive")
		DLabel:SetText( "Standard Hoverdrive\n\nHealth: 35\nWeight: 10 Tons\nSpeed: 200 kph at 20 ton total mass\n\nDescription: Mid tier hoverdrive, good balance of speed and weight savings." )
		end
		if (node == NodeList["HHoverdrive"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_hoverdrive")
		RunConsoleCommand("dakspawner_SpawnSettings", "HHoverdrive")
		DLabel:SetText( "Heavy Hoverdrive\n\nHealth: 50\nWeight: 20 Tons\nSpeed: 300 kph at 20 ton total mass\n\nDescription: The heaviest of the hoverdrives, this engine will get you moving quick, but the high weight requires sacrifice." )
		end
		if (node == NodeList["LMotor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_motor")
		RunConsoleCommand("dakspawner_SpawnSettings", "LMotor")
		DLabel:SetText( "Light Motor\n\nHealth: 25\nWeight: 1 Ton\nSpeed: 50 kph at 20 ton total mass\n\nDescription: The slowest and lightest motor, it really does move quite sluggish, but you'll save considerable weight." )
		end
		if (node == NodeList["MMotor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_motor")
		RunConsoleCommand("dakspawner_SpawnSettings", "MMotor")
		DLabel:SetText( "Standard Motor\n\nHealth: 50\nWeight: 2 Tons\nSpeed: 75 kph at 20 ton total mass\n\nDescription: Mid tier motor, good balance of speed and weight savings." )
		end
		if (node == NodeList["HMotor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_motor")
		RunConsoleCommand("dakspawner_SpawnSettings", "HMotor")
		DLabel:SetText( "Heavy Motor\n\nHealth: 100\nWeight: 4 Tons\nSpeed: 100 kph at 20 ton total mass\n\nDescription: The second heaviest motor, it'll get you moving the speed of a light hovercraft, though you still won't float." )
		end
		if (node == NodeList["JumpJet5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_jumpjet")
		RunConsoleCommand("dakspawner_SpawnSettings", "JumpJet5")
		DLabel:SetText( "Micro Jump Jet\n\nHealth: 10\nWeight: 0.25 Tons\n\nDescription: The lightest jump jet, good for battlearmor, but won't provide much of a push for heavier mechs." )
		end
		if (node == NodeList["JumpJet4"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_jumpjet")
		RunConsoleCommand("dakspawner_SpawnSettings", "JumpJet4")
		DLabel:SetText( "Light Jump Jet\n\nHealth: 20\nWeight: 0.5 Tons\n\nDescription: Second lightest jump jet, good for light mechs, but won't provide much of a push for heavier mechs." )
		end
		if (node == NodeList["JumpJet3"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_jumpjet")
		RunConsoleCommand("dakspawner_SpawnSettings", "JumpJet3")
		DLabel:SetText( "Standard Jump Jet\n\nHealth: 40\nWeight: 1 Ton\n\nDescription: Mid tier jump jet, great for medium and heavy mechs." )
		end
		if (node == NodeList["JumpJet2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_jumpjet")
		RunConsoleCommand("dakspawner_SpawnSettings", "JumpJet2")
		DLabel:SetText( "Heavy Jump Jet\n\nHealth: 80\nWeight: 2 Tons\n\nDescription: Heavy duty jump jet, good for assault mechs and capable of launching light mechs far into the air with just one." )
		end
		if (node == NodeList["JumpJet1"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_jumpjet")
		RunConsoleCommand("dakspawner_SpawnSettings", "JumpJet1")
		DLabel:SetText( "Ultra Jump Jet\n\nHealth: 160\nWeight: 4 Tons\n\nDescription: Jump jets that will make NASA jealous, these monsters will allow the heaviest of mechs to soar into the air." )
		end
		if (node == NodeList["LGyro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gyro")
		RunConsoleCommand("dakspawner_SpawnSettings", "LGyro")
		DLabel:SetText( "Light Gyro\n\nHealth: 50\nWeight: 1 Ton\nSpeed: 75 kph at 20 ton total mass\n\nDescription: Light gyroscope and gearing setup that will allow your mech to move, but not very fast. Sturdy for its weight though." )
		end
		if (node == NodeList["MGyro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gyro")
		RunConsoleCommand("dakspawner_SpawnSettings", "MGyro")
		DLabel:SetText( "Standard Gyro\n\nHealth: 100\nWeight: 3 Ton\nSpeed: 110 kph at 20 ton total mass\n\nDescription: Mid tier gyroscope that will allow your mech to keep pace with medium tanks." )
		end
		if (node == NodeList["HGyro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gyro")
		RunConsoleCommand("dakspawner_SpawnSettings", "HGyro")
		DLabel:SetText( "Heavy Gyro\n\nHealth: 150\nWeight: 7 Ton\nSpeed: 175 kph at 20 ton total mass\n\nDescription: High end gyro allowing you to reach speeds of slow hovercraft." )
		end
		if (node == NodeList["LQGyro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_quadgyro")
		RunConsoleCommand("dakspawner_SpawnSettings", "LQGyro")
		DLabel:SetText( "Light Quad Gyro\n\nHealth: 100\nWeight: 0.5 Tons\nSpeed: 75 kph at 20 ton total mass\n\nDescription: Light gyroscope and gearing setup that will allow your mech to move, but not very fast. Sturdy for its weight though." )
		end
		if (node == NodeList["MQGyro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_quadgyro")
		RunConsoleCommand("dakspawner_SpawnSettings", "MQGyro")
		DLabel:SetText( "Standard Quad Gyro\n\nHealth: 150\nWeight: 1.5 Ton\nSpeed: 110 kph at 20 ton total mass\n\nDescription: Mid tier gyroscope that will allow your mech to keep pace with medium tanks." )
		end
		if (node == NodeList["HQGyro"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_quadgyro")
		RunConsoleCommand("dakspawner_SpawnSettings", "HQGyro")
		DLabel:SetText( "Heavy Quad Gyro\n\nHealth: 200\nWeight: 3.5 Ton\nSpeed: 175 kph at 20 ton total mass\n\nDescription: High end gyro allowing you to reach speeds of slow hovercraft." )
		end
		if (node == NodeList["Magshot"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "Magshot")
		DLabel:SetText( "Magshot Gauss Rifle\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 2\nHeat: 1\nCooldown: 2s\nVelocity: 75000\nDPS: 1\nHPS: 0.5\nDPH: 2\n\nDescription: Battlearmor sized gauss rifle built to give anti armor ability to light craft. It also preforms as a powerful anti infantry sniper rifle." )
		end
		if (node == NodeList["MagshotAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "MagshotAmmo")
		DLabel:SetText( "Magshot Gauss Rifle Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["Sensor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_radar")
		DLabel:SetText( "Sensor\n\nHealth: 10\nWeight: 0.25 Tons\n\nDescription: Outputs a list of targets in your LOS and allows you to select from that list. You can use this information to indicate targets on your HUD or for missile locks." )
		end
		if (node == NodeList["ECM"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ecm")
		DLabel:SetText( "ECM\n\nHealth: 10\nWeight: 1 Ton\n\nDescription: Makes sensors unable to target you unless you are NARCed or designated by TAG." )
		end
		if (node == NodeList["TAG"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_xpulselaser")
		RunConsoleCommand("dakspawner_SpawnSettings", "TAG")
		DLabel:SetText( "TAG Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 0 per second\nHeat: 0 per second\nLock Time: 1 second\n\nDescription: Designates targets and allows for anyone on the field with a radar to target them even through ECM." )
		end
		if (node == NodeList["NARC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "NARC")
		DLabel:SetText( "NARC\n\nHealth: 30\nWeight: 3 Tons\nDamage: 5\nHeat: 0\nCooldown: 2.5s\nVelocity: 10000\nLock Time: 30 seconds\n\nDescription: Designates targets and allows for anyone on the field with a radar to target them even through ECM. IS techs have placed charges onto their launchers allowing them to also cause damage to their targets." )
		end
		if (node == NodeList["NARCAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "NARCAmmo")
		DLabel:SetText( "NARC Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 40\n\nDescription: Makes guns shootier, also explodes." )
		end
		if (node == NodeList["StealthModule"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_stealthmodule")
		DLabel:SetText( "Stealth Module\n\nHealth: 10\nWeight: 4 Tons\n\nDescription: When activated this module visually cloaks your vehicle and reduces your cooling ability to 0 while generating 1 heat per second. Pairing this with ECM is recommended as to mask your sensor presence also." )
		end
		if (node == NodeList["UMotor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_motor")
		RunConsoleCommand("dakspawner_SpawnSettings", "UMotor")
		DLabel:SetText( "Ultra Motor\n\nHealth: 150\nWeight: 6 Tons\nSpeed: 150 kph at 20 ton total mass\n\nDescription: The heaviest motor, created to give even the heaviest of tanks decent mobility, it'll propel light ground vehicles at extreme speeds." )
		end
		if (node == NodeList["HitBoxControl"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_hitboxcontroller")
		DLabel:SetText( "Hitbox Controller\n\nHealth: 10\n\nDescription: This entity allows you to select props to place into a health pool with the health pooling tool. Please know the rules and regulations for health pooling before using. Rules can be found in the Dak Health Pooler tool's description. It also outputs the group's health via wire so you can link it with EGPs or other HUD setups." )
		end
		if (node == NodeList["LVTOL"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_vtol")
		RunConsoleCommand("dakspawner_SpawnSettings", "LVTOL")
		DLabel:SetText( "Light VTOL Engine\n\nHealth: 10\nWeight: 2 Tons\nSpeed: 75 kph at 20 ton total mass\n\nDescription: Weak VTOL engine, good for light scouts and slow gunships that require heavy firepower and armor." )
		end
		if (node == NodeList["MVTOL"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_vtol")
		RunConsoleCommand("dakspawner_SpawnSettings", "MVTOL")
		DLabel:SetText( "Standard VTOL Engine\n\nHealth: 20\nWeight: 6 Tons\nSpeed: 150 kph at 20 ton total mass\n\nDescription: Mid level VTOL engine, great for light gunships that need a good balance between firepower and speed." )
		end
		if (node == NodeList["HVTOL"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_vtol")
		RunConsoleCommand("dakspawner_SpawnSettings", "HVTOL")
		DLabel:SetText( "Heavy VTOL Engine\n\nHealth: 30\nWeight: 10 Tons\nSpeed: 200 kph at 20 ton total mass\n\nDescription: The heaviest of the VTOL Engines, best for heavier VTOLs that require speed." )
		end
		if (node == NodeList["LFighter"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_fighter")
		RunConsoleCommand("dakspawner_SpawnSettings", "LFighter")
		DLabel:SetText( "Light Fighter Engine\n\nHealth: 10\nWeight: 5 Tons\nSpeed: 125 kph at 20 ton total mass\n\nDescription: Light fighter engine, great for recon planes, light transports, and harassers." )
		end
		if (node == NodeList["MFighter"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_fighter")
		RunConsoleCommand("dakspawner_SpawnSettings", "MFighter")
		DLabel:SetText( "Standard Fighter Engine\n\nHealth: 20\nWeight: 10 Tons\nSpeed: 250 kph at 20 ton total mass\n\nDescription: Mid tier fighter engine, good for heavier jets that still need speed." )
		end
		if (node == NodeList["HFighter"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_fighter")
		RunConsoleCommand("dakspawner_SpawnSettings", "HFighter")
		DLabel:SetText( "Heavy Fighter Engine\n\nHealth: 30\nWeight: 20 Tons\nSpeed: 350 kph at 20 ton total mass\n\nDescription: The heaviest of the fighter engines, it will get the heaviest fighters moving like mid sized jets." )
		end
		if (node == NodeList["HeavySmallLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavySmallLaser")
		DLabel:SetText( "Heavy Small Laser\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 4\nHeat: 4.5\nCooldown: 1.5s\nDuration: 1s\nDPS: 1.6 \nHPS: 1.8\nDPH: 0.89\n\nDescription: Horribly heat inefficient, but very high DPS for its tonnage. Great for light vehicles or for pairing with gauss." )
		end
		if (node == NodeList["HeavyMediumLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyMediumLaser")
		DLabel:SetText( "Heavy Medium Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 11\nHeat: 9\nCooldown: 3s\nDuration: 1.5s\nDPS: 2.44\nHPS: 2.00\nDPH: 1.22\n\nDescription: This boosted medium laser generates extreme heat but is quite light for the amount of damage it puts out, works well with heatsink boats." )
		end
		if (node == NodeList["HeavyLargeLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyLargeLaser")
		DLabel:SetText( "Heavy Large Laser\n\nHealth: 40\nWeight: 4 Tons\nDamage: 16\nHeat: 9.9\nCooldown: 3.25s\nDuration: 1.15s\nDPS: 3.64\nHPS: 2.25\nDPH: 1.62\n\nDescription: This laser happens to be the most efficient heavy laser and should be able to be mixed in with general builds that have a bit of cooling to spare." )
		end
		if (node == NodeList["HeavyAssaultLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyAssaultLaser")
		DLabel:SetText( "Heavy Assault Laser\n\nHealth: 50\nWeight: 5 Tons\nDamage: 30\nHeat: 22.5\nCooldown: 4s\nDuration: 1.0s\nDPS: 6\nHPS: 4.5\nDPH: 1.33\n\nDescription: This laser packs more damage than a heavy gauss rifle but generates so much heat that light vehicles won't even be able to fire it fully." )
		end
		if (node == NodeList["HAG20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HAG20")
		DLabel:SetText( "Hyper-Assault Gauss Rifle 20\n\nHealth: 50\nWeight: 10 Tons\nDamage: 20\nHeat: 6\nCooldown: 2s\nVelocity: 75000\nDPS: 10\nHPS: 3\nDPH: 3.33\nProjectile Count: 10\n\nDescription: The Clan's attempt at heavy gauss rifles, this advanced gauss rifle is built to fire multiple smaller projectiles rapidly. Unlike normal gauss rifles, it generates significant heat, but puts out high DPS. It explodes when heavily damaged, though its ammo doesn't." )
		end
		if (node == NodeList["HAG30"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HAG30")
		DLabel:SetText( "Hyper-Assault Gauss Rifle 30\n\nHealth: 65\nWeight: 13 Tons\nDamage: 30\nHeat: 9\nCooldown: 2s\nVelocity: 75000\nDPS: 15\nHPS: 4.5\nDPH: 3.33\nProjectile Count: 10\n\nDescription: The Clan's attempt at heavy gauss rifles, this advanced gauss rifle is built to fire multiple smaller projectiles rapidly. Unlike normal gauss rifles, it generates significant heat, but puts out high DPS. It explodes when heavily damaged, though its ammo doesn't." )
		end
		if (node == NodeList["HAG40"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HAG40")
		DLabel:SetText( "Hyper-Assault Gauss Rifle 40\n\nHealth: 80\nWeight: 16 Tons\nDamage: 40\nHeat: 12\nCooldown: 2s\nVelocity: 75000\nDPS: 20\nHPS: 6\nDPH: 3.33\nProjectile Count: 10\n\nDescription: The Clan's attempt at heavy gauss rifles, this advanced gauss rifle is built to fire multiple smaller projectiles rapidly. Unlike normal gauss rifles, it generates significant heat, but puts out high DPS. It explodes when heavily damaged, though its ammo doesn't." )
		end
		if (node == NodeList["HAG20Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "HAG20Ammo")
		DLabel:SetText( "HAG20 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 200\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["HAG30Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "HAG30Ammo")
		DLabel:SetText( "HAG30 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 134\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["HAG40Ammo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "HAG40Ammo")
		DLabel:SetText( "HAG40 Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 100\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		--NEW--

		if (node == NodeList["CMicroLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CMicroLaser")
		DLabel:SetText( "C-ER Micro Laser\n\nHealth: 2.5\nWeight: 0.25 Tons\nDamage: 1\nHeat: 1.35\nCooldown: 1.75s\nDuration: 0.5s\nDPS: 0.44\nHPS: 0.6\nDPH: 0.74\n\nDescription: Tiny laser often found on battlearmor and protomechs, it can be useful against infantry and light vehicles in mass." )
		end
		if (node == NodeList["CSmallLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSmallLaser")
		DLabel:SetText( "C-ER Small Laser\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 2\nHeat: 1.8\nCooldown: 1.5s\nDuration: 1s\nDPS: 0.8 \nHPS: 0.72\nDPH: 1.11\n\nDescription: You ever want a guardsman in mech form? Well this is the weapon you want." )
		end
		if (node == NodeList["CMediumLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CMediumLaser")
		DLabel:SetText( "C-ER Medium Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 7\nHeat: 5.4\nCooldown: 3s\nDuration: 1.5s\nDPS: 1.56\nHPS: 1.20\nDPH: 1.30\n\nDescription: Standard laser, good for massing, efficient when killing infantry, fine main gun for a light micro vehicle." )
		end
		if (node == NodeList["CLargeLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLargeLaser")
		DLabel:SetText( "C-ER Large Laser\n\nHealth: 40\nWeight: 4 Tons\nDamage: 11\nHeat: 5.4\nCooldown: 3.25s\nDuration: 1.15s\nDPS: 2.5\nHPS: 1.22\nDPH: 2.04\n\nDescription: Powerful laser on the lighter side of weaponry, just a few can prove for a mighty strike, but beware the heat." )
		end
		if (node == NodeList["CAssaultLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CAssaultLaser")
		DLabel:SetText( "C-ER Assault Laser\n\nHealth: 50\nWeight: 5 Tons\nDamage: 20\nHeat: 13.5\nCooldown: 4s\nDuration: 1.0s\nDPS: 4\nHPS: 2.7\nDPH: 1.48\n\nDescription: Extremely hot and extremely powerful with a short duration, this laser packs a powerful punch if you have the proper cooling." )
		end
		if (node == NodeList["CMicropulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CMicropulseLaser")
		DLabel:SetText( "C-ER Micro Pulse Laser\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 1\nHeat: 1.35\nCooldown: 0.75s\nDuration: 0.25s\nDPS: 1\nHPS: 1.35\nDPH: 0.74\n\nDescription: Tiny pulse laser able to focus a small burst of damage into an enemy quickly with minimal heat." )
		end
		if (node == NodeList["CSmallpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSmallPulseLaser")
		DLabel:SetText( "C-ER Small Pulse Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 2\nHeat: 1.8\nCooldown: 0.5s\nDuration: 0.5s\nDPS: 2\nHPS: 1.8\nDPH: 1.11\n\nDescription: Small laser set up to fire weak but focused beams able to make quick work of infantry." )
		end
		if (node == NodeList["CMediumpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CMediumPulseLaser")
		DLabel:SetText( "C-ER Medium Pulse Laser\n\nHealth: 20\nWeight: 2 Tons\nDamage: 8\nHeat: 3.9\nCooldown: 2.5s\nDuration: 0.75s\nDPS: 2.46\nHPS: 1.2\nDPH: 2.05\n\nDescription: A suprisingly powerful weapon for its weight, the low duration focuses 8 points of damage into a location quickly, good against light vehicles and infantry." )
		end
		if (node == NodeList["CLargepulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLargePulseLaser")
		DLabel:SetText( "C-ER Large Pulse Laser\n\nHealth: 60\nWeight: 6 Tons\nDamage: 13\nHeat: 5\nCooldown: 3s\nDuration: 0.5s\nDPS: 3.71\nHPS: 1.43\nDPH: 2.6\n\nDescription: Less tonnage efficient than the lighter lasers, but much more efficient with its energy transfer causing a higher damage to heat ratio than lighter lasers and very focused beam durations." )
		end
		if (node == NodeList["CAssaultpulseLaser"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_laser")
		RunConsoleCommand("dakspawner_SpawnSettings", "CAssaultPulseLaser")
		DLabel:SetText( "C-ER Assault Pulse Laser\n\nHealth: 80\nWeight: 8 Tons\nDamage: 25\nHeat: 10\nCooldown: 3.5s\nDuration: 0.5s\nDPS: 6.25\nHPS: 2.5\nDPH: 2.5\n\nDescription: Ultra focused laser beam with a half second duration, great for burning holes through things." )
		end
		if (node == NodeList["CFlamer"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CFlamer")
		DLabel:SetText( "C-Flamer\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 0.1\nHeat Damage: 0.6\nHeat: 0.36\nCooldown: 0.2s\nVelocity: 2500\nCooling Reduction Time: 0s \nHeatDPS: 3\nDPS: 0.5\nHPS: 1.8\nDPH: 0.28\n\nDescription: Flamethrower great for increasing enemy heat and igniting exposed infantry, does minimal damage other than heat. Can overpower enemy cooling entirely in masses." )
		end
		if (node == NodeList["CPPC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CPPC")
		DLabel:SetText( "CERPPC\n\nHealth: 60\nWeight: 6 Tons\nDamage: 25\nHeat: 11\nCooldown: 3.5s\nVelocity: 35000\nDPS: 7.14\nHPS: 3.14\nDPH: 2.27\n\nDescription: This PPC deals more damage than an IS PPC while weighing a full ton less, however it generates nearly the same heat per shot as a heavy PPC." )
		end
		if (node == NodeList["CUAC2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CUAC2")
		DLabel:SetText( "C-Ultra AC-2\n\nHealth: 50\nWeight: 5 Tons\nDamage: 1.4\nHeat: 0.395\nCooldown: 0.1875s\nVelocity: 35000\nDPS: 7.47\nHPS: 2.11\nDPH: 3.54\n\nDescription: The Clans have forgone normal autocannons in favor of ultras, they have lightened their weight, putting them even lower than normal IS ACs, however their heat generation suffers. The CUAC2 gives light vehicles a solid high DPS ballistic option." )
		end
		if (node == NodeList["CUAC5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CUAC5")
		DLabel:SetText( "C-Ultra AC-5\n\nHealth: 70\nWeight: 7 Tons\nDamage: 4\nHeat: 1.05\nCooldown: 0.4375s\nVelocity: 30000\nDPS: 9.14\nHPS: 2.4\nDPH: 3.81\n\nDescription: The Clans have forgone normal autocannons in favor of ultras, they have lightened their weight, putting them even lower than normal IS ACs, however their heat generation suffers. The CUAC5 gives a solid punch per shot and higher DPS over class 2 UACs, a good option if you have the weight." )
		end
		if (node == NodeList["CUAC10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CUAC10")
		DLabel:SetText( "C-Ultra AC-10\n\nHealth: 100\nWeight: 10 Tons\nDamage: 9\nHeat: 2.925\nCooldown: 0.75s\nVelocity: 25000\nDPS: 12\nHPS: 3.9\nDPH: 3.08\n\nDescription: The Clans have forgone normal autocannons in favor of ultras, they have lightened their weight, putting them even lower than normal IS ACs, however their heat generation suffers. The CUAC10 is a great weapon to base a loadout around with its solid damage per shot, DPS, and low weight, but beware its heat." )
		end
		if (node == NodeList["CUAC20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CUAC20")
		DLabel:SetText( "C-Ultra AC-20\n\nHealth: 120\nWeight: 12 Tons\nDamage: 15\nHeat: 4.6875\nCooldown: 1s\nVelocity: 20000\nDPS: 15\nHPS: 4.6875\nDPH: 3.2\n\nDescription: The Clans have forgone normal autocannons in favor of ultras, they have lightened their weight, putting them even lower than normal IS ACs, however their heat generation suffers. The CUAC20 offers extremely high DPS for its weight, but its heat generation may force you to put more tonnage than expected into it via heatsinks if you wish to keep it firing for prolonged periods." )
		end
		if (node == NodeList["CRAC2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CRAC2")
		DLabel:SetText( "C-Rotary AC-2\n\nHealth: 60\nWeight: 6 Tons\nDamage: 0.55\nHeat: 0.13\nCooldown: 0.05s\nVelocity: 35000\nDPS: 11\nHPS: 2.6\nDPH: 4.235\n\nDescription: Once again the Clans have increased weight savings for the cost of heat generation. The CRAC2 spits out great DPS but just one will take up a significant portion of your cooling." )
		end
		if (node == NodeList["CRAC5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CRAC5")
		DLabel:SetText( "C-Rotary AC-5\n\nHealth: 80\nWeight: 8 Tons\nDamage: 1.375\nHeat: 0.3125\nCooldown: 0.1s\nVelocity: 30000\nDPS: 13.75\nHPS: 3.125\nDPH: 4.4\n\nDescription: Once again the Clans have increased weight savings for the cost of heat generation. The CRAC5 ramps up damage, heat, and weight over the CRAC2, but not so much that its heat will be a big issue." )
		end
		if (node == NodeList["CRAC10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CRAC10")
		DLabel:SetText( "C-Rotary AC-10\n\nHealth: 110\nWeight: 11 Tons\nDamage: 2.75\nHeat: 0.8\nCooldown: 0.15s\nVelocity: 25000\nDPS: 18.33\nHPS: 5.33\nDPH: 3.4375\n\nDescription: Once again the Clans have increased weight savings for the cost of heat generation. The CRAC10's heat cripples its longevity, but its a great weapon in bursts or with ample cooling." )
		end
		if (node == NodeList["CRAC20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CRAC20")
		DLabel:SetText( "C-Rotary AC-20\n\nHealth: 130\nWeight: 13 Tons\nDamage: 5.5\nHeat: 1.54\nCooldown: 0.25s\nVelocity: 20000\nDPS: 22\nHPS: 6.16\nDPH: 3.575\n\nDescription: Once again the Clans have increased weight savings for the cost of heat generation. The CRAC20's massive DPS will be limited to bursts in all but the coldest running of vehicles." )
		end
		if (node == NodeList["CLBX2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLBX2")
		DLabel:SetText( "CLBX-2\n\nHealth: 50\nWeight: 5 Tons\nHeat: 0.5\nCooldown: 0.45s\n\nPellet Rounds:\nDamage: 3\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 2\nDPS: 6.67\nHPS: 1.11\nDPH: 6\n\nSlug Rounds:\nDamage: 2\nVelocity: 35000\nDPS: 4.44\nHPS: 1.11\nDPH: 4\n\nAnti-Air Rounds:\nDamage: 2\nVelocity: 45000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 4\nDPS: 4.44\nHPS: 1.11\nDPH: 4\n\nDescription: A light shotgun like cannon that deals 50% more damage than a standard AC2 at the cost of spread. Clan versions weigh less, but run hotter and fire slower." )
		end
		if (node == NodeList["CLBX5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLBX5")
		DLabel:SetText( "CLBX-5\n\nHealth: 70\nWeight: 7 Tons\nHeat: 1.15\nCooldown: 1s\n\nPellet Rounds:\nDamage: 7.5\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 5\nDPS: 7.5\nHPS: 1.15\nDPH: 6.52\n\nSlug Rounds:\nDamage: 5\nVelocity: 30000\nDPS: 5\nHPS: 1.15\nDPH: 4.35\n\nAnti-Air Rounds:\nDamage: 5\nVelocity: 40000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 10\nDPS: 5\nHPS: 1.15\nDPH: 4.35\n\nDescription: A shotgun like cannon that splits its damage between 5 projectiles, spreading damage over the target area. Clan versions weigh less, but run hotter and fire slower." )
		end
		if (node == NodeList["CLBX10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLBX10")
		DLabel:SetText( "CLBX-10\n\nHealth: 100\nWeight: 10 Tons\nHeat: 2.75\nCooldown: 1.375s\n\nPellet Rounds:\nDamage: 15\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 10\nDPS: 10.91\nHPS: 2\nDPH: 5.45\n\nSlug Rounds:\nDamage: 10\nVelocity: 25000\nDPS: 7.27\nHPS: 2\nDPH: 3.64\n\nAnti-Air Rounds:\nDamage: 10\nVelocity: 35000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 20\nDPS: 7.27\nHPS: 2\nDPH: 3.64\n\nDescription: A large shotgun like cannon quite powerful up close. Clan versions weigh less, but run hotter and fire slower." )
		end
		if (node == NodeList["CLBX20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLBX20")
		DLabel:SetText( "CLBX-20\n\nHealth: 120\nWeight: 12 Tons\nHeat: 5.85\nCooldown: 2.33s\n\nPellet Rounds:\nDamage: 30\nVelocity: 45000\nSpread: +-0.85 Degrees\nProjectile Count: 20\nDPS: 12.875\nHPS: 2.51\nDPH: 5.13\n\nSlug Rounds:\nDamage: 20\nVelocity: 20000\nDPS: 8.58\nHPS: 2.51\nDPH: 3.42\n\nAnti-Air Rounds:\nDamage: 20\nVelocity: 30000\nProximity Range: 500 units\nSpread: +-1 Degree\nProjectile Count: 40\nDPS: 8.58\nHPS: 2.51\nDPH: 3.42\n\nDescription: A massive shotgun like cannon capable of devastating bursts up close, but rather lacking at range. Clan versions weigh less, but run hotter and fire slower." )
		end
		if (node == NodeList["CGauss"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CGauss")
		DLabel:SetText( "Clan Gauss Rifle\n\nHealth: 60\nWeight: 12 Tons\nDamage: 30\nHeat: 1\nCooldown: 4.125s\nVelocity: 60000\nDPS: 7.27\nHPS: 0.24\nDPH: 30\n\nDescription: A coilgun that puts out great damage for its weight, but cuts into the recharge times to save weight. It explodes when heavily damaged, though its ammo doesn't. Clan versions weigh considerably less, but have longer cooldowns." )
		end
		if (node == NodeList["CLightMachineGun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLightMachineGun")
		DLabel:SetText( "C-Light Machine Gun\n\nHealth: 1.25\nWeight: 0.125 Tons\nDamage: 0.075\nHeat: 0\nCooldown: 0.2s\nVelocity: 25000\nDPS: 0.375\nHPS: 0\nDPH: inf\n\nDescription: A lightened version of the machine gun with a higher velocity but weaker projectiles." )
		end
		if (node == NodeList["CMachineGun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CMachineGun")
		DLabel:SetText( "C-Machine Gun\n\nHealth: 2.5\nWeight: 0.25 Tons\nDamage: 0.15\nHeat: 0\nCooldown: 0.2s\nVelocity: 20000\nDPS: 0.75\nHPS: 0\nDPH: inf\n\nDescription: Light weapon able to deal constant DPS for no heat, can be devastating when massed, and remains powerful against unarmored troops even as a single gun." )
		end
		if (node == NodeList["CHeavyMachineGun"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CHeavyMachineGun")
		DLabel:SetText( "C-Heavy Machine Gun\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 0.3\nHeat: 0\nCooldown: 0.2s\nVelocity: 15000\nDPS: 1.5\nHPS: 0\nDPH: inf\n\nDescription: Heavy duty machine gun able to kill most infantry in a single shot, suffers from low velocity, but can be powerful against armor." )
		end
		if (node == NodeList["CSRM2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSRM2")
		DLabel:SetText( "CSRM-2\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 4\nHeat: 4\nCooldown: 6s\nVelocity: 10000\nDPS: 0.67\nHPS: 0.67\nDPH: 1\nProjectile Count: 2\n\nDescription: Small dumbfire missile launcher with a small, but decent DPS for its weight with minimal spread and no projectile drop." )
		end
		if (node == NodeList["CSRM4"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSRM4")
		DLabel:SetText( "CSRM-4\n\nHealth: 10\nWeight: 1 Ton\nDamage: 8\nHeat: 6\nCooldown: 6s\nVelocity: 10000\nDPS: 1.33\nHPS: 1\nDPH: 1.33\nProjectile Count: 4\n\nDescription: Medium dumbfire missile launcher with a respectable DPS for its weight with minimal spread and no projectile drop." )
		end
		if (node == NodeList["CSRM6"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSRM6")
		DLabel:SetText( "CSRM-6\n\nHealth: 1.5\nWeight: 1.5 Tons\nDamage: 12\nHeat: 8\nCooldown: 6s\nVelocity: 10000\nDPS: 2\nHPS: 1.33\nDPH: 1.5\nProjectile Count: 6\n\nDescription: Large dumbfire missile launcher with good DPS for its weight with minimal spread and no projectile drop." )
		end
		if (node == NodeList["CSSRM2"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSSRM2")
		DLabel:SetText( "Clan Streak SRM-2\n\nHealth: 10\nWeight: 1 Ton\nDamage: 4\nHeat: 4\nCooldown: 6s\nVelocity: 12500\nDPS: 0.67\nHPS: 0.67\nDPH: 1\nProjectile Count: 2\n\nDescription: Small missile launcher that locks onto a target it is pointed at, trades tonnage efficiency for accuracy." )
		end
		if (node == NodeList["CSSRM4"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSSRM4")
		DLabel:SetText( "Clan Streak SRM-4\n\nHealth: 20\nWeight: 2 Tons\nDamage: 8\nHeat: 6\nCooldown: 6s\nVelocity: 12500\nDPS: 1.33\nHPS: 1\nDPH: 1.33\nProjectile Count: 4\n\nDescription: Medium missile launcher that locks onto a target it is pointed at, trades tonnage efficiency for accuracy." )
		end
		if (node == NodeList["CSSRM6"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CSSRM6")
		DLabel:SetText( "Clan Streak SRM-6\n\nHealth: 30\nWeight: 3 Tons\nDamage: 12\nHeat: 8\nCooldown: 6s\nVelocity: 12500\nDPS: 2\nHPS: 1.33\nDPH: 1.5\nProjectile Count: 6\n\nDescription: Large missile launcher that locks onto a target it is pointed at, trades tonnage efficiency for accuracy." )
		end
		if (node == NodeList["CLRM5"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLRM5")
		DLabel:SetText( "CLRM-5\n\nHealth: 10\nWeight: 1 Tons\nDamage: 5\nHeat: 4\nCooldown: 4.5s\nVelocity: 4000\nDPS: 1.11\nHPS: 0.89\nDPH: 1.25\nProjectile Count: 5\n\nDescription: Tiny long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["CLRM10"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLRM10")
		DLabel:SetText( "CLRM-10\n\nHealth: 25\nWeight: 2.5 Tons\nDamage: 10\nHeat: 6\nCooldown: 4.5s\nVelocity: 4000\nDPS: 2.22\nHPS: 1.33\nDPH: 1.67\nProjectile Count: 10\n\nDescription: Small long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["CLRM15"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLRM15")
		DLabel:SetText( "CLRM-15\n\nHealth: 35\nWeight: 3.5 Tons\nDamage: 15\nHeat: 8\nCooldown: 4.5s\nVelocity: 4000\nDPS: 3.33\nHPS: 1.78\nDPH: 1.875\nProjectile Count: 15\n\nDescription: Medium long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["CLRM20"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CLRM20")
		DLabel:SetText( "CLRM-20\n\nHealth: 50\nWeight: 5 Tons\nDamage: 20\nHeat: 8\nCooldown: 4.5s\nVelocity: 4000\nDPS: 4.44\nHPS: 1.78\nDPH: 2.5\nProjectile Count: 20\n\nDescription: Large long range missile system that will lock onto targets infront of it or be given targets, can be made into a powerful indirect fire tool." )
		end
		if (node == NodeList["CTAG"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_xpulselaser")
		RunConsoleCommand("dakspawner_SpawnSettings", "TAG")
		DLabel:SetText( "TAG Laser\n\nHealth: 10\nWeight: 1 Ton\nDamage: 0 per second\nHeat: 0 per second\nLock Time: 1 second\n\nDescription: Designates targets and allows for anyone on the field with a radar to target them even through ECM." )
		end
		if (node == NodeList["CNARC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "CNARC")
		DLabel:SetText( "C-NARC\n\nHealth: 20\nWeight: 2 Tons\nDamage: 0.01\nHeat: 0\nCooldown: 5s\nVelocity: 10000\nLock Time: 30 seconds\n\nDescription: Designates targets and allows for anyone on the field with a radar to target them even through ECM." )
		end

		if (node == NodeList["ATM3"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM3")
		DLabel:SetText( "ATM-3\n\nHealth: 15\nWeight: 1.5 Tons\nDamage: ER:3, S:6, HE:3 + 6 Splash\nHeat: 3\nCooldown: 4s\nVelocity: 30000-15000-5000\nDPS: 0.75-1.5-2.25\nHPS: 0.75\nDPH: 1-2-3\nProjectile Count: 3\n\nDescription: Tiny Advanced Tactical Missile system capable of swapping ammo types between high explosive, standard, and extended range munitions. All rounds are capable of locking onto targets that are directly aimed at. Without lock HE has spread radius of 175 units, Standard 125, and ER 50. With a lock there is no spread." )
		end
		if (node == NodeList["ATM6"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM6")
		DLabel:SetText( "ATM-6\n\nHealth: 35\nWeight: 3.5 Tons\nDamage: ER:6, S:12, HE:6 + 12 Splash\nHeat: 5\nCooldown: 4s\nVelocity: 30000-15000-5000\nDPS: 1.5-3-4.5\nHPS: 1.25\nDPH: 1.2-2.4-3.6\nProjectile Count: 6\n\nDescription: Compact Advanced Tactical Missile system capable of swapping ammo types between high explosive, standard, and extended range munitions. All rounds are capable of locking onto targets that are directly aimed at. Without lock HE has spread radius of 175 units, Standard 125, and ER 50. With a lock there is no spread." )
		end
		if (node == NodeList["ATM9"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM9")
		DLabel:SetText( "ATM-9\n\nHealth: 50\nWeight: 5 Tons\nDamage: ER:9, S:18, HE:9 + 18 Splash\nHeat: 7\nCooldown: 4s\nVelocity: 30000-15000-5000\nDPS: 2.25-4.5-6.75\nHPS: 1.75\nDPH: 1.29-2.57-3.86\nProjectile Count: 9\n\nDescription: Mid-sized Advanced Tactical Missile system capable of swapping ammo types between high explosive, standard, and extended range munitions. All rounds are capable of locking onto targets that are directly aimed at. Without lock HE has spread radius of 175 units, Standard 125, and ER 50. With a lock there is no spread." )
		end
		if (node == NodeList["ATM12"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_launcher")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM12")
		DLabel:SetText( "ATM-12\n\nHealth: 70\nWeight: 7 Tons\nDamage: ER:12, S:24, HE:12 + 24 Splash\nHeat: 9\nCooldown: 4s\nVelocity: 30000-15000-5000\nDPS: 3-6-9\nHPS: 2.25\nDPH: 1.33-2.67-4\nProjectile Count: 12\n\nDescription: Large Advanced Tactical Missile system capable of swapping ammo types between high explosive, standard, and extended range munitions. All rounds are capable of locking onto targets that are directly aimed at. Without lock HE has spread radius of 175 units, Standard 125, and ER 50. With a lock there is no spread." )
		end

		if (node == NodeList["ATM3HEAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM3HEAmmo")
		DLabel:SetText( "ATM-3 HE Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 45\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM6HEAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM6HEAmmo")
		DLabel:SetText( "ATM-6 HE Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 23\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM9HEAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM9HEAmmo")
		DLabel:SetText( "ATM-9 HE Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 15\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM12HEAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM12HEAmmo")
		DLabel:SetText( "ATM-12 HE Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 12\n\nDescription: Makes guns shootier, doesn't explode." )
		end

		if (node == NodeList["ATM3SAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM3SAmmo")
		DLabel:SetText( "ATM-3 S Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 67\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM6SAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM6SAmmo")
		DLabel:SetText( "ATM-6 S Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 34\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM9SAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM9SAmmo")
		DLabel:SetText( "ATM-9 S Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 23\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM12SAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM12SAmmo")
		DLabel:SetText( "ATM-12 S Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 17\n\nDescription: Makes guns shootier, doesn't explode." )
		end

		if (node == NodeList["ATM3ERAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM3ERAmmo")
		DLabel:SetText( "ATM-3 ER Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 134\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM6ERAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM6ERAmmo")
		DLabel:SetText( "ATM-6 ER Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 67\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM9ERAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM9ERAmmo")
		DLabel:SetText( "ATM-9 ER Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 45\n\nDescription: Makes guns shootier, doesn't explode." )
		end
		if (node == NodeList["ATM12ERAmmo"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_ammo")
		RunConsoleCommand("dakspawner_SpawnSettings", "ATM12ERAmmo")
		DLabel:SetText( "ATM-12 ER Ammo\n\nHealth: 10\nWeight: 1 Ton\nAmmo: 34\n\nDescription: Makes guns shootier, doesn't explode." )
		end

		if (node == NodeList["HeavyFlamer"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyFlamer")
		DLabel:SetText( "Heavy Flamer\n\nHealth: 20\nWeight: 2 Tons\nDamage: 0.5\nHeat Damage: 0.6\nHeat: 0.36\nCooldown: 0.2s\nVelocity: 2500\nCooling Reduction Time: 0s \nHeatDPS: 3\nDPS: 2.5\nHPS: 1.8\nDPH: 1.39\n\nDescription: Heavy duty flamethrower with an added focus on damaging the enemy directly while maintaining the same increase in heating against enemies as a normal flamer." )
		end
		if (node == NodeList["CERFlamer"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_gun")
		RunConsoleCommand("dakspawner_SpawnSettings", "CERFlamer")
		DLabel:SetText( "C-ER Flamer\n\nHealth: 5\nWeight: 0.5 Tons\nDamage: 0.05\nHeat Damage: 0.6\nHeat: 0.36\nCooldown: 0.2s\nVelocity: 5000\nCooling Reduction Time: 0s \nHeatDPS: 3\nDPS: 0.25\nHPS: 1.8\nDPH: 0.139\n\nDescription: This flamethrower does half the normal damage but has double the velocity, leaving it rather effective at heating up enemies, yet nearly useless at damaging them directly." )
		end

		if (node == NodeList["MASC"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_masc")
		RunConsoleCommand("dakspawner_SpawnSettings", "MASC")
		DLabel:SetText( "MASC\n\nHealth: 30\nWeight: 3 Tons\n\nDescription: This piece of equipment only works with mechs. It is able to increase movement speed by 40% when active but generates heat when in use. The heat it generates goes up by 0.5 each second. When inactive it will begin to cool down but will not stop producing heat until its fully cooled off. Prolonged use can lead to temperatures too high for your mech to dissipate and can lead to catastrophic reactor failure." )
		end

		if (node == NodeList["Supercharger"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_supercharger")
		RunConsoleCommand("dakspawner_SpawnSettings", "Supercharger")
		DLabel:SetText( "Supercharger\n\nHealth: 50\nWeight: 3 Tons\n\nDescription: This piece of equipment can be used on any vehicle. It increases the engine power modifier of your reactor by 50%, leading to 50% faster movement speed, but reduces its base cooling value by 1 heat per second." )
		end

		if (node == NodeList["BAP"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_bap")
		RunConsoleCommand("dakspawner_SpawnSettings", "BAP")
		DLabel:SetText( "Beagle Active Probe\n\nHealth: 15\nWeight: 1.5 Tons\n\nDescription: This cluster of sensors is able to counter ECM within 5000 units automatically. The target's ECM will be disabled for an additional 5 seconds after you've moved 5000 units away." )
		end

		--Modules
		if (node == NodeList["Modules"]) then
		DLabel:SetText( "Modules\n\nPieces of equipment that grant various bonuses when linked to the reactor. All weigh one ton." )
		end
		if (node == NodeList["ArmorModules"]) then
		DLabel:SetText( "Armor Modules\n\nModules that change your armor properties. They can be mixed, leading to more advanced combinations of armor. Their properties are applied multiplicatively, so a 20% decrease ontop of a 20% decrease would be loss 36% instead of 40%." )
		end
		if (node == NodeList["WeaponModules"]) then
		DLabel:SetText( "Weapon Modules\n\nModules that boost weapon performance." )
		end
		if (node == NodeList["UtilityModules"]) then
		DLabel:SetText( "Utility Modules\n\nModules that boost utility performance." )
		end
		if (node == NodeList["HighYieldPayloads"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "HighYieldPayloads")
		DLabel:SetText( "High Yield Payloads Module\n\nYour engineers tune your ballistic weapons, PPCs, flamers, and plasma cannons to deal 10% more damage per shot. Has no effect on missiles." )
		end
		if (node == NodeList["MissileLoader"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "MissileLoader")
		DLabel:SetText( "Missile Loader Module\n\nAn advanced missile loading mechanism is added to your mech, allowing for 20% faster rate of fire in all launchers." )
		end
		if (node == NodeList["BeamFocus"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "BeamFocus")
		DLabel:SetText( "Beam Focus Module\n\nThrough use of high quality lenses and focusing mechanisms your lasers have 10% shorter durations and cooldowns." )
		end
		if (node == NodeList["TightWadding"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "TightWadding")
		DLabel:SetText( "Tight Wadding Module\n\nYour engineers pack the wadding extra tight for your LBX cannons and silver bullet gauss rifles, resulting in 40% less spread." )
		end
		if (node == NodeList["DumbfireFins"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "DumbfireFins")
		DLabel:SetText( "Dumbfire Fins Module\n\nFins are added to your missiles, decreasing their spread by 60% when dumbfired." )
		end
		if (node == NodeList["MissileExhaustVenting"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "MissileExhaustVenting")
		DLabel:SetText( "Missile Exhaust Venting Module\n\nYour missile launcher exhaust vents have been enlarged to reduce their heat generation by 10%." )
		end
		if (node == NodeList["LaserInsulation"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "LaserInsulation")
		DLabel:SetText( "Laser Insulation Module\n\nYour energy weapons are more insulated from the rest of the vehicle, causing them to generate 25% less heat, but leaving the heat trapped in them, reducing their health by 25% ." )
		end
		if (node == NodeList["PPCFrequencyScrambler"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "PPCFrequencyScrambler")
		DLabel:SetText( "PPC Frequency Scrambler Module\n\nYour PPCs have had their frequencies tuned to disrupt ECM at their impact area. A shot from your PPC will disable all ECM within 500 units of impact for 5 seconds." )
		end
		if (node == NodeList["WeaponShielding"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "WeaponShielding")
		DLabel:SetText( "Weapon Shielding Module\n\nLight armor plating has been attached to all weaponry on your vehicle, giving each 10 extra health." )
		end
		if (node == NodeList["HeavyArmor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeavyArmor")
		DLabel:SetText( "Heavy Armor Module\n\nThrough the use of thicker and more rigid armor plating you gain 30% more armor protection per ton at the cost of a 25% reduction in speed due to the restricting plate armor." )
		end
		if (node == NodeList["ReactiveArmor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "ReactiveArmor")
		DLabel:SetText( "Reactive Armor Module\n\nThis armor triggers micro explosions when hit with ballistic or missile weapons to reduce their effectiveness by 50%, however it provides 20% less protection than standard armor. It does not provide extra protection against explosions." )
		end
		if (node == NodeList["ReflectiveArmor"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "ReflectiveArmor")
		DLabel:SetText( "Reflective Armor Module\n\nThis armor is made of reflective but brittle plating that reduces energy damage by 50% but provides 20% less protection than normal armor." )
		end
		if (node == NodeList["EnhancedBAP"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "EnhancedBAP")
		DLabel:SetText( "Enhanced BAP Module\n\nThrough a hefty boost to your sensors array you've doubled the range in which your BAP is able to shut down ECM." )
		end
		if (node == NodeList["HeatsinkSupercooling"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "HeatsinkSupercooling")
		DLabel:SetText( "Heatsink Supercooling Module\n\nBy supercooling your heatsinks you were able to double the amount they increase your heatcap." )
		end
		if (node == NodeList["ReinforcedHeatsinks"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "ReinforcedHeatsinks")
		DLabel:SetText( "Reinforced Heatsinks Module\n\nYour engineers have reinforced your heatsinks with armor plating, allowing them to absorb double the damage of a normal heatsink." )
		end
		if (node == NodeList["EfficientLAMS"]) then
		RunConsoleCommand("dakspawner_SpawnEnt", "dak_module")
		RunConsoleCommand("dakspawner_SpawnSettings", "EfficientLAMS")
		DLabel:SetText( "Efficient LAMS Module\n\nYour LAMS has been tuned and dialed in to more efficiently destroy incoming missiles for half the heat." )
		end

		--GENERAL INFO
		if (node == NodeList["Mobility"]) then
		DLabel:SetText( "Mobility\n\nThe equipment used to get your vehicle moving." )
		end
		if (node == NodeList["Gyro"]) then
		DLabel:SetText( "Gyros\n\nGyroscope and gearing setups that allow mechs to move. Use the C menu to edit their properties, they must be tuned for the mech to reach their top speeds, otherwise they may end up slower than normal. Animation looks are also tuned via the C menu to user preference." )
		end
		if (node == NodeList["QGyro"]) then
		DLabel:SetText( "Quad Gyros\n\nGyroscope and gearing setups that allow mechs to move. Use the C menu to edit their properties, they must be tuned for the mech to reach their top speeds, otherwise they may end up slower than normal. Animation looks are also tuned via the C menu to user preference. These gyros are setup to work with 4 legs, they weigh less and are sturdier due to the lower complexity from the inherent stability of a quadruped." )
		end
		if (node == NodeList["JumpJet"]) then
		DLabel:SetText( "Jump Jets\n\nRocket boosters that can be attached to mechs to allow them to jump into the air." )
		end
		if (node == NodeList["ExtraMobility"]) then
		DLabel:SetText( "Extra Mobility\n\nExtras that can be added to vehicles to increase mobility." )
		end
		if (node == NodeList["VTOL"]) then
		DLabel:SetText( "VTOL Engines\n\nAircraft engines allowing for movement in all directions and hovering. Limited to 30 tons. No hitbox on these can be over 250hp/5tons." )
		end
		if (node == NodeList["Fighter"]) then
		DLabel:SetText( "Fighter Engines\n\nAircraft engines allowing for very fast speeds. Limited to 50 tons. No hitbox on these can be over 250hp/5tons." )
		end
		if (node == NodeList["Hoverdrive"]) then
		DLabel:SetText( "Hoverdrives\n\nHeavy but frail engines that allow your vehicle to hover at great speeds but are limited to 50 tons." )
		end
		if (node == NodeList["Motor"]) then
		DLabel:SetText( "Motors\n\nElectrical motors powered by the reactor that can propel your land vehicle forward." )
		end
		if (node == NodeList["Utilities"]) then
		DLabel:SetText( "Utilities\n\nThe basic equipment needed to run your vehicle." )
		end
		if (node == NodeList["Engines"]) then
		DLabel:SetText( "Reactors\n\nThe power source that runs all vehicle weaponry. Different engines have different max loads and cooling values and maximum heat capacities. Overheating your engine can cause it to explode when they go critical, igniting and damaging anything nearby. If over their max heat cap they will take damage equal to the amount of heat they are over their limit by. Standing in water increases cooling based on how deep you are in the water. They also automatically pool internal structure health at a rate of 12.5 per ton plus their own health." )
		end
		if (node == NodeList["Compact"]) then
		DLabel:SetText( "Compact Engines\n\nHeavy engines with extra high health and compact sizes, great for builds that need more space and have the extra tonnage to spare. Their sturdiness also offers higher max heat capacities than XLs or standards along with the highest base cooling rates. These provide a 20% boost to armor when used." )
		end
		if (node == NodeList["Standard"]) then
		DLabel:SetText( "Standard Engines\n\nThe basic engine type, has mid tier stats in all departments, good mix of tanking and weight savings. These provide a 10% boost to armor when used." )
		end
		if (node == NodeList["XL"]) then
		DLabel:SetText( "XL Engines\n\nExtra light engines that take up large amounts of space and have low health, great for gunboats focused solely on dishing out damage rather than being able to take it. These engines also have the lowest heat capacities and dissipation rates." )
		end
		if (node == NodeList["Weapons"]) then
		DLabel:SetText( "Weapons\n\nEquipment used to make things deader, point at things you want removed." )
		end
		if (node == NodeList["Energy"]) then
		DLabel:SetText( "Energy Weapons\n\nWeapons that require no ammo but generate large amounts of heat, generally also light." )
		end
		if (node == NodeList["Ballistic"]) then
		DLabel:SetText( "Ballistic Weapons\n\nGenerally heavy weapons that fire a variety of shells at opponents, only the heaviest generate much heat." )
		end
		if (node == NodeList["Missile"]) then
		DLabel:SetText( "Missile Weapons\n\nMissile launchers with a variety of tracking systems and sizes." )
		end
		if (node == NodeList["CEnergy"]) then
		DLabel:SetText( "Energy Weapons\n\nWeapons that require no ammo but generate large amounts of heat, generally also light." )
		end
		if (node == NodeList["CBallistic"]) then
		DLabel:SetText( "Ballistic Weapons\n\nGenerally heavy weapons that fire a variety of shells at opponents, only the heaviest generate much heat." )
		end
		if (node == NodeList["CMissile"]) then
		DLabel:SetText( "Missile Weapons\n\nMissile launchers with a variety of tracking systems and sizes." )
		end
		if (node == NodeList["Ammo"]) or (node == NodeList["BallisticAmmo"]) or (node == NodeList["MissileAmmo"]) then
		DLabel:SetText( "Ammo\n\nKeeps guns shooty." )
		end
		if (node == NodeList["Clan"]) then
		DLabel:SetText( "Clan Tech\n\nClan weaponry is often lighter than IS equipment, but runs hotter and has lower DPS leading to hit and fade tactics." )
		end
		if (node == NodeList["IS"]) then
		DLabel:SetText( "IS Tech\n\nIS weaponry is often heavier than Clan weaponry but runs cooler and focuses on DPS, leading to a more brawly nature." )
		end

	end
end

function TOOL:Think()
end
