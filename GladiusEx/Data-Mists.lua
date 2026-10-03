GladiusEx.Data = {}

function GladiusEx.Data.DefaultAlertSpells()
    return {}
end

function GladiusEx.Data.DefaultAuras()
    return {
        -- [GladiusEx:SafeGetSpellName(57940)] = true -- Essence of Wintergrasp
    }
end

function GladiusEx.Data.DefaultClassicon()
	return {
		-- Higher Number is More Priority
        -- Drinks
        [GladiusEx:SafeGetSpellName(22734)] = 10, -- Drink
        [GladiusEx:SafeGetSpellName(46755)] = 10, -- Drink
        [GladiusEx:SafeGetSpellName(27089)] = 10, -- Drink
        [GladiusEx:SafeGetSpellName(43183)] = 10, -- Drink
        [GladiusEx:SafeGetSpellName(57073)] = 10, -- Drink
        [GladiusEx:SafeGetSpellName(46755)] = 10, -- Drink
        [GladiusEx:SafeGetSpellName(44166)] = 10, -- Refreshment

		-- CCs
        [GladiusEx:SafeGetSpellName(33786)]	= 10, -- Cyclone
        [GladiusEx:SafeGetSpellName(113506)] = 10, -- Cyclone (Symbiosis)
		[GladiusEx:SafeGetSpellName(605)] = 10,	-- Mind Control
		[GladiusEx:SafeGetSpellName(2637)] = 10, -- Hibernate 
		[GladiusEx:SafeGetSpellName(3355)] = 10, -- Freezing Trap 
		[GladiusEx:SafeGetSpellName(19503)] = 10, -- Scatter Shot
		[GladiusEx:SafeGetSpellName(118)] = 10, -- Polymorph
		[GladiusEx:SafeGetSpellName(28272)] = 10, -- Polymorph (pig)
		[GladiusEx:SafeGetSpellName(28271)] = 10, -- Polymorph (turtle)
        [GladiusEx:SafeGetSpellName(61305)] = 10, -- Polymorph: Black Cat
        [GladiusEx:SafeGetSpellName(61721)] = 10, -- Polymorph: Rabbit
        [GladiusEx:SafeGetSpellName(61025)] = 10, -- Polymorph: Serpent
        [GladiusEx:SafeGetSpellName(61780)] = 10, -- Polymorph: Turkey
		[GladiusEx:SafeGetSpellName(20066)] = 10, -- Repentance
		[GladiusEx:SafeGetSpellName(1776)] = 10, -- Gouge
		[GladiusEx:SafeGetSpellName(6770)] = 10, -- Sap
		[GladiusEx:SafeGetSpellName(1513)] = 10, -- Scare Beast
		[GladiusEx:SafeGetSpellName(31661)] = 10, -- Dragon's Breath 
		[GladiusEx:SafeGetSpellName(8122)] = 10, -- Psychic Scream 
		[GladiusEx:SafeGetSpellName(2094)] = 10, -- Blind 
		[GladiusEx:SafeGetSpellName(5782)] = 10, -- Fear
        [GladiusEx:SafeGetSpellName(51514)] = 10, -- Hex
		[GladiusEx:SafeGetSpellName(5484)] = 10, -- Howl of Terror
		[GladiusEx:SafeGetSpellName(6358)] = 10, -- Seduction
		[GladiusEx:SafeGetSpellName(5246)] = 10, -- Intimidating Shout 
		[GladiusEx:SafeGetSpellName(22570)] = 10, -- Maim
		[GladiusEx:SafeGetSpellName(19386)] = 10, -- Wyvern Sting
		[GladiusEx:SafeGetSpellName(90337)] = 10, -- Bad Manner
        [GladiusEx:SafeGetSpellName(710)] = 10, -- Banish
        [GladiusEx:SafeGetSpellName(76780)] = 10, -- Bind Elemental
        [GladiusEx:SafeGetSpellName(115078)] = 10, -- Paralysis
        [GladiusEx:SafeGetSpellName(107079)] = 10, -- Quaking Palm (Racial)
        [GladiusEx:SafeGetSpellName(82691)] = 10, -- Ring of Frost
        [GladiusEx:SafeGetSpellName(9484)] = 10, -- Shackle Undead
        [GladiusEx:SafeGetSpellName(105421)] = 10, -- Blinding Light
        [GladiusEx:SafeGetSpellName(99)] = 10, -- Disorienting Roar
        [GladiusEx:SafeGetSpellName(123393)] = 10, -- Glyph of Breath of Fire
        [GladiusEx:SafeGetSpellName(88625)] = 10, -- Holy Word: Chastise
        [GladiusEx:SafeGetSpellName(118699)] = 10, -- Fear 2
        [GladiusEx:SafeGetSpellName(113056)] = 10, -- Intimidating Roar (Symbiosis 2)
        [GladiusEx:SafeGetSpellName(113004)] = 10, -- Intimidating Roar (Symbiosis)
        [GladiusEx:SafeGetSpellName(20511)] = 10, -- Intimidating Shout (secondary targets)
        [GladiusEx:SafeGetSpellName(115268)] = 10, -- Mesmerize (Shivarra)
        [GladiusEx:SafeGetSpellName(113792)] = 10, -- Psychic Terror (Psyfiend)
        [GladiusEx:SafeGetSpellName(104045)] = 10, -- Sleep (Metamorphosis)
        [GladiusEx:SafeGetSpellName(10326)] = 10, -- Turn Evil
        [GladiusEx:SafeGetSpellName(145067)] = 10, -- Turn Evil (Evil is a Point of View)
        [GladiusEx:SafeGetSpellName(137143)] = 10, -- Blood Horror
		[GladiusEx:SafeGetSpellName(6789)] = 10, -- Death Coil
        [GladiusEx:SafeGetSpellName(64044)] = 10, -- Psychic Horror
		[GladiusEx:SafeGetSpellName(5211)] = 10, -- Bash 
		[GladiusEx:SafeGetSpellName(24394)] = 10, -- Intimidation 
		[GladiusEx:SafeGetSpellName(853)] = 10, -- Hammer of Justice
		[GladiusEx:SafeGetSpellName(1833)] = 10, -- Cheap Shot 
		[GladiusEx:SafeGetSpellName(408)] = 10, -- Kidney Shot 
		[GladiusEx:SafeGetSpellName(30283)] = 10, -- Shadowfury 
		[GladiusEx:SafeGetSpellName(20549)] = 10, -- War Stomp
		[GladiusEx:SafeGetSpellName(835)] = 10, -- Tidal Charm (magic dispellable), (probably does not exist in the game and not usable in arena)
        [GladiusEx:SafeGetSpellName(108194)] = 10, -- Asphyxiate
        [GladiusEx:SafeGetSpellName(89766)] = 10, -- Axe Toss (Felguard)
        [GladiusEx:SafeGetSpellName(113801)] = 10, -- Bash (Treants)
        [GladiusEx:SafeGetSpellName(102795)] = 10, -- Bear Hug
        [GladiusEx:SafeGetSpellName(117526)] = 10, -- Binding Shot
        [GladiusEx:SafeGetSpellName(115752)] = 10, -- Blinding Light (Glyphed)
        [GladiusEx:SafeGetSpellName(119392)] = 10, -- Charging Ox Wave
        [GladiusEx:SafeGetSpellName(122242)] = 10, -- Clash
        [GladiusEx:SafeGetSpellName(118271)] = 10, -- Combustion
        [GladiusEx:SafeGetSpellName(44572)] = 10, -- Deep Freeze
        [GladiusEx:SafeGetSpellName(105593)] = 10, -- Fist of Justice
        [GladiusEx:SafeGetSpellName(120086)] = 10, -- Fists of Fury
        [GladiusEx:SafeGetSpellName(91800)] = 10, -- Gnaw (Ghoul)
        [GladiusEx:SafeGetSpellName(110698)] = 10, -- Hammer of Justice (Symbiosis)
        [GladiusEx:SafeGetSpellName(119072)] = 10, -- Holy Wrath
        [GladiusEx:SafeGetSpellName(22703)] = 10, -- Inferno Effect
        [GladiusEx:SafeGetSpellName(119381)] = 10, -- Leg Sweep
        [GladiusEx:SafeGetSpellName(126246)] = 10, -- Lullaby (Crane pet)
        [GladiusEx:SafeGetSpellName(91797)] = 10, -- Monstrous Blow (Dark Transformation Ghoul)
        [GladiusEx:SafeGetSpellName(126423)] = 10, -- Petrifying Gaze (Basilisk pet)
        [GladiusEx:SafeGetSpellName(9005)] = 10, -- Pounce
        [GladiusEx:SafeGetSpellName(118345)] = 10, -- Pulverize (Primal Earth Elemental)
        [GladiusEx:SafeGetSpellName(126355)] = 10, -- Quill (Porcupine pet)
        [GladiusEx:SafeGetSpellName(115001)] = 10, -- Remorseless Winter
        [GladiusEx:SafeGetSpellName(132168)] = 10, -- Shockwave
        [GladiusEx:SafeGetSpellName(50519)] = 10, -- Sonic Blast
        [GladiusEx:SafeGetSpellName(118905)] = 10, -- Static Charge (Capacitor Totem)
        [GladiusEx:SafeGetSpellName(56626)] = 10, -- Sting (Wasp)
        [GladiusEx:SafeGetSpellName(107570)] = 10, -- Storm Bolt
        [GladiusEx:SafeGetSpellName(132169)] = 10, -- Storm Bolt 2
        [GladiusEx:SafeGetSpellName(7922)] = 9.9, -- Charge Stun
        [GladiusEx:SafeGetSpellName(118000)] = 10, -- Dragon Roar
        [GladiusEx:SafeGetSpellName(118895)] = 10, -- Dragon Roar
        [GladiusEx:SafeGetSpellName(77505)] = 10, -- Earthquake
        [GladiusEx:SafeGetSpellName(113953)] = 10, -- Paralysis
        
        -- Rogue Vanish Buff
        [GladiusEx:SafeGetSpellName(115193)] = 9.5, -- Vanish (Rogue)
        [GladiusEx:SafeGetSpellName(115192)] = 9.5, -- Subterfuge (Rogue)
        
        -- Silences
        [GladiusEx:SafeGetSpellName(25046)]	= 9, -- Arcane Torrent (Racial, Energy)
        [GladiusEx:SafeGetSpellName(80483)]	= 9, -- Arcane Torrent (Racial, Focus)
        [GladiusEx:SafeGetSpellName(28730)]	= 9, -- Arcane Torrent (Racial, Mana)
        [GladiusEx:SafeGetSpellName(69179)]	= 9, -- Arcane Torrent (Racial, Rage)
        [GladiusEx:SafeGetSpellName(50613)]	= 9, -- Arcane Torrent (Racial, Runic Power)
        [GladiusEx:SafeGetSpellName(31935)]	= 9, -- Avenger's Shield
        [GladiusEx:SafeGetSpellName(55021)]	= 9, -- Counterspell
        [GladiusEx:SafeGetSpellName(102051)] = 9, -- Frostjaw
        [GladiusEx:SafeGetSpellName(114238)] = 9, -- Glyph of Fae Silence
        [GladiusEx:SafeGetSpellName(115782)] = 9, -- Optical Blast (Observer)
        [GladiusEx:SafeGetSpellName(137460)] = 9, -- Ring of Peace (Silence effect)
        [GladiusEx:SafeGetSpellName(18498)]	= 9, -- Silenced - Gag Order
        [GladiusEx:SafeGetSpellName(78675)]	= 9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(81261)]	= 9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(133901)] = 9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(129888)] = 9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(129889)] = 9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(133899)] = 9, -- Solar Beam
        [GladiusEx:SafeGetSpellName(113286)] = 9, -- Solar Beam (Symbiosis)
        [GladiusEx:SafeGetSpellName(113287)] = 9, -- Solar Beam (Symbiosis)
        [GladiusEx:SafeGetSpellName(116709)] = 9, -- Spear Hand Strike
        [GladiusEx:SafeGetSpellName(24259)]	= 9, -- Spell Lock
        [GladiusEx:SafeGetSpellName(47476)]	= 9, -- Strangulate
        [31117] = 9, -- Unstable Affliction (Silence), exact aura ID as in LoseControl
        [43523] = 9, -- Unstable Affliction (Silence), exact aura ID as in LoseControl
        [GladiusEx:SafeGetSpellName(15487)]	= 9, -- Silence
		[GladiusEx:SafeGetSpellName(34490)]	= 9, -- Silencing shot (3 second silence)
		[GladiusEx:SafeGetSpellName(1330)]	= 9, -- Garrote

        -- Instant Casts
        [GladiusEx:SafeGetSpellName(16188)]	= 8.9, -- Ancestral Swiftness (Shaman)
        [GladiusEx:SafeGetSpellName(132158)] = 8.9, -- Nature's Swiftness (Druid)
        [GladiusEx:SafeGetSpellName(114108)] = 8.6, -- Soul of the Forest (Resto Druid)
        [GladiusEx:SafeGetSpellName(29274)]	= 8.9, -- Nature's Swiftness (Druid)
        [GladiusEx:SafeGetSpellName(12043)]	= 8.9, -- Presence of Mind
        [GladiusEx:SafeGetSpellName(69369)]	= 8.9, -- Predator's Swiftness (Feral Druid)


        -- Immunity
        [GladiusEx:SafeGetSpellName(122465)] = 8.8, -- Dematerialize
        [GladiusEx:SafeGetSpellName(65871)]	= 8.8, -- Deterrence
        [GladiusEx:SafeGetSpellName(110617)] = 8.8, -- Deterrence
        [GladiusEx:SafeGetSpellName(19263)]	= 8.8, -- Deterrence
        [GladiusEx:SafeGetSpellName(148467)] = 8.8, -- Deterrence
        [GladiusEx:SafeGetSpellName(67801)]	= 8.8, -- Deterrence
        [GladiusEx:SafeGetSpellName(110618)] = 8.8, -- Deterrence
        [GladiusEx:SafeGetSpellName(642)] = 8.8, -- Divine Shield
        [GladiusEx:SafeGetSpellName(110700)] = 8.8, -- Divine Shield
        [GladiusEx:SafeGetSpellName(110696)] = 8.8, -- Ice Block
        [GladiusEx:SafeGetSpellName(45438)]	= 8.8, -- Ice Block
        [GladiusEx:SafeGetSpellName(58984)]	= 8.8, -- Shadowmeld
        [GladiusEx:SafeGetSpellName(11327)]	= 8.8, -- Vanish
        [GladiusEx:SafeGetSpellName(27827)]	= 8.8, -- Spirit of Redemption
        [GladiusEx:SafeGetSpellName(1022)] = 8.7, -- Hand of Protection (Magic CCs still go through)

        -- Offensive Procs that I need to Outplay/Anticipate like a Deep Freeze
        [GladiusEx:SafeGetSpellName(44544)]	= 8.5, -- Fingers of Frost
        -- Roots
        [GladiusEx:SafeGetSpellName(96294)]	= 8, -- Chains of Ice (Chilblains)
        [GladiusEx:SafeGetSpellName(25999)]	= 8, -- Charge
        [GladiusEx:SafeGetSpellName(116706)] = 8, -- Disable (Root)
        [GladiusEx:SafeGetSpellName(64695)]	= 8, -- Earthgrab (Earthgrab Totem)
        [GladiusEx:SafeGetSpellName(113770)] = 8, -- Entangling Roots (Force of Nature - Balance Treants)
        [GladiusEx:SafeGetSpellName(19975)]	= 8, -- Entangling Roots (Nature's Grasp)
        [GladiusEx:SafeGetSpellName(113275)] = 8, -- Entangling Roots (Symbiosis) [Monk]
        [GladiusEx:SafeGetSpellName(115197)] = 8, -- Partial Paralysis
        [GladiusEx:SafeGetSpellName(50245)]	= 8, -- Pin (Crab)
        [GladiusEx:SafeGetSpellName(64803)]	= 8, -- Entrapment
        [GladiusEx:SafeGetSpellName(63685)]	= 8, -- Freeze (Frozen Power)
        [GladiusEx:SafeGetSpellName(39965)]	= 8, -- Frost Grenade
        [GladiusEx:SafeGetSpellName(115757)] = 8, -- Frost Nova (Glyph of Ice Block)
        [GladiusEx:SafeGetSpellName(110693)] = 8, -- Frost Nova (Mage) [Symbiosis]
        [GladiusEx:SafeGetSpellName(87194)]	= 8, -- Glyph of Mind Blast
        [GladiusEx:SafeGetSpellName(111340)] = 8, -- Ice Ward
        [GladiusEx:SafeGetSpellName(102359)] = 8, -- Mass Entanglement
        [GladiusEx:SafeGetSpellName(136634)] = 8, -- Narrow Escape
        [GladiusEx:SafeGetSpellName(115000)] = 8, -- Remorseless Winter
        [GladiusEx:SafeGetSpellName(91807)]	= 8, -- Shambling Rush (Dark Transformation)
        [GladiusEx:SafeGetSpellName(123407)] = 8, -- Spinning Fire Blossom
        [GladiusEx:SafeGetSpellName(107566)] = 8, -- Staggering Shout
        [GladiusEx:SafeGetSpellName(54706)]	= 8, -- Venom Web Spray (Silithid)
        [GladiusEx:SafeGetSpellName(114404)] = 8, -- Void Tendril's Grasp
        [GladiusEx:SafeGetSpellName(105771)] = 8, -- Warbringer
        [GladiusEx:SafeGetSpellName(4167)] = 8, -- Web (Spider)
        [GladiusEx:SafeGetSpellName(96201)] = 8, -- Web Wrap (Shale Spider)
		[GladiusEx:SafeGetSpellName(339)] = 8, -- Entangling Roots
		[GladiusEx:SafeGetSpellName(122)] = 8, -- Frost Nova
		[GladiusEx:SafeGetSpellName(33395)]	= 8, -- Freeze (Water Elemental)
		[GladiusEx:SafeGetSpellName(45334)]	= 8, -- Immobilized
		[GladiusEx:SafeGetSpellName(90327)]	= 8, -- Lock Jaw

        -- Disarms
        [GladiusEx:SafeGetSpellName(676)] = 7, -- Disarm
        [GladiusEx:SafeGetSpellName(126458)] = 7, -- Grapple Weapon (Symbiosis)
        [GladiusEx:SafeGetSpellName(117368)] = 7, -- Grapple Weapon
        [GladiusEx:SafeGetSpellName(50541)]	= 7, -- Clench (Scorpid)
        [GladiusEx:SafeGetSpellName(118093)] = 7, -- Disarm (Voidwalker/Voidlord)
        [GladiusEx:SafeGetSpellName(51722)]	= 7, -- Dismantle
        [GladiusEx:SafeGetSpellName(64058)]	= 7, -- Psychic Horror (Disarm Effect)
        [GladiusEx:SafeGetSpellName(137461)] = 7, -- Ring of Peace (Disarm effect)
        [GladiusEx:SafeGetSpellName(91644)]	= 7, -- Snatch (Bird of Prey)

        -- cc immunities
        [GladiusEx:SafeGetSpellName(46924)] = 8, -- Bladestorm
        [GladiusEx:SafeGetSpellName(115018)] = 7, -- Desecrated Ground
        [GladiusEx:SafeGetSpellName(137562)] = 8.9, -- Nimble Brew
        [GladiusEx:SafeGetSpellName(49039)] = 9.5, -- Lichborne
        [GladiusEx:SafeGetSpellName(18499)] = 9.5, -- Berserker Rage
        
        -- immune to magic cc
        [GladiusEx:SafeGetSpellName(48707)] = 8.1, -- Anti-Magic Shell (Death Knight)
        [GladiusEx:SafeGetSpellName(110570)] = 8.1, -- Anti-Magic Shell (Druid) (symbiosis)
        [GladiusEx:SafeGetSpellName(31224)] = 8.1, -- Cloak of Shadows (Rogue)
        [GladiusEx:SafeGetSpellName(110788)] = 8.1, -- Cloak of Shadows (Druid) (symbiosis)
        [GladiusEx:SafeGetSpellName(8178)] = 8.1, -- Grounding Totem Effect
        [GladiusEx:SafeGetSpellName(114028)] = 8.1, -- Mass Spell Reflection
        [GladiusEx:SafeGetSpellName(89523)] = 8.1, -- Grounding Totem (reflect)
        [GladiusEx:SafeGetSpellName(33961)] = 8.1, -- Spell Reflection
        [GladiusEx:SafeGetSpellName(23920)] = 8.1, -- Spell Reflection (Warrior)
        [GladiusEx:SafeGetSpellName(113002)] = 8.1, -- Spell Reflection (Druid) (symbiosis)
        
        [GladiusEx:SafeGetSpellName(13750)] = 6, -- Adrenaline Rush (Combat Rogue)
        [GladiusEx:SafeGetSpellName(51713)] = 6, -- Shadow Dance (Subtlety Rogue)
        [GladiusEx:SafeGetSpellName(102560)] = 6, -- Incarnation: Chosen of Elune (Balance Druid)
        [GladiusEx:SafeGetSpellName(16166)] = 6, -- Elemental Mastery (Elemental Shaman)

        -- Defensive Cooldowns
        [GladiusEx:SafeGetSpellName(110909)] = 5, -- Alter Time
        [GladiusEx:SafeGetSpellName(114214)] = 5, -- Angelic Bulwark
        [GladiusEx:SafeGetSpellName(50461)]  = 5, -- Anti-Magic Zone
        [GladiusEx:SafeGetSpellName(31850)]  = 5, -- Ardent Defender
        [GladiusEx:SafeGetSpellName(22812)]  = 5, -- Barkskin
        [GladiusEx:SafeGetSpellName(6940)]   = 5, -- Blessing of Sacrifice
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
        [GladiusEx:SafeGetSpellName(122783)] = 5, -- Diffuse Magic
        [GladiusEx:SafeGetSpellName(5277)]   = 5, -- Evasion
        [GladiusEx:SafeGetSpellName(110791)] = 5, -- Evasion (Druid) (Symbiosis)
        [GladiusEx:SafeGetSpellName(5384)]   = 5, -- Feign Death
        [GladiusEx:SafeGetSpellName(126456)] = 5, -- Fortifying Brew
        [GladiusEx:SafeGetSpellName(22842)]  = 5, -- Frenzied Regeneration
        [GladiusEx:SafeGetSpellName(86659)]  = 5, -- Guardian of Ancient Kings
        [GladiusEx:SafeGetSpellName(47788)]  = 5, -- Guardian Spirit
        [GladiusEx:SafeGetSpellName(48792)]  = 5, -- Icebound Fortitude
        [GladiusEx:SafeGetSpellName(110575)] = 5, -- Icebound Fortitude (Druid) (Symbiosis)
        [GladiusEx:SafeGetSpellName(12975)]  = 5, -- Last Stand
        [GladiusEx:SafeGetSpellName(116849)] = 5, -- Life Cocoon
        [GladiusEx:SafeGetSpellName(33206)]  = 5, -- Pain Suppression
        [GladiusEx:SafeGetSpellName(81782)]  = 5, -- Power Word: Barrier
        [GladiusEx:SafeGetSpellName(53480)]  = 5, -- Roar of Sacrifice (Hunter Pet Skill)
        [GladiusEx:SafeGetSpellName(30823)]  = 5, -- Shamanistic Rage
        [GladiusEx:SafeGetSpellName(871)]    = 5, -- Shield Wall
        [GladiusEx:SafeGetSpellName(98007)]  = 5, -- Spirit Link Totem
        [GladiusEx:SafeGetSpellName(61336)]  = 5, -- Survival Instincts
        [GladiusEx:SafeGetSpellName(115610)] = 5, -- Temporal Shield
        [GladiusEx:SafeGetSpellName(122470)] = 5, -- Touch of Karma
        [GladiusEx:SafeGetSpellName(104773)] = 5, -- Unending Resolve
        [GladiusEx:SafeGetSpellName(122291)] = 5, -- Unending Resolve (Druid) (Symbiosis)
        [GladiusEx:SafeGetSpellName(114030)] = 5, -- Vigilance
        [GladiusEx:SafeGetSpellName(131523)] = 5, -- Zen Meditation
        [GladiusEx:SafeGetSpellName(108271)] = 5, -- Astral Shift
        
        -- Higher Constraint Debuffs
        [GladiusEx:SafeGetSpellName(41425)] = 4.5, -- Hypothermia
        [GladiusEx:SafeGetSpellName(25771)] = 4.5, -- Forbearance

        -- Minor Defensive Cooldowns
        [GladiusEx:SafeGetSpellName(55694)] = 4, -- Enraged Regeneration
        [GladiusEx:SafeGetSpellName(111397)] = 4, -- Blood Horror
        [GladiusEx:SafeGetSpellName(16689)] = 4, -- Nature's Grasp
        [GladiusEx:SafeGetSpellName(102342)] = 4, -- Ironbark
        [GladiusEx:SafeGetSpellName(111264)] = 4, -- Ice Ward
        [GladiusEx:SafeGetSpellName(15286)] = 4, -- Vampiric Embrace

		-- 3 Movement Freedom
		[GladiusEx:SafeGetSpellName(124488)] = 3, -- Zen Focus
        [GladiusEx:SafeGetSpellName(96267)] = 3, -- Inner Focus
        [GladiusEx:SafeGetSpellName(79206)] = 3, -- spiritwalker's grace
        [GladiusEx:SafeGetSpellName(114239)] = 3, -- Phantasm
        [GladiusEx:SafeGetSpellName(1044)] = 3, -- Hand of Freedom
        [GladiusEx:SafeGetSpellName(54216)] = 3, -- Master's Call (Magic, Dispellable)
        [GladiusEx:SafeGetSpellName(62305)] = 3, -- Master's Call -- no check id because there are multiple ids which this might not be the correct one
        [GladiusEx:SafeGetSpellName(116841)] = 3, -- Tiger's Lust
        [GladiusEx:SafeGetSpellName(118922)] = 3, -- Posthaste
        [GladiusEx:SafeGetSpellName(108843)] = 3, -- Blazing Speed
        [GladiusEx:SafeGetSpellName(73325)] = 3, -- Leap of Faith
        [GladiusEx:SafeGetSpellName(121557)] = 3, -- Angelic Feather
        [GladiusEx:SafeGetSpellName(36554)] = 3, -- Shadowstep
        [GladiusEx:SafeGetSpellName(77761)] = 3, -- Stampeding Roar
        [GladiusEx:SafeGetSpellName(96268)] = 3, -- Death's Advance
        [GladiusEx:SafeGetSpellName(137573)] = 3, -- Burst of Speed
        [GladiusEx:SafeGetSpellName(108212)] = 3, -- Burst of Speed
        [GladiusEx:SafeGetSpellName(114896)] = 3, -- Windwalk
        [GladiusEx:SafeGetSpellName(58875)] = 3, -- Spirit Walk
        [GladiusEx:SafeGetSpellName(111400)] = 3, -- Burning Rush
        [GladiusEx:SafeGetSpellName(79438)] = 3, -- Soulburn: Demonic Circle

        -- Abilities for Mana Restoring (Healer Based)
        [GladiusEx:SafeGetSpellName(29166)] = 2.7, -- Innervate
        [GladiusEx:SafeGetSpellName(16191)] = 2.7, -- Mana Tide Totem
        [GladiusEx:SafeGetSpellName(54428)] = 2.7, -- Divine Plea
	    [GladiusEx:SafeGetSpellName(12051)] = 2.7, -- Evocation
		
		-- 2.5 Speed Boosts
        [GladiusEx:SafeGetSpellName(2983)] = 2.5, -- Sprint
        [GladiusEx:SafeGetSpellName(1850)] = 2.5, -- Dash
        [GladiusEx:SafeGetSpellName(54861)] = 2.5, -- Nitro Boosts
        [GladiusEx:SafeGetSpellName(65081)] = 2.5, -- Body and Soul
        [GladiusEx:SafeGetSpellName(133278)] = 2.5,  -- warrior heroic leap PVP set bonus speed buff
        [GladiusEx:SafeGetSpellName(85499)] = 2.5, -- Speed of Light

        -- Constraint Debuffs
        [GladiusEx:SafeGetSpellName(87023)] = 2, -- Cauterize
        [GladiusEx:SafeGetSpellName(770)] = 2, -- Faerie Fire, No Check Spell ID, just the debuff name
        [GladiusEx:SafeGetSpellName(31615)] = 2, -- Hunter's Mark, No Check Spell ID, just the debuff name
        [GladiusEx:SafeGetSpellName(1543)] = 2, -- Flare -- don't check id, not sure exact debuff id
        [GladiusEx:SafeGetSpellName(34709)] = 2, -- Shadow Sight -- Stealth Detection. -- Invisibility Detection. -- Increases damage taken by 5%.

        -- Stance/Forms
        [GladiusEx:SafeGetSpellName(119030)] = 1.2, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(112833)] = 1.2, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(119032)] = 1.2, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(119012)] = 1.2, -- Spectral Guise
        [GladiusEx:SafeGetSpellName(6346)] = 1, -- Fear Ward
        [GladiusEx:SafeGetSpellName(5487)] = 1, -- Bear Form
        [GladiusEx:SafeGetSpellName(768)] = 1, -- Cat Form
        [GladiusEx:SafeGetSpellName(783)] = 1, -- Travel Form
        [GladiusEx:SafeGetSpellName(24858)] = 1, -- Moonkin Form
        [GladiusEx:SafeGetSpellName(33891)] = 1, -- Incarnation: Tree of Life
        [GladiusEx:SafeGetSpellName(115191)] = 1, -- Stealth
        [GladiusEx:SafeGetSpellName(1784)] = 1, -- Stealth with speed (probably a glyph)
        [GladiusEx:SafeGetSpellName(115834)] = 1, -- Shroud of Concealment
        [GladiusEx:SafeGetSpellName(80325)] = 1, -- Camouflage
        [GladiusEx:SafeGetSpellName(51755)] = 1, -- Camouflage
        [GladiusEx:SafeGetSpellName(90954)] = 1, -- Camouflage
        [GladiusEx:SafeGetSpellName(119450)] = 1, -- Camouflage
        [GladiusEx:SafeGetSpellName(66)] = 1, -- Invisibility (initial)
        [GladiusEx:SafeGetSpellName(32612)] = 1, -- Invisibility (main)
        [GladiusEx:SafeGetSpellName(2645)] = 1, -- Ghost Wolf
        [GladiusEx:SafeGetSpellName(48266)] = 1, -- Frost Presence (DK)
        [GladiusEx:SafeGetSpellName(48265)] = 1, -- Unholy Presence (DK)
        [GladiusEx:SafeGetSpellName(48263)] = 1, -- Blood Presence (DK)
        [GladiusEx:SafeGetSpellName(5215)] = 1, -- Prowl
  }
