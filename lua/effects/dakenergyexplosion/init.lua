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
	
	for i = 1,50 do

		local particle = emitter:Add( "dak/smokey", Pos + Vector( math.random(-50,50),math.random(-50,50),math.random(-50,50) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(2.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(25) 
			particle:SetEndSize(75)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local CVal = math.random(10,100)
			particle:SetColor(CVal,CVal,CVal,math.random(255,255))
			particle:SetGravity( Vector(0,0,250) ) 
			particle:SetAirResistance(250)  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end

	for i = 1,125 do

		local particle = emitter:Add( "dak/flamelet5", Pos + Vector( math.random(-50,50),math.random(-50,50),math.random(-50,50) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/flamelet5", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-1000,1000),math.random(-1000,1000),math.random(-1000,1000)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(1.0) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(100) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(255,math.random(0,200),0,math.random(150,250))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(250)  
			particle:SetCollide(false)
			particle:SetBounce(1000)
		end
	end

		for i = 1,25 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Vector( math.random(-50,50),math.random(-50,50),math.random(-50,50) ) ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(4) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(250) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(255,155,0,math.random(255,255))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(250)  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end

	emitter:Finish()
		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end