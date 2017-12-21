AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakEngine = NULL
ENT.DakMaxHealth = 50
ENT.DakHealth = 50
ENT.DakName = "Light Gyro"
ENT.DakModel = "models/dak/1gyro.mdl"
ENT.DakSpeed = 3
ENT.DakMass = 2500
ENT.DakSound = "npc/combine_gunship/engine_whine_loop1.wav"
ENT.DakPooled=0
ENT.DakMASCon = 0


function ENT:Initialize()
    self:SetModel(self.DakModel)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.DakHealth = self.DakMaxHealth
    local phys = self:GetPhysicsObject()
    if(phys:IsValid()) then
        phys:Wake()
    end
    self.Inputs = Wire_CreateInputs(self, { "Forward", "Reverse", "Left", "Right", "Activate" , "Sprint" , "Crouch" , "JumpJet" , "LAMToggle", "Hip [ENTITY]" , "LeftFoot [ENTITY]" , "RightFoot [ENTITY]" , "LeftLegHitbox [ENTITY]" , "RightLegHitbox [ENTITY]", "LeftTorsoHitbox [ENTITY]", "RightTorsoHitbox [ENTITY]", "FrontTorsoHitbox [ENTITY]", "RearTorsoHitbox [ENTITY]" })
    self.Outputs = WireLib.CreateOutputs( self, { "JumpFuel" } )

    self.Perc = 0
    self.SprintPerc = 0
    self.MASCPerc = 0
    self.JumpFuel = 0
    self.JumpFuelMax = 0
    self.CrouchPerc = 0
    self.RightIncrement = 0
    self.LeftIncrement = 180
    self.initsound = self.DakSound
    self.Sound = CreateSound( self, self.DakSound )
    self.Sound:PlayEx(1,100)
    self.Sound:ChangePitch( 0, 0 )
    self.Sound:ChangeVolume( 0, 0 )
    self.Yaw = self:GetAngles().yaw
    self.OldLeftHit = false
    self.OldRightHit = false
    self.Soundtime = CurTime()
    self.SparkTime = CurTime()
    self.JumpJets = {}
    self.JumpFuelMax = 0
    self.EntCount = 0
end

