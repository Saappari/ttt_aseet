

if SERVER then

   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType			= "ar2"


--if CLIENT then

  -- SWEP.PrintName			= "M16 Silenced"
  -- SWEP.Slot				= 6

   --SWEP.Icon = "VGUI/ttt/icon_m16"
--end
if CLIENT then
   -- Path to the icon material
   SWEP.Icon = "VGUI/ttt/icon_m16"
   -- Text shown in the equip menu
   SWEP.EquipMenuData = {
      type = "Silenced M16",
      desc = "Äänenvaimennettu M16.\nTämä on primary weapon, joten sinulla\nei voi olla muita aseita kuin\npistooli ostaessasi tämän."
   };
end



SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_HEAVY
-- SWEP.WeaponID = AMMO_M16 -- koska "custom" aseet eivät tarvitse tätä

SWEP.Primary.Delay			= 0.19
SWEP.Primary.Recoil			= 1.4 --norm 1.6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Damage = 22
SWEP.Primary.Cone = 0.018
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt" 
-- omat lisäykset
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.LimitedStock = true -- Weapons that are limited in stock can only be bought once per round.
SWEP.AllowDrop = true
SWEP.IsSilent = true
SWEP.PrintName			= "M16 Silenced"
SWEP.Slot				= 2
SWEP.AutoSwitchTo	 = false	 -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom	 = false	 -- Auto switch from if you pick up 
SWEP.InLoadoutFor = nil -- poista jos käytössä heti alussa T:lla

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 64
SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Primary.Sound = Sound( "weapons/usp/usp1.wav" ) --Weapon_M4A1.Single
SWEP.Primary.SoundLevel = 80

SWEP.IronSightsPos = Vector(-7.58, -9.2, 0.55)
SWEP.IronSightsAng = Vector(2.599, -1.3, -3.6)


function SWEP:SetZoom(state)
   if CLIENT then return end
   if not (IsValid(self.Owner) and self.Owner:IsPlayer()) then return end
   if state then
      self.Owner:SetFOV(35, 0.5)
   else
      self.Owner:SetFOV(0, 0.2)
   end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
   if not self.IronSightsPos then return end
   if self.Weapon:GetNextSecondaryFire() > CurTime() then return end

   bIronsights = not self:GetIronsights()

   self:SetIronsights( bIronsights )

   if SERVER then
      self:SetZoom(bIronsights)
   end

   self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:PreDrop()
   self:SetZoom(false)
   self:SetIronsights(false)
   return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
   self.Weapon:DefaultReload( ACT_VM_RELOAD );
   self:SetIronsights( false )
   self:SetZoom(false)
end


function SWEP:Holster()
   self:SetIronsights(false)
   self:SetZoom(false)
   return true
end


