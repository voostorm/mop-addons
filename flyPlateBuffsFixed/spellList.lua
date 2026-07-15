local _, fPB = ...

local defaultLargeSpells = { --Important spells, add them with huge icons.

}

local defaultMediumSpells = { --semi-important spells, add them with mid size icons.

}

local defaultHiddenSpells = {
  
}

-- here comes my default spell lists

-- size 1.1
local snares50 = {
	-- 50 % slows
	147531, -- Bloodbath -- 50%
	110300, -- Burden of Guilt -- 50%
	12486, -- Chilled -- 50%
	50435, -- Chilblains -- 50%
	132747, -- Crippling Poison -- 50%
	26679, -- Deadly Throw -- 50%
	119696, -- Debilitation -- 50%
	116095, -- Disable -- 50%
	123727, -- Dizzying Haze -- 50%
	8034, -- Frostbrand Attack -- 50%
	116, -- Frostbolt -- 50%
	8056, -- Frost Shock -- 50%
	102355, -- Faerie Swarm -- 50%
	5116, -- Concussive Shot -- 50%
	20170, -- Seal of Justice -- 50%
	129923, -- Sluggish (Glyph of Hindering Strikes) -- 50%
	1715, -- Hamstring -- 50%
	58180, -- Infected Wounds -- 50%
	3600, -- Earthbind (Earthbind Totem) -- 50%
	116947, -- Earthbind (Earthgrab Totem) -- 50%
	15407, -- Mind Flay -- 50%
	137637, -- Warbringer -- 50%
	73682, -- Unleash Frost -- 50%
	12323, -- Piercing Howl -- 50%
	63529, -- Dazed - Avenger's Shield -- 50%
	61391, -- Typhoon -- 50%
	50259, -- Dazed (Wild Charge - Cat) -- 50%
	1604, -- Dazed -- 50%
	35101, -- Concussive Barrage -- 50%
	31589, -- Slow -- 50%
	50433, -- Ankle Crack (Crocolisk) -- 50%
	3409, -- Crippling Poison -- 50%
	54644, -- Frost Breath (Chimaera) -- 50%
	135299, -- Ice Trap -- 50%
	17962, -- Conflagrate -- 50%
}

-- size 1.2
local snares60 = {
	45524, -- Chains of Ice -- 60%
	120, -- Cone of Cold -- 60%
}

-- size 1.3
local snares70 = {
	123586, -- Flying Serpent Kick -- 70%
	113092, -- Frost Bomb -- 70%
	15571, -- Dazed -- 70%
	61394, -- Frozen Wake (Glyph of Freezing Trap) -- 70%
}

