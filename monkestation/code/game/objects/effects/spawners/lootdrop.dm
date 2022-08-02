/// Mail loot spawner. Some sort of random and rare building tool. No alien tech here.
/obj/effect/spawner/lootdrop/space/fancytool/engineonly
	loot = list(
		/obj/item/wrench/caravan = 1,
		/obj/item/wirecutters/caravan = 1,
		/obj/item/screwdriver/caravan = 1,
		/obj/item/crowbar/red/caravan = 1
	)

/// Mail loot spawner. Drop pool of advanced medical tools typically from research. Not endgame content.
/obj/effect/spawner/lootdrop/space/fancytool/advmedicalonly
	loot = list(
		/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/cautery/augment = 1
	)

/// Mail loot spawner. Some sort of random and rare surgical tool. Alien tech found here.
/obj/effect/spawner/lootdrop/space/fancytool/raremedicalonly
	loot = list(
		/obj/item/scalpel/alien = 1,
		/obj/item/hemostat/alien = 1,
		/obj/item/retractor/alien = 1,
		/obj/item/circular_saw/alien = 1,
		/obj/item/surgicaldrill/alien = 1,
		/obj/item/cautery/alien = 1
	)

/// Random Engine Room Spawner. Allows for either a 75% chance for a tesla gen and a 25% chance for the singularity gen for RandomEngines modules
/obj/effect/spawner/lootdrop/Engines
	name = "singulo or tesla spawner"
	loot = list(
				/obj/machinery/the_singularitygen = 25,
				/obj/machinery/the_singularitygen/tesla = 75
				)
	lootcount = 1

/obj/effect/spawner/lootdrop/summonmagic/lesser//for mapping and because lootdrop code is fun
	name = "lesser summon magic loot spawner"
	loot = list(
				/obj/item/book/granter/spell/fireball,
				/obj/item/book/granter/spell/smoke,
				/obj/item/book/granter/spell/blind,
				/obj/item/book/granter/spell/mindswap,
				/obj/item/book/granter/spell/forcewall,
				/obj/item/book/granter/spell/knock,
				/obj/item/book/granter/spell/barnyard,
				/obj/item/book/granter/spell/charge,
				/obj/item/book/granter/spell/summonitem,
				/obj/item/gun/magic/wand,//what does this even do?
//people will complain				/obj/item/gun/magic/wand/death,
				/obj/item/gun/magic/wand/resurrection,//people will also complain but not as much
				/obj/item/gun/magic/wand/polymorph,
				/obj/item/gun/magic/wand/teleport,
				/obj/item/gun/magic/wand/door,
				/obj/item/gun/magic/wand/fireball,
				/obj/item/gun/magic/staff/healing,//I am not sure but I am keeping it for now
				/obj/item/gun/magic/staff/door,
				/obj/item/scrying,//very very strong but gives you no direct combat bonus so I am keeping ti for now
				/obj/item/voodoo,
				/obj/item/warpwhistle,
//bee made this suit good now, so no				/obj/item/clothing/suit/space/hardsuit/shielded/wizard,
				/obj/item/immortality_talisman,
				/obj/item/melee/ghost_sword,
				/obj/item/stand_arrow//IS THAT A JO-

				)

/obj/effect/spawner/lootdrop/summonguns/less//also mapping(both have some of the stronger stuff taken out) named less instead of lesser due to the lesser summon guns spell
	name = "summon guns loot spawner"
	loot = list(
				/obj/item/gun/energy/disabler,
				/obj/item/gun/energy/e_gun,
				/obj/item/gun/energy/e_gun/advtaser,
				/obj/item/gun/energy/laser,
				/obj/item/gun/ballistic/revolver,
				/obj/item/gun/ballistic/revolver/detective,
				/obj/item/gun/ballistic/automatic/pistol/deagle/camo,
//really high damage and AoE, nope				/obj/item/gun/ballistic/automatic/gyropistol,
//pulse rifle.				/obj/item/gun/energy/pulse,
				/obj/item/gun/ballistic/automatic/pistol/suppressed,
				/obj/item/gun/ballistic/shotgun/doublebarrel,
				/obj/item/gun/ballistic/shotgun,
				/obj/item/gun/ballistic/shotgun/automatic/combat,
//full auto weapon, dont want to risk it				/obj/item/gun/ballistic/automatic/ar,
				/obj/item/gun/ballistic/revolver/mateba,
				/obj/item/gun/ballistic/rifle/boltaction,
				/obj/item/pneumatic_cannon/speargun,
//full auto				/obj/item/gun/ballistic/automatic/mini_uzi,
				/obj/item/gun/energy/lasercannon,
				/obj/item/gun/energy/kinetic_accelerator/crossbow/large,
				/obj/item/gun/energy/e_gun/nuclear,
//no idea but not risking it				/obj/item/gun/ballistic/automatic/proto,
//nukie gun				/obj/item/gun/ballistic/automatic/c20r,
//nukie				/obj/item/gun/ballistic/automatic/l6_saw,
//nukie?				/obj/item/gun/ballistic/automatic/m90,
				/obj/item/gun/energy/alien,
				/obj/item/gun/energy/e_gun/dragnet,
//why can you even get this? its MAYBE useful for a warden and thats it				/obj/item/gun/energy/e_gun/turret,
//still a pulse weapon				/obj/item/gun/energy/pulse/carbine,
				/obj/item/gun/energy/decloner,//turns out this weapon is really bad
				/obj/item/gun/energy/mindflayer,
				/obj/item/gun/energy/kinetic_accelerator,
				/obj/item/gun/energy/plasmacutter/adv,
				/obj/item/gun/energy/wormhole_projector,
				/obj/item/gun/ballistic/automatic/wt550,
				/obj/item/gun/ballistic/shotgun/bulldog,//keeping due to the fact that ammo reloading will be a pain
				/obj/item/gun/ballistic/revolver/grenadelauncher,
				/obj/item/gun/ballistic/revolver/golden,
//no				/obj/item/gun/ballistic/automatic/sniper_rifle,
				/obj/item/gun/ballistic/rocketlauncher,//1 shot so I think its fine
				/obj/item/gun/medbeam,
				/obj/item/gun/energy/laser/scatter,
				/obj/item/gun/energy/gravity_gun
				)
