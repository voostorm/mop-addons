-- MAGE arena cooldowns.
-- Generated from OmniCD's MoP spellDefaults; items and racials are intentionally excluded.

-- Counterspell (interrupt)
LCT_SpellData[2139] = {
	class = "MAGE",
	interrupt = true,
	cooldown = 24,
	counterspell = true,
}

-- Remove Curse (dispel)
LCT_SpellData[475] = {
	class = "MAGE",
	dispel = true,
	cooldown_starts_on_dispel = true,
	cooldown = 8,
}

-- Deep Freeze (cc)
LCT_SpellData[44572] = {
	class = "MAGE",
	cc = true,
	cooldown = 30,
}

-- Dragon's Breath (aoeCC)
LCT_SpellData[31661] = {
	class = "MAGE",
	specID = { 63 },
	cc = true,
	cooldown = 20,
}

-- Ring of Frost (aoeCC)
LCT_SpellData[113724] = {
	class = "MAGE",
	talent = true,
	cc = true,
	duration = 10,
	cooldown = 45,
}

-- Ice Block (defensive)
LCT_SpellData[45438] = {
	class = "MAGE",
	defensive = true,
	duration = 10,
	cooldown = 300,
}

-- Alter Time (defensive). While aura 110909 is active, the original spell is
-- replaced by manual return spell 127140. Natural expiry and manual return keep
-- the initial cast as the cooldown origin; an early cancel/dispel starts a fresh
-- cooldown when the aura is removed. Aura 110909 does not appear in the CLEU,
-- so the library observes it through UNIT_AURA with a six-second fallback.
LCT_SpellData[108978] = {
	class = "MAGE",
	defensive = true,
	duration = 6,
	cooldown_starts_on_aura_resolution = true,
	aura_resolution_spellid = 110909,
	-- Arena mages have the PvP four-piece bonus, so GladiusEx must be correct
	-- from the first use instead of waiting to learn the shorter recast.
	cooldown = 90,
}
LCT_SpellAliases[127140] = { spellid = 108978, aura_resolution = true }

-- Cauterize (defensive)
LCT_SpellData[86949] = {
	class = "MAGE",
	talent = true,
	defensive = true,
	duration = 6,
	cooldown = 120,
}

-- Cold Snap (defensive)
LCT_SpellData[11958] = {
	class = "MAGE",
	talent = true,
	defensive = true,
	resets = { 45438 },
	cooldown = 180,
}

-- Greater Invisibility (defensive)
LCT_SpellData[110959] = {
	class = "MAGE",
	talent = true,
	defensive = true,
	duration = 20,
	cooldown = 90,
}

-- Temporal Shield (defensive)
LCT_SpellData[115610] = {
	class = "MAGE",
	talent = true,
	defensive = true,
	duration = 4,
	cooldown = 25,
}

-- Arcane Power (offensive)
LCT_SpellData[12042] = {
	class = "MAGE",
	specID = { 62 },
	offensive = true,
	duration = 15,
	cooldown = 90,
}

-- Combustion (offensive)
LCT_SpellData[11129] = {
	class = "MAGE",
	specID = { 63 },
	offensive = true,
	stun = true,
	cooldown = 45,
	cooldown_variants = { 36 },
}

-- Icy Veins (offensive)
LCT_SpellData[12472] = {
	class = "MAGE",
	specID = { 64 },
	offensive = true,
	duration = 20,
	cooldown = 180,
	cooldown_variants = { 90 },
}

-- Mirror Image (offensive)
LCT_SpellData[55342] = {
	class = "MAGE",
	offensive = true,
	duration = 40,
	cooldown = 180,
}

-- Presence of Mind (misc)
LCT_SpellData[12043] = {
	class = "MAGE",
	talent = true,
	none = true,
	misc = true,
	cooldown_starts_on_aura_fade = true,
	cooldown = 90,
}

-- Evocation (mana)
LCT_SpellData[12051] = {
	class = "MAGE",
	mana = true,
	duration = 6,
	cooldown = 120,
}

-- Summon Water Elemental (offensive)
LCT_SpellData[31687] = {
	class = "MAGE",
	specID = { 64 },
	offensive = true,
	cooldown = 60,
}

-- Blazing Speed (movement)
LCT_SpellData[108843] = {
	class = "MAGE",
	talent = true,
	mobility = true,
	duration = 1.5,
	cooldown = 25,
}

-- Blink (movement)
LCT_SpellData[1953] = {
	class = "MAGE",
	mobility = true,
	duration = 1,
	opt_charges = 2,
	cooldown = 15,
}

-- Alternate combat-log IDs.
LCT_SpellData[87024] = 86949
