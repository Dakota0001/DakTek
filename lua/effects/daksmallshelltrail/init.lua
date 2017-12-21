/*

This effect goes in lua/effects/<Your effect name>/init.lua

How to use: Example Code:

	local OurEnt = LocalPlayer() 
	local part = EffectData()
	if OurEnt ~= NULL then
	part:SetStart( OurEnt:GetPos() + Vector(0,0,70) )
	part:SetOrigin( OurEnt:GetPos() + Vector(0,0,70) )
	part:SetEntity( OurEnt )
	part:SetScale( 1 )
	util.Effect( "Your Effect name", part)
	end 
	
You can use this in ENT:Think() or PrimaryEffect in an entity or hook.Add("Think","Effect", function() ... end)

Think is for animated effects
*/
function EFFECT:Init( data )
	local Pos = data:GetOrigin()
	local Ent = data:GetEntity()
	local size = data:GetScale()
	local length = data:GetMagnitude()*100
	
	local emitter = ParticleEmitter( Pos )
	
	if not(Ent==NULL) then
	for i = 1,1 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*length)
			particle:SetLifeTime(0) 
			particle:SetDieTime(10) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(100)
			particle:SetStartSize(size*50) 
			particle:SetEndSize(size*50)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(225,175,100,math.random(150,255))
			particle:SetGravity( physenv.GetGravity() ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(true)
			particle:SetBounce(0)
			particle.LastPos = particle:GetPos()
			particle:SetCollideCallback( function(p) p:SetDieTime( 0 )
			end )
			particle:SetNextThink( CurTime() )
			particle:SetThinkFunction( function( pa )
				local trace = {}
				trace.start = pa.LastPos
				trace.endpos = pa:GetPos() + pa:GetVelocity():GetNormalized()*pa.LastPos:Distance(pa:GetPos())
				trace.mins = Vector(-2.5,-2.5,-2.5)
				trace.maxs = Vector(2.5,2.5,2.5)
				trace.filter = Ent
				local Hit = util.TraceHull( trace )
				pa.LastPos = pa:GetPos()
				if Hit.Hit then		
					pa:SetVelocity(Vector(0,0,0))
					pa:SetDieTime(0)
				else
				pa:SetNextThink( CurTime() )
				end
			end )
		end
	end
	end

	if not(Ent==NULL) then
	for i = 1,5 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
		
		if (particle) then
			particle:SetVelocity((Ent:GetForward()*length)+(-Ent:GetForward()*350*i))
			particle:SetLifeTime(0) 
			particle:SetDieTime(10) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(100)
			particle:SetStartSize((size*50)-((size*50)*(i/5))) 
			particle:SetEndSize((size*50)-((size*50)*(i/5))) 
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(225,175,100,math.random(150,255))
			particle:SetGravity( physenv.GetGravity() ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(true)
			particle:SetBounce(0)
			particle.LastPos = particle:GetPos()
			particle:SetCollideCallback( function(p) p:SetDieTime( 0 )
			end )
			particle:SetNextThink( CurTime() )
			particle:SetThinkFunction( function( pa )
				local trace = {}
				trace.start = pa.LastPos
				trace.endpos = pa:GetPos() + pa:GetVelocity():GetNormalized()*pa.LastPos:Distance(pa:GetPos())
				trace.mins = Vector(-2.5,-2.5,-2.5)
				trace.maxs = Vector(2.5,2.5,2.5)
				trace.filter = Ent
				local Hit = util.TraceHull( trace )
				pa.LastPos = pa:GetPos()
				if Hit.Hit then	
					pa:SetVelocity(Vector(0,0,0))
					pa:SetDieTime(0)
				else
				pa:SetNextThink( CurTime() )
				end
			end )
		end
	end
	end

	emitter:Finish()
		
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end