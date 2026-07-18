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
        [GladiusEx:SafeGetSpellName(7922)] = 10, -- Charge Stun
        [GladiusEx:SafeGetSpellName(118000)] = 10, -- Dragon Roar
        [GladiusEx:SafeGetSpellName(118895)] = 10, -- Dragon Roar
        [GladiusEx:SafeGetSpellName(77505)] = 10, -- Earthquake
        [GladiusEx:SafeGetSpellName(113953)] = 10, -- Paralysis
    
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
        [GladiusEx:SafeGetSpellName(31117)]	= 9, -- Unstable Affliction (Silence)
        [GladiusEx:SafeGetSpellName(43523)]	= 9, -- Unstable Affliction (Silence)
        [GladiusEx:SafeGetSpellName(15487)]	= 9, -- Silence
		[GladiusEx:SafeGetSpellName(34490)]	= 9, -- Silencing shot (3 second silence)
		[GladiusEx:SafeGetSpellName(1330)]	= 9, -- Garrote

        -- Instant Casts
        [GladiusEx:SafeGetSpellName(16188)]	= 9, -- Ancestral Swiftness (Shaman)
        [GladiusEx:SafeGetSpellName(132158)] = 9, -- Nature's Swiftness (Druid)
        [GladiusEx:SafeGetSpellName(29274)]	= 9, -- Nature's Swiftness (Druid)
        [GladiusEx:SafeGetSpellName(12043)]	= 9, -- Presence of Mind
        [GladiusEx:SafeGetSpellName(69369)]	= 9, -- Predator's Swiftness (Feral Druid)

        -- Immunity
        [GladiusEx:SafeGetSpellName(122465)] = 9, -- Dematerialize
        [GladiusEx:SafeGetSpellName(65871)]	= 9, -- Deterrence
        [GladiusEx:SafeGetSpellName(110617)] = 9, -- Deterrence
        [GladiusEx:SafeGetSpellName(19263)]	= 9, -- Deterrence
        [GladiusEx:SafeGetSpellName(148467)] = 9, -- Deterrence
        [GladiusEx:SafeGetSpellName(67801)]	= 9, -- Deterrence
        [GladiusEx:SafeGetSpellName(110618)] = 9, -- Deterrence
        [GladiusEx:SafeGetSpellName(642)] = 9, -- Divine Shield
        [GladiusEx:SafeGetSpellName(110700)] = 9, -- Divine Shield
        [GladiusEx:SafeGetSpellName(110696)] = 9, -- Ice Block
        [GladiusEx:SafeGetSpellName(45438)]	= 9, -- Ice Block
        [GladiusEx:SafeGetSpellName(58984)]	= 9, -- Shadowmeld
        [GladiusEx:SafeGetSpellName(11327)]	= 9, -- Vanish
        [GladiusEx:SafeGetSpellName(27827)]	= 9, -- Spirit of Redemption

        -- Offensive - Spell Caster Burst Damage CD + Proc (CD > Proc) (they can still use this while rooted if in range or disarmed)
        -- [GladiusEx:SafeGetSpellName(12472)]	= 8.5, -- Icy Veins
        [GladiusEx:SafeGetSpellName(44544)]	= 8.5, -- Fingers of Frost
        [GladiusEx:SafeGetSpellName(12042)]	= 8.5, -- Arcane Power
        [GladiusEx:SafeGetSpellName(114050)] = 8.5, -- Ascendance (Elemental Shaman)
        [GladiusEx:SafeGetSpellName(112071)] = 8.5, -- Celestial Alignment
        [GladiusEx:SafeGetSpellName(113858)] = 8.5, -- Dark Soul: Instability
        [GladiusEx:SafeGetSpellName(113861)] = 8.5, -- Dark Soul: Knowledge
        [GladiusEx:SafeGetSpellName(113860)] = 8.5, -- Dark Soul: Misery
        -- [GladiusEx:SafeGetSpellName(16166)] = 8.5, -- Elemental Mastery
        
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
        [GladiusEx:SafeGetSpellName(55536)]	= 8, -- Frostweave Net
        [GladiusEx:SafeGetSpellName(87194)]	= 8, -- Glyph of Mind Blast
        [GladiusEx:SafeGetSpellName(111340)] = 8, -- Ice Ward
        [GladiusEx:SafeGetSpellName(102359)] = 8, -- Mass Entanglement
        [GladiusEx:SafeGetSpellName(136634)] = 8, -- Narrow Escape
        [GladiusEx:SafeGetSpellName(31367)]	= 8, -- Netherweave Net (Item) (Does not wo
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

        -- Offensive - Melee Burst CD disarm not effective can be stopped with roots
        [GladiusEx:SafeGetSpellName(114051)] = 7.5, -- Ascendance (Enhancement Shaman)
        [GladiusEx:SafeGetSpellName(50334)]	= 7.5, -- Berserk
        [GladiusEx:SafeGetSpellName(115288)] = 7.5, -- Energizing Brew

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

        -- Offensive - Melee Burst CD (can be stopped with roots 8 and disarms 7)
        [GladiusEx:SafeGetSpellName(1719)] = 6,	-- Recklessness
        [GladiusEx:SafeGetSpellName(13750)] = 6, -- Adrenaline Rush
        [GladiusEx:SafeGetSpellName(13877)] = 6, -- Blade Flurry
        [GladiusEx:SafeGetSpellName(3045)] = 6, -- Rapid Fire
        [GladiusEx:SafeGetSpellName(51713)] = 6, -- Shadow Dance
        [GladiusEx:SafeGetSpellName(49016)] = 6, -- Unholy Frenzy
        [GladiusEx:SafeGetSpellName(51271)] = 6, -- Pillar of Frost
        [GladiusEx:SafeGetSpellName(31884)] = 6, -- Avenging Wrath

        -- bit of misc from here
        -- Drinks for Mana Restoring
        [GladiusEx:SafeGetSpellName(44166)]	= 5,	-- Refreshment
		[GladiusEx:SafeGetSpellName(27089)]	= 5,	-- Drink1
		[GladiusEx:SafeGetSpellName(46755)]	= 5,	-- Drink2
        -- Invisibility
        [GladiusEx:SafeGetSpellName(5215)]	= 5,	-- Prowl
		[GladiusEx:SafeGetSpellName(32612)]	= 5,	-- Invisibility (main)
		[GladiusEx:SafeGetSpellName(1784)]	= 5,	-- Stealth 
        -- Deselect Target
		[GladiusEx:SafeGetSpellName(5384)]	= 5,	-- Feign Death

        -- commenting out all below for now. Adding stuff as I go.
        -- most of them are covered by nameplates but aura on arena portait is extra emphasis
        -- to preemptively react by being alerted

		-- [GladiusEx:SafeGetSpellName(1022)]  	= 7,	-- Blessing of Protection
		-- [GladiusEx:SafeGetSpellName(33206)]   = 7, -- Pain Suppression
		-- [GladiusEx:SafeGetSpellName(5277)]  	= 7,	-- Evasion


		-- -- Defensives
		-- [GladiusEx:SafeGetSpellName(3411)]    = 6.5,   -- Intervene
		-- [GladiusEx:SafeGetSpellName(45182)]	 	= 6.5,	 -- Cheat Death
		
        -- [GladiusEx:SafeGetSpellName(23920)] = 10,	-- Spell Reflection
		-- [GladiusEx:SafeGetSpellName(31224)]	= 10,	-- Cloak of Shadows
	

		-- [GladiusEx:SafeGetSpellName(18499)]  	= 6,	-- Berserker Rage

		
		-- [GladiusEx:SafeGetSpellName(29166)]  	= 4,	-- Innervate
		-- [GladiusEx:SafeGetSpellName(31842)]  	= 4,	-- Divine Illumination
		-- [GladiusEx:SafeGetSpellName(1044)]		= 4,	-- Blessing of Freedom
		-- [GladiusEx:SafeGetSpellName(34709)]  	= 4,	-- Shadow Sight (eye in arena)

		
        -- [GladiusEx:SafeGetSpellName(6940)] 	= 2.5,	-- Blessing of Sacrifice
		-- [GladiusEx:SafeGetSpellName(871)]  	= 2.5,	-- Shield Wall
		-- [GladiusEx:SafeGetSpellName(22812)]  	= 2.5,	-- Barkskin
		-- [GladiusEx:SafeGetSpellName(16689)]   = 2.5,   -- Nature's Grasp
		-- [GladiusEx:SafeGetSpellName(22842)]  	= 2.5,	-- Frenzied Regen
		-- [GladiusEx:SafeGetSpellName(498)]  	  = 2.5,	-- Divine Protection
		-- [GladiusEx:SafeGetSpellName(12975)]  	= 2.5,	-- Last Stand
		-- [GladiusEx:SafeGetSpellName(38031)]  	= 2.5,	-- Shield Block
		-- [GladiusEx:SafeGetSpellName(66)]	   	= 2.5,	-- Invisibility (initial)
		-- [GladiusEx:SafeGetSpellName(20578)]  	= 2.5,	-- Cannibalize
		-- [GladiusEx:SafeGetSpellName(8178)]  	= 2.5,	-- Grounding Totem Effect
		-- [GladiusEx:SafeGetSpellName(8145)]    = 2.5,   -- Tremor Totem Passive
	
		-- [GladiusEx:SafeGetSpellName(30823)]   = 2.5,   -- Shamanistic Rage
		-- [GladiusEx:SafeGetSpellName(7812)]   = 2.5,     -- Sacrifice

		-- [GladiusEx:SafeGetSpellName(10060)]  	= 2,	-- Power Infusion
		
        -- [GladiusEx:SafeGetSpellName(76577)] = 5, -- Smoke Bomb
		-- [GladiusEx:SafeGetSpellName(2645)]		= 1,	-- Ghost Wolf
		-- [GladiusEx:SafeGetSpellName(16190)]  	= 1,	-- Mana Tide Totem
		-- [GladiusEx:SafeGetSpellName(1850)]  	= 1,	-- Dash
		-- [GladiusEx:SafeGetSpellName(5118)]  	= 1,	-- Aspect of the Cheetah
		-- [GladiusEx:SafeGetSpellName(2983)]  	= 1,	-- Sprint
		-- [GladiusEx:SafeGetSpellName(36554)]  	= 1,	-- Shadowstep
		-- [GladiusEx:SafeGetSpellName(41425)]  	= 1,	-- Hypothermia
		-- [GladiusEx:SafeGetSpellName(25771)]  	= 1,	-- Forbearance
		-- [GladiusEx:SafeGetSpellName(11426)]   = 1,  -- Ice Barrier
		-- [GladiusEx:SafeGetSpellName(1543)]    = 1,  -- Flare
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
            [17116] = true, -- Druid/Nature's Swiftness
            [29166] = true, -- Druid/Nature's Swiftness
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
        [19675] = { duration = 4 }, -- Feral Charge Effect (Druid)
        [2139]  = { duration = 7 }, -- Counterspell (Mage)
        [1766]  = { duration = 5 }, -- Kick (Rogue)
        [6552]  = { duration = 4 }, -- Pummel (Warrior)
        [72]    = { duration = 6 }, -- Shield Bash (Warrior)
        [57994] = { duration = 2 }, -- Wind Shear (Shaman)
        [19647] = { duration = 5 }, -- Spell Lock (Warlock)
        [47528] = { duration = 5 }, -- Mind Freeze (Death Knight)
        [93985] = { duration = 4 }, -- Skull Bash (Druid)
        [96231] = { duration = 4 }, -- Rebuke (Paladin)
        [50318] = { duration = 4 }, -- Serenity Dust (Moth - Hunter Pet)
        [50479] = { duration = 2 }, -- Nether Shock (Nether Ray - Hunter Pet)
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









