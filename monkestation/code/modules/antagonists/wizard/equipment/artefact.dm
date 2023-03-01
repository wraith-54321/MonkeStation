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

//reactive talisman
/obj/item/clothing/neck/neckless/wizard_reactive
	name = "reactive talisman"
	desc = "A reactive talisman for the reactive mage."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "memento_mori"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "stamina" = 10)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	hit_reaction_chance = 100 //100 for testing
	var/reaction_cooldown = 0
	var/reaction_cooldown_duration = 15 SECONDS
	var/has_targets = TRUE //does the spell the talisman is casting have a target list var
	var/bound = FALSE //is the talisman bound to a spell or not
	var/binding_spell = list() //if bound then to what binding spell
	var/binding_user = list() //mob that owns the binding spell

/obj/item/clothing/neck/neckless/wizard_reactive/Destroy()
	. = ..()
	for(var/obj/effect/proc_holder/spell/targeted/re_talisman_bind/unbound in binding_spell)
		unbound.bound_talisman = null
	return ..()

/obj/item/clothing/neck/neckless/wizard_reactive/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(bound && prob(hit_reaction_chance))
		if(world.time < reaction_cooldown) // ADD WORKING COOLDOIWN
			to_chat(owner, "<span class='danger'>The magical energies are still gathering!</span>")
			return FALSE
		for(var/mob/living/carbon/human/user in binding_user)
			for(var/obj/effect/proc_holder/spell/targeted/re_talisman_bind/bind_spell in user.mind.spell_list)
				switch(pick(list( "rod", "mutate", "mutagenic", "mmissile", "emp", "repulse", "time_stop", "smoke", "forcewall", "spacetdist", "traps", "bees", "apes", "blink", "stportal", "jaunt")))
					if("rod")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/rod_form)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("mutate")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/mutagenic_pulse)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("mutagenic")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/mutagenic_pulse)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("mmissile")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/projectile/magic_missile)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("emp")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/emplosion/disable_tech)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("repulse")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/repulse)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("time_stop")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/conjure/timestop)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("smoke")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/smoke)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("forcewall")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/forcewall)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("spacetdist")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/spacetime_dist)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("traps")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/conjure/the_traps)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("bees")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/conjure/creature/bee)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("apes")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/conjure/lesser_summonapes)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("blink")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/turf_teleport/blink)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("stportal")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/aoe_turf/conjure/spacetime_portal)
						return reaction_cooldown = world.time + reaction_cooldown_duration
					if("jaunt")
						bind_spell.do_cast(/obj/effect/proc_holder/spell/targeted/ethereal_jaunt)
						return reaction_cooldown = world.time + reaction_cooldown_duration
	return FALSE

//spellbook charges

/obj/item/spellbook_charge
	name = "power charge"
	desc = "An artifact that when inserted into a spellbook increases its power."
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity2"
	var/value = 1

/obj/item/spellbook_charge/ten
	name = "greater power charge"
	desc = "An artifact that when inserted into a spellbook increases its power by a massive amount."
	value = 10

/obj/item/spellbook_charge/debug
	name = "debug power charge"
	desc = "An artifact that when inserted into a spellbook increases its power by 100."
	value = 100

/obj/item/spellbook_charge/afterattack(obj/item/spellbook/book, mob/user)
	. = ..()
	if(!istype(book))
		to_chat(user, "<span class='warning'>The charge can only increase the power of spellbooks!</span>")
		return
	book.uses += value
	to_chat(user, "<span class='notice'>You increase the power of the spellbook by [value] points.</span>")
	qdel(src)
