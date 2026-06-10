GladiusEx.Data = {}

function GladiusEx.Data.DefaultAlertSpells()
    return {}
end

function GladiusEx.Data.DefaultAuras()
    return {
        [GladiusEx:SafeGetSpellName(57940)] = true -- Essence of Wintergrasp
    }
end

function GladiusEx.Data.DefaultClassicon()
	return {
		-- Higher Number is More Priority
		-- Example : [GladiusEx:SafeGetSpellName(33786)]	= 6,    -- Cyclone

        -- CC (on big debuffs it these are priority 60)
        -- *** Incapacitate Effects ***
        [GladiusEx:SafeGetSpellName(2637)]   = 6, -- Hibernate
        [GladiusEx:SafeGetSpellName(3355)]   = 6, -- Freezing Trap Effect
        [GladiusEx:SafeGetSpellName(19386)]  = 6, -- Wyvern Sting
        [GladiusEx:SafeGetSpellName(118)]    = 6, -- Polymorph
        [GladiusEx:SafeGetSpellName(28271)]  = 6, -- Polymorph: Turtle
        [GladiusEx:SafeGetSpellName(28272)]  = 6, -- Polymorph: Pig
        [GladiusEx:SafeGetSpellName(61025)]  = 6, -- Polymorph: Serpent
        [GladiusEx:SafeGetSpellName(61721)]  = 6, -- Polymorph: Rabbit
        [GladiusEx:SafeGetSpellName(61780)]  = 6, -- Polymorph: Turkey
        [GladiusEx:SafeGetSpellName(61305)]  = 6, -- Polymorph: Black Cat
        [GladiusEx:SafeGetSpellName(82691)]  = 6, -- Ring of Frost
        [GladiusEx:SafeGetSpellName(115078)] = 6, -- Paralysis
        [GladiusEx:SafeGetSpellName(20066)]  = 6, -- Repentance
        [GladiusEx:SafeGetSpellName(9484)]   = 6, -- Shackle Undead
        [GladiusEx:SafeGetSpellName(1776)]   = 6, -- Gouge
        [GladiusEx:SafeGetSpellName(6770)]   = 6, -- Sap
        [GladiusEx:SafeGetSpellName(76780)]  = 6, -- Bind Elemental
        [GladiusEx:SafeGetSpellName(51514)]  = 6, -- Hex
        [GladiusEx:SafeGetSpellName(710)]    = 6, -- Banish
        [GladiusEx:SafeGetSpellName(107079)] = 6, -- Quaking Palm (Racial)

        -- *** Disorient Effects ***
        [GladiusEx:SafeGetSpellName(99)]     = 6, -- Disorienting Roar
        [GladiusEx:SafeGetSpellName(19503)]  = 6, -- Scatter Shot
        [GladiusEx:SafeGetSpellName(31661)]  = 6, -- Dragon's Breath
        [GladiusEx:SafeGetSpellName(123393)] = 6, -- Glyph of Breath of Fire
        [GladiusEx:SafeGetSpellName(105421)] = 6, -- Blinding Light
        [GladiusEx:SafeGetSpellName(88625)]  = 6, -- Holy Word: Chastise

        -- *** Controlled Stun Effects ***
        [GladiusEx:SafeGetSpellName(108194)] = 6, -- Asphyxiate
        [GladiusEx:SafeGetSpellName(91800)]  = 6, -- Gnaw (Ghoul)
        [GladiusEx:SafeGetSpellName(91797)]  = 6, -- Monstrous Blow (Dark Transformation Ghoul)
        [GladiusEx:SafeGetSpellName(115001)] = 6, -- Remorseless Winter
        [GladiusEx:SafeGetSpellName(102795)] = 6, -- Bear Hug
        [GladiusEx:SafeGetSpellName(5211)]   = 6, -- Mighty Bash
        [GladiusEx:SafeGetSpellName(9005)]   = 6, -- Pounce
        [GladiusEx:SafeGetSpellName(22570)]  = 6, -- Maim
        [GladiusEx:SafeGetSpellName(113801)] = 6, -- Bash (Treants)
        [GladiusEx:SafeGetSpellName(117526)] = 6, -- Binding Shot
        [GladiusEx:SafeGetSpellName(24394)]  = 6, -- Intimidation
        [GladiusEx:SafeGetSpellName(126246)] = 6, -- Lullaby (Crane pet) -- TODO: verify category
        [GladiusEx:SafeGetSpellName(126423)] = 6, -- Petrifying Gaze (Basilisk pet) -- TODO: verify category
        [GladiusEx:SafeGetSpellName(126355)] = 6, -- Quill (Porcupine pet) -- TODO: verify category
        [GladiusEx:SafeGetSpellName(90337)]  = 6, -- Bad Manner (Monkey)
        [GladiusEx:SafeGetSpellName(56626)]  = 6, -- Sting (Wasp)
        [GladiusEx:SafeGetSpellName(50519)]  = 6, -- Sonic Blast
        [GladiusEx:SafeGetSpellName(118271)] = 6, -- Combustion
        [GladiusEx:SafeGetSpellName(44572)]  = 6, -- Deep Freeze
        [GladiusEx:SafeGetSpellName(119392)] = 6, -- Charging Ox Wave
        [GladiusEx:SafeGetSpellName(122242)] = 6, -- Clash
        [GladiusEx:SafeGetSpellName(120086)] = 6, -- Fists of Fury
        [GladiusEx:SafeGetSpellName(119381)] = 6, -- Leg Sweep
        [GladiusEx:SafeGetSpellName(115752)] = 6, -- Blinding Light (Glyphed)
        [GladiusEx:SafeGetSpellName(853)]    = 6, -- Hammer of Justice
        [GladiusEx:SafeGetSpellName(110698)] = 6, -- Hammer of Justice (Symbiosis)
        [GladiusEx:SafeGetSpellName(119072)] = 6, -- Holy Wrath
        [GladiusEx:SafeGetSpellName(105593)] = 6, -- Fist of Justice
        [GladiusEx:SafeGetSpellName(408)]    = 6, -- Kidney Shot
        [GladiusEx:SafeGetSpellName(1833)]   = 6, -- Cheap Shot
        [GladiusEx:SafeGetSpellName(118345)] = 6, -- Pulverize (Primal Earth Elemental)
        [GladiusEx:SafeGetSpellName(118905)] = 6, -- Static Charge (Capacitor Totem)
        [GladiusEx:SafeGetSpellName(89766)]  = 6, -- Axe Toss (Felguard)
        [GladiusEx:SafeGetSpellName(22703)]  = 6, -- Inferno Effect
        [GladiusEx:SafeGetSpellName(30283)]  = 6, -- Shadowfury
        [GladiusEx:SafeGetSpellName(132168)] = 6, -- Shockwave
        [GladiusEx:SafeGetSpellName(107570)] = 6, -- Storm Bolt
        [GladiusEx:SafeGetSpellName(132169)] = 6, -- Storm Bolt 2
        [GladiusEx:SafeGetSpellName(20549)]  = 6, -- War Stomp (Racial)
        -- *** Non-controlled Stun Effects *** -- was "random_stun". 
        -- I get that the original author wants to separate it but having another category of dr is confusing for me or rather of an eye sore
        [GladiusEx:SafeGetSpellName(113953)] = 6, -- Paralysis
        [GladiusEx:SafeGetSpellName(118895)] = 6, -- Dragon Roar
        [GladiusEx:SafeGetSpellName(77505)]  = 6, -- Earthquake
        [GladiusEx:SafeGetSpellName(118000)] = 6, -- Dragon Roar

        -- *** Fear Effects ***
        [GladiusEx:SafeGetSpellName(113004)] = 6, -- Intimidating Roar (Symbiosis)
        [GladiusEx:SafeGetSpellName(113056)] = 6, -- Intimidating Roar (Symbiosis 2)
        [GladiusEx:SafeGetSpellName(1513)]   = 6, -- Scare Beast
        [GladiusEx:SafeGetSpellName(10326)]  = 6, -- Turn Evil
        [GladiusEx:SafeGetSpellName(145067)] = 6, -- Turn Evil (Evil is a Point of View)
        [GladiusEx:SafeGetSpellName(8122)]   = 6, -- Psychic Scream
        [GladiusEx:SafeGetSpellName(113792)] = 6, -- Psychic Terror (Psyfiend)
        [GladiusEx:SafeGetSpellName(2094)]   = 6, -- Blind
        [GladiusEx:SafeGetSpellName(5782)]   = 6, -- Fear
        [GladiusEx:SafeGetSpellName(118699)] = 6, -- Fear 2
        [GladiusEx:SafeGetSpellName(5484)]   = 6, -- Howl of Terror
        [GladiusEx:SafeGetSpellName(115268)] = 6, -- Mesmerize (Shivarra)
        [GladiusEx:SafeGetSpellName(6358)]   = 6, -- Seduction (Succubus)
        [GladiusEx:SafeGetSpellName(104045)] = 6, -- Sleep (Metamorphosis) -- TODO: verify this is the correct category
        [GladiusEx:SafeGetSpellName(5246)]   = 6, -- Intimidating Shout
        [GladiusEx:SafeGetSpellName(20511)]  = 6, -- Intimidating Shout (secondary targets)
        
        -- *** Horror Effects ***
        [GladiusEx:SafeGetSpellName(64044)]  = 6, -- Psychic Horror
        [GladiusEx:SafeGetSpellName(137143)] = 6, -- Blood Horror
        [GladiusEx:SafeGetSpellName(6789)]   = 6, -- Death Coil

        -- *** Spells that DRs with itself only ***
        [GladiusEx:SafeGetSpellName(33786)]  = 6, -- Cyclone
        [GladiusEx:SafeGetSpellName(113506)] = 6, -- Cyclone (Symbiosis)
        [GladiusEx:SafeGetSpellName(7922)]   = 6, -- Charge


        -- *** Mind Control Effects *** 
        [GladiusEx:SafeGetSpellName(605)]   = 6, -- Dominate Mind

        -- *** Disarm Weapon Effects ***
        [GladiusEx:SafeGetSpellName(50541)]  = 5.8, -- Clench (Scorpid)
        [GladiusEx:SafeGetSpellName(91644)]  = 5.8, -- Snatch (Bird of Prey)
        [GladiusEx:SafeGetSpellName(117368)] = 5.8, -- Grapple Weapon
        [GladiusEx:SafeGetSpellName(126458)] = 5.8, -- Grapple Weapon (Symbiosis)
        [GladiusEx:SafeGetSpellName(137461)] = 5.8, -- Ring of Peace (Disarm effect)
        [GladiusEx:SafeGetSpellName(64058)]  = 5.8, -- Psychic Horror (Disarm Effect)
        [GladiusEx:SafeGetSpellName(51722)]  = 5.8, -- Dismantle
        [GladiusEx:SafeGetSpellName(118093)] = 5.8, -- Disarm (Voidwalker/Voidlord)
        [GladiusEx:SafeGetSpellName(676)]    = 5.8, -- Disarm

        -- *** Silence Effects ***
        [GladiusEx:SafeGetSpellName(47476)]  = 5.9, -- Strangulate
        [GladiusEx:SafeGetSpellName(114238)] = 5.9, -- Glyph of Fae Silence
        [GladiusEx:SafeGetSpellName(34490)]  = 5.9, -- Silencing Shot
        [GladiusEx:SafeGetSpellName(102051)] = 5.9, -- Frostjaw
        [GladiusEx:SafeGetSpellName(55021)]  = 5.9, -- Counterspell
        [GladiusEx:SafeGetSpellName(137460)] = 5.9, -- Ring of Peace (Silence effect)
        [GladiusEx:SafeGetSpellName(116709)] = 5.9, -- Spear Hand Strike
        [GladiusEx:SafeGetSpellName(31935)]  = 5.9, -- Avenger's Shield
        [GladiusEx:SafeGetSpellName(15487)]  = 5.9, -- Silence
        [GladiusEx:SafeGetSpellName(1330)]   = 5.9, -- Garrote
        [GladiusEx:SafeGetSpellName(24259)]  = 5.9, -- Spell Lock
        [GladiusEx:SafeGetSpellName(115782)] = 5.9, -- Optical Blast (Observer)
        [GladiusEx:SafeGetSpellName(18498)]  = 5.9, -- Silenced - Gag Order
        [GladiusEx:SafeGetSpellName(50613)]  = 5.9, -- Arcane Torrent (Racial, Runic Power)
        [GladiusEx:SafeGetSpellName(28730)]  = 5.9, -- Arcane Torrent (Racial, Mana)
        [GladiusEx:SafeGetSpellName(25046)]  = 5.9, -- Arcane Torrent (Racial, Energy)
        [GladiusEx:SafeGetSpellName(69179)]  = 5.9, -- Arcane Torrent (Racial, Rage)
        [GladiusEx:SafeGetSpellName(80483)]  = 5.9, -- Arcane Torrent (Racial, Focus)
        [GladiusEx:SafeGetSpellName(31117)]  = 5.9, -- Unstable Affliction (Silence)
        [GladiusEx:SafeGetSpellName(43523)]  = 5.9, -- Unstable Affliction (Silence)
        [GladiusEx:SafeGetSpellName(129889)] = 5.9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(81261)]  = 5.9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(133901)] = 5.9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(113287)] = 5.9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(113286)] = 5.9, -- Solar Beam (Symbiosis)
        [GladiusEx:SafeGetSpellName(129888)] = 5.9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(133899)] = 5.9, -- Solar Beam

        [GladiusEx:SafeGetSpellName(76577)] = 6.1, -- Smoke Bomb (priority 61)

        -- ROOTS, priority 5.6
        [GladiusEx:SafeGetSpellName(96294)]  = 5.6, -- Chains of Ice (Chilblains)
        [GladiusEx:SafeGetSpellName(91807)]  = 5.6, -- Shambling Rush (Dark Transformation)
        [GladiusEx:SafeGetSpellName(339)]    = 5.6, -- Entangling Roots
        [GladiusEx:SafeGetSpellName(113770)] = 5.6, -- Entangling Roots (Force of Nature - Balance Treants)
        [GladiusEx:SafeGetSpellName(19975)]  = 5.6, -- Entangling Roots (Nature's Grasp)
        [GladiusEx:SafeGetSpellName(45334)]  = 5.6, -- Immobilized (Wild Charge - Bear)
        [GladiusEx:SafeGetSpellName(102359)] = 5.6, -- Mass Entanglement
        [GladiusEx:SafeGetSpellName(110693)] = 5.6, -- Frost Nova (Mage) [Symbiosis]
        [GladiusEx:SafeGetSpellName(19185)]  = 5.6, -- Entrapment
        [GladiusEx:SafeGetSpellName(64803)]  = 5.6, -- Entrapment
        [GladiusEx:SafeGetSpellName(136634)] = 5.6, -- Narrow Escape
        [GladiusEx:SafeGetSpellName(90327)]  = 5.6, -- Lock Jaw (Dog)
        [GladiusEx:SafeGetSpellName(50245)]  = 5.6, -- Pin (Crab)
        [GladiusEx:SafeGetSpellName(54706)]  = 5.6, -- Venom Web Spray (Silithid)
        [GladiusEx:SafeGetSpellName(4167)]   = 5.6, -- Web (Spider)
        [GladiusEx:SafeGetSpellName(96201)]  = 5.6, -- Web Wrap (Shale Spider)
        [GladiusEx:SafeGetSpellName(122)]    = 5.6, -- Frost Nova
        [GladiusEx:SafeGetSpellName(111340)] = 5.6, -- Ice Ward
        [GladiusEx:SafeGetSpellName(33395)]  = 5.6, -- Freeze (Water Elemental)
        [GladiusEx:SafeGetSpellName(116706)] = 5.6, -- Disable (Root)
        [GladiusEx:SafeGetSpellName(113275)] = 5.6, -- Entangling Roots (Symbiosis) [Monk]
        [GladiusEx:SafeGetSpellName(123407)] = 5.6, -- Spinning Fire Blossom
        [GladiusEx:SafeGetSpellName(115197)] = 5.6, -- Partial Paralysis
        [GladiusEx:SafeGetSpellName(64695)]  = 5.6, -- Earthgrab (Earthgrab Totem)
        [GladiusEx:SafeGetSpellName(63685)]  = 5.6, -- Freeze (Frozen Power)
        [GladiusEx:SafeGetSpellName(87194)]  = 5.6, -- Glyph of Mind Blast
        [GladiusEx:SafeGetSpellName(114404)] = 5.6, -- Void Tendril's Grasp
        [GladiusEx:SafeGetSpellName(39965)]  = 5.6, -- Frost Grenade
        [GladiusEx:SafeGetSpellName(55536)]  = 5.6, -- Frostweave Net
        [GladiusEx:SafeGetSpellName(107566)] = 5.6, -- Staggering Shout
        [GladiusEx:SafeGetSpellName(105771)] = 5.6, -- Warbringer
        [GladiusEx:SafeGetSpellName(115000)] = 5.6, -- Remorseless Winter
        [GladiusEx:SafeGetSpellName(25999)]  = 5.6, -- Charge
        [GladiusEx:SafeGetSpellName(115757)] = 5.6, -- Frost Nova (Glyph of Ice Block)

        -- IMMUNITIES (COMPLETE IMMUNITY), priority 8
        [GladiusEx:SafeGetSpellName(642)]    = 8, -- Divine Shield
        [GladiusEx:SafeGetSpellName(58984)]  = 8, -- Shadowmeld
        [GladiusEx:SafeGetSpellName(27827)]  = 8, -- Spirit of Redemption
        [GladiusEx:SafeGetSpellName(19263)]  = 8, -- Deterrence
        [GladiusEx:SafeGetSpellName(110618)] = 8, -- Deterrence
        [GladiusEx:SafeGetSpellName(65871)]  = 8, -- Deterrence
        [GladiusEx:SafeGetSpellName(148467)] = 8, -- Deterrence
        [GladiusEx:SafeGetSpellName(67801)]  = 8, -- Deterrence
        [GladiusEx:SafeGetSpellName(110617)] = 8, -- Deterrence (Hunter)
        [GladiusEx:SafeGetSpellName(110700)] = 8, -- Divine Shield (Paladin)
        [GladiusEx:SafeGetSpellName(110696)] = 8, -- Ice Block (Mage)
        [GladiusEx:SafeGetSpellName(45438)]  = 8, -- Ice Block
        [GladiusEx:SafeGetSpellName(122465)] = 8, -- Dematerialize

        -- Other Buffs like stealth buff and stance or form buffs -- priority 3
        [GladiusEx:SafeGetSpellName(22734)] = 3, -- Drink
        [GladiusEx:SafeGetSpellName(46755)] = 3, -- Drink
        [GladiusEx:SafeGetSpellName(27089)] = 3, -- Drink
        [GladiusEx:SafeGetSpellName(43183)] = 3, -- Drink
        [GladiusEx:SafeGetSpellName(57073)] = 3, -- Drink
        [GladiusEx:SafeGetSpellName(768)]   = 3, -- Cat Form
        [GladiusEx:SafeGetSpellName(783)]   = 3, -- Travel Form
        [GladiusEx:SafeGetSpellName(24858)] = 3, -- Moonkin Form
        [GladiusEx:SafeGetSpellName(33891)] = 3, -- Tree of Life
        [GladiusEx:SafeGetSpellName(5487)]  = 3, -- Bear Form
        [GladiusEx:SafeGetSpellName(115191)] = 3, -- Stealth
        [GladiusEx:SafeGetSpellName(114018)] = 3, -- Shroud of Concealment
        [GladiusEx:SafeGetSpellName(80325)] = 3, -- Camouflage
        [GladiusEx:SafeGetSpellName(51755)] = 3, -- Camouflage
        [GladiusEx:SafeGetSpellName(90954)] = 3, -- Camouflage
        [GladiusEx:SafeGetSpellName(119450)] = 3, -- Camouflage
        [GladiusEx:SafeGetSpellName(119030)] = 3, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(112833)] = 3, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(119032)] = 3, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(119012)] = 3, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(66)]    = 3, -- Invisibility
        [GladiusEx:SafeGetSpellName(5215)]  = 3, -- Prowl
        [GladiusEx:SafeGetSpellName(102547)] = 3, -- Prowl
        [GladiusEx:SafeGetSpellName(113289)] = 3, -- Prowl
        [GladiusEx:SafeGetSpellName(142453)] = 3, -- Prowl
        [GladiusEx:SafeGetSpellName(133079)] = 3, -- Prowl
        [GladiusEx:SafeGetSpellName(29166)] = 3, -- Innervate
        [GladiusEx:SafeGetSpellName(54428)] = 3, -- Divine Plea
        [GladiusEx:SafeGetSpellName(12051)] = 3, -- Evocation
        [GladiusEx:SafeGetSpellName(16191)] = 3, -- Mana Tide Totem

        -- BUFF_DEFENSIVE -- priority 5
        [GladiusEx:SafeGetSpellName(110909)] = 5, -- Alter Time
        [GladiusEx:SafeGetSpellName(16188)]  = 10, -- Ancestral Swiftness (also used offensively)
        [GladiusEx:SafeGetSpellName(114214)] = 5, -- Angelic Bulwark
        [GladiusEx:SafeGetSpellName(50461)]  = 5, -- Anti-Magic Zone
        [GladiusEx:SafeGetSpellName(31850)]  = 5, -- Ardent Defender
        [GladiusEx:SafeGetSpellName(22812)]  = 5, -- Barkskin
        [GladiusEx:SafeGetSpellName(6940)]   = 5, -- Blessing of Sacrifice
        [GladiusEx:SafeGetSpellName(111397)] = 5, -- Blood Horror
        [GladiusEx:SafeGetSpellName(45182)]  = 5, -- Cheating Death
        [GladiusEx:SafeGetSpellName(74001)]  = 5, -- Combat Readiness
        [GladiusEx:SafeGetSpellName(1742)]   = 5, -- Cower (Pet)
        [GladiusEx:SafeGetSpellName(110913)] = 5, -- Dark Bargain
        [GladiusEx:SafeGetSpellName(31821)]  = 5, -- Devotion Aura
        [GladiusEx:SafeGetSpellName(118038)] = 5, -- Die by the Sword
        [GladiusEx:SafeGetSpellName(110715)] = 5, -- Dispersion (Priest)
        [GladiusEx:SafeGetSpellName(47585)]  = 5, -- Dispersion
        [GladiusEx:SafeGetSpellName(31842)]  = 5, -- Divine Favor
        [GladiusEx:SafeGetSpellName(64843)]  = 5, -- Divine Hymn
        [GladiusEx:SafeGetSpellName(498)]    = 5, -- Divine Protection
        [GladiusEx:SafeGetSpellName(55694)]  = 5, -- Enraged Regeneration
        [GladiusEx:SafeGetSpellName(5277)]   = 5, -- Evasion
        [GladiusEx:SafeGetSpellName(110791)] = 5, -- Evasion (Druid) (Symbiosis)
        [GladiusEx:SafeGetSpellName(5384)]   = 5, -- Feign Death
        [GladiusEx:SafeGetSpellName(126456)] = 5, -- Fortifying Brew
        [GladiusEx:SafeGetSpellName(22842)]  = 5, -- Frenzied Regeneration
        [GladiusEx:SafeGetSpellName(86659)]  = 5, -- Guardian of Ancient Kings
        [GladiusEx:SafeGetSpellName(47788)]  = 5, -- Guardian Spirit
        [GladiusEx:SafeGetSpellName(1022)]   = 5, -- Hand of Protection
        [GladiusEx:SafeGetSpellName(48792)]  = 5, -- Icebound Fortitude
        [GladiusEx:SafeGetSpellName(110575)] = 5, -- Icebound Fortitude (Druid) (Symbiosis)
        [GladiusEx:SafeGetSpellName(1463)]   = 5, -- Incanter's Ward
        [GladiusEx:SafeGetSpellName(102342)] = 5, -- Ironbark
        [GladiusEx:SafeGetSpellName(12975)]  = 5, -- Last Stand
        [GladiusEx:SafeGetSpellName(116849)] = 5, -- Life Cocoon
        [GladiusEx:SafeGetSpellName(132158)] = 10, -- Nature's Swiftness (also used offensively)
        [GladiusEx:SafeGetSpellName(29274)]  = 10, -- Nature's Swiftness
        [GladiusEx:SafeGetSpellName(33206)]  = 5, -- Pain Suppression
        [GladiusEx:SafeGetSpellName(81782)]  = 5, -- Power Word: Barrier
        [GladiusEx:SafeGetSpellName(12043)]  = 10, -- Presence of Mind (also used offensively)
        [GladiusEx:SafeGetSpellName(116844)] = 5, -- Ring of Peace
        [GladiusEx:SafeGetSpellName(53480)]  = 5, -- Roar of Sacrifice (Hunter Pet Skill)
        [GladiusEx:SafeGetSpellName(30823)]  = 5, -- Shamanistic Rage
        [GladiusEx:SafeGetSpellName(871)]    = 5, -- Shield Wall
        [GladiusEx:SafeGetSpellName(98007)]  = 5, -- Spirit Link Totem
        [GladiusEx:SafeGetSpellName(20711)]  = 5, -- Spirit of Redemption
        [GladiusEx:SafeGetSpellName(61336)]  = 5, -- Survival Instincts
        [GladiusEx:SafeGetSpellName(115610)] = 5, -- Temporal Shield
        [GladiusEx:SafeGetSpellName(122470)] = 5, -- Touch of Karma
        [GladiusEx:SafeGetSpellName(104773)] = 5, -- Unending Resolve
        [GladiusEx:SafeGetSpellName(122291)] = 5, -- Unending Resolve (Druid) (Symbiosis)
        [GladiusEx:SafeGetSpellName(114030)] = 5, -- Vigilance
        [GladiusEx:SafeGetSpellName(131523)] = 5,  -- Zen Meditation

        -- BUFF_OFFENSIVE -- priority 4
        [GladiusEx:SafeGetSpellName(108288)]  = 4, -- Adrenaline Rush
        [GladiusEx:SafeGetSpellName(13750)]  = 4, -- Adrenaline Rush
        [GladiusEx:SafeGetSpellName(12042)]  = 4, -- Arcane Power
        [GladiusEx:SafeGetSpellName(114049)] = 4, -- Ascendance
        [GladiusEx:SafeGetSpellName(107574)] = 4, -- Avatar
        [GladiusEx:SafeGetSpellName(31884)]  = 4, -- Avenging Wrath
        [GladiusEx:SafeGetSpellName(50334)]  = 4, -- Berserk
        [GladiusEx:SafeGetSpellName(23505)]  = 4, -- Berserking (BG DMG BUFF)
        [GladiusEx:SafeGetSpellName(13877)]  = 4, -- Blade Flurry
        [GladiusEx:SafeGetSpellName(20572)]  = 4, -- Blood Fury (Racial)
        [GladiusEx:SafeGetSpellName(2825)]   = 4, -- Bloodlust
        [GladiusEx:SafeGetSpellName(126690)] = 4, -- Call of Conquest
        [GladiusEx:SafeGetSpellName(126683)] = 4, -- Call of Dominance
        [GladiusEx:SafeGetSpellName(126679)] = 4, -- Call of Victory
        [GladiusEx:SafeGetSpellName(112071)] = 4, -- Celestial Alignment
        [GladiusEx:SafeGetSpellName(113858)] = 4, -- Dark Soul: Instability
        [GladiusEx:SafeGetSpellName(113861)] = 4, -- Dark Soul: Knowledge
        [GladiusEx:SafeGetSpellName(113860)] = 4, -- Dark Soul: Misery
        [GladiusEx:SafeGetSpellName(120679)] = 4, -- Dire Beast
        [GladiusEx:SafeGetSpellName(16166)]  = 4, -- Elemental Mastery
        [GladiusEx:SafeGetSpellName(115288)] = 4, -- Energizing Brew
        [GladiusEx:SafeGetSpellName(82726)]  = 4, -- Fervor
        [GladiusEx:SafeGetSpellName(44544)]  = 4, -- Fingers of Frost
        [GladiusEx:SafeGetSpellName(32182)]  = 4, -- Heroism
        [GladiusEx:SafeGetSpellName(105809)] = 4, -- Holy Avenger
        [GladiusEx:SafeGetSpellName(131078)] = 4, -- Icy Veins (no check spell id)
        [GladiusEx:SafeGetSpellName(19577)]  = 4, -- Intimidation (Buff)
        [GladiusEx:SafeGetSpellName(51690)]  = 4, -- Killing Spree
        [GladiusEx:SafeGetSpellName(51271)]  = 4, -- Pillar of Frost
        [GladiusEx:SafeGetSpellName(10060)]  = 4, -- Power Infusion
        [GladiusEx:SafeGetSpellName(69369)]  = 4, -- Predator's Swiftness
        [GladiusEx:SafeGetSpellName(3045)]   = 4, -- Rapid Fire
        [GladiusEx:SafeGetSpellName(1719)]   = 4, -- Recklessness
        [GladiusEx:SafeGetSpellName(51713)]  = 4, -- Shadow Dance
        [GladiusEx:SafeGetSpellName(121818)] = 4, -- Stampede
        [GladiusEx:SafeGetSpellName(34471)]  = 4, -- The Beast Within
        [GladiusEx:SafeGetSpellName(5217)]   = 4, -- Tiger's Fury
        [GladiusEx:SafeGetSpellName(49016)]  = 4, -- Unholy Frenzy
  }
