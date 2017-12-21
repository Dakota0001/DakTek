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
	for i = 1,5 do

		local particle = emitter:Add( "dak/flamelet2", Pos + Ent:GetForward()*math.random( -50, 500 ))  
		 
		if particle == nil then particle = emitter:Add( "dak/flamelet2", Pos + Ent:GetForward()*math.random( 0, 0 )) end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*500 + Vector(math.random(-25,25),math.random(-25,25),math.random(-25,25)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(2.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(20) 
			particle:SetEndSize(40)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(0,0),math.random(50,100),math.random(255,255),255)
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(20)  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
	end
	end
		if not(Ent==NULL) then
	for i = 1,5 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( -50, 500 ))  
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 )) end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*500)
			particle:SetLifeTime(0) 
			particle:SetDieTime(2.0) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(25) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(0,0),math.random(50,100),math.random(255,255),255)
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(20)  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
	end
	end

	if not(Ent==NULL) then
		for i = 1,5 do
			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos +Ent:GetForward()*math.Rand(0,150)+ (Ent:GetUp()*25*math.sin(CurTime()*50)) + (Ent:GetRight()*25*math.cos(CurTime()*50))) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
			
			if (particle) then
				particle:SetVelocity(Ent:GetForward()*math.Rand(0,150) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
				particle:SetLifeTime(0) 
				particle:SetDieTime(2.0) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(20) 
				particle:SetEndSize(0)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				particle:SetColor(math.random(0,0),math.random(50,100),math.random(255,255),255)
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(0.0)  
				particle:SetCollide(false)
				particle:SetBounce(0)
			end
		end
	end
	if not(Ent==NULL) then
		for i = 1,5 do
			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos +Ent:GetForward()*math.Rand(0,150)+ (-Ent:GetUp()*25*math.sin(CurTime()*50)) + (-Ent:GetRight()*25*math.cos(CurTime()*50))) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
			
			if (particle) then
				particle:SetVelocity(Ent:GetForward()*math.Rand(0,150) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
				particle:SetLifeTime(0) 
				particle:SetDieTime(2.0) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(20) 
				particle:SetEndSize(0)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				particle:SetColor(math.random(0,0),math.random(50,100),math.random(255,255),255)
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(0.0)  
				particle:SetCollide(false)
				particle:SetBounce(0)
			end
		end
	end
		if not(Ent==NULL) then
		for i = 1,5 do
			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos +Ent:GetForward()*math.Rand(0,150)+ (Ent:GetUp()*25*math.sin(CurTime()*25)) + (-Ent:GetRight()*25*math.cos(CurTime()*25))) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
			
			if (particle) then
				particle:SetVelocity(Ent:GetForward()*math.Rand(0,150) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
				particle:SetLifeTime(0) 
				particle:SetDieTime(2.0) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(20) 
				particle:SetEndSize(0)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				particle:SetColor(math.random(0,0),math.random(50,100),math.random(255,255),255)
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(0.0)  
				particle:SetCollide(false)
				particle:SetBounce(0)
			end
		end
	end
	if not(Ent==NULL) then
		for i = 1,5 do
			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos +Ent:GetForward()*math.Rand(0,150)+ (-Ent:GetUp()*25*math.sin(CurTime()*25)) + (Ent:GetRight()*25*math.cos(CurTime()*25))) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
			
			if (particle) then
				particle:SetVelocity(Ent:GetForward()*math.Rand(0,150) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
				particle:SetLifeTime(0) 
				particle:SetDieTime(2.0) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(20) 
				particle:SetEndSize(0)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				particle:SetColor(math.random(0,0),math.random(50,100),math.random(255,255),255)
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(0.0)  
				particle:SetCollide(false)
				particle:SetBounce(0)
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