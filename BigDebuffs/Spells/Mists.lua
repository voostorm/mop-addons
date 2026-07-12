local addonName, addon = ...

local BUFF_DEFENSIVE = "buffs_defensive"
local BUFF_OFFENSIVE = "buffs_offensive"
local DEBUFF_OFFENSIVE = "debuffs_offensive"
local BUFF_OTHER = "buffs_other"
local INTERRUPT = "interrupts"
local CROWD_CONTROL = "cc"
local ROOT = "roots"
local IMMUNITY = "immunities"
local IMMUNITY_SPELL = "immunities_spells"

addon.Units = {
    "player",
    "pet",
    "target",
    "focus",
    "party1",
    "party2",
    "party3",
    "party4",
    "arena1",
    "arena2",
    "arena3",
    "arena4",
    "arena5",
}

-- Show one of these when a big debuff is displayed
addon.WarningDebuffs = {
    --30108, -- Unstable Affliction
    --34914, -- Vampiric Touch
}

-- Make sure we always see these debuffs, but don't make them bigger
addon.PriorityDebuffs = {
    -- 770, -- Faerie Fire
    -- 16857, -- Faerie Fire (Feral)
    -- 12294, -- Mortal Strike
    -- 21551, -- Mortal Strike
    -- 21552, -- Mortal Strike
    -- 21553, -- Mortal Strike
    -- 9035, -- Hex of Weakness
    -- 19281, -- Hex of Weakness
    -- 19282, -- Hex of Weakness
    -- 19283, -- Hex of Weakness
    -- 19284, -- Hex of Weakness
    -- 19285, -- Hex of Weakness
    -- 23230, -- Blood Fury Debuff
    -- 23605, -- Nightfall, Spell Vulnerability
}

