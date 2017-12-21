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
	local Ang = data:GetAngles()
	local Mult = data:GetScale()
	
	local emitter = ParticleEmitter( Pos )
	
	for i = 1,100 do

		local particle = emitter:Add( "dak/smokey", Pos + Vector( math.random(-50*Mult,50*Mult),math.random(-50*Mult,50*Mult),math.random(-50*Mult,50*Mult) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity((((Ang):Forward()*math.Rand(0,25000))+(Vector(math.Rand(-2500,2500),math.Rand(-2500,2500),math.Rand(-2500,2500))))*Mult) 
			particle:SetLifeTime(0) 
			particle:SetDieTime(2.5*Mult) 
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetStartSize(50*Mult) 
			particle:SetEndSize(25*Mult)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local CVal = math.random(10,100)
			particle:SetColor(CVal,CVal,CVal,math.random(100,200))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(2000*Mult)  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end

for i = 1,100 do

		local particle = emitter:Add( "dak/flamelet5", Pos + Vector( math.random(-10,10),math.random(-10,10),math.random(-10,10) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/flamelet5", Pos + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity((Ang+Angle(math.Rand(-2,2),math.Rand(-2,2),math.Rand(-2,2))):Forward()*math.Rand(5000,20000)*Mult)
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(25*Mult) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local CVal = math.random(50,200)
			particle:SetColor(CVal,CVal,CVal,math.random(255,255))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(750*Mult)  
			particle:SetCollide(false)
			particle:SetBounce(1000)
		end
	end

	emitter:Finish()
		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end