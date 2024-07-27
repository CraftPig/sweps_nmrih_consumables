if CLIENT then
language.Add("nmrih_genetherapy_consumable_ammo", "Genetherapy") 
end


game.AddAmmoType( {
name = "nmrih_genetherapy_consumable_ammo",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} )