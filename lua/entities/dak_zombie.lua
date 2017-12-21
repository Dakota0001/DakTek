AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true
ENT.AdminOnly = true

function ENT:Initialize()
	sound.Add( {
		name = "dak_zombie_gurgle",
		channel = 2,
		volume = 1,
		level = 100,
		pitch = { 95, 110 },
		sound = "npc/fast_zombie/gurgle_loop1.wav"
	} )
	sound.Add( {
		name = "dak_zombie_gurgle_quiet",
		channel = 2,
		volume = 0.3,
		level = 100,
		pitch = { 70, 90 },
		sound = "npc/fast_zombie/gurgle_loop1.wav"
	} )
	if self.BotType == nil then
		self.BotType = math.random(4,4)
	end
	if self.BotType == 1 then
		--Runner
		self:SetModel( "models/zombie/fast.mdl" )
		self.GunModel = ""
		self.ShootAnim = "shootSGs"
		self.FireSound = ""
		self:SetHealth(100)
		self.LongRange = 0

		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 40 --Distance away before running at you

		self.primaryrange =  0
		self.PrimaryNumberofShots = 0
		self.PrimarySpread = 0
		self.PrimaryForce = 0
		self.PrimaryDamage = 0
		self.PrimaryCooldown = 0.25

		self.meleerange = 50
		self.MeleeDamage = 10
		self.MeleeCooldown = 0.0

		self.ChaseSpeed = 550
	end
	if self.BotType == 2 then
		--Spitter
		self:SetModel( "models/zombie/fast.mdl" )
		self.GunModel = ""
		self.ShootAnim = "BR2_Roar"
		self.FireSound = ""
		self:SetHealth(100)
		self.LongRange = 1

		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 1000 --Distance away before running at you

		self.primaryrange =  1000
		self.PrimaryNumberofShots = 0
		self.PrimarySpread = 0
		self.PrimaryForce = 0
		self.PrimaryDamage = 0
		self.PrimaryCooldown = 1

		self.meleerange = 50
		self.MeleeDamage = 10
		self.MeleeCooldown = 0.25

		self.ChaseSpeed = 550
	end
	if self.BotType == 3 then
		--Giant
		self:SetModel( "models/zombie/fast.mdl" )
		self.GunModel = ""
		self.ShootAnim = "shootSGs"
		self.FireSound = ""
		self:SetHealth(500)
		self.LongRange = 0
		self:SetModelScale( 2, 0 )


		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 70 --Distance away before running at you

		self.primaryrange =  0
		self.PrimaryNumberofShots = 0
		self.PrimarySpread = 0
		self.PrimaryForce = 0
		self.PrimaryDamage = 0
		self.PrimaryCooldown = 0.25

		self.meleerange = 80
		self.MeleeDamage = 40
		self.MeleeCooldown = 0.0

		self.ChaseSpeed = 1100
	end
	if self.BotType == 4 then
		--Super Giant
		self:SetModel( "models/zombie/fast.mdl" )
		self.GunModel = ""
		self.ShootAnim = "shootSGs"
		self.FireSound = ""
		self:SetHealth(20000)
		self.LongRange = 0
		self:SetModelScale( 2, 0 )


		self.SightDist = 10000	-- How far can it see
		self.AlertDist = 2000 --Tell allies in this range to target you if they have no target
		self.chaserange = 150 --Distance away before running at you

		self.primaryrange =  0
		self.PrimaryNumberofShots = 0
		self.PrimarySpread = 0
		self.PrimaryForce = 0
		self.PrimaryDamage = 0
		self.PrimaryCooldown = 0.25

		self.meleerange = 160
		self.MeleeDamage = 80
		self.MeleeCooldown = 0.0

		self.ChaseSpeed = 2200
	end

	--self:PhysicsInit(SOLID_BBOX)
	--self.Entity:SetCollisionBounds( Vector(-8,-8,0), Vector(8,8,64) ) 
	self.SightDist = 100000


	self.NadeCooldown = 1
	self.PrimaryLastFire = CurTime()
	self.MeleeLastFire = CurTime()
	self.NadeLastFire = CurTime()
	--print(table.ToString(self:GetSequenceList(),"stuff",true))
	self.HasTarget = 0
	self.Destination = self:GetPos()+self:GetForward()
	self.RunAway = 0
	self.revenge = 0
	self.grenadeout = 0
	self.NewTargetGot = 0
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