function ENT:Think()
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
    if self.DakName == "Light Gyro" then
        self.DakMaxHealth = 50
        self.DakMass = 1000
        self.DakSpeed = 1.19
        self.DakModel = "models/dak/1gyro.mdl"
    end
    if self.DakName == "Standard Gyro" then
        self.DakMaxHealth = 100
        self.DakMass = 3000
        self.DakSpeed = 1.74
        self.DakModel = "models/dak/2gyro.mdl"
    end
    if self.DakName == "Heavy Gyro" then
        self.DakMaxHealth = 150
        self.DakMass = 7000
        self.DakSpeed = 2.77
        self.DakModel = "models/dak/3gyro.mdl"
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
    self.Active = self.Inputs.Activate.Value
    self.base = self.Inputs.Hip.Value
    self.Sprint = self.Inputs.Sprint.Value
    self.Crouch = self.Inputs.Crouch.Value
    self.JumpJet = self.Inputs.JumpJet.Value
    self.LeftLeg = self.Inputs.LeftLegHitbox.Value
    self.RightLeg = self.Inputs.RightLegHitbox.Value

    self.LeftTorso = self.Inputs.LeftTorsoHitbox.Value
    self.RightTorso = self.Inputs.RightTorsoHitbox.Value
    self.FrontTorso = self.Inputs.FrontTorsoHitbox.Value
    self.RearTorso = self.Inputs.RearTorsoHitbox.Value

    self.LAMToggle = self.Inputs.LAMToggle.Value

    if(not(self.base==NULL)) then
        self.phy = self.base:GetPhysicsObject()
    end
    self.LeftFoot = self.Inputs.LeftFoot.Value
    self.RightFoot = self.Inputs.RightFoot.Value

    if not(self.HipHeight == nil or self.DakTotalMass==nil) then
        if not(self.DakEngine==NULL) and not(self.LeftFoot==NULL) and not(self.RightFoot==NULL) and not(self.base==NULL) and not(self.LeftLeg==NULL) and not(self.RightLeg==NULL) and not(self.LeftLeg.DakHealth==nil) and not(self.RightLeg.DakHealth==nil) then
            if self.DakEngine.PowerMod == nil or self.DakEngine.Contraption == nil then
                self.DakSpeed = 0
            else
                self.DakSpeed = self.DakSpeed*((20000/self.DakTotalMass)*self.DakEngine.PowerMod)
                if self.DakEngine.HeavyArmor == 1 then
                    self.DakSpeed = self.DakSpeed * 0.75
                end

                self.CrouchPercent = self:GetCrouchPercent()
                self.JumpBias = self:GetJumpForwardBias()
                self.StrideCenter = self:GetStrideCenter()

                --torso segments aren't legs, but this flag tells the hitbox not to detonate on death
                self.LeftTorso.DakIsLeg = 1
                self.RightTorso.DakIsLeg = 1
                self.FrontTorso.DakIsLeg = 1
                self.RearTorso.DakIsLeg = 1

                self.LeftLeg.DakIsLeg = 1
                self.RightLeg.DakIsLeg = 1
                if (self.LeftLeg.DakHealth <= 0)or(self.RightLeg.DakHealth <= 0) then
                    self.DakSpeed = self.DakSpeed*0.4
                end
                if (self.LeftLeg.DakHealth <= 0)and(self.RightLeg.DakHealth <= 0) then
                    self.LeftLeg.DakIsLeg = 0
                    self.RightLeg.DakIsLeg = 0
                end
                
                if self.phy:IsMotionEnabled() then
                    local GroundRay = {}
                    GroundRay.start = self.base:GetPos()
                    GroundRay.endpos = self.base:GetPos() + (Vector(0,0,-1) * 1000000)
                    if self.Filters == nil then
                    self.Filters = {}
                        table.insert(self.Filters,self)
                        table.insert(self.Filters,self.base)
                        table.Add(self.Filters,self.DakEngine.Contraption)
                    end
                    GroundRay.filter = self.Filters
                    GroundRay.mask = MASK_SOLID_BRUSHONLY
                    self.GroundRay = util.TraceLine( GroundRay )
                    self.POS=self.GroundRay.HitPos
                    
                    self.Sound:ChangeVolume( 1, 1 )
                    if self.DakEngine.Contraption[1]:GetPhysicsObject():IsGravityEnabled() or not(self.EntCount==table.Count(self.DakEngine.Contraption)) then
                        self.JumpFuelMax=0
                        self.JumpJets = {}
                        for i=1, #self.DakEngine.Contraption do
                            if not(self.DakEngine.Contraption[i]==NULL) then
                                if self.DakEngine.Contraption[i]:IsSolid() then
                                    self.DakEngine.Contraption[i]:GetPhysicsObject():EnableGravity( false )
                                    if self.DakEngine.Contraption[i]:GetClass() == "dak_jumpjet" then
                                        table.insert(self.JumpJets,self.DakEngine.Contraption[i])  
                                        self.JumpFuelMax = self.JumpFuelMax + self.DakEngine.Contraption[i].DakJumpCapacity
                                    end
                                end
                            end
                        end
                        self.JumpFuelMax = (self.JumpFuelMax / (self.DakTotalMass/100))
                        self.EntCount = table.Count(self.DakEngine.Contraption)
                    end
                        self.deadcontraption = table.Copy(self.DakEngine.Contraption)

                    if not(self.MoveForward>0) and not(self.MoveReverse>0) then
                        if self.Perc > 0 then
                            self.Perc = self.Perc - 2
                        end
                        if self.Perc < 0 then
                            self.Perc = self.Perc + 2
                        end
                    end
                    self.Sound:ChangePitch( (math.abs(self.Perc)*1.5)+50, 1 )

                    if (self.JumpJet>0) and (self.JumpFuel>0) and (self.LAMToggle == 0) then
                        if table.Count(self.JumpJets) > 0 then
                            if self.JumpJets[1].DakActive == 0 then
                                for i=1, #self.JumpJets do
                                    self.JumpJets[i].DakActive = 1
                                end
                            end
                        end
                        self.JumpFuel = self.JumpFuel - 1
                        WireLib.TriggerOutput(self, "JumpFuel", (100*(self.JumpFuel/self.JumpFuelMax)))
                        self.brake = 1
                        self.vertbrake = 1
                        self.footbrake = 1
                        self.RightStride = Vector(0,0,0)
                        self.LeftStride = Vector(0,0,0)
                        self.ForwardVec = Vector(0,0,0)

                        self.phy:ApplyForceCenter((Vector(0,0,7.5)*(1-self.JumpBias)*self.phy:GetMass()*15)+(self:GetForward()*7.5*self.JumpBias*self.phy:GetMass()*15)+Vector(-self.phy:GetVelocity().x*0.03,-self.phy:GetVelocity().y*0.03,0)*self.phy:GetMass())

                        if self.Perc > 0 then
                            self.Perc = self.Perc - 2
                        end
                        if self.Perc < 0 then
                            self.Perc = self.Perc + 2
                        end

                        self.LeftPos = Vector(   (self.LeftBasePos.x)*math.cos(self.Yaw*math.pi/180) - (self.LeftBasePos.y)*math.sin(self.Yaw*math.pi/180) , (self.LeftBasePos.x)*math.sin(self.Yaw*math.pi/180) + (self.LeftBasePos.y)*math.cos(self.Yaw*math.pi/180) , ((math.abs(math.max(self.LeftFoot:OBBMins().x,self.LeftFoot:OBBMins().y,self.LeftFoot:OBBMins().z)) + math.abs(math.min(self.LeftFoot:OBBMaxs().x,self.LeftFoot:OBBMaxs().y,self.LeftFoot:OBBMaxs().z)))/2)+(self.LeftBasePos.z-self:GetExtraHeight())  )
                        self.RightPos = Vector(   (self.RightBasePos.x)*math.cos(self.Yaw*math.pi/180) - (self.RightBasePos.y)*math.sin(self.Yaw*math.pi/180) , (self.RightBasePos.x)*math.sin(self.Yaw*math.pi/180) + (self.RightBasePos.y)*math.cos(self.Yaw*math.pi/180) , ((math.abs(math.max(self.RightFoot:OBBMins().x,self.RightFoot:OBBMins().y,self.RightFoot:OBBMins().z)) + math.abs(math.min(self.RightFoot:OBBMaxs().x,self.RightFoot:OBBMaxs().y,self.RightFoot:OBBMaxs().z)))/2)+(self.RightBasePos.z-self:GetExtraHeight())  )
                    
                        self.Bob = self.HipBobMultiplier*math.max(self.RightStride.z-self.LeftStride.z,self.LeftStride.z-self.RightStride.z)

                        self.LeftFoot:GetPhysicsObject():ApplyForceCenter(Vector((self.base:GetPos()+self.LeftPos)-self.LeftFoot:GetPos()-Vector(self.LeftFoot:GetVelocity().x*0.05,self.LeftFoot:GetVelocity().y*0.05,0))*self.LeftFoot:GetPhysicsObject():GetMass()*0.5)            
                        self.RightFoot:GetPhysicsObject():ApplyForceCenter(Vector((self.base:GetPos()+self.RightPos)-self.RightFoot:GetPos()-Vector(self.RightFoot:GetVelocity().x*0.05,self.RightFoot:GetVelocity().y*0.05,0))*self.RightFoot:GetPhysicsObject():GetMass()*0.5)  
                    
                        if self.Crouch==0 then
                            if self.MoveLeft>0 then
                                self.Yaw = self.Yaw+1
                            end
                            if self.MoveRight>0 then
                                self.Yaw = self.Yaw-1
                            end

                            if self.Yaw < -180 then
                                self.Yaw = 180
                            end
                            if self.Yaw > 180 then
                                self.Yaw = -180
                            end
                        end

                        local AngleDiff = Angle(0,0,0)-self:GetAngles()
                        self.YawDiff = (self.Yaw)-self:GetAngles().yaw

                        if self.YawDiff > 180 then
                            self.YawDiff = self.YawDiff-360
                        end
                        if self.YawDiff< -180 then
                            self.YawDiff = self.YawDiff+360
                        end
                    
                        local RotVec = Vector(AngleDiff.r*5,AngleDiff.p*5,self.YawDiff*5)
                        self.phy:AddAngleVelocity(RotVec)

                        local LeftRay = {}
                        LeftRay.start = self.LeftFoot:GetPos()
                        LeftRay.endpos = self.LeftFoot:GetPos() + (Vector(0,0,-1.25) * ((math.abs(math.max(self.LeftFoot:OBBMins().x,self.LeftFoot:OBBMins().y,self.LeftFoot:OBBMins().z)) + math.abs(math.min(self.LeftFoot:OBBMaxs().x,self.LeftFoot:OBBMaxs().y,self.LeftFoot:OBBMaxs().z)))/2) )
                        LeftRay.filter = self.Filters
                        LeftRay.mask = MASK_SOLID_BRUSHONLY
                        self.LeftRay = util.TraceLine( LeftRay )
                        local RightRay = {}
                        RightRay.start = self.RightFoot:GetPos()
                        RightRay.endpos = self.RightFoot:GetPos() + (Vector(0,0,-1.25) * ((math.abs(math.max(self.RightFoot:OBBMins().x,self.RightFoot:OBBMins().y,self.RightFoot:OBBMins().z)) + math.abs(math.min(self.RightFoot:OBBMaxs().x,self.RightFoot:OBBMaxs().y,self.RightFoot:OBBMaxs().z)))/2) )
                        RightRay.filter = self.Filters
                        RightRay.mask = MASK_SOLID_BRUSHONLY
                        self.RightRay = util.TraceLine( RightRay )


                        

                        local StepSoundList = {}
                        if self.DakTotalMass <= 40000 then
                            StepSoundList = {"npc/dog/dog_footstep2.wav","npc/dog/dog_footstep3.wav"}
                        end
                        if self.DakTotalMass > 40000 and self.DakTotalMass <= 75000 then
                            StepSoundList = {"npc/dog/dog_footstep_run2.wav","npc/dog/dog_footstep_run3.wav"}
                        end
                        if self.DakTotalMass > 75000 then
                            StepSoundList = {"physics/concrete/boulder_impact_hard3.wav","physics/concrete/boulder_impact_hard3.wav"}
                        end

                        if self.LeftRay.Hit == true and(not(self.OldLeftHit==self.LeftRay.Hit)) then
                            self.LeftFoot:EmitSound( StepSoundList[math.random(1,2)], 100, 80, 1)
                        end
                        if self.RightRay.Hit == true and(not(self.OldRightHit==self.RightRay.Hit)) then
                            self.RightFoot:EmitSound( StepSoundList[math.random(1,2)], 100, 80, 1)
                        end


                        self.OldLeftHit = self.LeftRay.Hit
                        self.OldRightHit = self.RightRay.Hit
                    else
                        --------------------
                        --Begin normal state
                        --------------------
                        if table.Count(self.JumpJets) > 0 then
                            if self.JumpJets[1].DakActive == 1 then
                                for i=1, #self.JumpJets do
                                    self.JumpJets[i].DakActive = 0
                                end
                            end
                        end
                        if self.base:GetPos().z > self.POS.z+((self.HipHeight+self:GetExtraHeight())*2) then
                            self.brake = 1
                            self.vertbrake = 0
                            self.footbrake = 1
                            self.RightStride = Vector(0,0,0)
                            self.LeftStride = Vector(0,0,0)
                            self.ForwardVec = Vector(0,0,0)
                            if self.LAMToggle == 0 then
                                if not(self.DakEngine.Contraption[1]:GetPhysicsObject():IsGravityEnabled()) or not(self.EntCount==table.Count(self.DakEngine.Contraption)) then
                                    self.JumpFuelMax=0
                                    self.JumpJets = {}
                                    for i=1, #self.DakEngine.Contraption do
                                        if not(self.DakEngine.Contraption[i]==NULL) then
                                            if self.DakEngine.Contraption[i]:IsSolid() then
                                                self.DakEngine.Contraption[i]:GetPhysicsObject():EnableGravity( true )
                                                if self.DakEngine.Contraption[i]:GetClass() == "dak_jumpjet" then
                                                    table.insert(self.JumpJets,self.DakEngine.Contraption[i])  
                                                    self.JumpFuelMax = self.JumpFuelMax + self.DakEngine.Contraption[i].DakJumpCapacity
                                                end
                                            end
                                        end
                                    end
                                    self.JumpFuelMax = (self.JumpFuelMax / (self.DakTotalMass/100))
                                    self.EntCount = table.Count(self.DakEngine.Contraption)
                                end
                            end
                            self.deadcontraption = table.Copy(self.DakEngine.Contraption)

                            self.LeftPos = Vector(   (self.LeftBasePos.x)*math.cos(self.Yaw*math.pi/180) - (self.LeftBasePos.y)*math.sin(self.Yaw*math.pi/180) , (self.LeftBasePos.x)*math.sin(self.Yaw*math.pi/180) + (self.LeftBasePos.y)*math.cos(self.Yaw*math.pi/180) , ((math.abs(math.max(self.LeftFoot:OBBMins().x,self.LeftFoot:OBBMins().y,self.LeftFoot:OBBMins().z)) + math.abs(math.min(self.LeftFoot:OBBMaxs().x,self.LeftFoot:OBBMaxs().y,self.LeftFoot:OBBMaxs().z)))/2)+(self.LeftBasePos.z-self:GetExtraHeight())  )
                            self.RightPos = Vector(   (self.RightBasePos.x)*math.cos(self.Yaw*math.pi/180) - (self.RightBasePos.y)*math.sin(self.Yaw*math.pi/180) , (self.RightBasePos.x)*math.sin(self.Yaw*math.pi/180) + (self.RightBasePos.y)*math.cos(self.Yaw*math.pi/180) , ((math.abs(math.max(self.RightFoot:OBBMins().x,self.RightFoot:OBBMins().y,self.RightFoot:OBBMins().z)) + math.abs(math.min(self.RightFoot:OBBMaxs().x,self.RightFoot:OBBMaxs().y,self.RightFoot:OBBMaxs().z)))/2)+(self.RightBasePos.z-self:GetExtraHeight())  )
                    
                            self.Bob = 0*math.max(self.RightStride.z-self.LeftStride.z,self.LeftStride.z-self.RightStride.z)

                            self.LeftFoot:GetPhysicsObject():ApplyForceCenter(Vector((self.base:GetPos()+self.LeftPos)-self.LeftFoot:GetPos())*self.LeftFoot:GetPhysicsObject():GetMass()*0.5)            
                            self.RightFoot:GetPhysicsObject():ApplyForceCenter(Vector((self.base:GetPos()+self.RightPos)-self.RightFoot:GetPos())*self.RightFoot:GetPhysicsObject():GetMass()*0.5)  
                        
                        if self.Crouch==0 then
                            if self.MoveLeft>0 then
                                self.Yaw = self.Yaw+1
                            end
                            if self.MoveRight>0 then
                                self.Yaw = self.Yaw-1
                            end

                            if self.Yaw < -180 then
                                self.Yaw = 180
                            end
                            if self.Yaw > 180 then
                                self.Yaw = -180
                            end
                        end

                        local AngleDiff = Angle(0,0,0)-self:GetAngles()
                        self.YawDiff = (self.Yaw)-self:GetAngles().yaw

                        if self.YawDiff > 180 then
                            self.YawDiff = self.YawDiff-360
                        end
                        if self.YawDiff< -180 then
                            self.YawDiff = self.YawDiff+360
                        end
                    
                        local RotVec = Vector(AngleDiff.r*5,AngleDiff.p*5,self.YawDiff*5)
                        self.phy:AddAngleVelocity(RotVec)
                        else
                            if self.StrideCenter == nil then
                                self.StrideCenter = 0
                                self:SetStrideCenter(0)
                            end
                            if self.WalkStrideLength == nil then
                                self.WalkStrideLength = 1
                                self:SetWalkStrideLength(1)
                            end
                            if self.WalkStrideHeight == nil then
                                self.WalkStrideHeight = 1
                                self:SetWalkStrideHeight(1)
                            end
                            if self.SprintStrideLength == nil then
                                self.SprintStrideLength = 1
                                self:SetSprintStrideLength(1)
                            end
                            if self.SprintStrideHeight == nil then
                                self.SprintStrideHeight = 1
                                self:SetSprintStrideHeight(1)
                            end
                            if table.Count(self.JumpJets) > 0 then
                                if self.JumpJets[1].DakActive == 1 then
                                    for i=1, #self.JumpJets do
                                        self.JumpJets[i].DakActive = 0
                                    end
                                end
                            end
                            if self.JumpFuel < self.JumpFuelMax then
                                self.JumpFuel = self.JumpFuel + self.JumpFuelMax/500
                                WireLib.TriggerOutput(self, "JumpFuel", (100*(self.JumpFuel/self.JumpFuelMax)))
                            end

                            self.Radius = 50
                            self.StridePositionOffset = 0.75

                            if (self.DakMASCon>0) then
                                if self.MASCPerc < 100 then
                                    self.MASCPerc = self.MASCPerc + 1
                                end
                            else
                                if self.MASCPerc > 0 then
                                    self.MASCPerc = self.MASCPerc - 1
                                end
                            end

                            if (self.Sprint>0) then
                                if self.SprintPerc < 100 then
                                    self.SprintPerc = self.SprintPerc + 1
                                end
                                self.ForceMult = (0.5 + (0.25*(self.SprintPerc/100))) + (0.3*(self.MASCPerc/100))
                                self.StrideLength = self:GetSprintStrideLength()
                                self.StrideHeight = self:GetSprintStrideHeight()
                                self.AnimationSpeed = 2*(self.DakSpeed)*(50/(self.Radius*self.StrideLength))/(1.1875)
                                self.HipBobMultiplier = self:GetSprintHipBobMultiplier()
                            else
                                if self.SprintPerc > 0 then
                                    self.SprintPerc = self.SprintPerc - 1
                                end
                                self.ForceMult = (0.5 + (0.25*(self.SprintPerc/100))) + (0.3*(self.MASCPerc/100))
                                self.StrideLength = self:GetWalkStrideLength()
                                self.StrideHeight = self:GetWalkStrideHeight()
                                self.AnimationSpeed = 2*(self.DakSpeed)*(50/(self.Radius*self.StrideLength))/(1.1875)
                                self.HipBobMultiplier = self:GetWalkHipBobMultiplier()
                            end
                            if (self.LeftLeg.DakHealth <= 0)or(self.RightLeg.DakHealth <= 0) then
                                self.AnimationSpeed = self.AnimationSpeed*2.5
                            end
                            if self.Crouch==0 then
                                if self.MoveLeft>0 then
                                    self.Yaw = self.Yaw+(1*self.DakSpeed)
                                end
                                if self.MoveRight>0 then
                                    self.Yaw = self.Yaw-(1*self.DakSpeed)
                                end
                            end

                            if self.MoveForward>0 then
                                if self.Perc < 100 then
                                    self.Perc = self.Perc + 1
                                end
                                if self.RightIncrement<-360 then
                                    self.RightIncrement = 0
                                end
                                self.RightIncrement = (self.RightIncrement - (math.abs(self.Perc/100))*self.AnimationSpeed*(self.ForceMult/1))
                                self.LeftIncrement = self.RightIncrement + 180
                            end
                            if self.MoveReverse>0 then
                                if self.Perc > -100 then
                                    self.Perc = self.Perc - 1
                                end
                                if self.RightIncrement>360 then
                                    self.RightIncrement = 0
                                end
                                self.RightIncrement = (self.RightIncrement + (math.abs(self.Perc/100))*self.AnimationSpeed*(self.ForceMult/1))
                                self.LeftIncrement = self.RightIncrement + 180          
                            end
                        
                        self.ForwardVec = Vector(0,0,0)--Vector(self.Perc/10*Vector(1,0,0)*0.77*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)

                        if self.RightLeg.DakHealth <= 0 then
                            self.StrideLength = self.StrideLength*0.5
                            self.RightStride = Vector(   self.StrideCenter+(self.Radius*self.StrideLength*0.25)*math.cos(math.pi/180*(self.RightIncrement*9))   ,0, math.Clamp((self.Radius*self.StrideHeight*0.4)*math.sin(math.pi/180*(self.RightIncrement*9)),0,0.5*(self.Radius*self.StrideHeight) ) ) * math.abs(self.Perc)/100
                        else
                            self.RightStride = Vector(   self.StrideCenter+(self.Radius*self.StrideLength)*math.cos(math.pi/180*(self.RightIncrement*9))   ,0, math.Clamp((self.Radius*self.StrideHeight)*math.sin(math.pi/180*(self.RightIncrement*9)),0,0.5*(self.Radius*self.StrideHeight) ) ) * math.abs(self.Perc)/100
                        end
                        if self.LeftLeg.DakHealth <= 0 then
                            self.StrideLength = self.StrideLength*0.5
                            self.LeftStride = Vector(   self.StrideCenter+(self.Radius*self.StrideLength*0.25)*math.cos(math.pi/180*(self.LeftIncrement*9))   ,0, math.Clamp((self.Radius*self.StrideHeight*0.4)*math.sin(math.pi/180*(self.LeftIncrement*9)),0,0.5*(self.Radius*self.StrideHeight) ) ) * math.abs(self.Perc)/100
                        else
                            self.LeftStride = Vector(   self.StrideCenter+(self.Radius*self.StrideLength)*math.cos(math.pi/180*(self.LeftIncrement*9))   ,0, math.Clamp((self.Radius*self.StrideHeight)*math.sin(math.pi/180*(self.LeftIncrement*9)),0,0.5*(self.Radius*self.StrideHeight) ) ) * math.abs(self.Perc)/100
                        end

                        if not(self.MoveForward>0) and not(self.MoveReverse>0) then
                            if self.Crouch==0 then
                                if self.MoveLeft>0 then
                                    if self.RightIncrement<-360 then
                                        self.RightIncrement = 0
                                    end
                                    self.RightIncrement = (self.RightIncrement - 0.5)
                                    self.LeftIncrement = self.RightIncrement + 180
                                end
                                if self.MoveRight>0 then
                                    if self.RightIncrement<-360 then
                                        self.RightIncrement = 0
                                    end
                                    self.RightIncrement = (self.RightIncrement + 0.5)
                                    self.LeftIncrement = self.RightIncrement + 180
                                end
                                if self.MoveRight>0 or self.MoveLeft>0 then
                                    if self.RightLeg.DakHealth <= 0 then
                                        self.RightStride = (Vector( 0,0, (self.Radius*self.StrideHeight*0.4)*math.sin(math.pi/180*(self.RightIncrement*9))/2 ) )
                                    else
                                        self.RightStride = (Vector( 0,0, (self.Radius*self.StrideHeight)*math.sin(math.pi/180*(self.RightIncrement*9))/2 ) )
                                    end
                                    if self.LeftLeg.DakHealth <= 0 then
                                        self.LeftStride = (Vector( 0,0, (self.Radius*self.StrideHeight*0.4)*math.sin(math.pi/180*(self.LeftIncrement*9))/2 ) )
                                    else
                                        self.LeftStride = (Vector( 0,0, (self.Radius*self.StrideHeight)*math.sin(math.pi/180*(self.LeftIncrement*9))/2 ) )
                                    end
                                end
                            end
                            self.brake = 2
                            self.vertbrake = 2
                            self.footbrake = 2
                        else
                            self.brake = 1.5
                            self.vertbrake = 1.5
                            self.footbrake = 1
                        end

                        if (self.Crouch>0)or(self.LAMToggle>0)or(self.Active==0) then
                            if self.CrouchPerc < 100 then
                                self.CrouchPerc = self.CrouchPerc + 1
                            end
                            if (self.LAMToggle>0) then
                                self.brake = 0
                                self.vertbrake = 0
                                self.footbrake = 0
                                self.RightStride = Vector(0,0,self.CrouchPercent*(self.HipHeight+self:GetExtraHeight()))
                                self.LeftStride = Vector(0,0,self.CrouchPercent*(self.HipHeight+self:GetExtraHeight()))
                            else
                                self.RightStride = Vector(0,0,0)
                                self.LeftStride = Vector(0,0,0)
                            end
                            self.HeightMult = 1-(self.CrouchPercent*self.CrouchPerc/100)
                            self.ForwardVec = Vector(0,0,0)
                            self.HipForce = Vector(0,0,0)
                        else
                            if self.CrouchPerc > 0 then
                                self.CrouchPerc = self.CrouchPerc - 1
                            end
                            self.HeightMult = 1-(self.CrouchPercent*self.CrouchPerc/100)
                            self.ForwardVec = Vector(0,0,0)--Vector(self.Perc/10*Vector(1,0,0)*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)
                            
                            self.HipForce = Vector(self.Perc/10*self:GetForward()*50*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)*self.phy:GetMass()
                        end     

                        self.NegLeftPos = (self.phy:GetVelocity() / (1 / engine.TickInterval()))+Vector(   (self.LeftBasePos.x+self.LeftStride.x)*math.cos(self.Yaw*math.pi/180) , (self.LeftBasePos.x+self.LeftStride.x)*math.sin(self.Yaw*math.pi/180) , math.abs(self.LeftFoot:GetRotatedAABB(self.LeftFoot:OBBMins(),self.LeftFoot:OBBMaxs()).z)+self.HeightMult*(self.LeftBasePos.z-self:GetExtraHeight()+self.LeftStride.z)  )
                        self.NegRightPos = (self.phy:GetVelocity() / (1 / engine.TickInterval()))+Vector(   (self.RightBasePos.x+self.RightStride.x)*math.cos(self.Yaw*math.pi/180) , (self.RightBasePos.x+self.RightStride.x)*math.sin(self.Yaw*math.pi/180) , math.abs(self.RightFoot:GetRotatedAABB(self.RightFoot:OBBMins(),self.RightFoot:OBBMaxs()).z)+self.HeightMult*(self.RightBasePos.z-self:GetExtraHeight()+self.RightStride.z)  )

                        self.LNegForce = (Vector(self.Perc/10*self.LeftFoot:GetForward()*0.77*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)+Vector((self.base:GetPos()+self.NegLeftPos)-self.LeftFoot:GetPos()))*15
                        self.RNegForce = (Vector(self.Perc/10*self.RightFoot:GetForward()*0.77*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)+Vector((self.base:GetPos()+self.NegRightPos)-self.RightFoot:GetPos()))*15


                        self.NegationForce = (math.abs(self.Perc)/100)*self.phy:GetMass()*(Vector(self.LNegForce.x + self.RNegForce.x,self.LNegForce.y + self.RNegForce.y,0))

                        self.LeftPos = (self.phy:GetVelocity() / (1 / engine.TickInterval()))+ Vector(   (self.LeftBasePos.x+self.LeftStride.x)*math.cos(self.Yaw*math.pi/180) - (self.LeftBasePos.y+self.LeftStride.y)*math.sin(self.Yaw*math.pi/180) , (self.LeftBasePos.x+self.LeftStride.x)*math.sin(self.Yaw*math.pi/180) + (self.LeftBasePos.y+self.LeftStride.y)*math.cos(self.Yaw*math.pi/180) , math.abs(self.LeftFoot:GetRotatedAABB(self.LeftFoot:OBBMins(),self.LeftFoot:OBBMaxs()).z)+self.HeightMult*(self.LeftBasePos.z-self:GetExtraHeight()+self.LeftStride.z)  )
                        self.RightPos = (self.phy:GetVelocity() / (1 / engine.TickInterval()))+ Vector(   (self.RightBasePos.x+self.RightStride.x)*math.cos(self.Yaw*math.pi/180) - (self.RightBasePos.y+self.RightStride.y)*math.sin(self.Yaw*math.pi/180) , (self.RightBasePos.x+self.RightStride.x)*math.sin(self.Yaw*math.pi/180) + (self.RightBasePos.y+self.RightStride.y)*math.cos(self.Yaw*math.pi/180) , math.abs(self.RightFoot:GetRotatedAABB(self.RightFoot:OBBMins(),self.RightFoot:OBBMaxs()).z)+self.HeightMult*(self.RightBasePos.z-self:GetExtraHeight()+self.RightStride.z)  )

                        self.LeftForce = (Vector(self.Perc/10*self.LeftFoot:GetForward()*0.77*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)+Vector((self.base:GetPos()+self.LeftPos)-self.LeftFoot:GetPos()-self.LeftFoot:GetVelocity()*(0.05*self.footbrake)))*self.LeftFoot:GetPhysicsObject():GetMass()*15
                        self.RightForce = (Vector(self.Perc/10*self.RightFoot:GetForward()*0.77*self.DakSpeed*self.ForceMult*self.DakHealth/self.DakMaxHealth)+Vector((self.base:GetPos()+self.RightPos)-self.RightFoot:GetPos()-self.RightFoot:GetVelocity()*(0.05*self.footbrake)))*self.RightFoot:GetPhysicsObject():GetMass()*15
                        self.Bob = self.HipBobMultiplier*0.1*((self.LeftForce.z/self.LeftFoot:GetPhysicsObject():GetMass())+(self.RightForce.z/self.RightFoot:GetPhysicsObject():GetMass()))

                        self.LeftFoot:GetPhysicsObject():ApplyForceCenter(self.LeftForce+((1.5*self.HipForce/self.phy:GetMass())*self.LeftFoot:GetPhysicsObject():GetMass()))            
                        self.RightFoot:GetPhysicsObject():ApplyForceCenter(self.RightForce+((1.5*self.HipForce/self.phy:GetMass())*self.RightFoot:GetPhysicsObject():GetMass()))  

                        
                        self.HoverPos=Vector((self.POS).x,(self.POS).y,(self.POS.z+(self.HeightMult*self.HipHeight)-math.Clamp(self.Bob,-100,100)))

                            if (self.LAMToggle==0) then
                                if ((self.HoverPos-self.base:GetPos()-self.base:GetVelocity()*0.1)*self.phy:GetMass()).z > 0 then
                                    self.phy:ApplyForceCenter( Vector(self.HoverPos.x-self.base:GetPos().x-self.base:GetVelocity().x*0.1*self.brake*self.phy:GetMass(),self.HoverPos.y-self.base:GetPos().y-self.base:GetVelocity().y*0.1*self.brake*self.phy:GetMass(),((self.HoverPos-self.base:GetPos()-self.base:GetVelocity()*0.1*self.vertbrake)*self.phy:GetMass()*10).z))            
                                else
                                    self.phy:ApplyForceCenter( Vector(self.HoverPos.x-self.base:GetPos().x-self.base:GetVelocity().x*0.1*self.brake*self.phy:GetMass(),self.HoverPos.y-self.base:GetPos().y-self.base:GetVelocity().y*0.1*self.brake*self.phy:GetMass(),((self.HoverPos-self.base:GetPos()-self.base:GetVelocity()*0.1*self.vertbrake)*self.phy:GetMass()*10).z))            
                                end
                                self.phy:ApplyForceCenter(self.HipForce-(self.NegationForce*0.5))
                            end
                            self.phy:AddAngleVelocity(-self.phy:GetAngleVelocity())
                        end

                        if self.Yaw < -180 then
                            self.Yaw = 180
                        end
                        if self.Yaw > 180 then
                            self.Yaw = -180
                        end

                        local AngleDiff = Angle(0,0,0)-self:GetAngles()
                        self.YawDiff = (self.Yaw)-self:GetAngles().yaw

                        if self.YawDiff > 180 then
                            self.YawDiff = self.YawDiff-360
                        end
                        if self.YawDiff< -180 then
                            self.YawDiff = self.YawDiff+360
                        end
                    
                        local RotVec = Vector(AngleDiff.r*100,AngleDiff.p*100,self.YawDiff*25)
                        if self.LAMToggle==0 then
                           self.phy:AddAngleVelocity(RotVec)
                        end

                        --Step Sound
                        local LeftRay = {}
                        LeftRay.start = self.LeftFoot:GetPos()
                        LeftRay.endpos = self.LeftFoot:GetPos() + (Vector(0,0,-1.5) * ((math.abs(math.max(self.LeftFoot:OBBMins().x,self.LeftFoot:OBBMins().y,self.LeftFoot:OBBMins().z)) + math.abs(math.min(self.LeftFoot:OBBMaxs().x,self.LeftFoot:OBBMaxs().y,self.LeftFoot:OBBMaxs().z)))/2) )
                        LeftRay.filter = self.Filters
                        LeftRay.mask = MASK_SOLID_BRUSHONLY
                        self.LeftRay = util.TraceLine( LeftRay )
                        local RightRay = {}
                        RightRay.start = self.RightFoot:GetPos()
                        RightRay.endpos = self.RightFoot:GetPos() + (Vector(0,0,-1.5) * ((math.abs(math.max(self.RightFoot:OBBMins().x,self.RightFoot:OBBMins().y,self.RightFoot:OBBMins().z)) + math.abs(math.min(self.RightFoot:OBBMaxs().x,self.RightFoot:OBBMaxs().y,self.RightFoot:OBBMaxs().z)))/2) )
                        RightRay.filter = self.Filters
                        RightRay.mask = MASK_SOLID_BRUSHONLY
                        self.RightRay = util.TraceLine( RightRay )


                        local StepSoundList = {}
                        if self.DakTotalMass <= 40000 then
                            StepSoundList = {"npc/dog/dog_footstep2.wav","npc/dog/dog_footstep3.wav"}
                        end
                        if self.DakTotalMass > 40000 and self.DakTotalMass <= 75000 then
                            StepSoundList = {"npc/dog/dog_footstep_run2.wav","npc/dog/dog_footstep_run3.wav"}
                        end
                        if self.DakTotalMass > 75000 then
                            StepSoundList = {"physics/concrete/boulder_impact_hard3.wav","physics/concrete/boulder_impact_hard3.wav"}
                        end

                        if self.LeftRay.Hit == true and(not(self.OldLeftHit==self.LeftRay.Hit)) then
                            self.LeftFoot:EmitSound( StepSoundList[math.random(1,2)], 100, 80, 1)
                        end
                        if self.RightRay.Hit == true and(not(self.OldRightHit==self.RightRay.Hit)) then
                            self.RightFoot:EmitSound( StepSoundList[math.random(1,2)], 100, 80, 1)
                        end


                        self.OldLeftHit = self.LeftRay.Hit
                        self.OldRightHit = self.RightRay.Hit


                    end
                end
                self.base:GetPhysicsObject():EnableGravity( false )
            end
        else
            if not(self.deadcontraption[1]:GetPhysicsObject():IsGravityEnabled()) or not(self.EntCount==table.Count(self.DakEngine.Contraption)) then
                for i=1, #self.deadcontraption do
                    if not(self.deadcontraption[i]==NULL) then
                        if self.deadcontraption[i]:IsSolid() then
                            if IsEntity( self.deadcontraption[i] ) then
                                if self.deadcontraption[i]:IsValid() then
                                    self.deadcontraption[i]:GetPhysicsObject():EnableGravity( true )
                                end
                            end
                        end
                    end
                end
                self.EntCount = table.Count(self.DakEngine.Contraption)
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
    info.WalkStrideLength = self:GetWalkStrideLength()
    info.WalkStrideHeight = self:GetWalkStrideHeight()
    info.SprintStrideLength = self:GetSprintStrideLength()
    info.SprintStrideHeight = self:GetSprintStrideHeight()
    info.BaseID = self.base:EntIndex()
    info.LeftID = self.LeftFoot:EntIndex()
    info.RightID = self.RightFoot:EntIndex()
    info.DakTotalMass = self.DakEngine.TotalMass

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
        local Base = CreatedEntities[ Ent.EntityMods.DakTek.BaseID ]
        if Base and IsValid(Base) then
            self.base = Base
        end
        local LeftFoot = CreatedEntities[ Ent.EntityMods.DakTek.LeftID ]
        if LeftFoot and IsValid(LeftFoot) then
            self.LeftFoot = LeftFoot
        end
        local RightFoot = CreatedEntities[ Ent.EntityMods.DakTek.RightID ]
        if RightFoot and IsValid(RightFoot) then
            self.RightFoot = RightFoot
        end
        self.DakName = Ent.EntityMods.DakTek.DakName
        self.DakMass = Ent.EntityMods.DakTek.DakMass
        self.DakModel = Ent.EntityMods.DakTek.DakModel
        self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
        self.DakHealth = Ent.EntityMods.DakTek.DakHealth
        self.DakSpeed = Ent.EntityMods.DakTek.DakSpeed
        self.DakSound = Ent.EntityMods.DakTek.DakSound
        self.DakHealth = self.DakMaxHealth
        self.DakTotalMass = Ent.EntityMods.DakTek.DakTotalMass

        --if self:GetStrideCenter() == nil then
        --    self.StrideCenter = 0
        --    self:SetStrideCenter(0)
        --else
        --    self.StrideCenter = Ent.EntityMods.DakTek.StrideCenter
        --    self:SetStrideCenter(Ent.EntityMods.DakTek.StrideCenter)
        --end
        if self:GetWalkStrideLength() == nil or self:GetWalkStrideLength() == 0 then
            self.WalkStrideLength = 1
            self:SetWalkStrideLength(1)
        else
            self.WalkStrideLength = Ent.EntityMods.DakTek.WalkStrideLength
            self:SetWalkStrideLength(Ent.EntityMods.DakTek.WalkStrideLength)
        end
        if self:GetWalkStrideHeight() == nil or self:GetWalkStrideHeight() == 0 then
            self.WalkStrideHeight = 1
            self:SetWalkStrideHeight(1)
        else
            self.WalkStrideHeight = Ent.EntityMods.DakTek.WalkStrideHeight
            self:SetWalkStrideHeight(Ent.EntityMods.DakTek.WalkStrideHeight)
        end
        if self:GetSprintStrideLength() == nil or self:GetSprintStrideLength() == 0 then
            self.SprintStrideLength = 1
            self:SetSprintStrideLength(1)
        else
            self.SprintStrideLength = Ent.EntityMods.DakTek.SprintStrideLength
            self:SetSprintStrideLength(Ent.EntityMods.DakTek.SprintStrideLength)
        end
        if self:GetSprintStrideHeight() == nil or self:GetSprintStrideHeight() == 0 then
            self.SprintStrideHeight = 1
            self:SetSprintStrideHeight(1)
        else
            self.SprintStrideHeight = Ent.EntityMods.DakTek.SprintStrideHeight
            self:SetSprintStrideHeight(Ent.EntityMods.DakTek.SprintStrideHeight)
        end

        self.HipHeight = Vector(0,0,self.base:GetPos().z):Distance((Vector(0,0,self.LeftFoot:GetPos().z)+Vector(0,0,self.RightFoot:GetPos().z))/2)

        self.LeftBasePos = self.base:WorldToLocal( self.LeftFoot:GetPos() )
        self.RightBasePos = self.base:WorldToLocal( self.RightFoot:GetPos() )

        self.DakOwner = Player
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
    self.LeftLeg.DakIsLeg = 0
    self.RightLeg.DakIsLeg = 0

    self.LeftTorso.DakIsLeg = 0
    self.RightTorso.DakIsLeg = 0
    self.FrontTorso.DakIsLeg = 0
    self.RearTorso.DakIsLeg = 0
    
    if self.Sound then
        self.Sound:Stop()
    end
    if not(self.deadcontraption==nil) then
        for i=1, #self.deadcontraption do
            if not(self.deadcontraption[i]==NULL) then
                if self.deadcontraption[i]:IsSolid() then
                    if IsEntity( self.deadcontraption[i] ) then
                        if self.deadcontraption[i]:GetPhysicsObject():IsValid() then   
                            self.deadcontraption[i]:GetPhysicsObject():EnableGravity( true )
                        end
                    end
                end
            end
        end
    end
end