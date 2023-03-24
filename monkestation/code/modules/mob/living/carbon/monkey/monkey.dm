#define MELEE_WEAPON "melee_weapon" //I think this is better then a string, but I dont know
#define GUN_WEAPON "gun_weapon"

/mob/living/carbon/monkey/angry/armed //a monkey with a weapon
	name = "armed ape"
	var/weapon_type //does the monkey get a melee or ranged weapon
	var/no_drop = FALSE //does the weapon get the NO_DROP trait added
	var/drop_del = TRUE //does the item qdel on being dropped

/mob/living/carbon/monkey/angry/armed/Initialize(mapload)
	. = ..()
	var/obj/item/given_weapon
	var/chosen_weapon
	if(prob(50) || weapon_type == GUN_WEAPON && !(weapon_type == MELEE_WEAPON))
		chosen_weapon = pick(GLOB.summoned_guns)
		given_weapon = new chosen_weapon(get_turf(src))
		if(istype(given_weapon, /obj/item/gun))
			var/obj/item/gun/gun = given_weapon
			gun.unlock()
		weapon_type = GUN_WEAPON
	else
		chosen_weapon = pick(list(/obj/item/katana,  //if summon events is active the round is not long for this world
							/obj/item/chainsaw,
							/obj/item/storage/toolbox/syndicate,
							/obj/item/pitchfork,
							/obj/item/statuebust,
							/obj/item/melee/chainofcommand,
							/obj/item/melee/chainofcommand/tailwhip/kitty,
							/obj/item/melee/skateboard,
							/obj/item/melee/baseball_bat,
							/obj/item/melee/baseball_bat/homerun,
							/obj/item/melee/baseball_bat/ablative,
							/obj/item/club,
							/obj/item/melee/synthetic_arm_blade,
							/obj/item/melee/sabre,
							/obj/item/melee/classic_baton,
							/obj/item/melee/knockback_stick,
							/obj/item/spear))
		given_weapon = new chosen_weapon(get_turf(src))
		weapon_type = MELEE_WEAPON
	if(given_weapon)
		if(!put_in_hands(given_weapon))
			qdel(given_weapon)

	if(no_drop)
		ADD_TRAIT(given_weapon, TRAIT_NODROP, MAGIC_TRAIT)

	if(drop_del)
		given_weapon.item_flags += DROPDEL //maybe bitwise

/mob/living/carbon/monkey/angry/armed/gun
	name = "long ranged armed ape"
	weapon_type = GUN_WEAPON

/mob/living/carbon/monkey/angry/armed/melee
	name = "short ranged armed ape"
	weapon_type = MELEE_WEAPON

/mob/living/carbon/monkey/angry/armed/boss
	name = "super armed ape"
	no_drop = TRUE
	drop_del = FALSE //these are hard to kill, if you kill one of these monkeys you should be rewarded

/mob/living/carbon/monkey/angry/armed/boss/Initialize(mapload)
	. = ..()
	maxHealth = 400 //very tanky
	health = 400
	for(var/obj/item/bodypart/bpart as() in bodyparts) //no point in making them have that health if you can just delimb them
		bpart.max_damage += 150

#undef MELEE_WEAPON
#undef GUN_WEAPON
