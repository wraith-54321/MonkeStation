//chem sprayer
/obj/item/reagent_containers/spray/chemsprayer/magical
	name = "magical chem sprayer"
	desc = "Simply hit the button on the side and this will instantly be filled with a new reagent!"
	icon_state = "chemsprayer_janitor"
	item_state = "chemsprayer_janitor"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	reagent_flags = NONE
	volume = 1000
	amount_per_transfer_from_this = 10

/obj/item/reagent_containers/spray/chemsprayer/magical/attack_self(mob/user)
	cycle_chems()
	to_chat(user, "<span class='notice'>You change the reagent to [english_list(reagents.reagent_list)].</span>")
	return

/obj/item/reagent_containers/spray/chemsprayer/magical/proc/cycle_chems()
	reagents.clear_reagents()
	list_reagents = list(get_unrestricted_random_reagent_id() = volume)
	reagents.add_reagent_list(list_reagents)
	return

//reactive talismen
/obj/item/clothing/suit/armor/wizard_reactive
	name = "reactive talismen"
	desc = "A reactive talismen for the reactive soul."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "memento_mori"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "stamina" = 10)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	hit_reaction_chance = 80
	var/reaction_cooldown = 0
	var/reaction_cooldown_duration = 10 SECONDS


/obj/item/clothing/suit/armor/wizard_reactive/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(prob(hit_reaction_chance))
		if(world.time < reaction_cooldown)
			owner.visible_message("<span class='danger'>The magical energies are still gathering!</span>")
			return FALSE
		switch(list( "rod",/*, mutate, tesla_blast, mutagenic, mmissile, emp, repluse, time_stop, smoke, forcewall,*/ "stdistortion"/*, traps, bees, apes, blink, knock, stportal*/))
			if("rod")
				var/area/A = get_area(owner)
				if(istype(A, /area/wizard_station))
					to_chat(owner, "<span class='warning'>You know better than to trash Wizard Federation property. Best wait until you leave to use [src].</span>")
					return
				var/mob/living/M = owner
				var/turf/start = get_turf(M)
				var/obj/effect/immovablerod/wizard/W = new(start, get_ranged_target_turf(start, M.dir, (15)))
				W.wizard = M
				W.start_turf = start
				M.forceMove(W)
				M.notransform = TRUE
				M.status_flags |= GODMODE
				/*var/obj/effect/proc_holder/spell/targeted/rod_form/rod_spell
				rod_spell.cast( , user = owner)
				return TRUE*/
			/*if("stdistortion")
				var/obj/effect/proc_holder/spell/spacetime_dist/dist_spell = new
				dist_spell.cast(user = owner)
				return TRUE*/
	return FALSE
