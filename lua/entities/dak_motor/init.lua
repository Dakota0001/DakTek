AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 25
ENT.DakHealth = 25
ENT.DakName = "Light Motor"
ENT.DakModel = "models/dak/1motor.mdl"
ENT.DakSpeed = 1.1725
ENT.DakMass = 1000
ENT.DakSound = "vehicles/apc/apc_cruise_loop3.wav"
ENT.DakPooled=0


function ENT:Initialize()
	self:SetModel(self.DakModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.DakHealth = self.DakMaxHealth
	self.DakSpeed = 2
	local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:Wake()
	end
	self.Inputs = Wire_CreateInputs(self, { "Forward", "Reverse", "Left", "Right", "Brakes", "Activate", "LeftDriveWheel [ENTITY]" , "RightDriveWheel [ENTITY]", "CarTurning" })
	self.YawAng = Angle(0,self:GetAngles().yaw,0)
	--self:EmitSound(self.DakSound,75,0,1,CHAN_AUTO)
	self.initsound = self.DakSound
	self.Sound = CreateSound( self, self.DakSound )
	self.Sound:PlayEx(1,100)
	self.Sound:ChangePitch( 0, 0 )
	self.Sound:ChangeVolume( 0, 0 )
	self.Soundtime = CurTime()
 	self.SparkTime = CurTime()
 	self.Perc = 0
 	self.TurnPerc = 0
 	self.LastYaw = self:GetAngles().yaw
 	self.Prev = {}
 	self.PrevPos = self:GetPos()
 	self.Time = CurTime()
 	self.TopSpeed = 1
 	self.RBoost = 1
 	self.LBoost = 1
 	self.Speed = 0
 	self.ExtraTorque = 1
 	self.Vel = 1
end

function ENT:Think()
	if CurTime()>=self.SparkTime+0.33 then
		if self.DakHealth<=(self.DakMaxHealth*0.80) and self.DakHealth>(self.DakMaxHealth*0.60) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(1)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+3 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.4, 6)
				self.Soundtime=CurTime()
			end
		end
		if self.DakHealth<=(self.DakMaxHealth*0.60) and self.DakHealth>(self.DakMaxHealth*0.40) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(2)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+2 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.5, 6)
				self.Soundtime=CurTime()
			end
		end
		if self.DakHealth<=(self.DakMaxHealth*0.40) and self.DakHealth>(self.DakMaxHealth*0.20) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(3)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+1 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.6, 6)
				self.Soundtime=CurTime()
			end
		end
		if self.DakHealth<=(self.DakMaxHealth*0.20) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetEntity(self)
			effectdata:SetAttachment(1)
			effectdata:SetMagnitude(.5)
			effectdata:SetScale(4)
			util.Effect("dakdamage", effectdata)
			if CurTime()>=self.Soundtime+0.5 then
				self:EmitSound( "dak/shock.wav", 60, math.Rand(60,150), 0.75, 6)
				self.Soundtime=CurTime()
			end
		end
		self.SparkTime=CurTime()
	end
	if self.DakName == "Light Motor" then
		self.DakMaxHealth = 25
		self.DakMass = 1000
		self.DakSpeed = 1.675
		self.DakModel = "models/dak/1motor.mdl"
		--self.DakSound = "vehicles/apc/apc_cruise_loop3.wav"
	end
	if self.DakName == "Standard Motor" then
		self.DakMaxHealth = 50
		self.DakMass = 2000
		self.DakSpeed = 2.5125
		self.DakModel = "models/dak/2motor.mdl"
		--self.DakSound = "vehicles/airboat/fan_motor_idle_loop1.wav"
	end
	if self.DakName == "Heavy Motor" then
		self.DakMaxHealth = 100
		self.DakMass = 4000
		self.DakSpeed = 3.35
		self.DakModel = "models/dak/3motor.mdl"
		--self.DakSound = "vehicles/crane/crane_idle_loop3.wav"
	end
	if self.DakName == "Ultra Motor" then
		self.DakMaxHealth = 150
		self.DakMass = 6000
		self.DakSpeed = 5.025
		self.DakModel = "models/dak/4motor.mdl"
		--self.DakSound = "vehicles/airboat/fan_motor_fullthrottle_loop1.wav"
	end
	if self.DakHealth > self.DakMaxHealth then
		self.DakHealth = self.DakMaxHealth
	end
	if not(self.initsound == self.DakSound) then
	self.initsound = self.DakSound
	self.Sound:Stop()
	self.Sound = CreateSound( self, self.DakSound )
	self.Sound:PlayEx(1,100)
	self.Sound:ChangePitch( 0, 0 )
	self.Sound:ChangeVolume( 0, 0 )
	end
	if not(self:GetModel() == self.DakModel) then
		self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self:GetPhysicsObject():SetMass(self.DakMass)
	self.MoveForward = self.Inputs.Forward.Value
	self.MoveReverse = self.Inputs.Reverse.Value
	self.MoveLeft = self.Inputs.Left.Value
	self.MoveRight = self.Inputs.Right.Value
	self.Brakes = self.Inputs.Brakes.Value
	self.Active = self.Inputs.Activate.Value
	self.LeftDriveWheel = self.Inputs.LeftDriveWheel.Value
	self.RightDriveWheel = self.Inputs.RightDriveWheel.Value

	self.CarTurning = self.Inputs.CarTurning.Value
    
    if IsValid(self.DakEngine) and IsValid(self.LeftDriveWheel) and IsValid(self.RightDriveWheel) and not(IsValid(self.LeftDriveWheel:GetParent())) and not(IsValid(self.RightDriveWheel:GetParent())) then
    	if not(self.DakEngine.TotalMass==nil) then
	    	self.DakSpeed = self.DakSpeed*((20000/self.DakEngine.TotalMass)*self.DakEngine.PowerMod)
	    	self.TopSpeed = (29.851*self.DakSpeed)
			if(self:GetParent():IsValid()) then
				if(self:GetParent():GetParent():IsValid()) then
					self.phy = self:GetParent():GetParent():GetPhysicsObject()
					self.base = self:GetParent():GetParent()
				end
			end
			if not(self:GetParent():IsValid()) then
				self.phy = self:GetPhysicsObject()
				self.base = self
			end
	        if ((self.Active>0) and (self.DakEngine.TotalMass <= 200000)) then
	        	self.Sound:ChangeVolume( 1, 1 )

	        	if self.Brakes>0 then
		        	if constraint.FindConstraint( self.LeftDriveWheel, "Weld" )==nil then
		        		constraint.Weld( self.LeftDriveWheel, self.base, 0, 0, 0, false, false )
		        		constraint.Weld( self.RightDriveWheel, self.base, 0, 0, 0, false, false )
		        	end
		        else
		        	if constraint.FindConstraint( self.LeftDriveWheel, "Weld" )==nil then
		        	else
		        		constraint.RemoveConstraints( self.LeftDriveWheel, "Weld" )
		        		constraint.RemoveConstraints( self.RightDriveWheel, "Weld" )
		        	end
		        	if not(self.MoveForward>0) and not(self.MoveReverse>0) then
							self.Perc = 0
					end
					if not(self.MoveRight>0) and not(self.MoveLeft>0) then
						self.TurnPerc = 0
					end
					if self.MoveForward>0 then
		        			self.Perc = 1
					end
					if self.MoveReverse>0 then
		        			self.Perc = -1
					end
						
					local ForwardVal = self:GetForward():Distance(self.phy:GetVelocity():GetNormalized()) --if it is below one you are going forward, if it is above one you are reversing
					if self.Speed < self.TopSpeed and math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < math.Clamp(1250*(self.Speed*1.5/self.TopSpeed),500,1000) and math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < math.Clamp(1250*(self.Speed*1.5/self.TopSpeed),500,1000) then
						if self.Perc > 0 then
							if ForwardVal < 1 then
								self.ExtraTorque = math.Clamp(self.TopSpeed/self.Speed,1,10)
							else
								self.ExtraTorque = 10
							end		
						end
						if self.Perc < 0 then
							if ForwardVal > 1 then
								self.ExtraTorque = math.Clamp(self.TopSpeed/self.Speed,1,10)
							else
								self.ExtraTorque = 10
							end		
						end
						local TorqueBoost = 5*self.ExtraTorque			
						self.RBoost = 1
					 	self.LBoost = 1
						if self.MoveRight==0 and self.MoveLeft==0 then
							if self.Perc>=0 then
								if self.LastYaw-self:GetAngles().yaw > 0.01 then
									self.LBoost = 0
									self.RBoost = 1
								end
								if self.LastYaw-self:GetAngles().yaw < -0.01 then
									self.LBoost = 1
									self.RBoost = 0
								end
							else
								if self.LastYaw-self:GetAngles().yaw > 0.01 then
									self.LBoost = 1
									self.RBoost = 0
								end
								if self.LastYaw-self:GetAngles().yaw < -0.01 then
									self.LBoost = 0
									self.RBoost = 1
								end
							end
						else
							if self.CarTurning==0 then
								self.LBoost = 0
								self.RBoost = 0
							else
								self.LBoost = 0.1
								self.RBoost = 0.1
							end
						end

						local LeftVel = math.Clamp( (3000/(math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
						local RightVel = math.Clamp( (3000/(math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )

						if self.Speed<self.TopSpeed/3 then
							self.Sound:ChangePitch( 200*(TorqueBoost/50), 3 )
						else
							self.Sound:ChangePitch( 200*(self.Speed/self.TopSpeed), 1 )
						end

						self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*self.Perc*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost*self.LBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
						self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*self.Perc*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost*self.LBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
						self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*self.Perc*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost*self.RBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
						self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*self.Perc*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost*self.RBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
					end

					if math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < 500 and math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < 500 then
						if self.CarTurning==0 then
							local LeftVel = math.Clamp( (3000/(math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
							local RightVel = math.Clamp( (3000/(math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
							if self.MoveLeft>0 and self.MoveRight==0 then
								local TorqueBoost = math.Clamp(3/math.abs(self.LastYaw-self:GetAngles().yaw),1, 3+(((self.DakEngine.TotalMass/10000)+3)*(self.DakHealth/self.DakMaxHealth)) )
								self.Sound:ChangePitch( 200*(TorqueBoost/(3+((self.DakEngine.TotalMass/10000)+3))), 1 )
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
							end
							if self.MoveRight>0 and self.MoveLeft==0 then
								local TorqueBoost = math.Clamp(3/math.abs(self.LastYaw-self:GetAngles().yaw),1, 3+(((self.DakEngine.TotalMass/10000)+3)*(self.DakHealth/self.DakMaxHealth)) )
								self.Sound:ChangePitch( 200*(TorqueBoost/(3+((self.DakEngine.TotalMass/10000)+3))), 1 )
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
							end
						end
					end

					if math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < 1250*(self.Speed*1.5/self.TopSpeed) and math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < 1250*(self.Speed*1.5/self.TopSpeed) then
						if not(self.MoveForward>0) and not(self.MoveReverse>0) and not(self.MoveLeft>0) and not(self.MoveRight>0) then
							self.Vel = ((self.phy:GetVelocity()*self:GetForward()).x+(self.phy:GetVelocity()*self:GetForward()).y)*100
							local TorqueBoost = math.Clamp(math.abs(self.Vel/1000),1,10)
							local LeftVel = math.Clamp( (3000/(math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
							local RightVel = math.Clamp( (3000/(math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
							if self.Vel>0.1 then
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
							end
							if self.Vel<-0.1 then
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
								self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*1*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
							end
							self.Sound:ChangePitch( 75, 1 )
						end
					end
					self.LastYaw = self:GetAngles().yaw
				end
	        else
	        	if math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < 1250*(self.Speed*1.5/self.TopSpeed) and math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y/6) < 1250*(self.Speed*1.5/self.TopSpeed) then
		        	self.Vel = ((self.phy:GetVelocity()*self:GetForward()).x+(self.phy:GetVelocity()*self:GetForward()).y)*100
		        	local TorqueBoost = math.Clamp(math.abs(self.Vel/1000),1,10)
		        	local LeftVel = math.Clamp( (3000/(math.abs(self.LeftDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
					local RightVel = math.Clamp( (3000/(math.abs(self.RightDriveWheel:GetPhysicsObject():GetAngleVelocity().y)/6))-0.99,1,5 )
					if self.Vel>0.1 then
						self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
						self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
						self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
						self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
					end
					if self.Vel<-0.1 then
						self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
						self.LeftDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.LeftDriveWheel:OBBMaxs().z/22.5)*LeftVel*self:GetForward()*TorqueBoost, self.LeftDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.LeftDriveWheel:OBBMaxs().z*2,1,60))
						self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()+self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
						self.RightDriveWheel:GetPhysicsObject():ApplyForceOffset( (self.DakHealth/self.DakMaxHealth)*-1.5*75*(self.RightDriveWheel:OBBMaxs().z/22.5)*RightVel*self:GetForward()*TorqueBoost, self.RightDriveWheel:GetPos()-self:GetUp()*math.Clamp(self.RightDriveWheel:OBBMaxs().z*2,1,60))
					end
				end
	        	self.Sound:ChangeVolume( 0, 2 )
	        	self.Sound:ChangePitch( 0, 2 )
	        	self.LastYaw = self:GetAngles().yaw
	        end

	        if #self.Prev>=5 then 
	        	table.remove( self.Prev, 1 ) 
	        end
	        self.NewPos = self:GetPos()
	        self.Dist = self.NewPos:Distance(self.PrevPos)
	        self.PrevPos = self.NewPos

	        table.insert(self.Prev,1, ( (self.Dist/(CurTime()-self.Time))/(84480/1609) ) )
	        self.Time = CurTime()
	        if #self.Prev>=5 then 
	        	self.Speed = ((self.Prev[1]+self.Prev[2]+self.Prev[3]+self.Prev[4]+self.Prev[5])/5)*3.6*5
	        else
	        	self.Speed = 0
	        end
	    end
    end
    self:NextThink(CurTime())
    return true
end

function ENT:PreEntityCopy()

	local info = {}
	local entids = {}

	info.EngineID = self.DakEngine:EntIndex()
	info.DakName = self.DakName
	info.DakMass = self.DakMass
	info.DakModel = self.DakModel
	info.DakMaxHealth = self.DakMaxHealth
	info.DakHealth = self.DakHealth
	info.DakSpeed = self.DakSpeed
	info.DakSound = self.DakSound

	duplicator.StoreEntityModifier( self, "DakTek", info )

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then
		local Eng = CreatedEntities[ Ent.EntityMods.DakTek.EngineID ]
		if Eng and IsValid(Eng) then
			self.DakEngine = Eng
		end
		self.DakName = Ent.EntityMods.DakTek.DakName
		self.DakMass = Ent.EntityMods.DakTek.DakMass
		self.DakModel = Ent.EntityMods.DakTek.DakModel
		self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
		self.DakHealth = Ent.EntityMods.DakTek.DakHealth
		self.DakSpeed = Ent.EntityMods.DakTek.DakSpeed
		self.DakSound = Ent.EntityMods.DakTek.DakSound
		self.DakOwner = Player
		self.DakHealth = self.DakMaxHealth
		if Ent.EntityMods.DakTek.DakColor == nil then
		else
			self:SetColor(Ent.EntityMods.DakTek.DakColor)
		end

		self:PhysicsDestroy()
		--self:SetModel(self.DakModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:Activate()

		Ent.EntityMods.DakTek = nil
	end
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end