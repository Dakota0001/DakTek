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
	for i = 1,10 do
		local particle = emitter:Add( "dak/smokey", Pos + Ent:GetForward()*math.random( 0, 2000 ))  
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos + Ent:GetForward()*math.random( 0, 2000 )) end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*math.random(500,1000) + Vector(math.random(-25,25),math.random(-25,25),math.random(-25,25)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(10)
			particle:SetEndAlpha(0)
			particle:SetStartSize(20) 
			particle:SetEndSize(100)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(25,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(100,150),0,math.random(255,255),math.random(255,255))
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(0)  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
	end
	end

	if not(Ent==NULL) then
	for i = 1,10 do

		local particle = emitter:Add( "dak/smokey", Pos + Ent:GetForward()*math.random( 0, 2000 )) 
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos + Ent:GetForward()*math.random( 0, 2000 ))  end
		
		if (particle) then
			particle:SetVelocity(Ent:GetForward()*math.random(500,1000) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(20) 
			particle:SetEndSize(10)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(50,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(100,150),0,math.random(255,255),math.random(255,255))
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(0.0)  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
	end
	end

	if not(Ent==NULL) then
		for i = 1,5 do
			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos +Ent:GetForward()*math.Rand(0,0)+ (Ent:GetUp()*50*math.sin(CurTime()*500)) + (Ent:GetRight()*50*math.cos(CurTime()*500))) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
			
			if (particle) then
				particle:SetVelocity(Ent:GetForward()*math.Rand(0,5000) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
				particle:SetLifeTime(0) 
				particle:SetDieTime(2.0) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(40) 
				particle:SetEndSize(0)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				particle:SetColor(math.random(100,150),0,math.random(255,255),255)
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(0.0)  
				particle:SetCollide(false)
				particle:SetBounce(0)
			end
		end
	end
	if not(Ent==NULL) then
		for i = 1,5 do
			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos +Ent:GetForward()*math.Rand(0,0)+ (-Ent:GetUp()*50*math.sin(CurTime()*500)) + (-Ent:GetRight()*50*math.cos(CurTime()*500))) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
			
			if (particle) then
				particle:SetVelocity(Ent:GetForward()*math.Rand(0,5000) + Vector(math.random(0,0),math.random(0,0),math.random(0,0)))
				particle:SetLifeTime(0) 
				particle:SetDieTime(2.0) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(40) 
				particle:SetEndSize(0)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				particle:SetColor(math.random(100,150),0,math.random(255,255),255)
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(0.0)  
				particle:SetCollide(false)
				particle:SetBounce(0)
			end
		end
	end
	
	if not(Ent==NULL) then
		for i = 1,10 do
		local size = 75
		local length = 70000
		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Vector(math.Rand(-5,5),math.Rand(-5,5),math.Rand(-5,5)) ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
		
		if (particle) then
			local ranvec = Vector(math.Rand(-(50+(size*10)),(50+(size*10))),math.Rand(-(50+(size*10)),(50+(size*10))),math.Rand(-(50+(size*10)),(50+(size*10))))
			particle:SetVelocity(Ent:GetForward()*length + ranvec)
			particle:SetLifeTime(0) 
			particle:SetDieTime(1) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(20+(size*2)) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(100,150),math.random(50,75),math.random(255,255),math.random(150,255))
			particle:SetGravity( -(10*ranvec) +Vector(0,0,0) ) 
			particle:SetAirResistance(math.Rand(400,600))  
			particle:SetCollide(true)
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