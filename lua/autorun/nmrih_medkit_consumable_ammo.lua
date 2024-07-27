if CLIENT then
language.Add("nmrih_medkit_consumable_ammo", "Medkit") 
end


game.AddAmmoType( {
name = "nmrih_medkit_consumable_ammo",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} )