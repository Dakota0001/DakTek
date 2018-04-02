AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true
ENT.AdminOnly = true

function ENT:Initialize()
	self.ShellList = {}
 	self.RemoveList = {}
	self.LastThink = CurTime()
	if self.BotType == nil then
		self.BotType = math.random(9,10)
	end
	if self.BotType == 1 then
		--ShotGunner
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_shotgun.mdl"
		self.ShootAnim = "shootSGs"
		self.FireSound = "weapons/famas/famas-1.wav"
		self:SetHealth(100)
		self.LongRange = 0

		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 350 --Distance away before running at you

		self.primaryrange = 350
		self.PrimaryNumberofShots = 10
		self.PrimarySpread = 10
		self.PrimaryForce = 10
		self.PrimaryDamage = 10
		self.PrimaryCooldown = 1.5

		self.meleerange = 50
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 2 then
		--Machine Gunner
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_mach_m249para.mdl"
		self.ShootAnim = "shootAR2s"
		self.FireSound = "weapons/m249/m249-1.wav"
		self:SetHealth(150)
		self.LongRange = 1
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 4500 --Distance away before running at you

		self.primaryrange = 4500
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 10
		self.PrimaryForce = 10
		self.PrimaryDamage = 10
		self.PrimaryCooldown = 0.05

		self.meleerange = 50
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 3 then
		--Assault Rifle
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_rif_ak47.mdl"
		self.ShootAnim = "shootAR2s"
		self.FireSound = "weapons/aug/aug-1.wav"
		self:SetHealth(125)
		self.LongRange = 1
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 5000 --Distance away before running at you

		self.primaryrange = 5000
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 5
		self.PrimaryForce = 10
		self.PrimaryDamage = 10
		self.PrimaryCooldown = 0.2

		self.meleerange = 50
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 4 then
		--Sniper
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_snip_awp.mdl"
		self.ShootAnim = "shootAR2s"
		self.FireSound = "weapons/g3sg1/g3sg1-1.wav"
		self:SetHealth(50)
		self.LongRange = 1
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 9000 --Distance away before running at you

		self.primaryrange = 9000
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 1
		self.PrimaryForce = 50
		self.PrimaryDamage = 50
		self.PrimaryCooldown = 1.5

		self.meleerange = 50
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 5 then
		--Melee
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_smg_ump45.mdl"
		self.ShootAnim = "shootSMG1s"
		self.FireSound = "weapons/p90/p90-1.wav"
		self:SetHealth(75)
		self.LongRange = 0
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 50 --Distance away before running at you

		self.primaryrange = 50
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 10
		self.PrimaryForce = 5
		self.PrimaryDamage = 5
		self.PrimaryCooldown = 0.1

		self.meleerange = 75
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 6 then
		--Grenades
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_smg_p90.mdl"
		self.ShootAnim = "shootSGs"
		self.FireSound = "npc/dog/dog_footstep_run7.wav"
		self:SetHealth(125)
		self.LongRange = 1
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 5000 --Distance away before running at you

		self.primaryrange = 5000
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 15
		self.PrimaryForce = 5
		self.PrimaryDamage = 5
		self.PrimaryCooldown = 4

		self.meleerange = 75
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 7 then
		--Rocketeer
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_rocket_launcher.mdl"
		self.ShootAnim = "shootAR2s"
		self.FireSound = "dak/SRM.wav"
		self:SetHealth(150)
		self.LongRange = 1
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 7500 --Distance away before running at you

		self.primaryrange = 7500
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 15
		self.PrimaryForce = 5
		self.PrimaryDamage = 5
		self.PrimaryCooldown = 3

		self.meleerange = 75
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 8 then
		--Flamer
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_irifle.mdl"
		self.ShootAnim = "shootSMG1s"
		self.FireSound = "dak/flamerfire.wav"
		self:SetHealth(100)
		self.LongRange = 1
		
		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 2000 --Distance away before running at you

		self.primaryrange = 2000
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 15
		self.PrimaryForce = 5
		self.PrimaryDamage = 5
		self.PrimaryCooldown = 0.25

		self.meleerange = 75
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 9 then
		--Assault Rifle
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_rif_ak47.mdl"
		self.ShootAnim = "shootAR2"
		self.FireSound = "weapons/aug/aug-1.wav"
		self:SetHealth(150)
		self.LongRange = 1
		
		self.SightDist = 5000	-- How far can it see
		self.AlertDist = 1500 --Tell allies in this range to target you if they have no target
		self.chaserange = 750 --Distance away before running at you

		self.primaryrange = 5000
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 5
		self.PrimaryForce = 10
		self.PrimaryDamage = 10
		self.PrimaryCooldown = 0.2

		self.meleerange = 50
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if self.BotType == 10 then
		--Sniper Rifle
		self:SetModel( "models/combine_super_soldier.mdl" )
		self.GunModel = "models/weapons/w_snip_awp.mdl"
		self.ShootAnim = "shootAR2"
		self.FireSound = "weapons/g3sg1/g3sg1-1.wav"
		self:SetHealth(50)
		self.LongRange = 1
		
		self.SightDist = 7500	-- How far can it see
		self.AlertDist = 1500 --Tell allies in this range to target you if they have no target
		self.chaserange = 1500 --Distance away before running at you

		self.primaryrange = 7500
		self.PrimaryNumberofShots = 1
		self.PrimarySpread = 5
		self.PrimaryForce = 10
		self.PrimaryDamage = 10
		self.PrimaryCooldown = 2.5

		self.meleerange = 50
		self.MeleeDamage = 25
		self.MeleeCooldown = 1
	end
	if SERVER then
		if self.DakTeam == nil then
			self.DakTeam = math.random(1,2)
			if self.DakTeam == 1 then
				self:SetColor(Color(255,0,0,255))
			else
				self:SetColor(Color(0,0,255,255))
			end
		end
	end
	--self:PhysicsInit(SOLID_BBOX)
	--self.Entity:SetCollisionBounds( Vector(-4,-4,0), Vector(8,8,72) ) 
	--self.SightDist = 100000
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )


	self.NadeCooldown = 10
	self.PrimaryLastFire = CurTime()
	self.MeleeLastFire = CurTime()
	self.NadeLastFire = CurTime()
	--print(table.ToString(self:GetSequenceList(),"stuff",true))
	self.HasTarget = 0
	self.revenge = 0
	self.grenadeout=0
	--PrintTable( self:GetAttachments() )
	self.LastAlert = CurTime()
	self.LastRun = CurTime()
	self.LastFind = CurTime()
	self.LastPos = self:GetPos()+Vector(0,0,10)
end

----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy( ent )
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end

function ENT:HaveEnemy()
	-- If our current enemy is valid
	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) and self:GetEnemy().DakTeam~=self.DakTeam ) then
		-- If the enemy is too far
		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.chaserange ) then
			-- If the enemy is lost then call FindEnemy() to look for a new one
			-- FindEnemy() will return true if an enemy is found, making this function return true
			return self:FindEnemy()
		-- If the enemy is dead( we have to check if its a player before we use Alive() )
		elseif not(self:GetEnemy():Health()>0) and self:GetEnemy().DakTeam~=self.DakTeam  then
			return self:FindEnemy()		-- Return false if the search finds nothing
		end
		-- The enemy is neither too far nor too dead so we can return true
		return true
	else
		-- The enemy isn't valid so lets look for a new one
		return self:FindEnemy()
	end
end

