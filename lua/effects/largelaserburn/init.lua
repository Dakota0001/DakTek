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
	
	local emitter = ParticleEmitter( Pos )
	
	for i = 1,4 do

		local particle = emitter:Add( "dak/fireexplosion", Pos + Vector( math.random(0,0),math.random(0,0),math.random(0,0) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/fireexplosion", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-25,25),math.random(-25,25),math.random(-25,25)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.49997322981279) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(16) 
			particle:SetEndSize(4)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(238,255),math.random(0,255),math.random(0,0),math.random(255,255))
			particle:SetGravity( Vector(0,0,-26.257279859959) ) 
			particle:SetAirResistance(100 )  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end

	for i=1, 2 do
	
		local Debris = emitter:Add( "effects/fleck_tile"..math.random(1,2), Pos )
		if (Debris) then
			Debris:SetVelocity (Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100)))
			Debris:SetLifeTime( 0 )
			Debris:SetDieTime( math.Rand( 0.5 , 1.5 ) )
			Debris:SetStartAlpha( 255 )
			Debris:SetEndAlpha( 0 )
			Debris:SetStartSize( 1 )
			Debris:SetEndSize( 1 )
			Debris:SetRoll( math.Rand(0, 360) )
			Debris:SetRollDelta( math.Rand(-3, 3) )			
			Debris:SetAirResistance( 200 ) 			 
			Debris:SetGravity( Vector( 0, 0, math.Rand(-350, -150) ) ) 			
			Debris:SetColor( 50,50,50 )
		end
	end

	local Sparks = EffectData()
	Sparks:SetOrigin( Pos )
	--Sparks:SetNormal( self.Normal )
	Sparks:SetMagnitude( math.Rand(0.2,0.2) )
	Sparks:SetScale( math.Rand(1.0,2.5) )
	Sparks:SetRadius( math.Rand(5,7.5) )
	util.Effect( "Sparks", Sparks )
	emitter:Finish()
		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end