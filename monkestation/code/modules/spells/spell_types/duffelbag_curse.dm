//TG PORT
/obj/effect/proc_holder/spell/targeted/touch/duffelbag
	name = "Bestow Cursed Duffel Bag"
	desc = "A spell that summons a duffel bag demon on the target, slowing them down and slowly eating them."
	action_icon = 'monkestation/icons/mob/actions/actions_spells.dmi'
	action_icon_state = "duffelbag_curse"

	school = "conjuration"
	charge_max = 15 SECONDS
	cooldown_min = 5 SECONDS
	clothes_req = FALSE

	hand_path = /obj/item/melee/touch_attack/duffelbag

/obj/item/melee/touch_attack/duffelbag
	name = "\improper burdening touch"
	desc = "Where is the bar from here?"
	icon = 'monkestation/icons/obj/items_and_weapons.dmi'
	icon_state = "duffelcurse"
	item_state = "duffelcurse"
	catchphrase = "HU'SWCH H'ANS!!"
	on_use_sound = 'sound/magic/mm_hit.ogg'

	/// Some meme "elaborate backstories" to use.
	var/static/list/elaborate_backstory = list(
		"spacewar origin story",
		"military background",
		"corporate connections",
		"life in the colonies",
		"anti-government activities",
		"upbringing on the space farm",
		"fond memories with your buddy Keith")

/obj/item/melee/touch_attack/duffelbag/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!iscarbon(target))
		return
	var/mob/living/carbon/target_mob = target
	if(target_mob.anti_magic_check())
		to_chat(user, span_warning("The spell can't seem to affect [target_mob]!"))
		to_chat(target_mob, span_warning("You really don't feel like talking about your [pick(elaborate_backstory)] with complete strangers today."))
		return ..()

	// To get it started, stun and knockdown the person being hit
	target_mob.flash_act()
	target_mob.Immobilize(5 SECONDS)
	target_mob.apply_damage(80, STAMINA)
	target_mob.Knockdown(5 SECONDS)

	// If someone's already cursed, don't try to give them another
	if(istype(target_mob.back, /obj/item/storage/backpack/duffelbag/cursed))
		to_chat(user, span_warning("The burden of [target_mob]'s duffel bag becomes too much, shoving them to the floor!"))
		to_chat(target_mob, span_warning("The weight of this bag becomes overburdening!"))
		return TRUE

	// However if they're uncursed, they're fresh for getting a cursed bag
	var/obj/item/storage/backpack/duffelbag/cursed/conjured_duffel = new get_turf(target_mob)
	target_mob.visible_message(
		span_danger("A growling duffel bag appears on [target_mob]!"),
		span_danger("You feel something attaching itself to you, and a strong desire to discuss your [pick(elaborate_backstory)] at length!"))

	conjured_duffel.pickup(target_mob)
	conjured_duffel.forceMove(target_mob)

	// Put it on their back first
	if(target_mob.dropItemToGround(target_mob.back))
		target_mob.equip_to_slot_if_possible(conjured_duffel, ITEM_SLOT_BACK, TRUE, TRUE)
		return TRUE

	// If the back equip failed, put it in their hands first
	if(target_mob.put_in_hands(conjured_duffel))
		return TRUE

	// If they had no empty hands, try to put it in their inactive hand first
	target_mob.dropItemToGround(target_mob.get_inactive_held_item())
	if(target_mob.put_in_hands(conjured_duffel))
		return TRUE

	// If their inactive hand couldn't be emptied or found, put it in their active hand
	target_mob.dropItemToGround(target_mob.get_active_held_item())
	if(target_mob.put_in_hands(conjured_duffel))
		return TRUE

	// Well, we failed to give them the duffel bag,
	// but technically we still stunned them so that's something
	return TRUE
