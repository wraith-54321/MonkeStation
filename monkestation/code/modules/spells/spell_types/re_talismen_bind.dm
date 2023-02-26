/obj/effect/proc_holder/spell/targeted/re_talisman_bind
	name = "Bind Reactive Talisman"
	desc = "Bind a Reactive Talisman in your hand to yourself"
	invocation_type = "none"
	action_icon = 'icons/obj/lavaland/artefacts.dmi'
	action_icon_state = "memento_mori"
	charge_max = 1 SECONDS
	clothes_req = FALSE
	range = -1
	include_user = TRUE
	var/bound_talisman = list() //what talisman is bound to the spell
	var/owner = list() //who owns the spell, because we cant have nice things

/obj/effect/proc_holder/spell/targeted/re_talisman_bind/cast(list/targets, mob/user = usr)
	if(!(user in owner))
		owner += user
	for(var/mob/living/person in targets)
		var/held_thing = list(person.get_active_held_item())
		for(var/obj/item/clothing/neck/neckless/wizard_reactive/talisman in held_thing)
			if(talisman.bound)
				to_chat(person, "<span class='warning'>This talisman already has a binding and cannot be bound again!</span>")
				return FALSE
			else if(!talisman.bound)
				to_chat(person, "<span class='warning'>You bind the talisman to yourself.</span>")
				bound_talisman += talisman
				talisman.binding_spell += src
				talisman.binding_user += person
				talisman.bound = TRUE
				return TRUE
		to_chat(user, "<span class='warning'>You are not holding a talisman to bind.</span>")
		return FALSE

/obj/effect/proc_holder/spell/targeted/re_talisman_bind/proc/do_cast(var/obj/effect/proc_holder/spell/spelltype)
	new spelltype(src)
	for(var/mob/living/user in owner)
		for(var/obj/effect/proc_holder/spell/spell in contents)
			user.mind.spell_list += spelltype
			spell.choose_targets(user)
			user.mind.spell_list -= spelltype
			contents = null
	return

/obj/effect/proc_holder/spell/targeted/re_talisman_bind/Destroy()
	. = ..()
	for(var/obj/item/clothing/neck/neckless/wizard_reactive/unbound in bound_talisman)
		unbound.binding_spell = null //should prevent runtimes in case the spell somehow gets destroyed
		unbound.bound = FALSE
		unbound.binding_user = null
	return ..()
