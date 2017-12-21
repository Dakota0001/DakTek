include("shared.lua")
ENT.CycleVal = 1
function ENT:Draw()

	self:DrawModel()

end

function ENT:Think()
	if IsValid(self) then
		if (self:GetNWBool("Firing")) == true and self:GetNWBool("Firing")~=self.LastFire then
			sound.Play( self:GetNWString("FireSound"), LocalPlayer():GetPos()+((self:GetPos()-LocalPlayer():GetPos()):GetNormalized()*1000), 100, self:GetNWInt("FirePitch"), math.Clamp(math.pow( 0.5,LocalPlayer():GetPos():Distance(self:GetPos())/5000 ),0,1) )
		end
		self.LastFire = self:GetNWBool("Firing")
		--6 barrel Model 4
		if (self:GetModel()=="models/dak/13crac4.mdl") or (self:GetModel()=="models/dak/11crac4.mdl") or (self:GetModel()=="models/dak/8crac4.mdl") or (self:GetModel()=="models/dak/6crac4.mdl") or (self:GetModel()=="models/dak/8rac4.mdl") or (self:GetModel()=="models/dak/10rac4.mdl") or (self:GetModel()=="models/dak/14rac4.mdl") or (self:GetModel()=="models/dak/16rac4.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "spin" ) )
				self:SetCycle( 0.016666667*self.CycleVal )
				self.CycleVal = self.CycleVal + 1 + ((1/self:GetNWFloat("Cooldown"))*0.1)
				if self.CycleVal >= 61 then
					self.CycleVal = 1
				end
			else
				self:SetCycle( 0.016666667 )
			end
		end
		--6 barrel Model 3
		if (self:GetModel()=="models/dak/0125crac3.mdl") or (self:GetModel()=="models/dak/13crac3.mdl") or (self:GetModel()=="models/dak/11crac3.mdl") or (self:GetModel()=="models/dak/8crac3.mdl") or (self:GetModel()=="models/dak/6crac3.mdl") or (self:GetModel()=="models/dak/05rac3.mdl") or (self:GetModel()=="models/dak/025rac3.mdl") or (self:GetModel()=="models/dak/1rac3.mdl") or (self:GetModel()=="models/dak/8rac3.mdl") or (self:GetModel()=="models/dak/10rac3.mdl") or (self:GetModel()=="models/dak/14rac3.mdl") or (self:GetModel()=="models/dak/16rac3.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "spin" ) )
				self:SetCycle( 0.05*self.CycleVal )
				self.CycleVal = self.CycleVal + 1 + ((1/self:GetNWFloat("Cooldown"))*0.1)
				if self.CycleVal >= 21 then
					self.CycleVal = 1
				end
			else
				self:SetCycle( 0.05 )
			end
		end
		--4 barrel Model 2
		if (self:GetModel()=="models/dak/13crac2.mdl") or (self:GetModel()=="models/dak/11crac2.mdl") or (self:GetModel()=="models/dak/8crac2.mdl") or (self:GetModel()=="models/dak/6crac2.mdl") or (self:GetModel()=="models/dak/12crac2.mdl") or (self:GetModel()=="models/dak/10crac2.mdl") or (self:GetModel()=="models/dak/7crac2.mdl") or (self:GetModel()=="models/dak/5crac2.mdl") or (self:GetModel()=="models/dak/05rac2.mdl") or (self:GetModel()=="models/dak/7rac2.mdl") or (self:GetModel()=="models/dak/8rac2.mdl") or (self:GetModel()=="models/dak/9rac2.mdl") or (self:GetModel()=="models/dak/10rac2.mdl") or (self:GetModel()=="models/dak/13rac2.mdl") or (self:GetModel()=="models/dak/14rac2.mdl") or (self:GetModel()=="models/dak/15rac2.mdl") or (self:GetModel()=="models/dak/16rac2.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "spin" ) )
				self:SetCycle( 0.05*self.CycleVal )
				self.CycleVal = self.CycleVal + (4/6) + (((4/6)/self:GetNWFloat("Cooldown"))*0.1)
				if self.CycleVal >= 21 then
					self.CycleVal = 1
				end
			else
				self:SetCycle( 0.05 )
			end
		end
		--2 barrel Model 3
		if (self:GetModel()=="models/dak/12cuac3.mdl") or (self:GetModel()=="models/dak/10cuac3.mdl") or (self:GetModel()=="models/dak/7cuac3.mdl") or (self:GetModel()=="models/dak/5cuac3.mdl") or (self:GetModel()=="models/dak/7uac3.mdl") or (self:GetModel()=="models/dak/9uac3.mdl") or (self:GetModel()=="models/dak/13uac3.mdl") or (self:GetModel()=="models/dak/15uac3.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "spin" ) )
				self:SetCycle( 0.05*self.CycleVal )
				self.CycleVal = self.CycleVal + (2/6) + (((2/6)/self:GetNWFloat("Cooldown"))*0.1)
				if self.CycleVal >= 21 then
					self.CycleVal = 1
				end
			else
				self:SetCycle( 0.0 )
			end
		end
		--6 barrel Model 1
		if (self:GetModel()=="models/dak/0125crac.mdl") or (self:GetModel()=="models/dak/13crac.mdl") or (self:GetModel()=="models/dak/11crac.mdl") or (self:GetModel()=="models/dak/8crac.mdl") or (self:GetModel()=="models/dak/6crac.mdl") or (self:GetModel()=="models/dak/025rac.mdl") or (self:GetModel()=="models/dak/05rac.mdl") or (self:GetModel()=="models/dak/1rac.mdl") or (self:GetModel()=="models/dak/8rac.mdl") or (self:GetModel()=="models/dak/10rac.mdl") or (self:GetModel()=="models/dak/14rac.mdl") or (self:GetModel()=="models/dak/16rac.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "spin" ) )
				self:SetCycle( 0.05*self.CycleVal )
				self.CycleVal = self.CycleVal + 0.5 + ((0.5/self:GetNWFloat("Cooldown"))*0.1)
				if self.CycleVal >= 11 then
					self.CycleVal = 1
				end
			else
				self:SetCycle( 0.5 )
			end
		end
		--3 barrel Model 1
		if (self:GetModel()=="models/dak/12cuac.mdl") or (self:GetModel()=="models/dak/10cuac.mdl") or (self:GetModel()=="models/dak/7cuac.mdl") or (self:GetModel()=="models/dak/5cuac.mdl") or (self:GetModel()=="models/dak/05uac.mdl") or (self:GetModel()=="models/dak/7uac.mdl") or (self:GetModel()=="models/dak/9uac.mdl") or (self:GetModel()=="models/dak/13uac.mdl") or (self:GetModel()=="models/dak/15uac.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "spin" ) )
				self:SetCycle( 0.05*self.CycleVal )
				self.CycleVal = self.CycleVal + 0.5 + ((0.5/self:GetNWFloat("Cooldown"))*0.1)
				if self.CycleVal >= 21 then
					self.CycleVal = 1
				end
			else
				self:SetCycle( 0.05 )
			end
		end

		--Recoil guns
		if (self:GetModel()=="models/dak/0125ac2.mdl") or (self:GetModel()=="models/dak/6ac2.mdl") or (self:GetModel()=="models/dak/8ac2.mdl") or (self:GetModel()=="models/dak/10ac2.mdl") or (self:GetModel()=="models/dak/12ac2.mdl") or (self:GetModel()=="models/dak/14ac2.mdl") or (self:GetModel()=="models/dak/20ac2.mdl") or (self:GetModel()=="models/dak/05ac2.mdl") or (self:GetModel()=="models/dak/025ac2.mdl") or (self:GetModel()=="models/dak/1ac2.mdl") or (self:GetModel()=="models/dak/0125ac2.mdl") or (self:GetModel()=="models/dak/sniper4.mdl") or (self:GetModel()=="models/dak/10longtom.mdl") or (self:GetModel()=="models/dak/20longtom.mdl") or (self:GetModel()=="models/dak/6ac4.mdl") or (self:GetModel()=="models/dak/8ac4.mdl") or (self:GetModel()=="models/dak/12ac4.mdl") or (self:GetModel()=="models/dak/14ac4.mdl") or (self:GetModel()=="models/dak/0125uac4.mdl") or (self:GetModel()=="models/dak/025uac4.mdl") or (self:GetModel()=="models/dak/05uac4.mdl") or (self:GetModel()=="models/dak/1uac4.mdl") or (self:GetModel()=="models/dak/5uac4.mdl") or (self:GetModel()=="models/dak/6uac4.mdl") or (self:GetModel()=="models/dak/7uac4.mdl") or (self:GetModel()=="models/dak/8uac4.mdl") or (self:GetModel()=="models/dak/9uac4.mdl") or (self:GetModel()=="models/dak/10uac4.mdl") or (self:GetModel()=="models/dak/11uac4.mdl") or (self:GetModel()=="models/dak/12uac4.mdl") or (self:GetModel()=="models/dak/13uac4.mdl") or (self:GetModel()=="models/dak/14uac4.mdl") or (self:GetModel()=="models/dak/15uac4.mdl") then
			if self:GetNWBool("Firing") == true then
				self:SetSequence( self:LookupSequence( "recoil" ) )
				self:SetCycle( 0.15 )
				timer.Create( "RecoilTimer"..self:EntIndex()..CurTime(), 0.15, 1, function()
					self:ResetSequence(self:LookupSequence( "recoil" ))
					self:SetCycle( 1 )
				end)
			end
		end
	end
end