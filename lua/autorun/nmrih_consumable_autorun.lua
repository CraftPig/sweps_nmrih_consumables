AddCSLuaFile()

--[[
-----------------------------------------------------------------------------------------------------
Convar Tables
-----------------------------------------------------------------------------------------------------
]]

if CLIENT then
    hook.Add("PopulateToolMenu", "ToolMenu_NMRIHConsumables", function()
		spawnmenu.AddToolMenuOption("Options", "Craft_Pig", "ToolMenuOption_ConsumablesNMRIH", "NMRIH Consumables", "", "", function(panel)
			panel:ClearControls()
			panel:CheckBox("Enable Phalanx Regen?", "convar_consumablesnmrih_eregen", 1, 0, true)
			panel:CheckBox("Enable Phalanx Cure?", "convar_consumablesnmrih_edelayinf", 1, 0, true)
			panel:ControlHelp("Requires Infectious Mod to be mounted.")
			panel:CheckBox("Enable Genetherapy Armor?", "convar_consumablesnmrih_earmor", 1, 0, true)
			panel:CheckBox("Enable Genetherapy Cure?", "convar_consumablesnmrih_ecureinf", 1, 0, true)
			panel:ControlHelp("Requires Infectious Mod to be mounted.")
		end)
	end)
end

CreateConVar("convar_consumablesnmrih_eregen", "1", {FCVAR_ARCHIVE}, "Enable Phalanx Regen (0 - disabled, 1 - enabled)")
CreateConVar("convar_consumablesnmrih_edelayinf", "1", {FCVAR_ARCHIVE}, "Enable Phalanx Cure (0 - disabled, 1 - enabled)")
CreateConVar("convar_consumablesnmrih_earmor", "1", {FCVAR_ARCHIVE}, "Enable Phalanx Regen (0 - disabled, 1 - enabled)")
CreateConVar("convar_consumablesnmrih_ecureinf", "1", {FCVAR_ARCHIVE}, "Enable Phalanx Regen (0 - disabled, 1 - enabled)")


--[[
-----------------------------------------------------------------------------------------------------
Ammo Tables
-----------------------------------------------------------------------------------------------------
]]

game.AddAmmoType( {
name = "nmrih_phanlax",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} )

game.AddAmmoType( {
name = "nmrih_medkit",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} ) 

game.AddAmmoType( {
name = "nmrih_genetherapy",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} )

game.AddAmmoType( {
name = "nmrih_bandage",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} )

--[[
-----------------------------------------------------------------------------------------------------
Sound Tables
-----------------------------------------------------------------------------------------------------
]]
sound.Add( {
    name = "nmrih_consumables_shove",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/shove_01.wav",
		"weapons/nmrih/items/shove_02.wav",
		"weapons/nmrih/items/shove_03.wav",
		"weapons/nmrih/items/shove_04.wav",
		"weapons/nmrih/items/shove_05.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_genericfoley",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/clothes_generic_foley_01.wav",
		"weapons/nmrih/items/clothes_generic_foley_02.wav",
		"weapons/nmrih/items/clothes_generic_foley_03.wav",
		"weapons/nmrih/items/clothes_generic_foley_04.wav",
		"weapons/nmrih/items/clothes_generic_foley_05.wav",
    }
} )

sound.Add( {
    name = "nmrih_consumables_capremove",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/genetherapy/genetherapy_cap_remove_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_inject",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/genetherapy/genetherapy_inject_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_remove",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/genetherapy/genetherapy_click_01.wav",
    }
} )

sound.Add( {
    name = "nmrih_consumables_medkitopen",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/medkit_unzip_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medpillsdraw",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/medpills_draw_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medpillsopen",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/medpills_open_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medpillsshake",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/medpills_shake_01.wav",
		"weapons/nmrih/items/medkit/medpills_shake_02.wav",
		"weapons/nmrih/items/medkit/medpills_shake_03.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medshuffle",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/medkit_shuffle_01.wav",
		"weapons/nmrih/items/medkit/medkit_shuffle_02.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_stichprep",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/stitching_prepare_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medflesh",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/stitch_fleshy_01.wav",
		"weapons/nmrih/items/medkit/stitch_fleshy_02.wav",
		"weapons/nmrih/items/medkit/stitch_fleshy_03.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medsnip",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/scissors_snip_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_medtape",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/medkit/tape_unravel_01.wav",
    }
} )

sound.Add( {
    name = "nmrih_consumables_pillsdraw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/phalanx/pills_draw_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_pillslid",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/phalanx/pills_lid_twist_01.wav",
		"weapons/nmrih/items/phalanx/pills_lid_twist_02.wav",
		"weapons/nmrih/items/phalanx/pills_lid_twist_03.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_pillslidfinal",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/phalanx/pills_lid_twist_open_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_pillsshake",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/phalanx/pills_shake_01.wav",
		"weapons/nmrih/items/phalanx/pills_shake_02.wav",
		"weapons/nmrih/items/phalanx/pills_shake_03.wav",
		"weapons/nmrih/items/phalanx/pills_shake_04.wav",
		"weapons/nmrih/items/phalanx/pills_shake_05.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_entermouth",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/phalanx/pills_enter_mouth_01.wav",
		"weapons/nmrih/items/phalanx/pills_enter_mouth_02.wav",
		"weapons/nmrih/items/phalanx/pills_enter_mouth_03.wav",
		"weapons/nmrih/items/phalanx/pills_enter_mouth_04.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_pillsgulp",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/phalanx/gulp_01.wav",
		"weapons/nmrih/items/phalanx/gulp_02.wav",
    }
} )

sound.Add( {
    name = "nmrih_consumables_bandageapply",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/bandage/bandage_apply_01.wav",
		"weapons/nmrih/items/bandage/bandage_apply_02.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_bandageunravel1",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/bandage/bandage_unravel_01.wav",
    }
} )
sound.Add( {
    name = "nmrih_consumables_bandageunravel2",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/nmrih/items/bandage/bandage_unravel_02.wav",
    }
} )