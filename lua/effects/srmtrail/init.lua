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
	
	local emitter = ParticleEmitter( Pos )
	
	if not(Ent==NULL) then
	for i = 1,1 do

		local particle = emitter:Add( "dak/smokey", Pos + Ent:GetForward()*math.random( 0, 0 ) + Vector( math.random(-2,2),math.random(-2,2),math.random(-2,2) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos + Ent:GetForward()*math.random( 0, 0 ) + Vector(   math.random(-2,2),math.random(-2,2),math.random(-2,2) ) ) end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*100 + Vector(math.random(-1,1),math.random(-1,-1),math.random(-1,1)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(75)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10) 
			particle:SetEndSize(25)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local CVal = math.random(100,150)
			particle:SetColor(CVal,CVal,CVal,math.random(50,150))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(5)  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end
	end

	if not(Ent==NULL) then
	for i = 1,1 do

		local particle = emitter:Add( "dak/fireexplosion", Pos + Ent:GetForward()*math.random( 0, 0 ) + Vector( math.random(-2,2),math.random(-2,2),math.random(-2,2) ) ) 
		 
		if particle == nil then particle = emitter:Add( "dak/fireexplosion", Pos + Ent:GetForward()*math.random( 0, 0 ) + Vector(   math.random(-2,2),math.random(-2,2),math.random(-2,2) ) ) end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*100 + Vector(math.random(-1,1),math.random(-1,-1),math.random(-1,1)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.1) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10) 
			particle:SetEndSize(25)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(255,255,255,255)
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(5)  
			particle:SetCollide(false)
			particle:SetBounce(100)
		end
	end
	end
	
	if not(Ent==NULL) then
	for i = 1,1 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ) + Vector( math.random(-2,2),math.random(-2,2),math.random(-2,2) ) ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ) + Vector(   math.random(-2,2),math.random(-2,2),math.random(-2,2) ) ) end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*100 + Vector(math.random(-1,1),math.random(-1,-1),math.random(-1,1)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.1) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10) 
			particle:SetEndSize(25)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(255,225,75,math.random(150,255))
			particle:SetGravity( Vector(0,0,5) ) 
			particle:SetAirResistance(5)  
			particle:SetCollide(false)
			particle:SetBounce(100)
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