----------------------------------------------------
-- ENT:HaveEnemy()
-- Returns true if we have an enemy and checks if the enemy is valid for targetting
----------------------------------------------------
function ENT:HaveEnemy()
	-- If our current enemy is valid
	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
		-- If the enemy is too far
		local trace = {}
		trace.start = self:GetAttachment(self:LookupAttachment("head")).Pos
		trace.endpos = self:GetAttachment(self:LookupAttachment("head")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,1.5*self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("head")).Pos):GetNormalized()*self.SightDist
		self.Filters = ents.FindByClass( "dak_zombie" )
		table.Add( self.Filters, ents.FindByClass( "dak_salvage" ) )
		table.Add( self.Filters, ents.FindByClass( "prop_ragdoll" ) )
		table.Add( self.Filters, ents.FindByModel("models/Items/grenadeAmmo.mdl") )
		table.Add( self.Filters, ents.FindByModel("models/Items/AR2_Grenade.mdl") )
		trace.filter = self.Filters
		local Hit = util.TraceLine( trace )
		if self:GetEnemy()==Hit.Entity then
			return true
		else
			if IsValid(Hit.Entity) then
				if not(Hit.Entity:IsPlayer() or Hit.Entity:IsNPC()) then
					if Hit.Entity.DakHealth <= 0 then
						return self:FindEnemy()
					end
				end
				if IsValid(Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]) then
					if Hit.Entity:GetTable().OnDieFunctions.GetCountUpdate.Args[1]:IsWorld() then
						return self:FindEnemy()
					else
						self:SetEnemy(Hit.Entity)
						return true
					end
				else
					if Hit.Entity:IsPlayer() or Hit.Entity:IsNPC() then
						self:SetEnemy(Hit.Entity)
						return true
					end
				end
			else
				return self:FindEnemy()
			end
		end
	else
		return self:FindEnemy()
	end
end

----------------------------------------------------
-- ENT:FindEnemy()
-- Returns true and sets our enemy if we find one
----------------------------------------------------
function FindNearestEntity( pos, range )
    local nearestEnt;
    for i, entity in ipairs( player.GetAll() ) do
        local distance = pos:Distance( entity:GetPos() );
        if( distance <= range ) then
            nearestEnt = entity;
            range = distance;  
        end
    end
    return nearestEnt; 
end

function ENT:FindEnemy()
	--PrintTable( self:GetSequenceList() )
	local Target = FindNearestEntity( self:GetPos(), self.SightDist )
	if IsValid(Target) then
		if Target:GetPos():Distance(self:GetPos())<=self.SightDist then
			if Target:IsPlayer() then
				if Target:Alive() then
					if not(IsValid(self:GetEnemy())) then
						self.NewTargetGot = 1
					end
					self:SetEnemy( Target )
					self.HasTarget = 1
					return true
				else
					self:SetEnemy( nil )
					self.HasTarget = 0
					self.NewTargetGot = 0
				end
			end
		else
			self:SetEnemy( nil )
			self.HasTarget = 0
			self.NewTargetGot = 0
		end
	else
		self:SetEnemy( nil )
		self.HasTarget = 0
		self.NewTargetGot = 0
	end
	return false
end

--chase stuff down
function ENT:ChaseTarget(pos, options)		// Follow a target
	local options = options or {}
	local path = Path("Chase")
	path:SetMinLookAheadDistance(options.lookahead or 300)
	path:SetGoalTolerance(options.tolerance or 20)
	path:Compute(self, pos)
	if self.LongRange == 0 then
		while ( IsValid(self:GetEnemy()) ) and self:GetEnemy():GetPos():Distance(self:GetPos())>(self.meleerange-5) and self.NewTargetGot == 0 do
			path:Compute(self, self:GetEnemy():GetPos())
			--path:Draw()
			self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
			path:Chase(self, self:GetEnemy())
			-- If we're stuck then call the HandleStuck function and abandon
			if ( self.loco:IsStuck() ) then
				self:HandleStuck();
				return "stuck"
			end
			coroutine.yield()
		end
	else
		while ( IsValid(self:GetEnemy()) ) and self:GetEnemy():GetPos():Distance(self:GetPos())>(self.primaryrange*0.5) and self.NewTargetGot == 0 do
			path:Compute(self, self:GetEnemy():GetPos())
			--path:Draw()
			self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
			path:Chase(self, self:GetEnemy())
			-- If we're stuck then call the HandleStuck function and abandon
			if ( self.loco:IsStuck() ) then
				self:HandleStuck();
				return "stuck"
			end
			coroutine.yield()
		end
	end
	return "ok"
