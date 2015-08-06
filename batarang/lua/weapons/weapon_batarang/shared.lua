if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "melee"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Batarang"			
	SWEP.Author			= "Rottweiler"
	SWEP.Slot			= 1
	SWEP.SlotPos			= 7
	SWEP.ViewModelFOV		= 86
	SWEP.IconLetter			= "x"
	killicon.Add( "batarang", "batarang/deathicon", Color( 180, 0, 0, 255 ) );
	killicon.AddAlias( "weapon_batarang", "batarang" );
	killicon.AddAlias( "ent_batarang", "batarang" );


end

------------General Swep Info---------------
SWEP.Author   	    = "Rottweiler"
SWEP.Contact        = "n/a"
SWEP.Purpose        = "Throw batarangs."
SWEP.Instructions   = "Left click throws a batarang."
SWEP.Spawnable      = true
SWEP.AdminSpawnable = true
SWEP.UseHands		= true
-----------------------------------------------

------------Models---------------------------
SWEP.ViewModel      = "models/rottweiler/v_batarang.mdl"
SWEP.WorldModel   = "models/rottweiler/w_batarang.mdl"
-----------------------------------------------

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0.5		--Gun Kick
SWEP.Primary.Damage			= 100	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 100
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------
 
-- function SWEP:Reload() --To do when reloading
-- end 
 
 if ( CLIENT ) then
	function SWEP:GetViewModelPosition( pos, ang )
		pos = pos + ang:Forward()*4
		return pos, ang
	end 
end
 
function SWEP:Think() -- Called every frame
end

function SWEP:Initialize()
--util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
util.PrecacheSound("weapons/batarang/throw1.wav")
util.PrecacheSound("weapons/batarang/throw2.wav")
util.PrecacheSound("weapons/batarang/throw3.wav")
util.PrecacheSound("weapons/batarang/throw4.wav")
end

function SWEP:PrimaryAttack()
	self.Weapon:EmitSound("weapons/batarang/throw"..tostring( math.random( 1, 4 ) )..".wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.8)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	if SERVER then
		local batarang = ents.Create("ent_batarang")
		batarang:SetAngles(self.Owner:EyeAngles())-- Angle(0,90,0))
		batarang:SetPos(self.Owner:GetShootPos())
		batarang:SetOwner(self.Owner)
		batarang:SetPhysicsAttacker(self.Owner)
		batarang:Spawn()
		batarang:Activate()
		local phys = batarang:GetPhysicsObject()
		phys:SetVelocity(self.Owner:GetAimVector()*7000)
		phys:AddAngleVelocity(Vector(0,0,90))
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:EmitSound("weapons/batarang/throw"..tostring( math.random( 1, 4 ) )..".wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.8)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.8)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	if SERVER then
		local batarang = ents.Create("ent_batarang_explosive")
		batarang:SetAngles(self.Owner:EyeAngles())-- Angle(0,90,0))
		batarang:SetPos(self.Owner:GetShootPos())
		batarang:SetOwner(self.Owner)
		batarang:SetPhysicsAttacker(self.Owner)
		batarang:Spawn()
		batarang:Activate()
		local phys = batarang:GetPhysicsObject()
		phys:SetVelocity(self.Owner:GetAimVector()*7000)
		phys:AddAngleVelocity(Vector(0,0,90))
	end
end