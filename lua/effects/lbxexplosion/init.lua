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
	
	for i = 1,3 do

		local particle = emitter:Add( "dak/smokey", Pos + Vector( math.random(-5,5),math.random(-5,5),math.random(-5,5) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local CVal = math.random(10,100)
			particle:SetColor(CVal,CVal,CVal,math.random(255,255))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(25)  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end

for i = 1,3 do

		local particle = emitter:Add( "dak/flamelet5", Pos + Vector( math.random(-5,5),math.random(-5,5),math.random(-5,5) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/flamelet5", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-10,10),math.random(-10,10),math.random(-10,10)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(100,100,100,100)
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(25)  
			particle:SetCollide(false)
			particle:SetBounce(1000)
		end
	end

	for i=1, 4 do
	
		local Debris = emitter:Add( "effects/fleck_tile"..math.random(1,2), Pos )
		if (Debris) then
			Debris:SetVelocity (Vector(math.random(-33,33),math.random(-33,33),math.random(-33,33)))
			Debris:SetLifeTime( 0 )
			Debris:SetDieTime( math.Rand( 0.5 , 1.5 ) )
			Debris:SetStartAlpha( 255 )
			Debris:SetEndAlpha( 0 )
			Debris:SetStartSize( 1 )
			Debris:SetEndSize( 1 )
			Debris:SetRoll( math.Rand(0, 360) )
			Debris:SetRollDelta( math.Rand(-3, 3) )			
			Debris:SetAirResistance( 50 ) 			 
			Debris:SetGravity( Vector( 0, 0, math.Rand(-500, -250) ) ) 			
			Debris:SetColor( 50,50,50 )
		end
	end

	emitter:Finish()
		
end




function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end