----------------------------------------------------
-- ENT:FindEnemy()
-- Returns true and sets our enemy if we find one
----------------------------------------------------
function ENT:FindEnemy()
	-- Search around us for entities
	-- This can be done any way you want eg. ents.FindInCone() to replicate eyesight
	--[[
	local Checks = 0
	local Filter = {}
	while Checks < 10 do
		local trace = {}
			trace.start = self:GetPos()+Vector(0,0,50)
			trace.endpos = self:GetPos()+Vector(0,0,50) + self:GetForward()*self.SightDist
			trace.filter = Filter
			trace.mins = Vector(-1,-1,-1)
			trace.maxs = Vector(1,1,1)
		local ExpTrace = util.TraceHull( trace )

		Filter[#Filter+1] = IgnoreEnt

		self:SetEnemy( v )
		return true
	end
	self:SetEnemy( nil )
	return false
	]]--

	local _ents = ents.FindInSphere( self:GetPos(), self.SightDist )
	--Here we loop through every entity the above search finds and see if it's the one we want
	for k, v in pairs( _ents ) do
	  	if v.DakTeam then
			if v:Health()>0 and v.DakTeam~=self.DakTeam then
				-- We found one so lets set it as our enemy and return true

				if IsValid(navmesh.GetNavArea( v:GetPos(), 100 )) then
					--print(self.loco:IsAreaTraversable( navmesh.GetNavArea( v:GetPos(), 20 ) ))
					if self.loco:IsAreaTraversable( navmesh.GetNavArea( v:GetPos(), 100 ) ) then
						self:SetEnemy( v )
						return true
					end
				end
			end
		end
	end
	--We found nothing so we will set our enemy as nil ( nothing ) and return false
	self:SetEnemy( nil )
	return false
end

--chase stuff down
function ENT:ChaseTarget(pos, options)		// Follow a target
	local options = options or {}
	local path = Path("Chase")
	path:SetMinLookAheadDistance(options.lookahead or 0.5)
	path:SetGoalTolerance(options.tolerance or 5)
	path:Compute(self, pos)
	if ( !path:IsValid() ) then return "failed" end
	if self.LongRange == 0 then
		while ( IsValid(self:GetEnemy()) ) and self:GetEnemy():GetPos():Distance(self:GetPos())>(self.meleerange-5) do
			--path:Compute(self, self:GetEnemy():GetPos())
			--path:Draw()
			if IsValid(path:GetCurrentGoal()) then
				self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
			end
			path:Chase(self, self:GetEnemy())
			-- If we're stuck then call the HandleStuck function and abandon
			--if ( self.loco:IsStuck() ) then
			--	self:HandleStuck();
			--	return "stuck"
			--end
			coroutine.yield()
		end
	else
		local SensorTrace = {}
        SensorTrace.start = self:GetPos()+Vector(0,0,50)
        SensorTrace.endpos = self:GetEnemy():GetPos()+Vector(0,0,50)
		SensorTrace.filter = {self}
        local Sensory = util.TraceLine( SensorTrace )		
		while ( IsValid(self:GetEnemy()) ) and (self:GetEnemy():GetPos():Distance(self:GetPos())>(self.primaryrange*0.5) or (Sensory.Entity~=self:GetEnemy())) do
			local SensorTrace = {}
	        SensorTrace.start = self:GetPos()+Vector(0,0,50)
	        SensorTrace.endpos = self:GetEnemy():GetPos()+Vector(0,0,50)
			SensorTrace.filter = {self}
	        local Sensory = util.TraceLine( SensorTrace )
			if Sensory.Entity==self:GetEnemy() or Sensory.Entity.DakTeam == self:GetEnemy().DakTeam then
				if IsValid(self:GetEnemy()) then
					self.Destination=self:GetEnemy():GetPos()
					--self.loco:FaceTowards( self.Destination )
				end
				break
			end
			if (Sensory.Entity.DakOwner) then
				if Sensory.Entity.DakOwner.DakTeam == self:GetEnemy().DakTeam then
					if IsValid(self:GetEnemy()) then
						self.Destination=self:GetEnemy():GetPos()
						--self.loco:FaceTowards( self.Destination )
					end
					break
				end
			end

			--if self:GetPos() == self.LastPos and path:GetAge()>1 then
			--	break
			--end
			self.LastPos = self:GetPos()
			--path:Compute(self, self:GetEnemy():GetPos())
			path:Draw()
			if IsValid(self) then
				if not(path:GetCurrentGoal() == nil) then
					self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
				else
					self.Destination=self:GetPos()+self:GetForward()*100
				end
				--if IsValid(path:GetCurrentGoal()) then
				--	self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
				--end
				path:Chase(self, self:GetEnemy())
				-- If we're stuck then call the HandleStuck function and abandon
				--if ( self.loco:IsStuck() ) then
				--	self:HandleStuck();
				--	return "stuck"
				--end
			end
			coroutine.yield()
		end
	end
	if IsValid(self:GetEnemy()) then
		self.Destination=self:GetEnemy():GetPos()
		--self.loco:FaceTowards( self.Destination )
	end
	return "ok"
end

--Stoppable move function
function ENT:MoveHere(pos, options)		// Follow a target
	local options = options or {}
	local path = Path("Follow")

	if self:GetPos():Distance(self.LastPos)<2 then 
		pos = self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 1000
	end

	pos = pos+Vector( math.Rand( -150, 150 ), math.Rand( -150, 150 ), 0 )

	path:SetMinLookAheadDistance(options.lookahead or 0.5)
	path:SetGoalTolerance(options.tolerance or 5)
	path:Compute(self, pos)
	if ( !path:IsValid() ) then return "failed" end

	while self:GetPos():Distance(pos)>200 and not(self:GetEnemy()) do
		if not(path:GetCurrentGoal() == nil) then
			self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
			self.loco:SetDesiredSpeed( math.Clamp(self:GetPos():Distance(path:GetCurrentGoal().pos),150,450) )
		else
			self.Destination=self:GetPos()+self:GetForward()*100
		end
		--if IsValid(path:GetCurrentGoal()) then
		--	self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
		--end
		path:Update(self)
		--path:Draw()
		-- If we're stuck then call the HandleStuck function and abandon
		--if ( self.loco:IsStuck() ) then
		--	self:HandleStuck();
		--	return "stuck"
		--end
		if self.LastPos==self:GetPos() then
			break
		end
		if IsValid(self:GetEnemy()) then
			break
		end
		self.LastPos = self:GetPos()
		coroutine.yield()
	end
	return "ok"
end

function ENT:CombatMove(pos, options)		// Follow a target
	local options = options or {}
	local path = Path("Follow")

	if self:GetPos():Distance(self.LastPos)<2 then 
		pos = self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 1000
	end

	pos = pos+Vector( math.Rand( -150, 150 ), math.Rand( -150, 150 ), 0 )

	path:SetMinLookAheadDistance(options.lookahead or 0.5)
	path:SetGoalTolerance(options.tolerance or 50)
	path:Compute(self, pos)
	if ( !path:IsValid() ) then return "failed" end

	while self:GetPos():Distance(pos)>200 do
		if not(path:GetCurrentGoal() == nil) then
			self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
		--	self.loco:SetDesiredSpeed( math.Clamp(self:GetPos():Distance(path:GetCurrentGoal().pos),150,450) )
		else
			self.Destination=self:GetPos()+self:GetForward()*100
		end
		--if IsValid(path:GetCurrentGoal()) then
		--	self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
		--end
		path:Update(self)
		--path:Draw()
		-- If we're stuck then call the HandleStuck function and abandon
		--if ( self.loco:IsStuck() ) then
		--	self:HandleStuck();
		--	return "stuck"
		--end
		if self.LastPos==self:GetPos() then
			if IsValid(self:GetEnemy()) then
				self.Destination= self:GetEnemy():GetPos()
				--self.loco:FaceTowards( self:GetEnemy():GetPos() )
			end
			break
		end
		if path:GetAge()>5 then
			break
		end
		self.LastPos = self:GetPos()
		coroutine.yield()
	end
	--if IsValid(self:GetEnemy()) then
	--	self.Destination= self:GetEnemy():GetPos()
	--	--self.loco:FaceTowards( self:GetEnemy():GetPos() )
	--end
	return "ok"
end

function ENT:OnInjured( info )
	local mins, maxs = self:GetHitBoxBounds( 0, 0 )
	if (info:GetDamagePosition().z>(self:GetAttachment(self:LookupAttachment("eyes")).Pos.z+mins.z)) and (info:GetDamagePosition().z<(self:GetAttachment(self:LookupAttachment("eyes")).Pos.z+maxs.z)) then
		info:AddDamage( info:GetDamage() )	
	end
	self.LastHitDir = (self:GetPos()-info:GetAttacker():GetPos()):GetNormalized()*info:GetDamage()*250
	self.LastHitPos = info:GetDamagePosition()
	if not(IsValid(self:GetEnemy())) then
		if IsValid(info:GetAttacker()) then
			if not(IsValid(self:GetEnemy())) and not(info:GetAttacker().DakTeam==self.DakTeam) then
				self:SetEnemy(info:GetAttacker())
			end
			
		end
	end
	local SoundList = {"npc/metropolice/pain1.wav","npc/metropolice/pain2.wav","npc/metropolice/pain3.wav","npc/metropolice/pain4.wav"}
	self:EmitSound( SoundList[math.random(4)], 100, 100, 1, 2 )
end
----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------
function ENT:RunBehaviour()
	-- This function is called when the entity is first spawned. It acts as a giant loop that will run as long as the NPC exists
	--self.loco:SetMaxYawRate( 250 )
	while ( true ) do
		if self.IsBurning == 1 then
			while self:IsOnFire() do
				self:PlaySequenceAndWait("bugbait_hit")
			end
			self.IsBurning = 0
		end
		--self.loco:SetMaxYawRate( 250 )
		-- Lets use the above mentioned functions to see if we have/can find a enemy
		if ( IsValid(self:GetEnemy()) and IsValid(self) ) then
			-- Now that we have an enemy, the code in this block will run
			----self.loco:FaceTowards( self:GetEnemy():GetPos() )	-- Face our enemy
			if self.LastAlert+15<CurTime() then
				local _ents = ents.FindInSphere( self:GetPos(), self.AlertDist )
				self.Allies = 0
				for k, v in pairs( _ents ) do
					if ( v:GetClass()=="dak_bot" and not(v==self) ) and v.DakTeam == self.DakTeam then
						if not(IsValid(v:GetEnemy())) then
							v:SetEnemy(self:GetEnemy())
							self.Allies = 1
						end
					end
				end
				if self.Allies == 1 then
					self:EmitSound( "npc/metropolice/takedown.wav", 120, 100, 1, 2 )
					self:PlaySequenceAndWait( "signal_advance" )
				end
				self.LastAlert = CurTime()
			end
			if not(IsValid(self:GetEnemy())) then
				self:HaveEnemy()
			else
				local SensorTrace = {}
		        SensorTrace.start = self:GetPos()+Vector(0,0,50)
		        SensorTrace.endpos = self:GetEnemy():GetPos()+Vector(0,0,50)
				SensorTrace.filter = {self}
		        local Sensory = util.TraceLine( SensorTrace )

				self.loco:SetDesiredSpeed( 450 )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
				self.loco:SetAcceleration( 550 )			-- We are going to run at the enemy quickly, so we want to accelerate really fast
				self.loco:SetDeceleration( 550 )
				if IsValid(self:GetEnemy()) then
					if self:GetEnemy():GetPos():Distance(self:GetPos()) > self.chaserange or Sensory.Entity~=self:GetEnemy() or (Sensory.Entity.DakTeam and Sensory.Entity.DakTeam~=self.DakTeam) or Sensory.Entity.DakOwner ~= self:GetEnemy() then
						--self:PlaySequenceAndWait( "signal_advance" )	-- Get out of the pose
						self:SetSequence( "RunALL" )
						self:ResetSequenceInfo()
						self:SetCycle( 0 )
						self:SetPlaybackRate( 1.2 );
						if self.Allies == 0 or Sensory.Entity~=self:GetEnemy() or Sensory.Entity.DakOwner ~= self:GetEnemy() or (Sensory.Entity.DakTeam and Sensory.Entity.DakTeam==self.DakTeam) then
							self:ChaseTarget(self:GetEnemy():GetPos())
						end
						--self.loco:FaceTowards(self:GetEnemy():GetPos())
					end
				end
				self.loco:SetAcceleration( 550 )			-- Set this back to its default since we are done chasing the enemy
				self.loco:SetDeceleration( 550 )
				
				if IsValid(self:GetEnemy()) then
					self:SetSequence( "CombatIdle1" )
				else
					self:SetSequence( "Idle1" )
				end
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
					--ATTACK
				if SERVER then
					if self.revenge == 1 then
						self:PlaySequenceAndWait( "signal_halt" )
						self:SuiExplosion()
					else
					    if ( IsValid(self:GetEnemy()) ) then
					    	if IsValid(self:GetEnemy()) then
							    if self:GetEnemy():GetPos():Distance(self:GetPos()) <= self.meleerange then
							    	self.Destination= self:GetEnemy():GetPos()
							    	coroutine.wait( 0.1 )
							    	self:SetSequence( "melee_gunhit" )
									self:ResetSequenceInfo()
									self:SetCycle( 0 )
									self:SetPlaybackRate( 1.0 );
									coroutine.wait( 0.55 )
							        self:FireMelee()
							        coroutine.wait( 0.6 )
							        self:FirePrimary()
							        if self.BotType == 5 then
							        	coroutine.wait( 0.1 )
								        self:FirePrimary()
								        coroutine.wait( 0.1 )
								        self:FirePrimary()
							        end
							        if IsValid(self:GetEnemy()) then
										self:SetSequence( "CombatIdle1" )
									else
										self:SetSequence( "Idle1" )
									end
							    end
							end
							if IsValid(self:GetEnemy()) then
							    if self:GetEnemy():GetPos():Distance(self:GetPos()) < self.primaryrange and self:GetEnemy():GetPos():Distance(self:GetPos()) > self.meleerange then
							    	self.Destination= self:GetEnemy():GetPos()
							    	coroutine.wait(math.abs(math.abs(self:GetAngles().yaw)-math.abs((self:GetEnemy():GetPos()-self:GetPos()):Angle().yaw))/250)
							        if self.NadeLastFire+self.NadeCooldown<CurTime() and math.random(1,20)==20 then
								    	self:SetSequence( "grenThrow" )
										self:ResetSequenceInfo()
										self:SetCycle( 0 )
										self:SetPlaybackRate( 1.0 );
										coroutine.wait( 0.5 )
										if self.BotType==9 or self.BotType==10 then
											self:ThrowATNade()
										else
								        	self:ThrowNade()
								        end
							        else
							        	if self.BotType==6 or self.BotType==7 or self.BotType==8 or self.BotType==9 or self.BotType==10 then
							        		if self.BotType==6 then
							        			if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
								        			self:LaunchNade()
								        			coroutine.wait( 0.1 )
									        		self:LaunchNade()
									        		coroutine.wait( 0.1 )
									        		self:LaunchNade()
									        		coroutine.wait( 0.1 )
									        		self:LaunchNade()
									        		coroutine.wait( 0.1 )
									        		self:LaunchNade()
									        		self.PrimaryLastFire = CurTime()
									        	end
							        		end
							        		if self.BotType==7 then
							        			self:FireRocket()
							        		end
							        		if self.BotType==8 then
							        			self:FireFire()
							        		end
							        		if self.BotType==9 then
							        			--fire burst then move on
							        			if math.random(1,4) == 1 then
							        				self:PlaySequenceAndWait( "Combat_stand_to_crouch" )
													self:SetSequence( "crouch_aim_ar2" )
													for i=1, math.random(3,6) do
								        				self:FireRifle()
									        			coroutine.wait( 0.2 )
								        			end
								        			coroutine.wait( 0.5 )
													self:PlaySequenceAndWait( "Crouch_to_combat_stand" )
												else
													self:SetSequence( "CombatIdle1" )
													for i=1, math.random(3,6) do
								        				self:FireRifle()
									        			coroutine.wait( 0.2 )
								        			end
												end
							        			self:SetSequence( "RunAll" )
												self:ResetSequenceInfo()
												self:SetCycle( 0 )
												self:SetPlaybackRate( 1 );
												self.loco:SetDesiredSpeed( 400 )		-- Walk speed
												local navtable = navmesh.Find( self:GetPos(), 1000, 0, 0 )
												if navtable[math.random( 1, table.Count(navtable) )] then
													self:CombatMove( navtable[math.random( 1, table.Count(navtable) )]:GetRandomPoint() )
												end
												--self:StartActivity( ACT_IDLE )
												if IsValid(self:GetEnemy()) then
													self:SetSequence( "CombatIdle1" )
												else
													self:SetSequence( "Idle1" )
												end
												self:ResetSequenceInfo()
												self:SetCycle( 0 )
												self:SetPlaybackRate( 1 );
							        		end
							        		if self.BotType==10 then
							        			if math.random(1,2) == 1 then
							        				self:PlaySequenceAndWait( "Combat_stand_to_crouch" )
													self:SetSequence( "crouch_aim_ar2" )
													self:FireSniperRifle()
													coroutine.wait( 0.5 )
													self:PlaySequenceAndWait( "Crouch_to_combat_stand" )
												else
													self:SetSequence( "CombatIdle1" )
													self:FireSniperRifle()
												end
							        		end
							        	else
								        	self:FirePrimary()
								        end
							        end
							    end
							end
						end
					end
				end
			end
		else
			if not(IsValid(self:GetEnemy())) then
				--if not(self:HaveEnemy()) then
				--	self:FindEnemy()
				--end
				-- Since we can't find an enemy, lets wander
				-- Its the same code used in Garry's test bot
				local Missions = ents.FindByClass( "prop_thumper" )
				if #Missions > 0 then
					self:SetSequence( "RunAll" )
					self:ResetSequenceInfo()
					self:SetCycle( 0 )
					self:SetPlaybackRate( 1 );
					self.loco:SetDesiredSpeed( 400 )
					if not(self.HitLeft==true or self.HitRight==true) then
						self:MoveHere(Missions[math.random(1,#Missions)]:GetPos())
					end
					if self.HitLeft then
						self:MoveHere(self:GetPos()+self:GetRight()*10)
						self.HitLeft = false
					end
					if self.HitRight then
						self:MoveHere(self:GetPos()-self:GetRight()*10)
						self.HitRight = false
					end
					if IsValid(self:GetEnemy()) then
						self:SetSequence( "CombatIdle1" )
					else
						self:SetSequence( "Idle1" )
					end
					self:ResetSequenceInfo()
					self:SetCycle( 0 )
					self:SetPlaybackRate( 1 );
				else
					--self:StartActivity( ACT_WALK_AIM )			-- Walk anmimation
					self:SetSequence( "Walk_all" )
					self:ResetSequenceInfo()
					self:SetCycle( 0 )
					self:SetPlaybackRate( 1 );
					self.loco:SetDesiredSpeed( 125 )		-- Walk speed
					local navtable = navmesh.Find( self:GetPos(), 400, 0, 0 )
					self:MoveHere( navtable[math.random( 1, table.Count(navtable) )]:GetRandomPoint() )
					--self:StartActivity( ACT_IDLE )
					if IsValid(self:GetEnemy()) then
						self:SetSequence( "CombatIdle1" )
					else
						self:SetSequence( "Idle1" )
					end
					self:ResetSequenceInfo()
					self:SetCycle( 0 )
					self:SetPlaybackRate( 1 );
				end
			end
		end
		-- At this point in the code the bot has stopped chasing the player or finished walking to a random spot
		-- Using this next function we are going to wait 2 seconds until we go ahead and repeat it
		
		if IsValid(self:GetEnemy()) then
			coroutine.wait( self.PrimaryCooldown )
		else
			coroutine.wait( 3 )
		end
	end

end

function ENT:GiveWeapon(wep)
	local Gun = ents.Create("prop_physics")
	Gun:SetModel(wep)
	local pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
	Gun:SetOwner(self)
	Gun:SetPos(pos)
	Gun:Spawn()
	Gun.DontPickUp = true
	Gun:SetSolid(SOLID_NONE)	
	Gun:SetParent(self)
	Gun:Fire("setparentattachment", "anim_attachment_RH")
	Gun:AddEffects(EF_BONEMERGE)
	self.Weapon = Gun
end

function ENT:FirePrimary()
	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			if self:GetEnemy():IsPlayer() then
				if self:WorldToLocalAngles(((self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos)-self:GetAttachment(self:LookupAttachment("eyes")).Pos):Angle()).yaw < 5 then
					self:SetSequence( self.ShootAnim )
					self:ResetSequenceInfo()
					self:SetCycle( 0 )
					self:SetPlaybackRate( 1 );
					local bullet = {} 
					bullet.Num = self.PrimaryNumberofShots 
					bullet.Src = self:GetAttachment(self:LookupAttachment("eyes")).Pos
					bullet.Dir = (self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos)-self:GetAttachment(self:LookupAttachment("eyes")).Pos
					bullet.Spread = Vector( self.PrimarySpread , self.PrimarySpread, 0) 
					bullet.Tracer = 1
					bullet.TracerName = "Tracer" 
					bullet.Force = self.PrimaryForce 
					bullet.Damage = self.PrimaryDamage/2 --divide by two since they are set to always headshot
					self:FireBullets(bullet)

					local effectdata = EffectData()
					effectdata:SetOrigin( self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos +((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*25 )
					effectdata:SetAngles( ((self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos)-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle() )
					effectdata:SetEntity(self)
					effectdata:SetScale( 0.1 )
					--if CLIENT then
						util.Effect( "daksmallballisticfire", effectdata )
					--end

					self:EmitSound( self.FireSound, 140, 100, 1, 2)
					self.PrimaryLastFire = CurTime()
				end
			else
				self:SetSequence( self.ShootAnim )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
				local bullet = {} 
				bullet.Num = self.PrimaryNumberofShots 
				bullet.Src = self:GetAttachment(self:LookupAttachment("eyes")).Pos
				bullet.Dir = (self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("eyes")).Pos
				bullet.Spread = Vector( self.PrimarySpread , self.PrimarySpread, 0) 
				bullet.Tracer = 1
				bullet.TracerName = "Tracer" 
				bullet.Force = self.PrimaryForce 
				bullet.Damage = self.PrimaryDamage
				self:FireBullets(bullet)



				local effectdata = EffectData()
				effectdata:SetOrigin( self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*25 )
				effectdata:SetAngles( ((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle() )
				effectdata:SetEntity(self)
				effectdata:SetScale( 0.1 )
				util.Effect( "daksmallballisticfire", effectdata )

				self:EmitSound( self.FireSound, 140, 100, 1, 2)
				self.PrimaryLastFire = CurTime()
			end
		end
	end
end

function ENT:FireMelee()
	if self.MeleeLastFire+self.MeleeCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			local trace = {}
			trace.start = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
			trace.endpos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*self.meleerange
			self.Filters = {}
			table.insert(self.Filters,self)
			trace.filter = self.Filters
			local Hit = util.TraceLine( trace )
			if not(Hit.Entity==NULL) then
				Hit.Entity:SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*75+Vector(0,0,300))
				local Pain = DamageInfo()
				Pain:SetDamageForce( ((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*500 )
				Pain:SetDamage(self.MeleeDamage)
				Pain:SetAttacker( self )
				Pain:SetInflictor( self )
				Pain:SetReportedPosition( Hit.HitPos )
				Pain:SetDamagePosition( Hit.Entity:GetPos() )
				Pain:SetDamageType(DMG_CLUB)
				Hit.Entity:TakeDamageInfo( Pain )
			end
			self.MeleeLastFire = CurTime()
		end
	end
end

function ENT:ThrowNade()
	if self.NadeLastFire+self.NadeCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			local Nade = ents.Create("prop_physics")
				Nade:SetModel("models/Items/grenadeAmmo.mdl")
				util.SpriteTrail( Nade, -1, Color(255,0,0,150), true, 5, 1, 1, 1 / ( 5 + 1 ) * 0.5, "trails/smoke.vmt" )
				Nade:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos)
				Nade:Spawn()
				Nade.DakHealth = 1000
				Nade.DakMaxHealth = 1000
				Nade.DakNade = 1
				if self:GetEnemy():GetPos():Distance(self:GetPos()) > 1500 then
					Nade:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos):GetNormalized()*self:GetEnemy():GetPos():Distance(self:GetPos())*1.2+Vector(0,0,500))
				else
					Nade:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos):GetNormalized()*self:GetEnemy():GetPos():Distance(self:GetPos())*0.9+Vector(0,0,500))
				end
				timer.Simple( 2, function()
					if IsValid(Nade) then
						Explosion(Nade,Nade:GetPos(),250,15)
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
			self:EmitSound( "npc/metropolice/vo/grenade.wav", 120, 100, 1, 2)
			self.NadeLastFire = CurTime()
		end
	end
end

function ENT:ThrowATNade()
	if self.NadeLastFire+self.NadeCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			local Nade = ents.Create("prop_physics")
				Nade:SetModel("models/Items/grenadeAmmo.mdl")
				util.SpriteTrail( Nade, -1, Color(255,0,0,150), true, 5, 1, 1, 1 / ( 5 + 1 ) * 0.5, "trails/smoke.vmt" )
				Nade:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos)
				Nade:Spawn()
				Nade.DakHealth = 1000
				Nade.DakMaxHealth = 1000
				Nade.DakNade = 1
				if self:GetEnemy():GetPos():Distance(self:GetPos()) > 1500 then
					Nade:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos):GetNormalized()*self:GetEnemy():GetPos():Distance(self:GetPos())*1.2+Vector(0,0,500))
				else
					Nade:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos):GetNormalized()*self:GetEnemy():GetPos():Distance(self:GetPos())*0.9+Vector(0,0,500))
				end
				timer.Simple( 2, function()
					if IsValid(Nade) then

						DTExplosionNade(Nade,Nade:GetPos(),100,250,60,25,self)

						local effectdata = EffectData()
						effectdata:SetOrigin(Nade:GetPos())
						effectdata:SetEntity(Nade)
						effectdata:SetAttachment(1)
						effectdata:SetMagnitude(.5)
						effectdata:SetScale(250)
						util.Effect("dakscalingexplosion", effectdata)
						Nade:EmitSound( "dak/ammoexplode.wav", 100, 75, 1)
						Nade:Remove()
					end
				end )
			self:EmitSound( "npc/metropolice/vo/grenade.wav", 120, 100, 1, 2)
			self.NadeLastFire = CurTime()
		end
	end
end

function ENT:LaunchNade()
	
		if IsValid(self:GetEnemy()) then
				self:SetSequence( self.ShootAnim )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
			local Nade = ents.Create("prop_physics")
			Nade:SetModel("models/Items/AR2_Grenade.mdl")
			util.SpriteTrail( Nade, -1, Color(255,0,0,150), true, 5, 1, 1, 1 / ( 5 + 1 ) * 0.5, "trails/smoke.vmt" )
			Nade:SetAngles(self:GetForward():Angle())
			Nade:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos)
			Nade:Spawn()
			Nade.DakHealth = 1000
			Nade.DakMaxHealth = 1000
			Nade.DakNade = 1
			Nade:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()+Vector(math.Rand(-50,50),math.Rand(-50,50),math.Rand(-50,50)+self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*self:GetEnemy():GetPos():Distance(self:GetPos())*0.675+Vector(0,0,500))
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
			
			self:EmitSound( self.FireSound, 140, 100, 1, 2)
		end
	
