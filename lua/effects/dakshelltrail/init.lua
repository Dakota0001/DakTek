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
	local length = data:GetMagnitude()
	
	local emitter = ParticleEmitter( Pos )
	
	if not(Ent==NULL) then
	for i = 1,6 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Vector(math.Rand(-5,5),math.Rand(-5,5),math.Rand(-5,5)) ) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
		
		if (particle) then
			local ranvec = Vector(math.Rand(-(50+(size*10)),(50+(size*10))),math.Rand(-(50+(size*10)),(50+(size*10))),math.Rand(-(50+(size*10)),(50+(size*10))))
			particle:SetVelocity(Ent:GetForward()*length + ranvec)
			particle:SetLifeTime(0) 
			particle:SetDieTime(math.Rand(0.1,0.25)) 
			particle:SetStartAlpha(100)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10+(size*2)) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(225,175,100,math.random(150,255))
			particle:SetGravity( -(10*ranvec) +Vector(0,0,0) ) 
			particle:SetAirResistance(math.Rand(400,600))  
			particle:SetCollide(true)
			particle:SetBounce(0)
		end
	end
	end

	if not(Ent==NULL) then
	for i = 1,1 do

		local particle = emitter:Add( "dak/smokey", Pos ) 
		 
		if particle == nil then particle = emitter:Add( "dak/smokey", Pos ) end
		
		if (particle) then
			local ranvec = Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100))
			particle:SetVelocity(Ent:GetForward()*length*0.5 + ranvec)
			particle:SetLifeTime(0) 
			particle:SetDieTime(1.5) 
			particle:SetStartAlpha(35)
			particle:SetEndAlpha(0)
			particle:SetStartSize(10+(size*2))
			particle:SetEndSize((10+(size*2))*2)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local CVal = math.random(100,100)
			particle:SetColor(CVal,CVal,CVal,math.random(25,50))
			particle:SetGravity(-(1*ranvec) +Vector(0,0,0) ) 
			particle:SetAirResistance(500)  
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