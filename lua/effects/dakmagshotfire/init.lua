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
	for i = 1,25 do

		local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( -0, 0 )) 
		 
		if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.random( 0, 0 ))  end
		
		if (particle) then
			particle:SetVelocity(Vector(Ent:GetUp()*math.random( -100, 100 ))+Vector(Ent:GetRight()*math.random( -100, 100 ))+Vector(Ent:GetForward()*math.random( -100, 500 )))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(10)
			particle:SetEndAlpha(0)
			particle:SetStartSize(12.5) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(50,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor(math.random(255,255),math.random(100,150),math.random(0,0),255)
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(2500)  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
	end
	end

	local Sparks = EffectData()
		Sparks:SetOrigin( Pos )
		--Sparks:SetNormal( self.Normal )
		Sparks:SetMagnitude( math.Rand(100,100) )
		Sparks:SetScale( math.Rand(100,100) )
		Sparks:SetRadius( math.Rand(100,100) )
		util.Effect( "cball_explode", Sparks )

	emitter:Finish()
		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
end