end

function GladiusEx.Data.DefaultCooldowns()
    return {
        {
            -- group 1
            [22812] = true, -- Druid/Barkskin
            [33786] = true, -- Druid/Cyclone (feral)
            [99] = true, -- Druid/Disorienting Roar
            [16689] = true, -- Druid/Nature's Grasp
            [5211] = true, -- Druid/Bash
            [16979] = true, -- Druid/Feral Charge
            [132158] = true, -- Druid/Nature's Swiftness
            [29274] = true, -- Druid/Nature's Swiftness
            [19574] = true, -- Hunter/Bestial Wrath
            [19263] = true, -- Hunter/Deterrence
            [781] = true, -- Hunter/Disengage
            [1499] = true, -- Hunter/Freezing Trap
            [19577] = true, -- Hunter/Intimidation
            [23989] = true, -- Hunter/Readiness
            [19386] = true, -- Hunter/Wyvern Sting
            [19503] = true, -- Hunter/Scatter Shot
            [34490] = true, -- Hunter/Silencing Shot
            [26064] = true, -- Hunter/Shell Shield
            [3045] = true, -- Hunter/Rapid Fire
            [1953] = true, -- Mage/Blink
            [11958] = true, -- Mage/Cold Snap. V: changed ID in legion
            [2139] = true, -- Mage/Counterspell
            [122] = true, -- Mage/Frost Nova
            [45438] = true, -- Mage/Ice Block
            [12043] = true, -- Mage/Presence of Mind
            [12051] = true, -- Mage/Evocation
            [31661] = true, -- Mage/Dragon's Breath
            [11129] = true, -- Mage/Combustion
            [12472] = true, -- Mage/Icy Veins
            [4987] = true, -- Paladin/Cleanse
            [31821] = true, -- Paladin/Devotion Aura
            [642] = true, -- Paladin/Divine Shield
            [853] = true, -- Paladin/Hammer of Justice
            [20066] = true, -- Paladin/Repentance
            [1044] = true, -- Paladin/Blessing of Freedom
            [6940] = true, -- Paladin/Blessing of Sacrifice
            [31884] = true, -- Paladin/Avenging Wrath
            [31842] = true, -- Paladin/Divine Illumination
            [20925] = true, -- Paladin/Holy Shield
            [20216] = true, -- Paladin/Divine Favor
            [498] = true, -- Paladin/Divine Protection
            [1022] = true, -- Paladin/Blessing of Protection
            [48173] = true, -- Priest/Desperate Prayer
            [33206] = true, -- Priest/Pain Suppression
            [8122] = true, -- Priest/Psychic Scream
            [527] = true, -- Priest/Purify
            [15487] = true, -- Priest/Silence
            [10060] = true, -- Priest/Power Infusion
            [34433] = true, -- Priest/Shadowfiend
            [14751] = true, -- Priest/Inner Focus
            [6346] = true, -- Priest/Fear Ward
            [47585] = true, -- Priest/Dispersion
            [13750] = true, -- Rogue/Adrenaline Rush
            [13877] = true, -- Rogue/Blade Furry
            [2094] = true, -- Rogue/Blind
            [31224] = true, -- Rogue/Cloak of Shadows
            [1766] = true, -- Rogue/Kick
            [1856] = true, -- Rogue/Vanish
            [14177] = true, -- Rogue/Cold Blood
            [36554] = true, -- Rogue/Shadowstep
            [5277] = true, -- Rogue/Evasion
            [2983] = true, -- Rogue/Sprint
            [14185] = true, -- Rogue/Preparation
            [5484] = true, -- Warlock/Howl of Terror
            [6789] = true, -- Warlock/Death Coil
            [30283] = true, -- Warlock/Shadowfury
            [19647] = true, -- Warlock/Spell Lock
            [19505] = true, -- Warlock/Devour Magic
            [5246] = true, -- Warrior/Intimidating Shout
            [6552] = true, -- Warrior/Pummel
            [1719] = true, -- Warrior/Recklessness
            [871] = true, -- Warrior/Shield Wall
            [23920] = true, -- Warrior/Spell Reflection
            [12292] = true, -- Warrior/Death Wish
            [3411] = true, -- Warrior/Intervene
            [100] = true, -- Warrior/Charge
            [20252] = true, -- Warrior/Intercept
            [12809] = true, -- Warrior/Concussion Blow
            [18499] = true, -- Warrior/Berserker Rage
            [676] = true, -- Warrior/Disarm
            [12975] = true, -- Warrior/Last Stand
            [57994] = true, -- Shaman/Wind Shear
            [16188] = true, -- Shaman/Nature's Swiftness
            [8177] = true, -- Shaman/Grounding Totem
            [30823] = true, -- Shaman/Shamanistic Rage
            [49039] = true, -- Death Knight/Lichborne
            [47476] = true, -- Death Knight/Strangulate
            [48792] = true, -- Death Knight/Icebound Fortitude
            [47528] = true, -- Death Knight/Mind Freeze
            [51052] = true, -- Death Knight/Anti-Magic Zone
            [48707] = true -- Death Knight/Anti-Magic Shell
        },
        {
            -- group 2
            [42292] = true, -- PvP Trinket
            [59752] = true -- Will to Survive (Human EMFH) K: This is not needed since EMFH shares CD with PvP Trinket
        }
    }