-- we're going to make this into MOP ARENA ONLY
addon.Spells = {

    -- CROWD CONTROLS

    -- *** Incapacitate Effects ***
    [2637]   = { type = CROWD_CONTROL }, -- Hibernate
    [3355]   = { type = CROWD_CONTROL }, -- Freezing Trap Effect
    [19386]  = { type = CROWD_CONTROL }, -- Wyvern Sting
    [118]    = { type = CROWD_CONTROL }, -- Polymorph
    [28271]  = { type = CROWD_CONTROL }, -- Polymorph: Turtle
    [28272]  = { type = CROWD_CONTROL }, -- Polymorph: Pig
    [61025]  = { type = CROWD_CONTROL }, -- Polymorph: Serpent
    [61721]  = { type = CROWD_CONTROL }, -- Polymorph: Rabbit
    [61780]  = { type = CROWD_CONTROL }, -- Polymorph: Turkey
    [61305]  = { type = CROWD_CONTROL }, -- Polymorph: Black Cat
    [82691]  = { type = CROWD_CONTROL }, -- Ring of Frost
    [115078] = { type = CROWD_CONTROL }, -- Paralysis
    [20066]  = { type = CROWD_CONTROL }, -- Repentance
    [9484]   = { type = CROWD_CONTROL }, -- Shackle Undead
    [1776]   = { type = CROWD_CONTROL }, -- Gouge
    [6770]   = { type = CROWD_CONTROL }, -- Sap
    [76780]  = { type = CROWD_CONTROL }, -- Bind Elemental
    [51514]  = { type = CROWD_CONTROL }, -- Hex
    [710]    = { type = CROWD_CONTROL }, -- Banish
    [107079] = { type = CROWD_CONTROL }, -- Quaking Palm (Racial)

    -- *** Disorient Effects ***
    [99]     = { type = CROWD_CONTROL }, -- Disorienting Roar
    [19503]  = { type = CROWD_CONTROL }, -- Scatter Shot
    [31661]  = { type = CROWD_CONTROL }, -- Dragon's Breath
    [123393] = { type = CROWD_CONTROL }, -- Glyph of Breath of Fire
    [105421] = { type = CROWD_CONTROL }, -- Blinding Light
    [88625]  = { type = CROWD_CONTROL }, -- Holy Word: Chastise

    -- *** Controlled Stun Effects ***
    [108194] = { type = CROWD_CONTROL }, -- Asphyxiate
    [91800]  = { type = CROWD_CONTROL }, -- Gnaw (Ghoul)
    [91797]  = { type = CROWD_CONTROL }, -- Monstrous Blow (Dark Transformation Ghoul)
    [115001] = { type = CROWD_CONTROL }, -- Remorseless Winter
    [102795] = { type = CROWD_CONTROL }, -- Bear Hug
    [5211]   = { type = CROWD_CONTROL }, -- Mighty Bash
    [9005]   = { type = CROWD_CONTROL }, -- Pounce
    [22570]  = { type = CROWD_CONTROL }, -- Maim
    [113801] = { type = CROWD_CONTROL }, -- Bash (Treants)
    [117526] = { type = CROWD_CONTROL }, -- Binding Shot
    [24394]  = { type = CROWD_CONTROL }, -- Intimidation
    [126246] = { type = CROWD_CONTROL }, -- Lullaby (Crane pet) -- TODO: verify category
    [126423] = { type = CROWD_CONTROL }, -- Petrifying Gaze (Basilisk pet) -- TODO: verify category
    [126355] = { type = CROWD_CONTROL }, -- Quill (Porcupine pet) -- TODO: verify category
    [90337]  = { type = CROWD_CONTROL }, -- Bad Manner (Monkey)
    [56626]  = { type = CROWD_CONTROL }, -- Sting (Wasp)
    [50519]  = { type = CROWD_CONTROL }, -- Sonic Blast
    [118271] = { type = CROWD_CONTROL }, -- Combustion
    [44572]  = { type = CROWD_CONTROL }, -- Deep Freeze
    [119392] = { type = CROWD_CONTROL }, -- Charging Ox Wave
    [122242] = { type = CROWD_CONTROL }, -- Clash
    [120086] = { type = CROWD_CONTROL }, -- Fists of Fury
    [119381] = { type = CROWD_CONTROL }, -- Leg Sweep
    [115752] = { type = CROWD_CONTROL }, -- Blinding Light (Glyphed)
    [853]    = { type = CROWD_CONTROL }, -- Hammer of Justice
    [110698] = { type = CROWD_CONTROL }, -- Hammer of Justice (Symbiosis)
    [119072] = { type = CROWD_CONTROL }, -- Holy Wrath
    [105593] = { type = CROWD_CONTROL }, -- Fist of Justice
    [408]    = { type = CROWD_CONTROL }, -- Kidney Shot
    [1833]   = { type = CROWD_CONTROL }, -- Cheap Shot
    [118345] = { type = CROWD_CONTROL }, -- Pulverize (Primal Earth Elemental)
    [118905] = { type = CROWD_CONTROL }, -- Static Charge (Capacitor Totem)
    [89766]  = { type = CROWD_CONTROL }, -- Axe Toss (Felguard)
    [22703]  = { type = CROWD_CONTROL }, -- Inferno Effect
    [30283]  = { type = CROWD_CONTROL }, -- Shadowfury
    [132168] = { type = CROWD_CONTROL }, -- Shockwave
    [107570] = { type = CROWD_CONTROL }, -- Storm Bolt
    [132169] = { type = CROWD_CONTROL }, -- Storm Bolt 2
    [20549]  = { type = CROWD_CONTROL }, -- War Stomp (Racial)
    [835] = { type = CROWD_CONTROL }, -- Tidal Charm (magic dispellable), (probably does not exist in the game and not usable in arena)
    -- *** Non-controlled Stun Effects *** -- was "random_stun". 
    -- I get that the original author wants to separate it but having another category of dr is confusing for me or rather of an eye sore
    [113953] = { type = CROWD_CONTROL }, -- Paralysis
    [118895] = { type = CROWD_CONTROL }, -- Dragon Roar
    [77505]  = { type = CROWD_CONTROL }, -- Earthquake
    [118000] = { type = CROWD_CONTROL }, -- Dragon Roar

    -- *** Fear Effects ***
    [113004] = { type = CROWD_CONTROL }, -- Intimidating Roar (Symbiosis)
    [113056] = { type = CROWD_CONTROL }, -- Intimidating Roar (Symbiosis 2)
    [1513]   = { type = CROWD_CONTROL }, -- Scare Beast
    [10326]  = { type = CROWD_CONTROL }, -- Turn Evil
    [145067] = { type = CROWD_CONTROL }, -- Turn Evil (Evil is a Point of View)
    [8122]   = { type = CROWD_CONTROL }, -- Psychic Scream
    [113792] = { type = CROWD_CONTROL }, -- Psychic Terror (Psyfiend)
    [2094]   = { type = CROWD_CONTROL }, -- Blind
    [5782]   = { type = CROWD_CONTROL }, -- Fear
    [118699] = { type = CROWD_CONTROL }, -- Fear 2
    [5484]   = { type = CROWD_CONTROL }, -- Howl of Terror
    [115268] = { type = CROWD_CONTROL }, -- Mesmerize (Shivarra)
    [6358]   = { type = CROWD_CONTROL }, -- Seduction (Succubus)
    [104045] = { type = CROWD_CONTROL }, -- Sleep (Metamorphosis) -- TODO: verify this is the correct category
    [5246]   = { type = CROWD_CONTROL }, -- Intimidating Shout
    [20511]  = { type = CROWD_CONTROL }, -- Intimidating Shout (secondary targets)
    
    -- *** Horror Effects ***
    [64044]  = { type = CROWD_CONTROL }, -- Psychic Horror
    [137143] = { type = CROWD_CONTROL }, -- Blood Horror
    [6789]   = { type = CROWD_CONTROL }, -- Death Coil

    -- *** Spells that DRs with itself only ***
    [33786]  = { type = CROWD_CONTROL }, -- Cyclone
    [113506] = { type = CROWD_CONTROL }, -- Cyclone (Symbiosis)
	[7922] = { type = CROWD_CONTROL }, -- Charge


    -- *** Mind Control Effects *** 
    [605]   = { type = CROWD_CONTROL }, -- Dominate Mind

    -- *** Disarm Weapon Effects ***
    [50541]  = { type = CROWD_CONTROL }, -- Clench (Scorpid)
    [91644]  = { type = CROWD_CONTROL }, -- Snatch (Bird of Prey)
    [137461] = { type = CROWD_CONTROL }, -- Ring of Peace (Disarm effect)
    [64058]  = { type = CROWD_CONTROL }, -- Psychic Horror (Disarm Effect)
    [51722]  = { type = CROWD_CONTROL }, -- Dismantle
    [118093] = { type = CROWD_CONTROL }, -- Disarm (Voidwalker/Voidlord)
    [676]    = { type = CROWD_CONTROL }, -- Disarm
    [126458] = { type = CROWD_CONTROL }, -- Grapple Weapon (Symbiosis)
	[117368] = { type = CROWD_CONTROL }, -- Grapple Weapon

    -- *** Silence Effects ***
    [47476]  = { type = CROWD_CONTROL }, -- Strangulate
    [114238] = { type = CROWD_CONTROL }, -- Glyph of Fae Silence
    [34490]  = { type = CROWD_CONTROL }, -- Silencing Shot
    [102051] = { type = CROWD_CONTROL }, -- Frostjaw
    [55021]  = { type = CROWD_CONTROL }, -- Counterspell
    [137460] = { type = CROWD_CONTROL }, -- Ring of Peace (Silence effect)
    [116709] = { type = CROWD_CONTROL }, -- Spear Hand Strike
    [31935]  = { type = CROWD_CONTROL }, -- Avenger's Shield
    [15487]  = { type = CROWD_CONTROL }, -- Silence
    [1330]   = { type = CROWD_CONTROL }, -- Garrote
    [24259]  = { type = CROWD_CONTROL }, -- Spell Lock
    [115782] = { type = CROWD_CONTROL }, -- Optical Blast (Observer)
    [18498]  = { type = CROWD_CONTROL }, -- Silenced - Gag Order
    [50613]  = { type = CROWD_CONTROL }, -- Arcane Torrent (Racial, Runic Power)
    [28730]  = { type = CROWD_CONTROL }, -- Arcane Torrent (Racial, Mana)
    [25046]  = { type = CROWD_CONTROL }, -- Arcane Torrent (Racial, Energy)
    [69179]  = { type = CROWD_CONTROL }, -- Arcane Torrent (Racial, Rage)
    [80483]  = { type = CROWD_CONTROL }, -- Arcane Torrent (Racial, Focus)
    [31117]  = { type = CROWD_CONTROL }, -- Unstable Affliction (Silence)
    [43523]  = { type = CROWD_CONTROL }, -- Unstable Affliction (Silence)
    [78675] = { type = CROWD_CONTROL }, -- Solar Beam
    [81261] = { type = CROWD_CONTROL }, -- Solar Beam
    [133901] = { type = CROWD_CONTROL }, -- Solar Beam
    [129888] = { type = CROWD_CONTROL }, -- Solar Beam
    [129889] = { type = CROWD_CONTROL }, -- Solar Beam
    [133899] = { type = CROWD_CONTROL }, -- Solar Beam
    [113286] = { type = CROWD_CONTROL }, -- Solar Beam (Symbiosis)
    [113287] = { type = CROWD_CONTROL }, -- Solar Beam (Symbiosis)


    [76577] = { type = CROWD_CONTROL }, -- Smoke Bomb

    -- INTERRUPTS
    [72]    = { type = INTERRUPT, duration = 6 }, -- Shield Bash (Warrior)
    [1766]  = { type = INTERRUPT, duration = 5 }, -- Kick (Rogue)
    [2139]  = { type = INTERRUPT, duration = 8 }, -- Counterspell (Mage)
    [6552]  = { type = INTERRUPT, duration = 4 }, -- Pummel
    [13491] = { type = INTERRUPT, duration = 5 }, -- Iron Knuckles
    [16979] = { type = INTERRUPT, duration = 4 }, -- Feral Charge (Druid)
    [19647] = { type = INTERRUPT, duration = 6 }, -- Spell Lock - Rank 1 (Warlock)
    [26090] = { type = INTERRUPT, duration = 2, }, -- Pummel (Pet)
    [26679] = { type = INTERRUPT, duration = 3 }, -- Deadly Throw
    [29443] = { type = INTERRUPT, duration = 10 }, -- Clutch of Foresight
    [47528] = { type = INTERRUPT, duration = 4, },  -- Mind Freeze
    [50318] = { type = INTERRUPT, duration = 4 }, -- Serenity Dust (Moth - Hunter Pet)
    [50479] = { type = INTERRUPT, duration = 2},  -- Nether Shock (Nether Ray - Hunter Pet)
    [57994] = { type = INTERRUPT, duration = 2, },  -- Wind Shear
    [113288] = { type = INTERRUPT, duration = 4 }, -- Solar Beam (Symbiosis) Interrupt
    [97547] = { type = INTERRUPT, duration = 5 }, -- Solar Beam Interrupt
    [80964] = { type = INTERRUPT, duration = 4 }, -- Skull Bash (Bear)
    [80965] = { type = INTERRUPT, duration = 4 }, -- Skull Bash (Cat)
    [91802] = { type = INTERRUPT, duration = 2 },  -- Shambling Rush (pet dk kick)
    [96231] = { type = INTERRUPT, duration = 4 }, -- Rebuke
    [115781] = { type = INTERRUPT, duration = 6 }, -- Optical Blast (Interrupt)
    [119911] = { type = INTERRUPT, duration = 6 }, -- Optical Blast (Interrupt)
    [147362] = { type = INTERRUPT, duration = 3}, -- Counter Shot (Hunter)
    [386071] = { type = INTERRUPT, duration = 6 }, -- Disrupting Shout (Warrior)

    -- ROOTS
    [31367] = { type = ROOT }, -- Netherweave Net (Item) (Does not work in Arena)
    [96294]  = { type = ROOT }, -- Chains of Ice (Chilblains)
    [91807]  = { type = ROOT }, -- Shambling Rush (Dark Transformation)
    [339]    = { type = ROOT }, -- Entangling Roots
    [113770] = { type = ROOT }, -- Entangling Roots (Force of Nature - Balance Treants)
    [19975]  = { type = ROOT }, -- Entangling Roots (Nature's Grasp)
    [45334]  = { type = ROOT }, -- Immobilized (Wild Charge - Bear)
    [102359] = { type = ROOT }, -- Mass Entanglement
    [110693] = { type = ROOT }, -- Frost Nova (Mage) [Symbiosis]
    [19185]  = { type = ROOT }, -- Entrapment
    [64803]  = { type = ROOT }, -- Entrapment
    [136634] = { type = ROOT }, -- Narrow Escape
    [90327]  = { type = ROOT }, -- Lock Jaw (Dog)
    [50245]  = { type = ROOT }, -- Pin (Crab)
    [54706]  = { type = ROOT }, -- Venom Web Spray (Silithid)
    [4167]   = { type = ROOT }, -- Web (Spider)
    [96201]  = { type = ROOT }, -- Web Wrap (Shale Spider)
    [122]    = { type = ROOT }, -- Frost Nova
    [111340] = { type = ROOT }, -- Ice Ward
    [33395]  = { type = ROOT }, -- Freeze (Water Elemental)
    [116706] = { type = ROOT }, -- Disable (Root)
    [113275] = { type = ROOT }, -- Entangling Roots (Symbiosis) [Monk]
    [123407] = { type = ROOT }, -- Spinning Fire Blossom
    [115197] = { type = ROOT }, -- Partial Paralysis
    [64695]  = { type = ROOT }, -- Earthgrab (Earthgrab Totem)
    [63685]  = { type = ROOT }, -- Freeze (Frozen Power)
    [87194]  = { type = ROOT }, -- Glyph of Mind Blast
    [114404] = { type = ROOT }, -- Void Tendril's Grasp
    [39965]  = { type = ROOT }, -- Frost Grenade
    [55536]  = { type = ROOT }, -- Frostweave Net
    [107566] = { type = ROOT }, -- Staggering Shout
    [105771] = { type = ROOT }, -- Warbringer
    [115000] = { type = ROOT }, -- Remorseless Winter
    [25999]  = { type = ROOT }, -- Charge
    [115757] = { type = ROOT }, -- Frost Nova (Glyph of Ice Block)

    -- IMMUNITIES (COMPLETE IMMUNITY)
    [642]    = { type = IMMUNITY }, -- Divine Shield
    [58984]  = { type = IMMUNITY }, -- Shadowmeld
    [27827]  = { type = IMMUNITY }, -- Spirit of Redemption
    [19263]  = { type = IMMUNITY }, -- Deterrence
    [110618] = { type = IMMUNITY }, -- Deterrence
    [65871]  = { type = IMMUNITY }, -- Deterrence
    [148467] = { type = IMMUNITY }, -- Deterrence
    [67801]  = { type = IMMUNITY }, -- Deterrence
    [110617] = { type = IMMUNITY }, -- Deterrence (Hunter)
    [110700] = { type = IMMUNITY }, -- Divine Shield (Paladin)
    [110696] = { type = IMMUNITY }, -- Ice Block (Mage)
    [45438]  = { type = IMMUNITY }, -- Ice Block
    [122465] = { type = IMMUNITY }, -- Dematerialize

    -- DEBUFF_OFFENSIVE -- for raid frames to see who they going what big damage is incoming
    [46392]  = { type = DEBUFF_OFFENSIVE }, -- Focused Assault
    [46393]  = { type = DEBUFF_OFFENSIVE }, -- Brutal Assault
    
    [301091]  = { type = DEBUFF_OFFENSIVE }, -- Alliance Flag (Twin Peaks Flag)
    [301089]  = { type = DEBUFF_OFFENSIVE }, -- Horde Flag (Twin Peaks Flag)
    [23333]  = { type = DEBUFF_OFFENSIVE }, -- Warsong Flag (horde WSG flag)
    [23335]  = { type = DEBUFF_OFFENSIVE }, -- Silverwing Flag (alliance WSG flag)
    [34976]  = { type = DEBUFF_OFFENSIVE }, -- Nether Flag (Eye of the Storm flag)
    [141210]  = { type = DEBUFF_OFFENSIVE }, -- Horde Mine (Silvershard Mines flag)
    [140876]  = { type = DEBUFF_OFFENSIVE }, -- Alliance Mine (Silvershard Mines flag)
    [83853] = { type = DEBUFF_OFFENSIVE }, -- Combustion
    [49206]  = { type = DEBUFF_OFFENSIVE }, -- Summon Gargoyle
    [108200] = { type = DEBUFF_OFFENSIVE }, -- Remorseless Winter (Indicator to see the stacks)
    [130735] = { type = DEBUFF_OFFENSIVE }, -- Soul Reaper (Frost)
        [130736] = { parent = 130735 }, -- Soul Reaper (Unholy)
        [114866] = { parent = 130735 }, -- Soul Reaper (Blood)
    [73975]  = { type = DEBUFF_OFFENSIVE }, -- Necrotic Strike
    [34914]  = { type = DEBUFF_OFFENSIVE }, -- VT
    [80240]  = { type = DEBUFF_OFFENSIVE }, -- Havoc
    [30108]  = { type = DEBUFF_OFFENSIVE }, -- UA
    [117405] = { type = DEBUFF_OFFENSIVE }, -- debuff about to be stunned by Binding Shot
    [137619] = { type = DEBUFF_OFFENSIVE }, -- Marked for Death
    [79140]  = { type = DEBUFF_OFFENSIVE }, -- Vendetta
    [12292]  = { type = DEBUFF_OFFENSIVE }, -- Bloodbath Melee special attacks cause an additional 30% bleed damage.
    [124280] = { type = DEBUFF_OFFENSIVE }, -- Touch of Karma debuff that goes on enemy of the monk
    -- stealth constraint debuffs to see on raidframes
    [770]   = { type = DEBUFF_OFFENSIVE }, -- Faerie Fire
    [44457] = { type = DEBUFF_OFFENSIVE }, -- living bomb
    [31615] = { type = DEBUFF_OFFENSIVE }, -- Hunter's Mark
    -- healing reduction debuffs to see on raidframes
    [8680]  = { type = DEBUFF_OFFENSIVE }, -- Wound Poison Healing Debuff (Rogue Poison)
    [115804] = { type = DEBUFF_OFFENSIVE }, -- Mortal Wound (Warrior MS)
    [115625] = { type = DEBUFF_OFFENSIVE }, -- Demolock Wrathguard pet (6 sec 25% healing reduc debuff) Mortal Cleave
    [30213] = { type = DEBUFF_OFFENSIVE }, -- Demolock Felguard pet (6 sec 10% healing reduc debuff) Mortal Cleave
    -- constraints to see on raidframes
    [41425]  = { type = DEBUFF_OFFENSIVE }, -- Hypothermia
    [25771]  = { type = DEBUFF_OFFENSIVE }, -- Forbearance
    [87023]  = { type = DEBUFF_OFFENSIVE }, -- Cauterize
    [45181]  = { type = DEBUFF_OFFENSIVE }, -- Cheated Death

    -- BUFF_OTHER (includes debuffs too?)
    -- DRINKS
    [22734] = { type = BUFF_OTHER }, -- Drink
        [46755] = { parent = 22734 }, -- Drink
        [27089] = { parent = 22734 }, -- Drink
        [43183] = { parent = 22734 }, -- Drink
        [57073] = { parent = 22734 }, -- Drink
    
    -- want to see these buffs only on unit frames
    [768]    = { type = BUFF_OTHER }, -- Cat Form
    [783]    = { type = BUFF_OTHER }, -- Travel Form
    [24858]  = { type = BUFF_OTHER }, -- Moonkin Form
    [33891]  = { type = BUFF_OTHER }, -- Tree of Life
    [5487]   = { type = BUFF_OTHER }, -- Bear Form
    [115191] = { type = BUFF_OTHER }, -- Stealth
    [114018] = { type = BUFF_OTHER }, -- Shroud of Concealment
    [80325]  = { type = BUFF_OTHER }, -- Camouflage
    [51755]  = { type = BUFF_OTHER }, -- Camouflage
    [90954]  = { type = BUFF_OTHER }, -- Camouflage
    [119450] = { type = BUFF_OTHER }, -- Camouflage
    [119030] = { type = BUFF_OTHER }, -- Spectral Guise
    [112833] = { type = BUFF_OTHER }, -- Spectral Guise
    [119032] = { type = BUFF_OTHER }, -- Spectral Guise
    [119012] = { type = BUFF_OTHER }, -- Spectral Guise
    [66]     = { type = BUFF_OTHER }, -- Invisibility
    [5215] = { type = BUFF_OTHER }, -- Prowl
    [102547] = { type = BUFF_OTHER }, -- Prowl
    [113289] = { type = BUFF_OTHER }, -- Prowl
    [142453] = { type = BUFF_OTHER }, -- Prowl
    [133079] = { type = BUFF_OTHER }, -- Prowl
    [29166]  = { type = BUFF_OTHER }, -- Innervate
    [54428]  = { type = BUFF_OTHER }, -- Divine Plea
	[12051]  = { type = BUFF_OTHER }, -- Evocation
	[16191]  = { type = BUFF_OTHER }, -- Mana Tide Totem
    
    -- BUFF_DEFENSIVE
    [110909] = { type = BUFF_DEFENSIVE }, -- Alter Time
    [16188]  = { type = BUFF_DEFENSIVE }, -- Ancestral Swiftness (also used offensively)
    [114214] = { type = BUFF_DEFENSIVE }, -- Angelic Bulwark
    [50461]  = { type = BUFF_DEFENSIVE }, -- Anti-Magic Zone
    [31850]  = { type = BUFF_DEFENSIVE }, -- Ardent Defender
    [22812]  = { type = BUFF_DEFENSIVE }, -- Barkskin
    [6940]   = { type = BUFF_DEFENSIVE }, -- Blessing of Sacrifice
    [111397] = { type = BUFF_DEFENSIVE }, -- Blood Horror
    [45182]  = { type = BUFF_DEFENSIVE }, -- Cheating Death
    [74001]  = { type = BUFF_DEFENSIVE }, -- Combat Readiness
    [1742]   = { type = BUFF_DEFENSIVE }, -- Cower (Pet)
    [110913] = { type = BUFF_DEFENSIVE }, -- Dark Bargain
    [31821]  = { type = BUFF_DEFENSIVE }, -- Devotion Aura
    [118038] = { type = BUFF_DEFENSIVE }, -- Die by the Sword
    [110715] = { type = BUFF_DEFENSIVE }, -- Dispersion (Priest)
    [47585]  = { type = BUFF_DEFENSIVE }, -- Dispersion
    [31842]  = { type = BUFF_DEFENSIVE }, -- Divine Favor
    [64843]  = { type = BUFF_DEFENSIVE }, -- Divine Hymn
    [498]    = { type = BUFF_DEFENSIVE }, -- Divine Protection
    [55694]  = { type = BUFF_DEFENSIVE }, -- Enraged Regeneration
    [5277]   = { type = BUFF_DEFENSIVE }, -- Evasion
    [110791] = { type = BUFF_DEFENSIVE }, -- Evasion (Druid) (Symbiosis)
    [5384]   = { type = BUFF_DEFENSIVE }, -- Feign Death
    [126456] = { type = BUFF_DEFENSIVE }, -- Fortifying Brew
    [22842]  = { type = BUFF_DEFENSIVE }, -- Frenzied Regeneration
    [86659]  = { type = BUFF_DEFENSIVE }, -- Guardian of Ancient Kings
    [47788]  = { type = BUFF_DEFENSIVE }, -- Guardian Spirit
    [1022]   = { type = BUFF_DEFENSIVE }, -- Hand of Protection
    [48792]  = { type = BUFF_DEFENSIVE }, -- Icebound Fortitude
    [110575] = { type = BUFF_DEFENSIVE }, -- Icebound Fortitude (Druid) (Symbiosis)
    [1463]   = { type = BUFF_DEFENSIVE }, -- Incanter's Ward
    [102342] = { type = BUFF_DEFENSIVE }, -- Ironbark
    [12975]  = { type = BUFF_DEFENSIVE }, -- Last Stand
    [116849] = { type = BUFF_DEFENSIVE }, -- Life Cocoon
    [132158] = { type = BUFF_DEFENSIVE }, -- Nature's Swiftness (also used offensively)
    [29274]  = { type = BUFF_DEFENSIVE }, -- Nature's Swiftness
    [33206]  = { type = BUFF_DEFENSIVE }, -- Pain Suppression
    [81782]  = { type = BUFF_DEFENSIVE }, -- Power Word: Barrier
    [12043]  = { type = BUFF_DEFENSIVE }, -- Presence of Mind (also used offensively)
    [116844] = { type = BUFF_DEFENSIVE }, -- Ring of Peace
    [53480]  = { type = BUFF_DEFENSIVE }, -- Roar of Sacrifice (Hunter Pet Skill)
    [30823]  = { type = BUFF_DEFENSIVE }, -- Shamanistic Rage
    [871]    = { type = BUFF_DEFENSIVE }, -- Shield Wall
    [98007]  = { type = BUFF_DEFENSIVE }, -- Spirit Link Totem
    [20711]  = { type = BUFF_DEFENSIVE }, -- Spirit of Redemption
    [61336]  = { type = BUFF_DEFENSIVE }, -- Survival Instincts
    [115610] = { type = BUFF_DEFENSIVE }, -- Temporal Shield
    [122470] = { type = BUFF_DEFENSIVE }, -- Touch of Karma
    [104773] = { type = BUFF_DEFENSIVE }, -- Unending Resolve
    [122291] = { type = BUFF_DEFENSIVE }, -- Unending Resolve (Druid) (Symbiosis)
    [114030] = { type = BUFF_DEFENSIVE }, -- Vigilance
    [131523] = { type = BUFF_DEFENSIVE }, -- Zen Meditation

    -- BUFF_OFFENSIVE
    [13750]  = { type = BUFF_OFFENSIVE }, -- Adrenaline Rush
    [12042]  = { type = BUFF_OFFENSIVE }, -- Arcane Power
    [114049] = { type = BUFF_OFFENSIVE }, -- Ascendance
    [107574] = { type = BUFF_OFFENSIVE }, -- Avatar
    [31884]  = { type = BUFF_OFFENSIVE }, -- Avenging Wrath
    [50334]  = { type = BUFF_OFFENSIVE }, -- Berserk
    [23505]  = { type = BUFF_OFFENSIVE }, -- Berserking (BG DMG BUFF)
    [13877]  = { type = BUFF_OFFENSIVE }, -- Blade Flurry
    [20572]  = { type = BUFF_OFFENSIVE }, -- Blood Fury (Racial)
    [2825]   = { type = BUFF_OFFENSIVE }, -- Bloodlust
    [126690] = { type = BUFF_OFFENSIVE }, -- Call of Conquest
    [126683] = { type = BUFF_OFFENSIVE }, -- Call of Dominance
    [126679] = { type = BUFF_OFFENSIVE }, -- Call of Victory
    [112071] = { type = BUFF_OFFENSIVE }, -- Celestial Alignment
    [113858] = { type = BUFF_OFFENSIVE }, -- Dark Soul: Instability
    [113861] = { type = BUFF_OFFENSIVE }, -- Dark Soul: Knowledge
    [113860] = { type = BUFF_OFFENSIVE }, -- Dark Soul: Misery
    [120679] = { type = BUFF_OFFENSIVE }, -- Dire Beast
    [16166]  = { type = BUFF_OFFENSIVE }, -- Elemental Mastery
    [115288] = { type = BUFF_OFFENSIVE }, -- Energizing Brew
    [82726]  = { type = BUFF_OFFENSIVE }, -- Fervor
    [44544]  = { type = BUFF_OFFENSIVE }, -- Fingers of Frost
    [108288] = { type = BUFF_OFFENSIVE }, -- Heart of the Wild
    [32182]  = { type = BUFF_OFFENSIVE }, -- Heroism
    [105809] = { type = BUFF_OFFENSIVE }, -- Holy Avenger
    [131078]  = { type = BUFF_OFFENSIVE }, -- Icy Veins (no check spell id)
    [19577]  = { type = BUFF_OFFENSIVE }, -- Intimidation (Buff)
    [51690]  = { type = BUFF_OFFENSIVE }, -- Killing Spree
    [51271]  = { type = BUFF_OFFENSIVE }, -- Pillar of Frost
    [10060]  = { type = BUFF_OFFENSIVE }, -- Power Infusion
    [69369]  = { type = BUFF_OFFENSIVE }, -- Predator's Swiftness
    [3045]   = { type = BUFF_OFFENSIVE }, -- Rapid Fire
    [1719]   = { type = BUFF_OFFENSIVE }, -- Recklessness
    [51713]  = { type = BUFF_OFFENSIVE }, -- Shadow Dance
    [121818] = { type = BUFF_OFFENSIVE }, -- Stampede
    [34471]  = { type = BUFF_OFFENSIVE }, -- The Beast Within
    [5217]   = { type = BUFF_OFFENSIVE }, -- Tiger's Fury
    [49016]  = { type = BUFF_OFFENSIVE }, -- Unholy Frenzy
}