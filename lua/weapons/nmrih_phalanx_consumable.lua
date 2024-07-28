if SERVER then
   AddCSLuaFile()
end

if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/item_pills" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "Phalanx"
SWEP.Author = "Craft_Pig"
SWEP.Purpose = "Heals 30 hp over time"
SWEP.Category = "Craft_Pig"
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/nmrih/items/phalanx/v_item_phalanx.mdl"
SWEP.WorldModel = "models/weapons/nmrih/items/phalanx/w_phalanx.mdl"
SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false 
SWEP.UseHands = true

SWEP.Primary.Ammo = "nmrih_phanlax"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.HitDistance = 45

local HealAmount = 0
local ArmorAmount = 0
local HealTime = 5
local RegenAmount = 1
local RegenDuration = 30
local AttackTime = 0.8

local SecondaryAttacking = false

function SWEP:Initialize()
    self:SetHoldType("pistol")
	
	IsInfectiousZombieAddonMounted = false
	
	if xdeif_Cure then
	    IsInfectiousZombieAddonMounted = true
	end
end  

function SWEP:Deploy()
    local owner = self:GetOwner() 

    self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 0)
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then
        owner:StripWeapon("nmrih_phalanx_consumable")
	end
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.Idle = 0
	self.Move = 0
	self.Sprint = 0
	self.Consume = 0
	self.Attack = 0
	timer.Remove( "ConsumeTimerPhalanxNMRIH" )
end

function SWEP:Think()
    local owner = self:GetOwner()
	
    if self.Idle == 0 and self.IdleTimer <= CurTime() then
		self:SendWeaponAnim(ACT_VM_IDLE)  
        self.Idle = 1
    end
	
	if SecondaryAttacking == false then
	    if owner:KeyDown(IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT) and self.Move == 0 and self.Consume == 0 then
	        if self.Move == 0 and self.IdleTimer <= CurTime() then
		        self:SendWeaponAnim(ACT_VM_IDLE_LOWERED)  
		        self.Move = 1
		    end
	    elseif not owner:KeyDown(IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT) and self.Consume == 0 then
	        if self.Move == 1 and self.IdleTimer <= CurTime() then
		        self.Move = 0
			    self.Idle = 0
		    end
	    end
	 
	    if owner:KeyDown(IN_FORWARD + IN_BACK + IN_MOVELEFT + IN_MOVERIGHT) and owner:KeyDown(IN_SPEED) and self.Sprint == 0 and self.Consume == 0 then
	        if self.Sprint == 0 and self.IdleTimer <= CurTime() then
		        self:SendWeaponAnim(ACT_VM_SPRINT_IDLE)  
		        self.Sprint = 1
		    end
	    elseif not owner:KeyDown(IN_SPEED) and self.Consume == 0 then
	        if self.Sprint == 1 and self.IdleTimer <= CurTime() then
		        self.Sprint = 0
			    self.Idle = 0
			    self.Move = 0
		    end
	    end
	end
end

function SWEP:PrimaryAttack()
    local owner = self.Owner
	local ent = self.Owner
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end
	
	if SecondaryAttacking == false then
	    self.Idle = 1
	    self.Move = 1
	    self.Consume = 1
	    self:SetNextPrimaryFire(CurTime() + HealTime + 0)
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	    timer.Create("ConsumeTimerPhalanxNMRIH", HealTime, 1, function()
            
			HealPhalanxNMRIH(ent, self)		
			if IsValid(self) and IsValid(owner) and owner:IsPlayer() and owner:Alive() then
			   self:RegenerateHealthNMRIH(ent, owner)
			end
        end)	
	end
end

function HealPhalanxNMRIH(ent, self)
    local activeWeapon = ent:GetActiveWeapon()
	
	if IsValid(self) then
        if ( IsValid( ent ) && SERVER ) and activeWeapon:GetClass() == "nmrih_phalanx_consumable" then
		    ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + HealAmount))
		    ent:SetArmor(math.min(ent:GetMaxArmor(), ent:Armor() + ArmorAmount))
	
	        if IsInfectiousZombieAddonMounted == true and GetConVar("convar_consumablesnmrih_edelayinf"):GetBool() then
			    xdeif_Cure( ent, vacc, incu )
			end
			
			ent:RemoveAmmo(1, "nmrih_phanlax")
		
		    self:Deploy()
			
        end
	end
end


function SWEP:RegenerateHealthNMRIH(ent, owner)
    if not GetConVar("convar_consumablesnmrih_eregen"):GetBool() then return end
    timer.Create("HealthRegenTimerNMRIH", 0.5, RegenDuration, function()
        if IsValid(owner) and owner:Alive() then
            owner:SetHealth(math.min(owner:Health() + RegenAmount, owner:GetMaxHealth()))
        else
            timer.Remove("HealthRegenTimerNMRIH")
        end
    end)
end

-- Trace code was copied from GMod's fists.lua (https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/weapons/weapon_fists.lua)
function SWEP:SecondaryAttack()
    local owner = self:GetOwner()
	local tr = util.TraceLine( {
		start = owner:GetShootPos(),
		endpos = owner:GetShootPos() + owner:GetAimVector() * self.HitDistance,
		filter = owner,
		mask = MASK_SHOT_HULL
	} )
	if ( !IsValid( tr.Entity ) ) then
		tr = util.TraceHull( {
			start = owner:GetShootPos(),
			endpos = owner:GetShootPos() + owner:GetAimVector() * self.HitDistance,
			filter = owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end
	
	if self.Consume == 1 then return end
	SecondaryAttacking = true
	self:SetNextSecondaryFire(CurTime() + AttackTime + 0)
    self:SendWeaponAnim(ACT_VM_HITCENTER)
	
    timer.Create("AttackTimer", 0.3, 1, function()
	    if SERVER then
	        if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
		        local dmginfo = DamageInfo()
			
                dmginfo:SetDamage(10)
                dmginfo:SetAttacker(self.Owner)
                dmginfo:SetInflictor(self)
                dmginfo:SetDamageType(DMG_CRUSH)
                tr.Entity:TakeDamageInfo(dmginfo)
		    end
	    end        
    end)
	
	timer.Create("AttackCD", AttackTime, 1, function()
        SecondaryAttacking = false
		self.Idle = 0
	    self.Move = 0
	    self.Sprint = 0
    end)
end