end

function GladiusEx.Data.InterruptModifiers()
    return {}
end

function GladiusEx.Data.Interrupts()
    return {
        [72]    = { duration = 6 }, -- Shield Bash (Warrior)
        [1766]  = { duration = 5 }, -- Kick (Rogue)
        [2139]  = { duration = 8 }, -- Counterspell (Mage)
        [6552]  = { duration = 4 }, -- Pummel
        [13491] = { duration = 5 }, -- Iron Knuckles
        [16979] = { duration = 4 }, -- Feral Charge (Druid)
        [19647] = { duration = 6 }, -- Spell Lock - Rank 1 (Warlock)
        [26090] = { duration = 2, }, -- Pummel (Pet)
        [26679] = { duration = 3 }, -- Deadly Throw
        [29443] = { duration = 10 }, -- Clutch of Foresight
        [47528] = { duration = 4, },  -- Mind Freeze
        [50318] = { duration = 4 }, -- Serenity Dust (Moth - Hunter Pet)
        [50479] = { duration = 2},  -- Nether Shock (Nether Ray - Hunter Pet)
        [57994] = { duration = 2, },  -- Wind Shear
        [78675] = { duration = 5 }, -- Solar Beam interrupt
        [80964] = { duration = 4 }, -- Skull Bash (Bear)
        [80965] = { duration = 4 }, -- Skull Bash (Cat)
        [91802] = { duration = 2 },  -- Shambling Rush (pet dk kick)
        [96231] = { duration = 4 }, -- Rebuke
        [115781] = { duration = 6 }, -- Optical Blast (Interrupt)
        [119911] = { duration = 6 }, -- Optical Blast (Interrupt)
        [147362] = { duration = 3}, -- Counter Shot (Hunter)
        [386071] = { duration = 6 }, -- Disrupting Shout (Warrior)
    }
