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
	
	for i = 1,100 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(1.0) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(50) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(125,150),math.random(125,150),math.random(255,255),math.random(150,255))
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(150)  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
	end

	for i=1, 100 do
	
		local Debris = emitter:Add( "effects/fleck_tile"..math.random(1,2), Pos )
		if (Debris) then
			Debris:SetVelocity (Vector(math.random(-250,250),math.random(-250,250),math.random(-250,250)))
			Debris:SetLifeTime( 0 )
			Debris:SetDieTime( math.Rand( 0.5 , 1.5 ) )
			Debris:SetStartAlpha( 255 )
			Debris:SetEndAlpha( 0 )
			Debris:SetStartSize( 2 )
			Debris:SetEndSize( 2 )
			Debris:SetRoll( math.Rand(0, 360) )
			Debris:SetRollDelta( math.Rand(-3, 3) )			
			Debris:SetAirResistance( 50 ) 			 
			Debris:SetGravity( Vector( 0, 0, math.Rand(-500, -250) ) ) 			
			Debris:SetColor( 50,50,50 )
		end
	end

	local Sparks = EffectData()
		Sparks:SetOrigin( Pos )
		--Sparks:SetNormal( self.Normal )
		Sparks:SetMagnitude( math.Rand(10,10) )
		Sparks:SetScale( math.Rand(1,2) )
		Sparks:SetRadius( math.Rand(5,10) )
		util.Effect( "Sparks", Sparks )

	emitter:Finish()
		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end