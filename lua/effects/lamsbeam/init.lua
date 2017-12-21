function EFFECT:Init( data )
	self.Startpos = data:GetStart()
	self.Dist = data:GetMagnitude()
	self.Target = data:GetEntity()
end

function EFFECT:Think()	
	return false
end

function EFFECT:Render()
	local Laser = Material( "dak/pulsemedium" )
	render.SetMaterial( Laser )
	render.DrawBeam( self.Startpos, self.Target:GetPos(), 3, 1, 1, Color( 255, 255, 255, 255 ) ) 
end