end

--Stoppable move function
function ENT:MoveHere(pos, options)		// Follow a target
	local options = options or {}
	local path = Path("Chase")

	if self:GetPos():Distance(self.LastPos)<2 then 
		pos = self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 1000
	end

	path:SetMinLookAheadDistance(options.lookahead or 300)
	path:SetGoalTolerance(options.tolerance or 20)
	path:Compute(self, pos)
	while self.NewTargetGot == 0 and self:GetPos():Distance(pos)>125  do
		path:Compute(self, pos)
		--path:Draw()
		if not(path:GetCurrentGoal() == nil) then
			self.Destination=self:GetPos()+path:GetCurrentGoal().forward*100
		else
			self.Destination=self:GetPos()+self:GetForward()*100
		end
		path:Update(self)
		-- If we're stuck then call the HandleStuck function and abandon
		

		self.LastPos = self:GetPos()

		if ( self.loco:IsStuck() ) then
			self:HandleStuck();
			return "stuck"
		end
		coroutine.yield()
	end
	return "ok"
end

function ENT:OnInjured( info )
	local mins, maxs = self:GetHitBoxBounds( 0, 0 )
	if (info:GetDamagePosition().z>(self:GetAttachment(self:LookupAttachment("head")).Pos.z+mins.z)) and (info:GetDamagePosition().z<(self:GetAttachment(self:LookupAttachment("head")).Pos.z+maxs.z)) then
		info:AddDamage( info:GetDamage() )	
	end
	self.LastHitDir = (self:GetPos()-info:GetAttacker():GetPos()):GetNormalized()*info:GetDamage()*250
	self.LastHitPos = info:GetDamagePosition()
	if not(IsValid(self:GetEnemy())) then
		if IsValid(info:GetAttacker()) then
			if not(IsValid(self:GetEnemy())) then
				self.NewTargetGot = 1
			end
			self:SetEnemy(info:GetAttacker())
		end
	end
	local SoundList = {"npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav"}
	self:EmitSound( SoundList[math.random(3)], 100, 100, 1, 2 )
