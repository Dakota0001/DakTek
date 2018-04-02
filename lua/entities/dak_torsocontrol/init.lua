AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DakMaxHealth = 10
ENT.DakHealth = 10
ENT.DakName = "Torso Control"

function normalizedVector(vector)
    local len = (vector[1] * vector[1] + vector[2] * vector[2] + vector[3] * vector[3]) ^ 0.5
    if len > 0.0000001000000 then
        return Vector( vector[1] / len, vector[2] / len, vector[3] / len )
    else
        return Vector( 0, 0, 0 )
    end
end

local function angnorm(rv1)
    return Angle((rv1[1] + 180) % 360 - 180,(rv1[2] + 180) % 360 - 180,(rv1[3] + 180) % 360 - 180)
end

local function angClamp(ang,clamp1,clamp2)
    return Angle(math.Clamp(ang.pitch,clamp1.pitch,clamp2.pitch),math.Clamp(ang.yaw,clamp1.yaw,clamp2.yaw),math.Clamp(ang.roll,clamp1.roll,clamp2.roll))
end

local function angNumClamp(ang,clamp1,clamp2)
    return Angle(math.Clamp(ang.pitch,clamp1,clamp2),math.Clamp(ang.yaw,clamp1,clamp2),math.Clamp(ang.roll,clamp1,clamp2))
end

local function checkVector(v)
    return     -math.huge < v[1] and v[1] < math.huge and
            -math.huge < v[2] and v[2] < math.huge and
            -math.huge < v[3] and v[3] < math.huge
end

local function applyTorque(phys, torque)
    if not checkVector(torque) then return end
    local torqueamount = torque:Length()
    if torqueamount < 1.192093e-07 then return end

    -- Convert torque from local to world axis
    torque = phys:LocalToWorldVector(torque / torqueamount)

    -- Find two vectors perpendicular to the torque axis
    local off
    if math.abs(torque.x) > 0.1 or math.abs(torque.z) > 0.1 then
        off = Vector(-torque.z, 0, torque.x):GetNormalized()
    else
        off = Vector(-torque.y, torque.x, 0):GetNormalized()
    end
    local dir = torque:Cross(off)
    off = off * torqueamount * 0.5

    phys:ApplyForceOffset(dir, off)
    phys:ApplyForceOffset(dir * -1, off * -1)
end

--stoled from StarfallEx
-- faster access to some math library functions
local math = math -- Because global lookups suck
--local setmetatable = setmetatable
local abs   = math.abs
local Round = math.Round
local sqrt  = math.sqrt
local exp   = math.exp
local log   = math.log
local sin   = math.sin
local cos   = math.cos
local sinh  = math.sinh
local cosh  = math.cosh
local acos  = math.acos
local min     = math.min

local delta = 0.0000001000000

local isValid = IsValid

local deg2rad = math.pi / 180
local rad2deg = 180 / math.pi

local function qmul(lhs, rhs)
    local lhs1, lhs2, lhs3, lhs4 = lhs[1], lhs[2], lhs[3], lhs[4]
    local rhs1, rhs2, rhs3, rhs4 = rhs[1], rhs[2], rhs[3], rhs[4]
    return {lhs1 * rhs1 - lhs2 * rhs2 - lhs3 * rhs3 - lhs4 * rhs4,
        lhs1 * rhs2 + lhs2 * rhs1 + lhs3 * rhs4 - lhs4 * rhs3,
        lhs1 * rhs3 + lhs3 * rhs1 + lhs4 * rhs2 - lhs2 * rhs4,
        lhs1 * rhs4 + lhs4 * rhs1 + lhs2 * rhs3 - lhs3 * rhs2}
end

local function qdiv(lhs,rhs)
    local lhs1, lhs2, lhs3, lhs4 = lhs[1], lhs[2], lhs[3], lhs[4]
    local rhs1, rhs2, rhs3, rhs4 = rhs[1], rhs[2], rhs[3], rhs[4]
    local l = rhs1 * rhs1 + rhs2 * rhs2 + rhs3 * rhs3 + rhs4 * rhs4
    return {
        (lhs1 * rhs1 + lhs2 * rhs2 + lhs3 * rhs3 + lhs4 * rhs4) / l,
        (-lhs1 * rhs2 + lhs2 * rhs1 - lhs3 * rhs4 + lhs4 * rhs3) / l,
        (-lhs1 * rhs3 + lhs3 * rhs1 - lhs4 * rhs2 + lhs2 * rhs4) / l,
        (-lhs1 * rhs4 + lhs4 * rhs1 - lhs2 * rhs3 + lhs3 * rhs2) / l}
end

local function quat(ang)
    local p, y, r = ang.p, ang.y, ang.r
    p = p * deg2rad * 0.5
    y = y * deg2rad * 0.5
    r = r * deg2rad * 0.5
    local qr = { cos(r), sin(r), 0, 0 }
    local qp = { cos(p), 0, sin(p), 0 }
    local qy = { cos(y), 0, 0, sin(y) }
    return qmul(qy, qmul(qp, qr))
end

--- Returns the rotation vector - rotation axis where magnitude is the angle of rotation in degress (by coder0xff)
local function rotationVector(q)
    local l2 = q[1] * q[1] + q[2] * q[2] + q[3] * q[3] + q[4] * q[4]
    local m2 = math.max(q[2] * q[2] + q[3] * q[3] + q[4] * q[4], 0)
    if l2 == 0 or m2 == 0 then return Vector(0, 0, 0) end
    local s = 2 * acos(math.Clamp(q[1] / sqrt(l2), -1, 1)) * rad2deg
    if s > 180 then s = s - 360 end
    s = s / sqrt(m2)
    return Vector(q[2] * s, q[3] * s, q[4] * s)