end

function GladiusEx.Data.DefaultCooldowns()
    return {
		{
			-- OmniCD MoP arena class/spec/talent defaults.
			-- DEATHKNIGHT
			[47528] = true, -- interrupt
			[108194] = true, -- cc
			[108200] = true, -- cc
			[108199] = true, -- aoeCC
			[49576] = true, -- disarm
			[47476] = true, -- disarm
			[48707] = true, -- defensive
			[49028] = true, -- defensive
			[48792] = true, -- defensive
			[114556] = true, -- defensive
			[51052] = true, -- raidDefensive
			[48743] = true, -- heal
			[47568] = true, -- offensive
			[51271] = true, -- offensive
			[49206] = true, -- offensive
			[49016] = true, -- offensive
			[108201] = true, -- counterCC
			[49039] = true, -- counterCC
			[96268] = true, -- movement: Death's Advance
			[113072] = true, -- Symbiosis: Might of Ursoc (Blood)
			[113516] = true, -- Symbiosis: Wild Mushroom: Plague (Frost/Unholy)
			-- DRUID
			[80964] = true, -- interrupt
			[78675] = true, -- interrupt
			[88423] = true, -- dispel
			[2782] = true, -- dispel
			[99] = true, -- aoeCC
			[5211] = true, -- cc
			[132469] = true, -- aoeCC
			[22812] = true, -- defensive
			[106922] = true, -- defensive
			[108238] = true, -- defensive
			[33891] = true, -- defensive: Incarnation: Tree of Life (Restoration)
			[61336] = true, -- defensive
			[102342] = true, -- externalDefensive
			[124974] = true, -- raidDefensive
			[740] = true, -- raidDefensive
			[50334] = true, -- offensive
			[106951] = true, -- offensive
			[112071] = true, -- offensive
			[102560] = true, -- offensive: Incarnation: Chosen of Elune (Balance)
			[102543] = true, -- offensive: Incarnation: King of the Jungle (Feral)
			[102558] = true, -- offensive: Incarnation: Son of Ursoc (Guardian)
			[1850] = true, -- mobility: Dash
			[102280] = true, -- mobility: Displacer Beast
			[102417] = true, -- mobility: Wild Charge
			[106898] = true, -- mobility: Stampeding Roar
			[29166] = true, -- mana: Innervate
			[132158] = true, -- misc: Nature's Swiftness
			-- Symbiosis (Druid side; only the aura-detected spell is shown)
			[110570] = true, -- Anti-Magic Shell
			[122285] = true, -- Bone Shield
			[110575] = true, -- Icebound Fortitude
			[110588] = true, -- Misdirection
			[110597] = true, -- Play Dead
			[110600] = true, -- Ice Trap
			[110617] = true, -- Deterrence
			[110621] = true, -- Mirror Image
			[110693] = true, -- Frost Nova
			[110696] = true, -- Ice Block
			[126458] = true, -- Grapple Weapon
			[126449] = true, -- Clash
			[126453] = true, -- Elusive Brew
			[126456] = true, -- Fortifying Brew
			[110698] = true, -- Hammer of Justice
			[110700] = true, -- Divine Shield
			[110701] = true, -- Consecration
			[122288] = true, -- Cleanse
			[110707] = true, -- Mass Dispel
			[110715] = true, -- Dispersion
			[110717] = true, -- Fear Ward
			[110718] = true, -- Leap of Faith
			[110788] = true, -- Cloak of Shadows
			[110730] = true, -- Redirect
			[110791] = true, -- Evasion
			[110807] = true, -- Feral Spirit
			[110806] = true, -- Spiritwalker's Grace
			[122291] = true, -- Unending Resolve
			[110810] = true, -- Soul Swap
			[122290] = true, -- Life Tap
			[112970] = true, -- Demonic Circle: Teleport
			[122292] = true, -- Intervene
			[112997] = true, -- Shattering Blow
			[113002] = true, -- Spell Reflection
			[113004] = true, -- Intimidating Roar
			-- HUNTER
			[147362] = true, -- interrupt
			[34490] = true, -- interrupt
			[1499] = true, -- cc
			[19577] = true, -- cc
			[19503] = true, -- cc
			[19386] = true, -- cc
			[109248] = true, -- aoeCC
			[19263] = true, -- immunity
			[51753] = true, -- defensive
			[53480] = true, -- externalDefensive
			[109304] = true, -- heal
			[131894] = true, -- offensive
			[19574] = true, -- offensive
			[3045] = true, -- offensive
			[121818] = true, -- offensive
			[53271] = true, -- mobility: Master's Call
			[781] = true, -- mobility: Disengage
			[113073] = true, -- Symbiosis: Dash
			-- MAGE
			[2139] = true, -- interrupt
			[475] = true, -- dispel
			[44572] = true, -- cc
			[31661] = true, -- aoeCC
			[113724] = true, -- aoeCC
			[45438] = true, -- defensive: Ice Block
			[108978] = true, -- defensive
			[86949] = true, -- defensive
			[11958] = true, -- defensive
			[110959] = true, -- defensive
			[115610] = true, -- defensive
			[12042] = true, -- offensive
			[11129] = true, -- offensive
			[12472] = true, -- offensive
			[55342] = true, -- offensive
			[108843] = true, -- mobility: Blazing Speed
			[1953] = true, -- mobility: Blink
			[12043] = true, -- misc: Presence of Mind
			[12051] = true, -- mana: Evocation
			[113074] = true, -- Symbiosis: Healing Touch
			-- MONK
			[137562] = true, -- pvptrinket
			[116705] = true, -- interrupt
			[115450] = true, -- dispel
			[115078] = true, -- cc
			[119381] = true, -- aoeCC
			[116844] = true, -- aoeCC
			[117368] = true, -- disarm
			[122278] = true, -- defensive
			[122783] = true, -- defensive
			[115203] = true, -- defensive
			[122465] = true, -- immunity: Dematerialize (Mistweaver)
			[122470] = true, -- defensive
			[115176] = true, -- defensive
			[115213] = true, -- externalDefensive
			[116849] = true, -- externalDefensive
			[115310] = true, -- raidDefensive
			[113656] = true, -- offensive: Fists of Fury (Windwalker)
			[115288] = true, -- offensive: Energizing Brew (Windwalker)
			[132578] = true, -- offensive: Invoke Xuen, the White Tiger
			[116841] = true, -- mobility: Tiger's Lust
			[115008] = true, -- mobility: Chi Torpedo
			[101545] = true, -- mobility: Flying Serpent Kick (Windwalker)
			[109132] = true, -- mobility: Roll
			[122057] = true, -- mobility/cc: Clash (Brewmaster)
			[119996] = true, -- mobility: Transcendence: Transfer
			[113306] = true, -- Symbiosis: Survival Instincts (Brewmaster)
			[127361] = true, -- Symbiosis: Bear Hug (Windwalker)
			-- PALADIN
			[96231] = true, -- interrupt
			[4987] = true, -- dispel
			[105593] = true, -- cc
			[853] = true, -- cc
			[20066] = true, -- cc
			[115750] = true, -- aoeCC
			[642] = true, -- immunity
			[31850] = true, -- defensive
			[498] = true, -- defensive
			[86659] = true, -- defensive
			[1022] = true, -- externalDefensive
			[114039] = true, -- externalDefensive
			[6940] = true, -- externalDefensive
			[31821] = true, -- raidDefensive
			[86669] = true, -- heal
			[31884] = true, -- offensive
			[31842] = true, -- offensive
			[114157] = true, -- offensive
			[86698] = true, -- offensive
			[1044] = true, -- mobility: Hand of Freedom
			[54428] = true, -- mana: Divine Plea (Holy)
			[85499] = true, -- mobility: Speed of Light
			[113075] = true, -- Symbiosis: Barkskin (Protection)
			-- PRIEST
			[15487] = true, -- interrupt
			[32375] = true, -- dispel
			[527] = true, -- dispel
			[88625] = true, -- cc
			[64044] = true, -- cc
			[108921] = true, -- cc
			[8122] = true, -- aoeCC
			[19236] = true, -- defensive
			[47585] = true, -- defensive
			[108968] = true, -- defensive
			[47788] = true, -- externalDefensive
			[33206] = true, -- externalDefensive
			[64843] = true, -- raidDefensive
			[126135] = true, -- raidDefensive
			[62618] = true, -- raidDefensive
			[15286] = true, -- raidDefensive
			[10060] = true, -- offensive
			[34433] = true, -- offensive/mana: Shadowfiend
			[123040] = true, -- offensive/mana: Mindbender
			[6346] = true, -- counterCC
			[89485] = true, -- counterCC
			[32379] = true, -- counterCC
			[129176] = true, -- counterCC
			[121536] = true, -- mobility: Angelic Feather
			[114239] = true, -- mobility: Phantasm
			[73325] = true, -- mobility: Leap of Faith
			[64901] = true, -- mana: Hymn of Hope
			[112833] = true, -- misc: Spectral Guise
			[113277] = true, -- Symbiosis: Tranquility (Shadow)
			-- ROGUE
			[1766] = true, -- interrupt
			[2094] = true, -- cc
			[408] = true, -- cc
			[76577] = true, -- cc
			[51722] = true, -- disarm
			[31230] = true, -- defensive
			[31224] = true, -- defensive
			[74001] = true, -- defensive
			[5277] = true, -- defensive
			[14185] = true, -- defensive
			[1856] = true, -- defensive
			[13750] = true, -- offensive
			[51690] = true, -- offensive
			[121471] = true, -- offensive
			[51713] = true, -- offensive
			[79140] = true, -- offensive
			[36554] = true, -- mobility: Shadowstep
			[2983] = true, -- mobility: Sprint
			[113613] = true, -- Symbiosis: Growl
			-- SHAMAN
			[57994] = true, -- interrupt
			[51886] = true, -- dispel
			[77130] = true, -- dispel
			[51514] = true, -- cc
			[108269] = true, -- aoeCC
			[51490] = true, -- aoeCC
			[108271] = true, -- defensive
			[108285] = true, -- defensive
			[2062] = true, -- defensive
			[30884] = true, -- defensive
			[30823] = true, -- defensive
			[108270] = true, -- defensive
			[108281] = true, -- raidDefensive
			[108280] = true, -- raidDefensive
			[98008] = true, -- raidDefensive
			[114049] = true, -- offensive
			[16166] = true, -- offensive
			[51533] = true, -- offensive
			[2894] = true, -- offensive
			[120668] = true, -- offensive
			[8177] = true, -- counterCC
			[8143] = true, -- counterCC
			[58875] = true, -- mobility: Spirit Walk
			[108273] = true, -- mobility: Windwalk Totem
			[79206] = true, -- mobility: Spiritwalker's Grace
			[16188] = true, -- misc: Ancestral Swiftness
			[16190] = true, -- mana: Mana Tide Totem
			[113286] = true, -- Symbiosis: Solar Beam (Elemental/Enhancement)
			[113289] = true, -- Symbiosis: Prowl (Restoration)
			-- WARLOCK
			[108482] = true, -- defensive/mobility: Unbound Will
			[108501] = true, -- interrupt
			[19647] = true, -- interrupt
			[19505] = true, -- dispel
			[89766] = true, -- Axe Toss (Felguard/Wrathguard)
			[6789] = true, -- cc
			[5484] = true, -- aoeCC
			[30283] = true, -- aoeCC
			[110913] = true, -- defensive
			[108416] = true, -- defensive
			[104773] = true, -- defensive
			[108359] = true, -- heal
			[113858] = true, -- offensive
			[113861] = true, -- offensive
			[113860] = true, -- offensive
			[104316] = true, -- offensive: Imp Swarm
			[48020] = true, -- mobility: Demonic Circle: Teleport
			[113942] = true, -- mobility: Demonic Gateway reuse debuff
			[113295] = true, -- Symbiosis: Rejuvenation
			-- WARRIOR
			[102060] = true, -- interrupt
			[6552] = true, -- interrupt
			[5246] = true, -- cc
			[46968] = true, -- cc
			[107570] = true, -- cc
			[118000] = true, -- aoeCC
			[676] = true, -- disarm
			[114203] = true, -- defensive
			[118038] = true, -- defensive
			[12975] = true, -- defensive
			[871] = true, -- defensive
			[114030] = true, -- externalDefensive
			[97462] = true, -- raidDefensive
			[55694] = true, -- heal
			[107574] = true, -- offensive/mobility: Avatar
			[86346] = true, -- offensive
			[1719] = true, -- offensive
			[114207] = true, -- offensive
			[18499] = true, -- counterCC
			[3411] = true, -- counterCC
			[114028] = true, -- counterCC
			[114029] = true, -- counterCC
			[23920] = true, -- counterCC
			[1250619] = true, -- mobility: Charge
			[6544] = true, -- mobility: Heroic Leap
			[64382] = true, -- misc: Shattering Throw
			[122294] = true, -- Symbiosis: Stampeding Shout (Arms/Fury)
			[122286] = true, -- Symbiosis: Savage Defense (Protection)
		},
		{
			-- Existing PvP trinket/racial group (unchanged).
			[42292] = true,
			[59752] = true
		}
	}