end

-- K: This is used to assess whether a DR has (dynamically) reset early
GladiusEx.Data.AuraDurations = {
    [64058] = 10,  -- Psychic Horror Disarm Effect
    [51722] = 10,  -- Dismantle
    [676]   = 10,  -- Disarm
    [1513]  = 8,   -- Scare Beast
    [10326] = 8,   -- Turn Evil
    [8122]  = 8,   -- Psychic Scream
    [2094]  = 8,   -- Blind
    [5782]  = 8,   -- Fear
    [6358]  = 8,   -- Seduction (Succubus)
    [5484]  = 8,   -- Howl of Terror
    [5246]  = 8,   -- Intimidating Shout
    [20511] = 8,   -- Intimidating Shout (secondary targets)
    [339]   = 8,   -- Entangling Roots
    [19975] = 8,   -- Nature's Grasp
    [33395] = 8,   -- Freeze (Water Elemental)
    [122]   = 8,   -- Frost Nova
    [605]   = 8,   -- Mind Control
    [49203] = 8,   -- Hungering Cold
    [2637]  = 8,   -- Hibernate
    [3355]  = 8,   -- Freezing Trap Effect
    [9484]  = 8,   -- Shackle Undead
    [118]   = 8,   -- Polymorph
    [28271] = 8,   -- Polymorph: Turtle
    [28272] = 8,   -- Polymorph: Pig
    [61721] = 8,   -- Polymorph: Rabbit
    [61305] = 8,   -- Polymorph: Black Cat
    [51514] = 8,   -- Hex
    [6770]  = 8,   -- Sap
    [19386] = 6,   -- Wyvern Sting
    [33786] = 6,   -- Cyclone
    [20066] = 6,   -- Repentance
    [710]   = 6,   -- Banish
    [853]   = 6,   -- Hammer of Justice
    [64695] = 5,   -- Earthgrab
    [63685] = 5,   -- Freeze (Frost Shock)
    [54706] = 5,   -- Venom Web Spray (Silithid)
    [4167]  = 5,   -- Web (Spider)
    [19306] = 5,   -- Counterattack
    [31661] = 5,   -- Dragon's Breath
    [31117] = 5,   -- Silenced - Unstable Affliction (Rank 1)
    [47476] = 5,   -- Strangulate
    [23694] = 5,   -- Improved Hamstring
    [15487] = 5,   -- Silence
    [44572] = 5,   -- Deep Freeze
    [12809] = 5,   -- Concussion Blow
    [20170] = 5,   -- Seal of Justice Stun
    [1776]  = 4,   -- Gouge
    [5211]  = 4,   -- Bash
    [46968] = 4,   -- Shockwave
    [1833]  = 4,   -- Cheap Shot
    [83073] = 4,   -- Shattered Barrier (4 seconds)
    [55021] = 4,   -- Silenced - Improved Counterspell (Rank 2)
    [89766] = 4,   -- Axe Toss (Felguard)
    [19503] = 4,   -- Scatter Shot
    [67890] = 3,   -- Cobalt Frag Bomb (Item, Frag Belt)
    [24394] = 3,   -- Intimidation
    [2812]  = 3,   -- Holy Wrath
    [30283] = 3,   -- Shadowfury
    [20253] = 3,   -- Intercept Stun
    [9005]  = 3,   -- Pounce
    [19577] = 3,   -- Intimidation
    [39796] = 3,   -- Stoneclaw Stun
    [34490] = 3,   -- Silencing Shot
    [1330]  = 3,   -- Garrote - Silence
    [86759] = 3,   -- Silenced - Improved Kick (Rank 2)
    [24259] = 3,   -- Spell Lock
    [18498] = 3,   -- Silenced - Gag Order (Shield Slam)
    [74347] = 3,   -- Silenced - Gag Order (Heroic Throw)
    [31935] = 3,   -- Avenger's Shield
    [64044] = 3,   -- Psychic Horror
    [6789]  = 3,   -- Death Coil
    [50613] = 2,   -- Arcane Torrent (Racial, Runic Power)
    [18469] = 2,   -- Silenced - Improved Counterspell (Rank 1)
    [55080] = 2,   -- Shattered Barrier (2 seconds)
    [12355] = 2,   -- Impact
    [20549] = 2,   -- War Stomp (Racial)
    [47481] = 2,   -- Gnaw (Ghoul Pet)
    [50519] = 2,   -- Sonic Blast
    [12421] = 2,   -- Mithril Frag Bomb (Item)
    [28730] = 2,   -- Arcane Torrent (Racial, Mana)
    [25046] = 2,   -- Arcane Torrent (Racial, Energy)
    [58861] = 2,   -- Bash (Spirit Wolves)
    [18425] = 1.5, -- Silenced - Improved Kick
    [7922]  = 1.5, -- Charge Stun
    --[81261] = 0, -- Solar Beam (static, unusable)
    [408]   = 6, -- Kidney Shot (varies)
    [22570] = 5, -- Maim (varies)
}

function GladiusEx.Data.GetSpecializationInfoByID(id)
    return GetSpecializationInfoByID(id)
end

function GladiusEx.Data.GetNumSpecializationsForClassID(classID)
    return C_SpecializationInfo.GetNumSpecializationsForClassID(classID)
end

function GladiusEx.Data.GetSpecializationInfoForClassID(classID, specIndex)
    return GetSpecializationInfoForClassID(classID, specIndex)
end

function GladiusEx.Data.GetArenaOpponentSpec(id)
    return GetArenaOpponentSpec(id)
end

function GladiusEx.Data.CountArenaOpponents()
    return GetNumArenaOpponentSpecs()
end

function GladiusEx.Data.GetNumArenaOpponentSpecs()
    return GetNumArenaOpponentSpecs()
end