end

function ENT:Initialize()
    self:SetModel( "models/beer/wiremod/gate_e2_mini.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.DakHealth = self.DakMaxHealth
    self.DakArmor = 10
    local phys = self:GetPhysicsObject()
    self.timer = CurTime()

    if(IsValid(phys)) then
        phys:Wake()
    end

    self.Inputs = Wire_CreateInputs(self, { "Active", "Gyro [ENTITY]", "CamTrace [RANGER]", "CamAng [ANGLE]" })
    self.Soundtime = CurTime()
    self.SparkTime = CurTime()
    self.ErrorTime = CurTime()
    self.ErrorTime2 = CurTime()
    self.SlowThinkTime = CurTime()
    self.RotMult = 2
    self.SentError = 0
    self.SentError2 = 0
    self.LastHullAngles = self:GetAngles()
    self.DakBurnStacks = 0
end

function ENT:Think()
    local Gyro = self.Inputs.Gyro.Value
    if IsValid(Gyro) then
        if Gyro.DakEngine.TotalMass then
            self.RotMult = (Gyro.DakHealth/Gyro.DakMaxHealth)*(Gyro.DakSpeed*15)
            local Elevation = self:GetElevation()
            local Depression = self:GetDepression()
            --commented out yaw limits until clamping issue is fixed
            --local YawMin = self:GetYawMin()
            --local YawMax = self:GetYawMax()
            local YawMin = 360
            local YawMax = 360
            self.DakActive = self.Inputs.Active.Value
            self.RotationSpeed = self.RotMult * (50000/Gyro.DakEngine.TotalMass)
            self.DakCamTrace = self.Inputs.CamTrace.Value
            self.DakCamAng = self.Inputs.CamAng.Value

            if self.DakActive > 0 then
                if self.DakCamTrace then
                    local GunDir = normalizedVector(self.DakCamTrace.HitPos - self:GetPos())
                    local LocalTar=angClamp(Gyro:WorldToLocalAngles(GunDir:Angle()),
                        Angle(-math.min(Elevation,math.abs(self.DakCamAng.pitch)), -YawMin, -0.0001),
                        Angle(math.min(Depression,math.abs(self.DakCamAng.pitch)), YawMax, 0.0001)
                    )
                    local LocalCur=Gyro:WorldToLocalAngles(self:GetAngles())
                    local LocalDiff=angNumClamp(angnorm(LocalTar-LocalCur), -self.RotationSpeed, self.RotationSpeed)
                    local LocalAng=LocalCur + LocalDiff
                    local Ang=Gyro:LocalToWorldAngles(LocalAng)

                    local tarAng=Ang
                    local tarQ=quat(tarAng)
                    local curQ=quat(self:GetAngles())

                    
                    local qd=qdiv(tarQ, curQ)

                    if (self.LastYaw == -YawMin and self.CurYaw == YawMax) or (self.CurYaw == -YawMin and self.LastYaw == YawMax) then
                    	self.Switch = 1
                    end

                    local phys=self:GetParent():GetParent():GetPhysicsObject()
                    local v=phys:WorldToLocalVector(rotationVector(qd))
	                applyTorque(phys, (v*300 - phys:GetAngleVelocity()*25)*phys:GetInertia())
                end
            else
                if IsValid(self:GetParent()) then
                    local LocalCur=Gyro:WorldToLocalAngles(self:GetAngles())
                    local LocalDiff=angNumClamp(angnorm(Angle(0,0,0)-LocalCur), -self.RotationSpeed, self.RotationSpeed)
                    local LocalAng=LocalCur + LocalDiff
                    local Ang=Gyro:LocalToWorldAngles(LocalAng)

                    local tarAng=Ang
                    local tarQ=quat(tarAng)
                    local curQ=quat(self:GetAngles())
                    local qd=qdiv(tarQ, curQ)
                    local phys=self:GetParent():GetParent():GetPhysicsObject()
                    local v=phys:WorldToLocalVector(rotationVector(qd))
                    applyTorque(phys, (v*300 - phys:GetAngleVelocity()*25)*phys:GetInertia())
                end
            end
        end
    end
    self:NextThink(CurTime())
    return true
end

function ENT:PreEntityCopy()
    local info = {}
    local entids = {}

    if IsValid(self.DakTurretMotor) then
        info.TurretMotorID = self.DakTurretMotor:EntIndex()
    end

    info.DakName = self.DakName
    info.DakHealth = self.DakHealth
    info.DakMaxHealth = self.DakBaseMaxHealth
    info.DakMass = self.DakMass
    info.DakOwner = self.DakOwner
    duplicator.StoreEntityModifier( self, "DakTek", info )
    //Wire dupe info
    self.BaseClass.PreEntityCopy( self )
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
    if (Ent.EntityMods) and (Ent.EntityMods.DakTek) then

        local TurretMotor = CreatedEntities[ Ent.EntityMods.DakTek.TurretMotorID ]
        if TurretMotor and IsValid(TurretMotor) then
            self.DakTurretMotor = TurretMotor
        end

        self.DakName = Ent.EntityMods.DakTek.DakName
        self.DakHealth = Ent.EntityMods.DakTek.DakHealth
        self.DakMaxHealth = Ent.EntityMods.DakTek.DakMaxHealth
        self.DakMass = Ent.EntityMods.DakTek.DakMass
        self.DakOwner = Player
        Ent.EntityMods.DakTek = nil
    end
    self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )
end