-- size 1.9
local roots = {
	31367, -- Netherweave Net (Does not work in arena)
	96294, -- Chains of Ice (Chilblains)
	91807, -- Shambling Rush (Dark Transformation)
	339, -- Entangling Roots
	113770, -- Entangling Roots (Force of Nature - Balance Treants)
	19975, -- Entangling Roots (Nature's Grasp)
	45334, -- Immobilized (Wild Charge - Bear)
	102359, -- Mass Entanglement
	110693, -- Frost Nova (Mage) [Symbiosis]
	19185, -- Entrapment
	64803, -- Entrapment
	136634, -- Narrow Escape
	90327, -- Lock Jaw (Dog)
	50245, -- Pin (Crab)
	54706, -- Venom Web Spray (Silithid)
	4167, -- Web (Spider)
	96201, -- Web Wrap (Shale Spider)
	122, -- Frost Nova
	111340, -- Ice Ward
	33395, -- Freeze (Water Elemental)
	116706, -- Disable (Root)
	113275, -- Entangling Roots (Symbiosis) [Monk]
	123407, -- Spinning Fire Blossom
	115197, -- Partial Paralysis
	64695, -- Earthgrab (Earthgrab Totem)
	63685, -- Freeze (Frozen Power)
	87194, -- Glyph of Mind Blast
	114404, -- Void Tendril's Grasp
	39965, -- Frost Grenade
	55536, -- Frostweave Net
	107566, -- Staggering Shout
	105771, -- Warbringer
	115000, -- Remorseless Winter
	25999, -- Charge
	115757, -- Frost Nova (Glyph of Ice Block)
}

-- size 1.8
local silences = {
	47476, -- Strangulate
	114238, -- Glyph of Fae Silence
	34490, -- Silencing Shot
	102051, -- Frostjaw
	55021, -- Counterspell
	137460, -- Ring of Peace (Silence effect)
	116709, -- Spear Hand Strike
	31935, -- Avenger's Shield
	15487, -- Silence
	1330, -- Garrote
	24259, -- Spell Lock
	115782, -- Optical Blast (Observer)
	18498, -- Silenced - Gag Order
	50613, -- Arcane Torrent (Racial, Runic Power)
	28730, -- Arcane Torrent (Racial, Mana)
	25046, -- Arcane Torrent (Racial, Energy)
	69179, -- Arcane Torrent (Racial, Rage)
	80483, -- Arcane Torrent (Racial, Focus)
	78675, -- Solar Beam
	81261, -- Solar Beam
	133901, -- Solar Beam
    129888, -- Solar Beam
    129889, -- Solar Beam
    133899, -- Solar Beam
    113286, -- Solar Beam (Symbiosis)
    113287, -- Solar Beam (Symbiosis)
	31117, -- Unstable Affliction (Silence)
	43523, -- Unstable Affliction (Silence)
}

-- size 1.8
local disarms = {
	50541, -- Clench (Scorpid)
	91644, -- Snatch (Bird of Prey)
	137461, -- Ring of Peace (Disarm effect)
	64058, -- Psychic Horror (Disarm Effect)
	51722, -- Dismantle
	118093, -- Disarm (Voidwalker/Voidlord)
	676, -- Disarm
	126458, -- Grapple Weapon (Symbiosis)
	117368, -- Grapple Weapon
}

-- size 2.0 -- dispellable and undispellable cc
local cc = {
	-- Incapacitate
	2637, -- Hibernate
	3355, -- Freezing Trap Effect
	19386, -- Wyvern Sting
	118, -- Polymorph
	28271, -- Polymorph: Turtle
	28272, -- Polymorph: Pig
	61025, -- Polymorph: Serpent
	61721, -- Polymorph: Rabbit
	61780, -- Polymorph: Turkey
	61305, -- Polymorph: Black Cat
	82691, -- Ring of Frost
	115078, -- Paralysis
	20066, -- Repentance
	9484, -- Shackle Undead
	1776, -- Gouge
	6770, -- Sap
	76780, -- Bind Elemental
	51514, -- Hex
	710, -- Banish
	107079, -- Quaking Palm (Racial)

	-- Disorient
	99, -- Disorienting Roar
	19503, -- Scatter Shot
	31661, -- Dragon's Breath
	123393, -- Glyph of Breath of Fire
	105421, -- Blinding Light
	88625, -- Holy Word: Chastise

	-- Stun (Controlled)
	108194, -- Asphyxiate
	91800, -- Gnaw (Ghoul)
	91797, -- Monstrous Blow (Dark Transformation Ghoul)
	115001, -- Remorseless Winter
	102795, -- Bear Hug
	5211, -- Mighty Bash
	9005, -- Pounce
	22570, -- Maim
	113801, -- Bash (Treants)
	117526, -- Binding Shot
	24394, -- Intimidation
	126246, -- Lullaby (Crane pet)
	126423, -- Petrifying Gaze (Basilisk pet)
	126355, -- Quill (Porcupine pet)
	90337, -- Bad Manner (Monkey)
	56626, -- Sting (Wasp)
	50519, -- Sonic Blast
	118271, -- Combustion
	44572, -- Deep Freeze
	119392, -- Charging Ox Wave
	122242, -- Clash
	120086, -- Fists of Fury
	119381, -- Leg Sweep
	115752, -- Blinding Light (Glyphed)
	853, -- Hammer of Justice
	110698, -- Hammer of Justice (Symbiosis)
	119072, -- Holy Wrath
	105593, -- Fist of Justice
	408, -- Kidney Shot
	1833, -- Cheap Shot
	118345, -- Pulverize (Primal Earth Elemental)
	118905, -- Static Charge (Capacitor Totem)
	89766, -- Axe Toss (Felguard)
	22703, -- Inferno Effect
	30283, -- Shadowfury
	132168, -- Shockwave
	107570, -- Storm Bolt
	132169, -- Storm Bolt 2
	20549, -- War Stomp (Racial)
	835, -- Tidal Charm (magic dispellable), (probably does not exist in the game and not usable in arena)

	-- Stun (Non-controlled)
	113953, -- Paralysis
	118895, -- Dragon Roar
	77505, -- Earthquake
	7922, -- Charge
	118000, -- Dragon Roar

	-- Fear
	113004, -- Intimidating Roar (Symbiosis)
	113056, -- Intimidating Roar (Symbiosis 2)
	1513, -- Scare Beast
	10326, -- Turn Evil
	145067, -- Turn Evil (Evil is a Point of View)
	8122, -- Psychic Scream
	113792, -- Psychic Terror (Psyfiend)
	2094, -- Blind
	5782, -- Fear
	118699, -- Fear 2
	5484, -- Howl of Terror
	115268, -- Mesmerize (Shivarra)
	6358, -- Seduction (Succubus)
	104045, -- Sleep (Metamorphosis)
	5246, -- Intimidating Shout
	20511, -- Intimidating Shout (secondary targets)

	-- Horror
	64044, -- Psychic Horror
	137143, -- Blood Horror
	6789, -- Death Coil

	-- Mind Control
	605, -- Dominate Mind

	-- Cyclone
	33786, -- Cyclone
	113506, -- Cyclone (Symbiosis)

	76577, -- Smoke Bomb -- no check because id might be wrong
}

-- show mine only on enemies because I need to make sure MY debuff is applied, regardless of other people's debuffs
local war_personal_nostack_debuffs = {
	115767, -- Deep Wounds 1.3
	86346, -- Colossus Smash 1.5
	1822, -- Rake 1.3
	8921, -- Moonfire 1.3
	146739, -- Corruption 1.3
	30108, -- Unstable Affliction Dot
	109466, -- Curse of Enfeeblement
}

-- default size is 1.3
-- if one of these debuff is applied, then don't need to re-apply the same debuff so show no matter who applied it
local war_personal_stackable_debuffs = {
	110310, -- Dampening 1.4
	8680, -- Wound Poison Healing Debuff 1.4
	115804, -- Mortal Wounds 1.4
	81326, -- Physical Invulnerability 1.3 -- 4% dmg increase to the target with this debuff
	64382, -- Shattering Throw 1.3 -- target with this debuff has 20% less armor
	114205, -- Demoralizing Banner 1.3 -- target with this debuff does 10% less damage
	115798, -- Weakened Blows 1.4 -- target with this debuff does 10% less physical damage
	113746, -- Sunder Armor 1.3 -- 4% less armor per stack
	73975, -- necrotic strike
}

-- size 1.8
local major_defensive_buffs = {
	16188,-- Ancestral Swiftness, can either be defensive or offensive but want size to be big so added here
	114214, -- Angelic bulwark
	110909, -- Alter Time 
	50461, -- Anti-Magic Zone
	31850, -- Ardent Defender
	22812, -- Barkskin 
	6940, -- Blessing of Sacrifice
	111397, -- Blood Horror
	45182, -- Cheating Death
	74001, -- Combat Readiness
	1742, -- Cower (Pet)
	110913, -- Dark Bargain 
	31821, -- Devotion Aura
	118038, -- Die by the Sword
	110715, -- Dispersion (Priest)
    47585, -- Dispersion
	31842, -- Divine Favor
	64843, -- Divine Hymn 
	498, -- Divine Protection 
	55694, -- Enraged Regeneration 
	5277, -- Evasion 
	110791, -- Evasion (Druid) (Symbiosis)
	5384, -- Feign Death
	126456, -- Fortifying Brew
	22842, -- Frenzied Regeneration 
	86659, -- Guardian of Ancient Kings
	47788, -- Guardian Spirit 
	1022, -- Hand of Protection
	48792, -- Icebound Fortitude 
	110575, -- Icebound Fortitude (Druid) (Symbiosis)
	1463, -- Incanter's Ward
	102342, -- Ironbark 
	12975, -- Last Stand
	116849, -- Life Cocoon
	132158, -- Nature's Swiftness
	29274, -- Nature's Swiftness, can either be defensive or offensive but want size to be big so added here
	33206, -- Pain Suppression 
	81782, -- Power Word: Barrier
	12043, -- Presence of Mind, No Check Spell ID, just the buff name, can either be defensive or offensive but want size to be big so added here
	116844, -- Ring of Peace
	53480, -- Roar of Sacrifice (Hunter Pet Skill)
	30823, -- Shamanistic Rage 
	871, -- Shield Wall 
	98007, -- Spirit Link Totem
	20711, -- Spirit of Redemption
	61336, -- Survival Instincts 
	115610, -- Temporal Shield 
	122470, -- Touch of Karma
	104773, -- Unending Resolve 
	122291, -- Unending Resolve (Druid) (Symbiosis)
	114030, -- Vigilance
	131523, -- Zen Meditation
}

-- size 1.7
-- only shown on nameplates & not on bigdebuffs addon 
local minor_defensive_buffs = {
	122278, -- Dampen Harm
	81256, -- Dancing Rune Weapon -- 20% Parry
	1966, -- Feint -- don't check spell id, too many
	47753, -- Divine Aegis
	20594, -- Stoneform
	102351, -- Cenarion Ward, rdruid healing hot
	108281, -- Ancestral Guidance
	116680, -- Thunder Focus Tea
	108359, -- Dark Regeneration
	31567, -- tbc deterrence? Does it still exist in MoP?
	108416, -- Sacrificial Pact
	119899, -- Cauterize Master
	147833, -- Intervene
	122506, -- Intervene w/ Blitz?
	122292, -- Intervene (Druid) (Symbiosis)
	3411, -- Intervene 
	53476, -- Intervene (Pet)
	46947, -- Safeguard
	122973, -- Safeguard
	97463, -- Rallying Cry
	2565, -- Shield Block
	23493, -- Restoration (BG Leaf Healing Buff)
	77613, -- Grace -- Increase all healing received from the priest by 30%
	126697, -- Tremendous Fortitude
	16491, -- Second Wind
	114893, -- Stone Bulwark
	114168, -- Dark Apotheosis
}

-- size 1.6
local major_offensive_buffs = {
	13750, -- Adrenaline Rush 
	12042, -- Arcane Power 
	114049, -- Ascendance 
	107574, -- Avatar
	31884, -- Avenging Wrath 
	23505, -- Battleground Damage buff 
	23451, -- Battleground Speed buff 
	50334, -- Berserk
	23505, -- Berserking (BG DMG BUFF)
	13877, -- Blade Flurry 
	20572, -- Blood Fury 
	2825, -- Bloodlust 
	126690, -- Call of Conquest 
	126683, -- Call of Dominance 
	126679, -- Call of Victory 
	126700, -- Surge of Victory
	112071, -- Celestial Alignment
	113858, -- Dark Soul: Instability
	113861, -- Dark Soul: Knowledge
	113860, -- Dark Soul: Misery
	120679, -- Dire Beast
	16166, -- Elemental Mastery
	115288, -- Energizing Brew
	82726, -- Fervor
	44544, -- Fingers of Frost
	32182, -- Heroism 
	105809, -- Holy Avenger
	131078, -- Icy Veins -- no check spell id
	51690, -- Killing Spree
	103958, -- Metamorphosis
	16689, -- Nature's Grasp Buff
	51271, -- Pillar of Frost 
	10060, -- Power Infusion 
	69369, -- Predator's Swiftness 
	3045, -- Rapid Fire 
	1719, -- Recklessness
	51713, -- Shadow Dance
	121818, -- Stampede
	34471, -- The Beast Within 
	5217, -- Tiger's Fury
	49016, -- Unholy Frenzy
	108288, -- Heart of the Wild
}

-- size 1.5
local  minor_offensive_buffs = {
	114206, -- Skull Banner -- 20% Crit Damage
	-- 93435, -- Roar of Courage
	-- 104423, -- Windsong
	-- 12880, -- Enrage
	-- 120032, -- Dancing Steel
	-- 125489, -- Swordguard Embroidery
	-- 104993, -- Jade Spirit
	-- 126734, -- Synapse Springs
	-- 115989, -- Unholy Blight
	-- 128432, -- Cackling Howl
	-- 108508, -- Mannoroth's Fury
	-- 57934, -- Tricks of the Trade
}

-- size 2.0 -- includes cc reductions too
local cc_immunities = {
	46924, -- Bladestorm
	115018, -- Desecrated Ground
	137562, -- Nimble Brew
	49039, -- Lichborne
	18499, -- Berserker Rage
	7744, -- Will of the Forsaken 
}

-- size 1.8
local spell_immunities = {
	48707, -- Anti-Magic Shell (Death Knight)
	110570, -- Anti-Magic Shell (Druid) (symbiosis)
	31224, -- Cloak of Shadows (Rogue)
	110788, -- Cloak of Shadows (Druid) (symbiosis)
	115760, -- Glyph of Ice Block
	8178, -- Grounding Totem Effect
	114028, -- Mass Spell Reflection
	89523, -- Grounding Totem (reflect)
	33961, -- Spell Reflection
	23920, -- Spell Reflection (Warrior)
	113002, -- Spell Reflection (Druid) (symbiosis)
	122783, -- Diffuse Magic
	6346, -- Fear Ward
	114039, -- Hand of Purity
}

-- size 1.5
local mobility_buffs = {
	124488, -- Zen Focus
	96267, -- Inner Focus
	79206, -- spiritwalker's grace
	114239, -- Phantasm
	1044, -- Hand of Freedom
	-- 53271, -- Master's Call
	62305, -- Master's Call -- no check id because there are multiple ids which this might not be the correct one
	116841, -- Tiger's Lust
	118922, -- Posthaste
	108843, -- Blazing Speed
	73325, -- Leap of Faith
	121557, -- Angelic Feather
	36554, -- Shadowstep
	77761, -- Stampeding Roar
	96268, -- Death's Advance
	137573, -- Burst of Speed
	108212, -- Burst of Speed
	114896, -- Windwalk
	58875, -- Spirit Walk
	111400, -- Burning Rush
	79438, -- Soulburn: Demonic Circle
}

-- size 1.5
local speed_buffs = {
	2983, -- Sprint
	1850, -- Dash
	54861, -- Nitro Boosts
	65081, -- Body and Soul
	133278,  -- warrior heroic leap PVP set bonus speed buff
	85499, -- Speed of Light
}

-- size 1.5
local mana_buffs = {
	54428, -- Divine Plea
	12051, -- Evocation
	16191, -- Mana Tide Totem
	29166, -- Innervate
}

-- size 2.0 -- added both since they are both same size
local drinkflags = {
	301091, -- Alliance Flag (Twin Peaks Flag)
	301089, -- Horde Flag (Twin Peaks Flag)
	23333, -- Warsong Flag (horde WSG flag)
	23335, -- Silverwing Flag (alliance WSG flag)
	22734, -- Drink
	46755, -- Drink
	27089, -- Drink
	43183, -- Drink
	57073, -- Drink
	34976, -- Nether Flag (Eye of the Storm flag)
	141210, -- Horde Mine (Silvershard Mines flag)
	140876, -- Alliance Mine (Silvershard Mines flag)
	46393, -- Brutal Assault
	46392, -- Focused Assault
}

-- size 1.4
local stances_forms = {
	5487, -- Bear Form
	768, -- Cat Form
	783, -- Travel Form
	24858, -- Moonkin Form
	33891, -- Incarnation: Tree of Life
	115191, -- Stealth
	115834, -- Shroud of Concealment
	80325, -- Camouflage
	51755, -- Camouflage
	90954, -- Camouflage
	119450, -- Camouflage
	119030, -- Spectral Guise -- No Check Spell ID, just the buff name 1.6
	66, -- Invisibility
	2645, -- Ghost Wolf
	48266, -- Frost Presence (DK)
	48265, -- Unholy Presence (DK)
	48263, -- Blood Presence (DK)
}

-- size 1.5
local constraint_debuffs = {
	41425, -- Hypothermia
	87023, -- Cauterize
	25771, -- Forbearance
	113942, -- Demonic Gateway Cooldown
	770, -- Faerie Fire, No Check Spell ID, just the debuff name
	31615, -- Hunter's Mark, No Check Spell ID, just the debuff name
	1543, -- Flare -- don't check id, not sure exact debuff id
	34709, -- Shadow Sight -- Stealth Detection. -- Invisibility Detection. -- Increases damage taken by 5%.
	44457, -- Living Bomb, the contraint is sheep will break on targets that have living bomb, therefore, added.
}



fPB.defaultLargeSpells = defaultLargeSpells
fPB.defaultMediumSpells = defaultMediumSpells
fPB.defaultHiddenSpells = defaultHiddenSpells

fPB.snares50 = snares50
fPB.snares60 = snares60			
fPB.snares70 = snares70

fPB.roots = roots
fPB.silences = silences
fPB.disarms = disarms

fPB.cc = cc

fPB.war_personal_nostack_debuffs = war_personal_nostack_debuffs
fPB.war_personal_stackable_debuffs = war_personal_stackable_debuffs

fPB.major_defensive_buffs = major_defensive_buffs
fPB.minor_defensive_buffs = minor_defensive_buffs

fPB.major_offensive_buffs = major_offensive_buffs
fPB.minor_offensive_buffs = minor_offensive_buffs

fPB.cc_immunities = cc_immunities
fPB.spell_immunities = spell_immunities

fPB.mobility_buffs = mobility_buffs
fPB.speed_buffs = speed_buffs

fPB.mana_buffs = mana_buffs
fPB.drinkflags = drinkflags
fPB.stances_forms = stances_forms
fPB.constraint_debuffs = constraint_debuffs

