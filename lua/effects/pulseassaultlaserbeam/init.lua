function EFFECT:Init( data )
	self.Startpos = data:GetStart()
	self.Gun = data:GetEntity()
	self.Dist = data:GetMagnitude()
	self.Endpos = self.Startpos + (self.Gun:GetForward() * self.Dist)
	self.size = data:GetScale()-CurTime()


	local Pos = data:GetStart()
	local Ent = data:GetEntity()
	
	local emitter = ParticleEmitter( Pos )
	
	if not(Ent==NULL) then
		for i = 1, 1 do

			local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward() ) 
			 
			if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
			
			if (particle) then
				particle:SetVelocity(Vector(0,0,0))
				particle:SetLifeTime(0) 
				particle:SetDieTime(0.1) 
				particle:SetStartAlpha(100)
				particle:SetEndAlpha(0)
				particle:SetStartSize(20)
				if self.size<=1 and self.size>0 then
					particle:SetEndSize(30*self.size)
				else
					particle:SetEndSize(0)
				end
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle(0,0,0) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				
				particle:SetColor(200,0,255,math.random(200,255))
				particle:SetGravity( Vector(0,0,0) ) 
				particle:SetAirResistance(5)  
				particle:SetCollide(false)
				particle:SetBounce(100)
			end
		end
	end

		if not(Ent==NULL) then
			for i = 1, math.Clamp(math.Round( (self.Dist/100) ,0),0,3) do

				local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward()*math.Rand(0,self.Dist) ) 
				 
				if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
				
				if (particle) then
					particle:SetVelocity(Ent:GetForward()*2000)
					particle:SetLifeTime(0) 
					particle:SetDieTime(0.25) 
					particle:SetStartAlpha(100)
					particle:SetEndAlpha(0)
					particle:SetStartSize(20)
					if self.size<=1 and self.size>0 then
						particle:SetEndSize(5*self.size)
					else
						particle:SetEndSize(0)
					end
					particle:SetAngles( Angle(0,0,0) )
					particle:SetAngleVelocity( Angle(0,0,0) ) 
					particle:SetRoll(math.Rand( 0, 360 ))
					
					particle:SetColor(200,0,255,math.random(200,255))
					particle:SetGravity( Vector(0,0,0) ) 
					particle:SetAirResistance(5)  
					particle:SetCollide(true)
					particle:SetBounce(0)

					particle:SetNextThink( CurTime() )
					particle:SetThinkFunction( function( pa )
						if not(data:GetEntity()==NULL) then
							if data:GetStart():Distance(pa:GetPos())>data:GetMagnitude() then
								pa:SetPos( data:GetStart()+(data:GetEntity():GetForward()*data:GetMagnitude()) )
								pa:SetVelocity(Vector(0,0,0))
							end
						end
						pa:SetNextThink( CurTime() )
					end)
				end
			end
		end

		if not(Ent==NULL) then
			for i = 1, 1 do

				local particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos + Ent:GetForward() ) 
				 
				if particle == nil then particle = emitter:Add( "sprites/light_glow02_add.vmt", Pos ) end
				
				if (particle) then
					particle:SetVelocity(Ent:GetForward()*50000)
					particle:SetLifeTime(0) 
					particle:SetDieTime(1) 
					particle:SetStartAlpha(100)
					particle:SetEndAlpha(0)
					particle:SetStartSize(25)
					if self.size<=1 and self.size>0 then
						particle:SetEndSize(15*self.size)
					else
						particle:SetEndSize(0)
					end
					particle:SetAngles( Angle(0,0,0) )
					particle:SetAngleVelocity( Angle(0,0,0) ) 
					particle:SetRoll(math.Rand( 0, 360 ))
					
					particle:SetColor(200,0,255,math.random(200,255))
					particle:SetGravity( Vector(0,0,0) ) 
					particle:SetAirResistance(5)  
					particle:SetCollide(true)
					particle:SetBounce(0)

					particle:SetNextThink( CurTime() )
					particle:SetThinkFunction( function( pa )
						if not(data:GetEntity()==NULL) then
							if data:GetStart():Distance(pa:GetPos())>data:GetMagnitude() then
								pa:SetPos( data:GetStart()+(data:GetEntity():GetForward()*data:GetMagnitude()) )
								pa:SetVelocity(Vector(0,0,0))
							end
						end
						pa:SetNextThink( CurTime() )
					end)
				end
			end
		end


	emitter:Finish()
end 

function EFFECT:Think()	
	--return false
end

function EFFECT:Render()
	local Laser = Material( "dak/beamassaultpulse" )
	render.SetMaterial( Laser )
	--render.SetColorModulation( 1, 0, 0 )
	if self.size>0.80 then
		render.DrawBeam( self.Startpos, self.Endpos, (1-self.size)*114.284, 0, 0.5, Color( 150, 255, 255, 255 ) ) 
	end
	if self.size<=0.80 and self.size>0.7 then
		render.DrawBeam( self.Startpos, self.Endpos, ((self.size))*28.512, 0, 0.5, Color( 150, 255, 255, 255 ) ) 
	end
	if self.size<=0.70 and self.size>=0.2 then
		render.DrawBeam( self.Startpos, self.Endpos, 20, 0, 0.5, Color( 150, 255, 255, 255 ) ) 
	end
	if self.size<0.2 then
		render.DrawBeam( self.Startpos, self.Endpos, self.size*50, 0, 0.5, Color( 150, 255, 255, 255 ) ) 
	end
end