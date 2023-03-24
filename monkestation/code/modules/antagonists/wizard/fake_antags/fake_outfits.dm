//put the equiped outfits in this file

/datum/outfit/hollow_sword/post_equip(mob/living/carbon/human/equipped, visualsOnly) //make it so they cant change their clothes
	. = ..()
	var/list/stick_outfit = list()
	var/clothing_slots = list(ITEM_SLOT_FEET, ITEM_SLOT_ICLOTHING, ITEM_SLOT_OCLOTHING, ITEM_SLOT_HEAD, ITEM_SLOT_EYES, ITEM_SLOT_BACK,
							  ITEM_SLOT_BACKPACK, ITEM_SLOT_BELT, ITEM_SLOT_EARS, ITEM_SLOT_GLOVES, ITEM_SLOT_ID, ITEM_SLOT_MASK, ITEM_SLOT_NECK)
	for(var/current_slot in clothing_slots)
		equipped_check(stick_outfit, current_slot, equipped)

	for(var/obj/item/trait_needed as anything in stick_outfit)
		ADD_TRAIT(trait_needed, TRAIT_NODROP, CURSED_ITEM_TRAIT(trait_needed.type))

/datum/outfit/hollow_sword/proc/equipped_check(var/list/add_list, var/spot_to_check, var/mob/living/carbon/human/checked_mob) //make sure they have an item there
	if(checked_mob.get_item_by_slot(spot_to_check))
		add_list += checked_mob.get_item_by_slot(spot_to_check)
	return

//FAKE NUKIE
/datum/outfit/hollow_sword/beer_nukie
	name = "Fake Lone Op"
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	suit_store = /obj/item/tank/internals/oxygen //they cant use a jet harness due to nodrop, this is so they can use their suits jetpack for a bit instead
	internals_slot = ITEM_SLOT_SUITSTORE
	l_pocket = /obj/item/modular_computer/tablet/nukeops
	id = /obj/item/card/id/syndicate
	belt = /obj/item/storage/belt/military
	r_hand = /obj/item/gun/ballistic/automatic/c20r/toy
	l_hand = /obj/item/storage/toolbox/syndicate
	back = /obj/item/storage/backpack/fireproof
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/combat
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	box = /obj/item/storage/box/syndie
	backpack_contents = list(/obj/item/ammo_box/foambox/riot=3, \
							 /obj/item/ammo_box/magazine/toy/smgm45/riot=3)

	implants = list(/obj/item/implant/explosive, \
					/obj/item/implant/weapons_auth, \
					/obj/item/implant/stealth)

//FAKE TRAITOR
/datum/outfit/hollow_sword/original_traitor
	name = "Fake Traitor"
	suit = /obj/item/clothing/suit/armor/laserproof
	uniform = /obj/item/clothing/under/color/grey
	shoes = /obj/item/clothing/shoes/magboots
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/sunglasses/advanced
	id = /obj/item/card/id/syndicate
	gloves = /obj/item/clothing/gloves/color/yellow
	r_hand = /obj/item/holo/esword/green
	box = /obj/item/storage/box/survival
	mask = /obj/item/clothing/mask/gas/old
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/gun/energy/kinetic_accelerator/crossbow/fake)