end

function GladiusEx.Data.InterruptModifiers()
    return {}
end

function GladiusEx.Data.Interrupts()
    return {
        [2139]  = { duration = 8 }, -- Counterspell (Mage)
        [1766]  = { duration = 5 }, -- Kick (Rogue)
        [6552]  = { duration = 4 }, -- Pummel (Warrior)
        [57994] = { duration = 2 }, -- Wind Shear (Shaman)
        [19647] = { duration = 5 }, -- Spell Lock (Warlock)
        [47528] = { duration = 5 }, -- Mind Freeze (Death Knight)
        [93985] = { duration = 4 }, -- Skull Bash (Druid)
        [96231] = { duration = 4 }, -- Rebuke (Paladin)
        [50318] = { duration = 4 }, -- Serenity Dust (Moth - Hunter Pet)
        [50479] = { duration = 2 }, -- Nether Shock (Nether Ray - Hunter Pet)
        [26090] = { duration = 2 }, -- Pummel (Pet)
        [26679] = { duration = 3 }, -- Deadly Throw
        [113288] = { duration = 4 }, -- Solar Beam (Symbiosis) Interrupt
        [97547] = { duration = 5 }, -- Solar Beam Interrupt
        [80964] = { duration = 4 }, -- Skull Bash (Bear)
        [80965] = { duration = 4 }, -- Skull Bash (Cat)
        [91802] = { duration = 2 }, -- Shambling Rush (pet dk kick)
        [115781] = { duration = 6 }, -- Optical Blast (Interrupt)
        [119911] = { duration = 6 }, -- Optical Blast (Interrupt)
        [147362] = { duration = 3 }, -- Counter Shot (Hunter)
        [102060] = { duration = 4 }, -- Disrupting Shout (Warrior)
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