end

function ENT:FireRocket()

	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			self:SetSequence( self.ShootAnim )
			self:ResetSequenceInfo()
			self:SetCycle( 0 )
			self:SetPlaybackRate( 1 );
			local Nade = ents.Create("dak_atmhe")
			Nade.DakTarget = self:GetEnemy()
			Nade.DakGun = self
			self.DakOwner = self
			Nade.DakFireTime = CurTime()
			Nade:SetAngles(((self:GetEnemy():GetPos()+Vector(0,0,1500))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle())
			Nade:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos)
			Nade:Spawn()
			self.PrimaryLastFire = CurTime()
			self:EmitSound( self.FireSound, 140, 100, 1, 2)
		end
	end
end

function ENT:FireFire()

	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			self:SetSequence( self.ShootAnim )
			self:ResetSequenceInfo()
			self:SetCycle( 0 )
			self:SetPlaybackRate( 1 );
			local Nade = ents.Create("dak_erflamerbolt")
			Nade.DakTarget = self:GetEnemy()
			Nade.DakGun = self
			self.DakOwner = self
			Nade.DakFireTime = CurTime()
			Nade:SetAngles(((self:GetEnemy():GetPos()+Vector(0,0,50))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle())
			Nade:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos)
			Nade:Spawn()
			self.PrimaryLastFire = CurTime()
			self:EmitSound( self.FireSound, 140, 100, 1, 6)
		end
	end