end
----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------
function ENT:RunBehaviour()
	-- This function is called when the entity is first spawned. It acts as a giant loop that will run as long as the NPC exists
	while ( true ) do
		-- Lets use the above mentioned functions to see if we have/can find a enemy
		if ( IsValid(self:GetEnemy()) ) then
			-- Now that we have an enemy, the code in this block will run
			--self.loco:FaceTowards( self:GetEnemy():GetPos() )	-- Face our enemy
			if self.NewTargetGot == 1 or self.LastAlert+15<CurTime() then
				local _ents = ents.FindInSphere( self:GetPos(), self.AlertDist )
				self.Allies = 0
				for k, v in pairs( _ents ) do
					if ( v:GetClass()=="dak_zombie" and not(v==self) ) then
						if not(IsValid(v:GetEnemy())) then
							v:SetEnemy(self:GetEnemy())
							self.Allies = 1
						end
					end
				end
				if self.Allies == 1 then
					self:EmitSound( "npc/stalker/go_alert2.wav", 120, 100, 1, 2 )
					self:PlaySequenceAndWait( "BR2_Roar" )
				end
				self.NewTargetGot = 0
				self.LastAlert = CurTime()
			end

			if self.LastRun+(3+self.PrimaryCooldown) < CurTime() and self.LongRange == 1 then
				self:SetSequence( "Run" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1.4 );
				self.loco:SetDesiredSpeed( self.ChaseSpeed )	
				local navtable = navmesh.Find( self:GetPos(), 1000, 0, 0 )
				self:MoveHere( navtable[math.random( 1, table.Count(navtable) )]:GetRandomPoint() )
				self.LastRun = CurTime()
				self:SetSequence( "idle" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
				if IsValid(self:GetEnemy()) then
					self.Destination=self:GetEnemy():GetPos()
				end
			else
				self.loco:SetDesiredSpeed( self.ChaseSpeed )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
				self.loco:SetAcceleration( self.ChaseSpeed )			-- We are going to run at the enemy quickly, so we want to accelerate really fast
				self.loco:SetDeceleration( self.ChaseSpeed )
				
				if IsValid(self:GetEnemy()) then
					if self:GetEnemy():GetPos():Distance(self:GetPos()) > self.chaserange then
						--self:PlaySequenceAndWait( "signal_advance" )	-- Get out of the pose
						self:SetSequence( "Run" )
						self:ResetSequenceInfo()
						self:SetCycle( 0 )
						self:SetPlaybackRate( 1.4 );
						if self.Allies == 0 then
							self:ChaseTarget(self:GetEnemy():GetPos())
						end
					end
				end
				--self.loco:SetDesiredSpeed( self.ChaseSpeed )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
				self.loco:SetAcceleration( self.ChaseSpeed )			-- We are going to run at the enemy quickly, so we want to accelerate really fast
				self.loco:SetDeceleration( self.ChaseSpeed )
				
				self:SetSequence( "idle" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
					--ATTACK
				if SERVER then
					if self.revenge == 1 then
						self:PlaySequenceAndWait( "BR2_Roar" )
						self:SuiExplosion()
					else
					    if ( IsValid(self:GetEnemy()) ) then
					    	--MELEE--
					    	if IsValid(self:GetEnemy()) then
							    if self:GetEnemy():GetPos():Distance(self:GetPos()) <= self.meleerange then
							    	self.Destination=self:GetEnemy():GetPos()
							    	--coroutine.wait( 0.1 )
							    	self:SetSequence( "Melee" )
									self:ResetSequenceInfo()
									self:SetCycle( 0 )
									self:SetPlaybackRate( 1.0 );
									coroutine.wait( 0.05 )
							        self:FireMelee()
							        coroutine.wait( 0.05 )
							    end
							end
							--RANGE--
							if IsValid(self:GetEnemy()) then
							    if self:GetEnemy():GetPos():Distance(self:GetPos()) < self.primaryrange and self:GetEnemy():GetPos():Distance(self:GetPos()) > self.meleerange then
							        self.Destination=self:GetEnemy():GetPos()
							    	--coroutine.wait( 0.1 )
						        	if self.BotType==2 then
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
							    end
							end
						end
					end
				end
			end
		else
			--if not(self:HaveEnemy()) then
				--self:FindEnemy()
			--end
			-- Since we can't find an enemy, lets wander
			-- Its the same code used in Garry's test bot
			if self.RunAway==0 then
				--self:StartActivity( ACT_WALK_AIM )			-- Walk anmimation
				self:SetSequence( "walk_all" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
				self.loco:SetDesiredSpeed( self.ChaseSpeed/4 )		-- Walk speed
				local navtable = navmesh.Find( self:GetPos(), 400, 0, 0 )
				self:MoveHere( navtable[math.random( 1, table.Count(navtable) )]:GetRandomPoint() )
				--self:StartActivity( ACT_IDLE )
				self:SetSequence( "idle" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
			else
				--self:StartActivity( ACT_WALK_AIM )			-- Walk anmimation
				self:SetSequence( "Run" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
				self.loco:SetDesiredSpeed( self.ChaseSpeed*0.7 )		-- Walk speed	
				local navtable = navmesh.Find( self:GetPos(), 1000, 0, 0 )
				self:MoveHere( navtable[math.random( 1, table.Count(navtable) )]:GetRandomPoint() )
				--self:StartActivity( ACT_IDLE )
				self:SetSequence( "idle_angry" )
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
				self:SetPlaybackRate( 1 );
				self.RunAway = 0
			end
		end
		-- At this point in the code the bot has stopped chasing the player or finished walking to a random spot
		-- Using this next function we are going to wait 2 seconds until we go ahead and repeat it
		
		if IsValid(self:GetEnemy()) then
			self:StopSound( "dak_zombie_gurgle_quiet" )
			self:EmitSound( "dak_zombie_gurgle" )
			if self.NewTargetGot == 0 then
				coroutine.wait( self.PrimaryCooldown )
			else
				coroutine.wait( 0 )
			end
		else
			self:StopSound( "dak_zombie_gurgle" )
			self:EmitSound( "dak_zombie_gurgle_quiet" )
			if self.NewTargetGot == 0 then
				coroutine.wait( 3 )
			else
				coroutine.wait( 0 )
			end
		end

	end

end

function ENT:FireMelee()
	if self.MeleeLastFire+self.MeleeCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			local trace = {}
			trace.start = self:GetAttachment(self:LookupAttachment("chest")).Pos
			trace.endpos = self:GetAttachment(self:LookupAttachment("chest")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*(self.meleerange*2)
			self.Filters = {}
			table.insert(self.Filters,self)
			trace.filter = self.Filters
			local Hit = util.TraceLine( trace )
			if not(Hit.Entity==NULL) then
				if Hit.Entity:GetClass()=="dak_zombie" or Hit.Entity:GetClass()=="dak_bot" or Hit.Entity:IsNPC() or Hit.Entity:IsPlayer() then
				--Hit.Entity:SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*75+Vector(0,0,300))
					local Pain = DamageInfo()
					Pain:SetDamageForce( ((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*5 )
					Pain:SetDamage(self.MeleeDamage)
					Pain:SetAttacker( self )
					Pain:SetInflictor( self )
					Pain:SetReportedPosition( Hit.HitPos )
					Pain:SetDamagePosition( Hit.Entity:GetPos() )
					Pain:SetDamageType(DMG_CLUB)
					Hit.Entity:TakeDamageInfo( Pain )
				else
					if Hit.Entity.DakHealth == nil then
						DakTekSetupNewEnt(Hit.Entity)
					end
					if not(Hit.Entity:IsPlayer() or Hit.Entity:IsNPC()) then
						if Hit.Entity.DakHealth <= 0 then
							self:MeleeRefire(Hit.Entity)
						end
					end
					if Hit.Entity.DakHealth>0 then
				self.RemoveDamage = Hit.Entity.DakHealth
			else
				self.RemoveDamage = 0
			end
					local HPPerc = (Hit.Entity.DakHealth-(self.MeleeDamage/5))/Hit.Entity.DakMaxHealth
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.MeleeDamage/5)
					if not(Hit.Entity.DakRed == nil) then 
						Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
					end
					Hit.Entity.DakLastDamagePos = Hit.HitPos
					if Hit.Entity.DakHealth <= 0 and Hit.Entity.DakPooled==0 then
						self.salvage = ents.Create( "dak_salvage" )
						self.salvage.DakModel = Hit.Entity:GetModel()
						self.salvage:SetPos( Hit.Entity:GetPos())
						self.salvage:SetAngles( Hit.Entity:GetAngles())
						self.salvage:Spawn()
						Hit.Entity:Remove()
					end

				end
			end
			self.MeleeLastFire = CurTime()
			local SoundList = {"npc/fast_zombie/claw_strike1.wav","npc/fast_zombie/claw_strike2.wav","npc/fast_zombie/claw_strike3.wav"}
			self:EmitSound( SoundList[math.random(3)], 100, 100, 1, 2)

			if IsValid(self:GetEnemy()) then
				if not(self:GetEnemy():IsPlayer()) then
					if self:GetEnemy().DakHealth <= 0 then
						self:FindEnemy()
					end
				end
			end

		end
	end
end

function ENT:MeleeRefire(ent)
	if self.MeleeLastFire+self.MeleeCooldown<CurTime() then
		if IsValid(self:GetEnemy()) then
			local trace = {}
			trace.start = self:GetAttachment(self:LookupAttachment("chest")).Pos
			trace.endpos = self:GetAttachment(self:LookupAttachment("chest")).Pos+((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*(self.meleerange*2)
			table.insert(self.Filters,ent)
			trace.filter = self.Filters
			local Hit = util.TraceLine( trace )
			if not(Hit.Entity==NULL) then
				if Hit.Entity:GetClass()=="dak_zombie" or Hit.Entity:GetClass()=="dak_bot" or Hit.Entity:IsNPC() or Hit.Entity:IsPlayer() then
				--Hit.Entity:SetVelocity(((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*75+Vector(0,0,300))
					local Pain = DamageInfo()
					Pain:SetDamageForce( ((self:GetEnemy():GetPos()+Vector(0,0,self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*5 )
					Pain:SetDamage(self.MeleeDamage)
					Pain:SetAttacker( self )
					Pain:SetInflictor( self )
					Pain:SetReportedPosition( Hit.HitPos )
					Pain:SetDamagePosition( Hit.Entity:GetPos() )
					Pain:SetDamageType(DMG_CLUB)
					Hit.Entity:TakeDamageInfo( Pain )
				else
					if Hit.Entity.DakHealth == nil then
						DakTekSetupNewEnt(Hit.Entity)
					end
					if not(Hit.Entity:IsPlayer() or Hit.Entity:IsNPC()) then
						if Hit.Entity.DakHealth <= 0 then
							self:MeleeRefire(Hit.Entity)
						end
					end
					if Hit.Entity.DakHealth>0 then
				self.RemoveDamage = Hit.Entity.DakHealth
			else
				self.RemoveDamage = 0
			end
					local HPPerc = (Hit.Entity.DakHealth-(self.MeleeDamage/5))/Hit.Entity.DakMaxHealth
					Hit.Entity.DakHealth = Hit.Entity.DakHealth-(self.MeleeDamage/5)
					if not(Hit.Entity.DakRed == nil) then 
						Hit.Entity:SetColor(Color(Hit.Entity.DakRed*HPPerc,Hit.Entity.DakGreen*HPPerc,Hit.Entity.DakBlue*HPPerc,Hit.Entity:GetColor().a))
					end
					Hit.Entity.DakLastDamagePos = Hit.HitPos
					if Hit.Entity.DakHealth <= 0 and Hit.Entity.DakPooled==0 then
						self.salvage = ents.Create( "dak_salvage" )
						self.salvage.DakModel = Hit.Entity:GetModel()
						self.salvage:SetPos( Hit.Entity:GetPos())
						self.salvage:SetAngles( Hit.Entity:GetAngles())
						self.salvage:Spawn()
						Hit.Entity:Remove()
					end

				end
			end
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
		Nade:SetModel("models/Gibs/HGIBS.mdl")
		util.SpriteTrail( Nade, -1, Color(25,255,0,150), true, 15, 1, 1, 1 / ( 5 + 1 ) * 0.5, "trails/smoke.vmt" )
		Nade:SetAngles(self:GetForward():Angle())
		Nade:SetPos(self:GetAttachment(self:LookupAttachment("chest")).Pos)
		Nade:Spawn()
		Nade.DakHealth = 1000
		Nade.DakMaxHealth = 1000
		Nade.DakNade = 1
		Nade:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()+Vector(math.Rand(-50,50),math.Rand(-50,50),math.Rand(-50,50)+self:GetEnemy():OBBCenter().z))-self:GetAttachment(self:LookupAttachment("chest")).Pos):GetNormalized()*self:GetEnemy():GetPos():Distance(self:GetPos())*0.675+Vector(0,0,500))
		timer.Simple( 1.5, function()
			if IsValid(Nade) then
				Explosion(Nade,Nade:GetPos(),250,5)
				local effectdata = EffectData()
				effectdata:SetOrigin(Nade:GetPos())
				effectdata:SetEntity(Nade)
				effectdata:SetAttachment(1)
				effectdata:SetMagnitude(.5)
				effectdata:SetScale(200)
				util.Effect("daklightburstppcexplosion", effectdata)
				Nade:EmitSound( "physics/body/body_medium_break3.wav", 100, 75, 1, 2)
				Nade:Remove()
			end
		end )
		
		self:EmitSound( self.FireSound, 140, 100, 1, 2)
	end
end

function ENT:SuiExplosion()
	Explosion(self,self:GetAttachment(self:LookupAttachment("chest")).Pos,250,15)
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
	if self.BotType==3 then
		body:SetModelScale( 2, 0 )
	end
	body:Spawn()
	body.DakHealth=1000000
	body.DakMaxHealth=1000000
	self:StopSound( "dak_zombie_gurgle_quiet" )
	self:StopSound( "dak_zombie_gurgle" )
	self:Remove()
	local SoundList = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}
	body:EmitSound( SoundList[math.random(3)], 100, 100, 1, 2 )
	timer.Simple( 5, function()
		body:Remove()
	end )
end

function ENT:Think()
	if not(self.SPPOwner==nil) then			
		if self.SPPOwner:IsAdmin()==false and not(game.SinglePlayer()) then
			self:StopSound( "dak_zombie_gurgle_quiet" )
			self:StopSound( "dak_zombie_gurgle" )
			self:Remove()
		end
	end
	if SERVER then
		if (self.LastFind+0.5) < CurTime() then
			if not(self:HaveEnemy()) then
				self:FindEnemy()
			end
			self.LastFind = CurTime()
		end
	    if IsValid(self:GetEnemy()) then
		    self.loco:FaceTowards( self.Destination )
		end
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
			if self.BotType==3 then
				body:SetModelScale( 2, 0 )
			end
			body:Spawn()
			body.DakHealth=1000000
			body.DakMaxHealth=1000000
			--print(self.LastHitDir)
			--print(self.LastHitPos)
			if not(self.LastHitDir==nil) and not(self.LastHitPos==nil) then
				body:GetPhysicsObject():ApplyForceOffset( self.LastHitDir, self.LastHitPos )
			end
			self:StopSound( "dak_zombie_gurgle_quiet" )
			self:StopSound( "dak_zombie_gurgle" )
			self:Remove()
			local SoundList = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}
			body:EmitSound( SoundList[math.random(3)], 100, 100, 1, 2 )
			timer.Simple( 5, function()
				body:Remove()
			end )

		end
	end
end

function ENT:OnKilled( dmginfo )
	self:StopSound( "dak_zombie_gurgle_quiet" )
	self:StopSound( "dak_zombie_gurgle" )
	if math.random(1,5) == 1 then
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
end

list.Set( "NPC", "dak_zombie", {
	Name = "DakZombie",
	Class = "dak_zombie",
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
							if (Targets[i]:GetClass()=="dak_bot" or Targets[i]:GetClass()=="dak_zombie") then
								Targets[i]:SetHealth(Targets[i]:Health() - Damage*10*(1-(ExpTrace.Entity:GetPos():Distance(Pos)/1000))*Radius)
								if Targets[i]:Health() <= 0 and Ent.revenge==0 then
									local body = ents.Create( "prop_ragdoll" )
									body:SetPos( Targets[i]:GetPos() )
									body:SetModel( Targets[i]:GetModel() )
									if self.BotType==3 then
										body:SetModelScale( 2, 0 )
									end
									body:Spawn()
									body.DakHealth=1000000
									body.DakMaxHealth=1000000
									Targets[i]:Remove()
									if Targets[i]:GetClass()=="dak_bot" then
										local SoundList = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}
									else
										local SoundList = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}
									end
									body:EmitSound( SoundList[math.random(3)], 100, 100, 1, 2 )
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
								ExpPain:SetDamageType(DMG_ACID)
								ExpTrace.Entity:TakeDamageInfo( ExpPain )
							end
						end
					end
				end
			end
		end
		for i = 1, #Ent.DamageList do
			if(Ent.DamageList[i]:IsValid()) then
				if not(Ent.DamageList[i]:GetClass() == "dak_bot" or Ent.DamageList[i]:GetClass() == "dak_zombie") then
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
			if not(Ent.DamageList[i]:GetClass() == "dak_bot" or Ent.DamageList[i]:GetClass() == "dak_zombie") then
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

function ENT:OnRemove()
	self:StopSound( "dak_zombie_gurgle_quiet" )
	self:StopSound( "dak_zombie_gurgle" )
end