end

function ENT:FireRifle()
	if IsValid(self:GetEnemy()) then
		local FriendlyTrace = {}
	        FriendlyTrace.start = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
	        FriendlyTrace.endpos = self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos
			FriendlyTrace.filter = {self}
		    FriendlyTrace.Mins = Vector(-10,-10,-10)
			FriendlyTrace.Maxs = Vector(10,10,10)
	    local CheckFire = util.TraceHull( FriendlyTrace )
	    if CheckFire.Entity then
	    	if CheckFire.Entity.DakTeam == self.DakTeam then
	    		self.NoFire = 1
	    	else
	    		self.NoFire = 0
	    	end
	    end
	end
	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() and not(self.NoFire == 1) then
		if IsValid(self:GetEnemy()) then
			local shell = {}
			shell.Pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
			shell.Ang = ((self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos)-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle() + Angle(math.Rand(-0.75,0.75),math.Rand(-0.75,0.75),math.Rand(-0.75,0.75))
			shell.DakTrail = "dakshelltrail"
			shell.DakVelocity = 31494
			shell.DakDamage = 0.0762
			shell.DakMass = 7.62*0.1
			shell.DakIsPellet = false
			shell.DakSplashDamage = 0
			shell.DakPenetration = 15.24
			shell.DakExplosive = false
			shell.DakBlastRadius = 0
			shell.DakPenSounds = {"daktanks/daksmallpen1.wav","daktanks/daksmallpen2.wav","daktanks/daksmallpen3.wav","daktanks/daksmallpen4.wav"}
			shell.DakBasePenetration = 15.24
			shell.DakCaliber = 7.62
			shell.DakFireSound = "daktanks/7mm.wav"
			shell.DakFirePitch = 100
			shell.DakGun = self
			shell.DakGun.DakOwner = self
			shell.Filter = {self}
			shell.LifeTime = 0
			shell.Gravity = 0
			if self.DakName == "Flamethrower" then
				shell.DakIsFlame = 1
			end
			self.ShellList[#self.ShellList+1] = shell
			self.PrimaryLastFire = CurTime()
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*25 )
			effectdata:SetAngles( ((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle() )
			effectdata:SetEntity(self)
			effectdata:SetScale( 0.1 )
			util.Effect( "daksmallballisticfire", effectdata )
			self:EmitSound( self.FireSound, 140, 100, 1, 2)
		end
	end
end

function ENT:FireSniperRifle()
	if IsValid(self:GetEnemy()) then
		local FriendlyTrace = {}
	        FriendlyTrace.start = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
	        FriendlyTrace.endpos = self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos
			FriendlyTrace.filter = {self}
		    FriendlyTrace.Mins = Vector(-10,-10,-10)
			FriendlyTrace.Maxs = Vector(10,10,10)
	    local CheckFire = util.TraceHull( FriendlyTrace )
	    if CheckFire.Entity then
	    	if CheckFire.Entity.DakTeam == self.DakTeam then
	    		self.NoFire = 1
	    	else
	    		self.NoFire = 0
	    	end
	    end
	end
	if self.PrimaryLastFire+self.PrimaryCooldown<CurTime() and not(self.NoFire == 1) then
		if IsValid(self:GetEnemy()) then
			local shell = {}
			shell.Pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
			shell.Ang = ((self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes")).Pos)-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle() + Angle(math.Rand(-0.75,0.75),math.Rand(-0.75,0.75),math.Rand(-0.75,0.75))
			shell.DakTrail = "dakshelltrail"
			shell.DakVelocity = 51494
			shell.DakDamage = 0.125
			shell.DakMass = 12.5*0.1
			shell.DakIsPellet = false
			shell.DakSplashDamage = 0
			shell.DakPenetration = 25
			shell.DakExplosive = false
			shell.DakBlastRadius = 0
			shell.DakPenSounds = {"daktanks/daksmallpen1.wav","daktanks/daksmallpen2.wav","daktanks/daksmallpen3.wav","daktanks/daksmallpen4.wav"}
			shell.DakBasePenetration = 25
			shell.DakCaliber = 12.5
			shell.DakFireSound = "daktanks/12mm.wav"
			shell.DakFirePitch = 100
			shell.DakGun = self
			shell.DakGun.DakOwner = self
			shell.Filter = {self}
			shell.LifeTime = 0
			shell.Gravity = 0
			if self.DakName == "Flamethrower" then
				shell.DakIsFlame = 1
			end
			self.ShellList[#self.ShellList+1] = shell
			self.PrimaryLastFire = CurTime()
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):GetNormalized()*25 )
			effectdata:SetAngles( ((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos):Angle() )
			effectdata:SetEntity(self)
			effectdata:SetScale( 0.1 )
			util.Effect( "daksmallballisticfire", effectdata )
			self:EmitSound( self.FireSound, 140, 100, 1, 2)
		end
	end
end

function ENT:SuiExplosion()
	Explosion(self,self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos,250,15)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetEntity(self)
	effectdata:SetAttachment(1)
	effectdata:SetMagnitude(.5)
	effectdata:SetScale(200)
	util.Effect("dakatmexplosion", effectdata)
	self:EmitSound( "dak/longtomimpact.wav", 140, 150, 1, 2)
	local body = ents.Create( "prop_ragdoll" )
	body:SetPos( self:GetPos() )
	body:SetModel( self:GetModel() )
	body:Spawn()
	body.DakHealth=1000000
	body.DakMaxHealth=1000000
	self:Remove()
	local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
	body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
	timer.Simple( 5, function()
		body:Remove()
	end )
end

--setup buddy system
function ENT:Use( activator, caller, type, value )
end

function ENT:OnIgnite()
	self.IsBurning = 1
end

function ENT:Think()

	--if not(self.SPPOwner==nil) then			
	--	if self.SPPOwner:IsAdmin()==false and not(game.SinglePlayer()) then
	--		self:Remove()
	--	end
	--end
	if SERVER then
		if self.LastAnim == nil then
			self.LastAnim = 0
		end
		--if (self.LastAnim+0.1) < CurTime() then
			if self.loco:GetVelocity() == Vector(0,0,0) then
				if IsValid(self:GetEnemy()) then
					self.loco:FaceTowards( self:GetEnemy():GetPos() )
				end
			else
				if self.Destination then
					self.loco:FaceTowards( self.Destination )
				end
			end
			--self.LastAnim = CurTime()
		--end
	end
	if SERVER then
		if (self.LastThink+0.1) < CurTime() then

			for i = 1, #self.ShellList do
				self.ShellList[i].LifeTime = self.ShellList[i].LifeTime + 0.1
				self.ShellList[i].Gravity = physenv.GetGravity()*self.ShellList[i].LifeTime

				local trace = {}
					trace.start = self.ShellList[i].Pos
					trace.endpos = self.ShellList[i].Pos + (self.ShellList[i].Ang:Forward()*self.ShellList[i].DakVelocity*0.1) + (self.ShellList[i].Gravity*0.1)
					trace.filter = self.ShellList[i].Filter
					trace.mins = Vector(-1,-1,-1)
					trace.maxs = Vector(1,1,1)
				local ShellTrace = util.TraceHull( trace )

				local effectdata = EffectData()
				effectdata:SetStart(ShellTrace.StartPos)
				effectdata:SetOrigin(ShellTrace.HitPos)
				effectdata:SetScale((self.ShellList[i].DakCaliber*0.0393701))
				util.Effect("dakballistictracer", effectdata)

				if ShellTrace.Hit then
					DTShellHit(ShellTrace.StartPos,ShellTrace.HitPos,ShellTrace.Entity,self.ShellList[i],ShellTrace.HitNormal)
				end

				if self.ShellList[i].DieTime then
					--self.RemoveList[#self.RemoveList+1] = i
					if self.ShellList[i].DieTime+1.5<CurTime()then
						self.RemoveList[#self.RemoveList+1] = i
					end
				end

				if self.ShellList[i].RemoveNow == 1 then
					self.RemoveList[#self.RemoveList+1] = i
				end

				self.ShellList[i].Pos = self.ShellList[i].Pos + (self.ShellList[i].Ang:Forward()*self.ShellList[i].DakVelocity*0.1) + (self.ShellList[i].Gravity*0.1)
			end
			
			if #self.RemoveList > 0 then
				for i = 1, #self.RemoveList do
					table.remove( self.ShellList, self.RemoveList[i] )
				end
			end

			self.RemoveList = {}


			local ForwardTrace = {}
	        ForwardTrace.start = self:GetPos()+Vector(0,0,50)
	        ForwardTrace.endpos = self:GetPos()+self:GetForward()*100
			ForwardTrace.filter = {self}
	        local DoorOpener = util.TraceLine( ForwardTrace )
	        if IsValid(DoorOpener.Entity) then
		        if DoorOpener.Entity:GetClass() == "prop_door_rotating" then
		        	DoorOpener.Entity:Remove()
					--DoorOpener.Entity:Fire("OpenAwayFrom")
					--DoorOpener.Entity:Fire("setanimation","open","0")
					--self.OpenedDoor = 1
				end
			end
			--if not(IsValid(navmesh.GetNavArea( self:GetPos(), 20 ))) then
			--	self:Remove()
			--end
			if (self.LastFind+1) < CurTime() then
				if not(IsValid(self:GetEnemy())) then
					self:FindEnemy()
				else
					if IsValid(navmesh.GetNavArea( self:GetEnemy():GetPos(), 100 )) then
						if not(self.loco:IsAreaTraversable( navmesh.GetNavArea( self:GetEnemy():GetPos(), 100 ) )) then
							self:FindEnemy()
						end
					else
						self:FindEnemy()
					end
				end
				self.LastFind = CurTime()
			end
			if not IsValid(self.Weapon) then
		        self:GiveWeapon(self.GunModel)
		    end
			--
			if self.revenge == 1 then
				if self.grenadeout==0 then
			        local Bomb = ents.Create("prop_physics")
					Bomb:SetModel("models/weapons/w_npcnade.mdl")
					pos2 = self:GetPos()+self:GetForward()*4.5
					Bomb:SetOwner(self)
					Bomb:SetPos(pos2)
					Bomb:Spawn()
					Bomb.DontPickUp = true
					Bomb:SetSolid(SOLID_NONE)	
					self.grenadeout=1
					Bomb:FollowBone( self, self:LookupBone( "ValveBiped.Bip01_L_Hand" ) )
			    end
			end
			if self.revenge == 0 and self:Health()<=0 then

				local body = ents.Create( "prop_ragdoll" )
				body:SetPos( self:GetPos() )
				body:SetModel( self:GetModel() )
				body:Spawn()
				body.DakHealth=1000000
				body.DakMaxHealth=1000000
				if self.DakTeam == 1 then
					if RedTeamBots then
						RedTeamBots = RedTeamBots - 1
					end
				end
				if self.DakTeam == 2 then
					if BlueTeamBots then
						BlueTeamBots = BlueTeamBots - 1
					end
				end
				if not(self.LastHitDir==nil) and not(self.LastHitPos==nil) then
					body:GetPhysicsObject():ApplyForceOffset( self.LastHitDir, self.LastHitPos )
				end
				self:Remove()
				local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
				body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
				timer.Simple( 5, function()
					body:Remove()
				end )

			end
			self.LastThink = CurTime()
		end
	end
end

function ENT:OnKilled( dmginfo )
	hook.Run( "OnNPCKilled", self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )
	if math.random(1,3) == 1 then
		if self.LongRange == 0 then
			if IsValid(self:GetEnemy()) then
				self.revenge = 1
			end
		end
	end
	if self.revenge == 1 then
		timer.Simple( 5, function()
			if IsValid(self) then
				self:SuiExplosion()
			end
		end )
	end
	if self.DakTeam == 1 then
		if RedTeamBots then
			RedTeamBots = RedTeamBots - 1
		end
	end
	if self.DakTeam == 2 then
		if BlueTeamBots then
			BlueTeamBots = BlueTeamBots - 1
		end
	end
end

list.Set( "NPC", "dak_bot", {
	Name = "DakBot",
	Class = "dak_bot",
	Category = "DakTek"
} )

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
									body.DakHealth=1000000
									body.DakMaxHealth=1000000
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
				if not(Ent.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]==nil) then
					if Ent.DamageList[i]:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:HasGodMode()==false then	
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

function CheckClip(Ent, HitPos)
	if not (Ent:GetClass() == "prop_physics") or (Ent.ClipData == nil) then return false end
	
	local HitClip = false
	local normal
	local origin
	for i=1, #Ent.ClipData do
		normal = Ent:LocalToWorldAngles(Ent.ClipData[i]["n"]):Forward()
		origin = Ent:LocalToWorld(Ent.ClipData[i]["n"]:Forward()*Ent.ClipData[i]["d"])
		HitClip = HitClip or normal:Dot((origin - HitPos):GetNormalized()) > 0.25
		if HitClip then return true end
	end
	return HitClip
end

function DTExplosionNade(Ent,Pos,Damage,Radius,Caliber,Pen,Owner)
	local traces = math.Round(Caliber/2)
	local Filter = {Ent}
	for i=1, traces do
		local Direction = VectorRand()
		local trace = {}
			trace.start = Pos
			trace.endpos = Pos + Direction*Radius*10
			trace.filter = Filter
			trace.mins = Vector(-1,-1,-1)
			trace.maxs = Vector(1,1,1)
		local ExpTrace = util.TraceHull( trace )

		if ExpTrace.Entity:IsValid() then
			if ExpTrace.Entity == self then
				ExpTrace.Entity =  NULL
			end 
		end
		if hook.Run("DakTankDamageCheck", ExpTrace.Entity, Owner) ~= false and ExpTrace.HitPos:Distance(Pos)<=Radius then
			--decals don't like using the adjusted by normal Pos
			util.Decal( "Impact.Concrete", Ent:GetPos(), Ent:GetPos()+(Direction*Radius), Ent)
			if ExpTrace.Entity:IsValid() and not(ExpTrace.Entity:IsPlayer()) and not(ExpTrace.Entity:IsNPC()) and not(ExpTrace.Entity:GetClass()=="dak_bot") then
				if (CheckClip(ExpTrace.Entity,ExpTrace.HitPos)) or (ExpTrace.Entity:GetPhysicsObject():GetMass()<=1 or (ExpTrace.Entity.DakIsTread==1) and not(ExpTrace.Entity:IsVehicle()) and not(ExpTrace.Entity.IsDakTekFutureTech==1)) then
					if ExpTrace.Entity.DakArmor == nil then
						DakTekTankEditionSetupNewEnt(ExpTrace.Entity)
					end
					local SA = ExpTrace.Entity:GetPhysicsObject():GetSurfaceArea()
					if ExpTrace.Entity.IsDakTekFutureTech == 1 then
						ExpTrace.Entity.DakArmor = 1000
					else
						if SA == nil then
							--Volume = (4/3)*math.pi*math.pow( ExpTrace.Entity:OBBMaxs().x, 3 )
							ExpTrace.Entity.DakArmor = ExpTrace.Entity:OBBMaxs().x/2
							ExpTrace.Entity.DakIsTread = 1
						else
							if ExpTrace.Entity:GetClass()=="prop_physics" then 
								if not(ExpTrace.Entity.DakArmor == 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25) then
									ExpTrace.Entity.DakArmor = 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25
								end
							end
						end
					end
					DamageEXP(Ent,Filter,ExpTrace.Entity,Pos,Damage,Radius,Caliber,Pen,Owner,Direction)
				else
					if ExpTrace.Entity.DakArmor == nil then
						DakTekTankEditionSetupNewEnt(ExpTrace.Entity)
					end
					local SA = ExpTrace.Entity:GetPhysicsObject():GetSurfaceArea()
					if ExpTrace.Entity.IsDakTekFutureTech == 1 then
						ExpTrace.Entity.DakArmor = 1000
					else
						if SA == nil then
							--Volume = (4/3)*math.pi*math.pow( ExpTrace.Entity:OBBMaxs().x, 3 )
							ExpTrace.Entity.DakArmor = ExpTrace.Entity:OBBMaxs().x/2
							ExpTrace.Entity.DakIsTread = 1
						else
							if ExpTrace.Entity:GetClass()=="prop_physics" then 
								if not(ExpTrace.Entity.DakArmor == 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25) then
									ExpTrace.Entity.DakArmor = 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25
								end
							end
						end
					end
					
					ExpTrace.Entity.DakLastDamagePos = ExpTrace.HitPos

					if not(ExpTrace.Entity.SPPOwner==nil) then			
						if ExpTrace.Entity.SPPOwner:HasGodMode()==false and ExpTrace.Entity.DakIsTread == nil then	
							local HPPerc = (ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor))/ExpTrace.Entity.DakMaxHealth
							ExpTrace.Entity.DakHealth = ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor)
							if not(ExpTrace.Entity.DakRed == nil) then 
								ExpTrace.Entity:SetColor(Color(ExpTrace.Entity.DakRed*HPPerc,ExpTrace.Entity.DakGreen*HPPerc,ExpTrace.Entity.DakBlue*HPPerc,ExpTrace.Entity:GetColor().a))
							end
						end
					else
						local HPPerc = (ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor))/ExpTrace.Entity.DakMaxHealth
						ExpTrace.Entity.DakHealth = ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor)
						if not(ExpTrace.Entity.DakRed == nil) then 
							ExpTrace.Entity:SetColor(Color(ExpTrace.Entity.DakRed*HPPerc,ExpTrace.Entity.DakGreen*HPPerc,ExpTrace.Entity.DakBlue*HPPerc,ExpTrace.Entity:GetColor().a))
						end
					end
					if ExpTrace.Entity.DakHealth <= 0 and ExpTrace.Entity.DakPooled==0 then
						Ent.salvage = ents.Create( "dak_tesalvage" )
						Ent.salvage.DakModel = ExpTrace.Entity:GetModel()
						Ent.salvage:SetPos( ExpTrace.Entity:GetPos())
						Ent.salvage:SetAngles( ExpTrace.Entity:GetAngles())
						Ent.salvage:Spawn()
						ExpTrace.Entity:Remove()
					end
				end
			end
			if ExpTrace.Entity:IsValid() then
				if ExpTrace.Entity:IsPlayer() or ExpTrace.Entity:IsNPC() or ExpTrace.Entity:GetClass() == "dak_bot" then
					if ExpTrace.Entity:GetClass() == "dak_bot" then
						ExpTrace.Entity:SetHealth(ExpTrace.Entity:Health() - (Damage/traces)*500)
						if ExpTrace.Entity:Health() <= 0 and Ent.revenge==0 then
							local body = ents.Create( "prop_ragdoll" )
							body:SetPos( ExpTrace.Entity:GetPos() )
							body:SetModel( ExpTrace.Entity:GetModel() )
							body:Spawn()
							ExpTrace.Entity:Remove()
							local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
							body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
							timer.Simple( 5, function()
								body:Remove()
							end )
						end
					else
						local Pain = DamageInfo()
						Pain:SetDamageForce( Direction*(Damage/traces)*5000*Ent:GetPhysicsObject():GetMass() )
						Pain:SetDamage( (Damage/traces)*500 )
						Pain:SetAttacker( Owner )
						Pain:SetInflictor( Ent )
						Pain:SetReportedPosition( Ent:GetPos() )
						Pain:SetDamagePosition( ExpTrace.Entity:GetPos() )
						Pain:SetDamageType(DMG_BLAST)
						ExpTrace.Entity:TakeDamageInfo( Pain )
					end
				end
			end

			if (ExpTrace.Entity:IsValid()) and not(ExpTrace.Entity:IsNPC()) and not(ExpTrace.Entity:IsPlayer()) and not(ExpTrace.Entity:GetClass()=="dak_bot") then
				if(ExpTrace.Entity:GetParent():IsValid()) then
					if(ExpTrace.Entity:GetParent():GetParent():IsValid()) then
						ExpTrace.Entity:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (ExpTrace.HitPos-Pos):GetNormalized()*(Damage/traces)*3.5*ExpTrace.Entity:GetParent():GetParent():GetPhysicsObject():GetMass()*(1-(ExpTrace.HitPos:Distance(Pos)/1000))  )
					end
				end
				if not(ExpTrace.Entity:GetParent():IsValid()) then
					ExpTrace.Entity:GetPhysicsObject():ApplyForceCenter( (ExpTrace.HitPos-Pos):GetNormalized()*(Damage/traces)*3.5*ExpTrace.Entity:GetPhysicsObject():GetMass()*(1-(ExpTrace.HitPos:Distance(Pos)/1000))  )
				end
			end		
		end
	end
end

function DamageEXP(Ent,Filter,IgnoreEnt,Pos,Damage,Radius,Caliber,Pen,Owner,Direction)
	local traces = math.Round(Caliber/2)
	local trace = {}
		trace.start = Pos
		trace.endpos = Pos + Direction*Radius*10
		Filter[#Filter+1] = IgnoreEnt
		trace.filter = Filter
		trace.mins = Vector(-1,-1,-1)
		trace.maxs = Vector(1,1,1)
	local ExpTrace = util.TraceHull( trace )

	if ExpTrace.Entity:IsValid() then
		if ExpTrace.Entity == self then
			ExpTrace.Entity =  NULL
		end 
	end

	if hook.Run("DakTankDamageCheck", ExpTrace.Entity, Owner) ~= false and ExpTrace.HitPos:Distance(Pos)<=Radius then
		--decals don't like using the adjusted by normal Pos
		util.Decal( "Impact.Concrete", Ent:GetPos(), Ent:GetPos()+(Direction*Radius), Ent)
		if ExpTrace.Entity:IsValid() and not(ExpTrace.Entity:IsPlayer()) and not(ExpTrace.Entity:IsNPC()) and not(ExpTrace.Entity:GetClass()=="dak_bot") then
			if (CheckClip(ExpTrace.Entity,ExpTrace.HitPos)) or (ExpTrace.Entity:GetPhysicsObject():GetMass()<=1 or (ExpTrace.Entity.DakIsTread==1) and not(ExpTrace.Entity:IsVehicle()) and not(ExpTrace.Entity.IsDakTekFutureTech==1)) then
				if ExpTrace.Entity.DakArmor == nil then
					DakTekTankEditionSetupNewEnt(ExpTrace.Entity)
				end
				local SA = ExpTrace.Entity:GetPhysicsObject():GetSurfaceArea()
				if ExpTrace.Entity.IsDakTekFutureTech == 1 then
					ExpTrace.Entity.DakArmor = 1000
				else
					if SA == nil then
						--Volume = (4/3)*math.pi*math.pow( ExpTrace.Entity:OBBMaxs().x, 3 )
						ExpTrace.Entity.DakArmor = ExpTrace.Entity:OBBMaxs().x/2
						ExpTrace.Entity.DakIsTread = 1
					else
						if ExpTrace.Entity:GetClass()=="prop_physics" then 
							if not(ExpTrace.Entity.DakArmor == 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25) then
								ExpTrace.Entity.DakArmor = 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25
							end
						end
					end
				end
				DamageEXP(Ent,Filter,ExpTrace.Entity,Pos,Damage,Radius,Caliber,Pen,Owner,Direction)
			else
				if ExpTrace.Entity.DakArmor == nil then
					DakTekTankEditionSetupNewEnt(ExpTrace.Entity)
				end
				local SA = ExpTrace.Entity:GetPhysicsObject():GetSurfaceArea()
				if ExpTrace.Entity.IsDakTekFutureTech == 1 then
					ExpTrace.Entity.DakArmor = 1000
				else
					if SA == nil then
						--Volume = (4/3)*math.pi*math.pow( ExpTrace.Entity:OBBMaxs().x, 3 )
						ExpTrace.Entity.DakArmor = ExpTrace.Entity:OBBMaxs().x/2
						ExpTrace.Entity.DakIsTread = 1
					else
						if ExpTrace.Entity:GetClass()=="prop_physics" then 
							if not(ExpTrace.Entity.DakArmor == 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25) then
								ExpTrace.Entity.DakArmor = 7.8125*(ExpTrace.Entity:GetPhysicsObject():GetMass()/4.6311781)*(288/SA) - ExpTrace.Entity.DakBurnStacks*0.25
							end
						end
					end
				end
				
				ExpTrace.Entity.DakLastDamagePos = ExpTrace.HitPos

				if not(ExpTrace.Entity.SPPOwner==nil) then			
					if ExpTrace.Entity.SPPOwner:HasGodMode()==false and ExpTrace.Entity.DakIsTread == nil then	
						local HPPerc = (ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor))/ExpTrace.Entity.DakMaxHealth
						ExpTrace.Entity.DakHealth = ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor)
						if not(ExpTrace.Entity.DakRed == nil) then 
							ExpTrace.Entity:SetColor(Color(ExpTrace.Entity.DakRed*HPPerc,ExpTrace.Entity.DakGreen*HPPerc,ExpTrace.Entity.DakBlue*HPPerc,ExpTrace.Entity:GetColor().a))
						end
					end
				else
					local HPPerc = (ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor))/ExpTrace.Entity.DakMaxHealth
					ExpTrace.Entity.DakHealth = ExpTrace.Entity.DakHealth- (Damage/traces)*2*(Pen/ExpTrace.Entity.DakArmor)
					if not(ExpTrace.Entity.DakRed == nil) then 
						ExpTrace.Entity:SetColor(Color(ExpTrace.Entity.DakRed*HPPerc,ExpTrace.Entity.DakGreen*HPPerc,ExpTrace.Entity.DakBlue*HPPerc,ExpTrace.Entity:GetColor().a))
					end
				end
				if ExpTrace.Entity.DakHealth <= 0 and ExpTrace.Entity.DakPooled==0 then
					Ent.salvage = ents.Create( "dak_tesalvage" )
					Ent.salvage.DakModel = ExpTrace.Entity:GetModel()
					Ent.salvage:SetPos( ExpTrace.Entity:GetPos())
					Ent.salvage:SetAngles( ExpTrace.Entity:GetAngles())
					Ent.salvage:Spawn()
					ExpTrace.Entity:Remove()
				end
			end
		end
		if ExpTrace.Entity:IsValid() then
			if ExpTrace.Entity:IsPlayer() or ExpTrace.Entity:IsNPC() or ExpTrace.Entity:GetClass() == "dak_bot" then
				if ExpTrace.Entity:GetClass() == "dak_bot" then
					ExpTrace.Entity:SetHealth(ExpTrace.Entity:Health() - (Damage/traces)*500)
					if ExpTrace.Entity:Health() <= 0 and Ent.revenge==0 then
						local body = ents.Create( "prop_ragdoll" )
						body:SetPos( ExpTrace.Entity:GetPos() )
						body:SetModel( ExpTrace.Entity:GetModel() )
						body:Spawn()
						ExpTrace.Entity:Remove()
						local SoundList = {"npc/metropolice/die1.wav","npc/metropolice/die2.wav","npc/metropolice/die3.wav","npc/metropolice/die4.wav","npc/metropolice/pain4.wav"}
						body:EmitSound( SoundList[math.random(5)], 100, 100, 1, 2 )
						timer.Simple( 5, function()
							body:Remove()
						end )
					end
				else
					local Pain = DamageInfo()
					Pain:SetDamageForce( Direction*(Damage/traces)*5000*Ent:GetPhysicsObject():GetMass() )
					Pain:SetDamage( (Damage/traces)*500 )
					Pain:SetAttacker( Owner )
					Pain:SetInflictor( Ent )
					Pain:SetReportedPosition( Ent:GetPos() )
					Pain:SetDamagePosition( ExpTrace.Entity:GetPos() )
					Pain:SetDamageType(DMG_BLAST)
					ExpTrace.Entity:TakeDamageInfo( Pain )
				end
			end
		end
		if (ExpTrace.Entity:IsValid()) and not(ExpTrace.Entity:IsNPC()) and not(ExpTrace.Entity:IsPlayer()) then
			if(ExpTrace.Entity:GetParent():IsValid()) then
				if(ExpTrace.Entity:GetParent():GetParent():IsValid()) then
					ExpTrace.Entity:GetParent():GetParent():GetPhysicsObject():ApplyForceCenter( (ExpTrace.HitPos-Pos):GetNormalized()*(Damage/traces)*3.5*ExpTrace.Entity:GetParent():GetParent():GetPhysicsObject():GetMass()*(1-(ExpTrace.HitPos:Distance(Pos)/1000))  )
				end
			end
			if not(ExpTrace.Entity:GetParent():IsValid()) then
				ExpTrace.Entity:GetPhysicsObject():ApplyForceCenter( (ExpTrace.HitPos-Pos):GetNormalized()*(Damage/traces)*3.5*ExpTrace.Entity:GetPhysicsObject():GetMass()*(1-(ExpTrace.HitPos:Distance(Pos)/1000))  )
			end
		end		
	end
end