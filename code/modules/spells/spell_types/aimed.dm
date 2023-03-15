
/obj/effect/proc_holder/spell/aimed
	name = "aimed projectile spell"
	var/projectile_type = /obj/item/projectile/magic/teleport
	var/deactive_msg = "You discharge your projectile..."
	var/active_msg = "You charge your projectile!"
	base_icon_state = "projectile"
	var/active_icon_state = "projectile"
	var/list/projectile_var_overrides = list()
	var/projectile_amount = 1	//How many times you can fire per cast.
	var/current_amount = 0	//How many projectiles left.
	var/projectiles_per_fire = 1		//Projectiles per fire. Probably not a good thing to use unless you override ready_projectile().

/obj/effect/proc_holder/spell/aimed/Click()
	var/mob/living/user = usr
	if(!istype(user))
		return
	var/msg
	if(!can_cast(user))
		msg = "<span class='warning'>You can no longer cast [name]!</span>"
		remove_ranged_ability(msg)
		return
	if(active)
		msg = "<span class='notice'>[deactive_msg]</span>"
		if(charge_type == "recharge")
			var/refund_percent = current_amount/projectile_amount
			charge_counter = charge_max * refund_percent
			start_recharge()
		remove_ranged_ability(msg)
		on_deactivation(user)
	else
		msg = "<span class='notice'>[active_msg] <B>Left-click to shoot it at a target!</B></span>"
		current_amount = projectile_amount
		add_ranged_ability(user, msg, TRUE)
		on_activation(user)

/obj/effect/proc_holder/spell/aimed/proc/on_activation(mob/user)
	return

/obj/effect/proc_holder/spell/aimed/proc/on_deactivation(mob/user)
	return

/obj/effect/proc_holder/spell/aimed/update_icon()
	if(!action)
		return
	action.button_icon_state = "[base_icon_state][active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/spell/aimed/InterceptClickOn(mob/living/caller, params, atom/target)
	if(..())
		return FALSE
	var/ran_out = (current_amount <= 0)
	if(!cast_check(!ran_out, ranged_ability_user))
		remove_ranged_ability()
		return FALSE
	var/list/targets = list(target)
	perform(targets, ran_out, user = ranged_ability_user)
	return TRUE

/obj/effect/proc_holder/spell/aimed/cast(list/targets, mob/living/user)
	var/target = targets[1]
	var/turf/T = user.loc
	var/turf/U = get_step(user, user.dir) // Get the tile infront of the move, based on their direction
	if(!isturf(U) || !isturf(T))
		return FALSE
	fire_projectile(user, target)
	user.newtonian_move(get_dir(U, T))
	if(current_amount <= 0)
		remove_ranged_ability() //Auto-disable the ability once you run out of bullets.
		charge_counter = 0
		start_recharge()
		on_deactivation(user)
	return TRUE

/obj/effect/proc_holder/spell/aimed/proc/fire_projectile(mob/living/user, atom/target)
	current_amount--
	if(!projectile_type)
		return
	for(var/i in 1 to projectiles_per_fire)
		var/obj/item/projectile/P = new projectile_type(user.loc, spell_level)
		P.firer = user
		P.preparePixelProjectile(target, user)
		for(var/V in projectile_var_overrides)
			if(P.vars[V])
				P.vv_edit_var(V, projectile_var_overrides[V])
		ready_projectile(P, target, user, i)
		P.fire()
	return TRUE

/obj/effect/proc_holder/spell/aimed/proc/ready_projectile(obj/item/projectile/P, atom/target, mob/user, iteration)
	return

//monkestation edit start
/obj/effect/proc_holder/spell/aimed/after_cast(list/targets) //makes it so things that are meant to fire more then once per cast can
	if(projectile_amount > 1 && current_amount)
		recharging = FALSE
		update_icon()
	return ..()
//monkestation edit end
/obj/effect/proc_holder/spell/aimed/lightningbolt
	name = "Lightning Bolt"
	desc = "Fire a lightning bolt at your foes! It will jump between targets, but can't knock them down."
	school = "evocation"
	charge_max = 150
	clothes_req = FALSE
	invocation = "UN'LTD P'WAH"
	invocation_type = "shout"
	cooldown_min = 50
	base_icon_state = "lightning"
	action_icon_state = "lightning0"
	sound = 'sound/magic/lightningbolt.ogg'
	active = FALSE
	projectile_var_overrides = list("zap_range" = 15, "zap_power" = 20000, "zap_flags" = ZAP_MOB_DAMAGE)
	active_msg = "You energize your hand with arcane lightning!"
	deactive_msg = "You let the energy flow out of your hands back into yourself..."
	projectile_type = /obj/item/projectile/magic/aoe/lightning

/obj/effect/proc_holder/spell/aimed/lightningbolt/on_gain(mob/living/user)
	. = ..()
	ADD_TRAIT(user, TRAIT_TESLA_SHOCKIMMUNE, "lightning_bolt_spell")

/obj/effect/proc_holder/spell/aimed/lightningbolt/on_lose(mob/living/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_TESLA_SHOCKIMMUNE, "lightning_bolt_spell")

/obj/effect/proc_holder/spell/aimed/fireball
	name = "Fireball"
	desc = "This spell fires an explosive fireball at a target."
	school = "evocation"
	charge_max = 140
	clothes_req = TRUE
	invocation = "ONI SOMA"
	invocation_type = "shout"
	range = 20
	cooldown_min = 40 //10 deciseconds reduction per rank
	projectile_type = /obj/item/projectile/magic/aoe/fireball
	base_icon_state = "fireball"
	action_icon_state = "fireball0"
	sound = 'sound/magic/fireball.ogg'
	active_msg = "You prepare to cast your fireball spell!"
	deactive_msg = "You extinguish your fireball... for now."
	active = FALSE

/obj/effect/proc_holder/spell/aimed/spell_cards
	name = "Spell Cards"
	desc = "Magically sharpened rapid-fire homing cards. Send your foes to the shadow realm with their mystical piercing power!"
	school = "evocation"
	charge_max = 90
	clothes_req = FALSE
	invocation = "Sigi'lu M'Fan 'Tasia"
	invocation_type = "shout"
	range = 40
	cooldown_min = 6 SECONDS //monkestation edit: from 3 to 6 seconds
	projectile_amount = 5
	projectiles_per_fire = 3 //monkestation edit: from 7 to 3
	projectile_type = /obj/item/projectile/spellcard
	base_icon_state = "spellcard"
	action_icon_state = "spellcard0"
//	var/datum/weakref/current_target_weakref monkestation edit: removed
//	var/datum/component/lock_on_cursor/lockon_component //monkestation edit: removed
	var/projectile_turnrate = 40 //monkestation edit: from 10 to 40
	var/projectile_pixel_homing_spread = 32
	var/projectile_initial_spread_amount = 30
	var/projectile_location_spread_amount = 12
	ranged_clickcd_override = TRUE
	var/datum/weakref/target_override //monkestation edit: tries to override a non-mob target if there is a possible mob target

/*/obj/effect/proc_holder/spell/aimed/spell_cards/on_activation(mob/M)
	QDEL_NULL(lockon_component)
	lockon_component = M.AddComponent(/datum/component/lock_on_cursor, \
		lock_cursor_range = 5, \
		target_typecache = GLOB.typecache_living, \
		lock_amount = 1, \
		on_lock = CALLBACK(src, .proc/on_lockon_component))*/ //monkestation edit: removed

/*/obj/effect/proc_holder/spell/aimed/spell_cards/proc/on_lockon_component(list/locked_weakrefs)
	if(!length(locked_weakrefs))
		current_target_weakref = null
		return
	current_target_weakref = locked_weakrefs[1]
	var/atom/A = current_target_weakref.resolve()
	if(A)
		var/mob/M = lockon_component.parent
		M.face_atom(A)*/ //monkestation edit: removed

///obj/effect/proc_holder/spell/aimed/spell_cards/on_deactivation(mob/M)
//	QDEL_NULL(lockon_component) monkestation edit: removed

/obj/effect/proc_holder/spell/aimed/spell_cards/ready_projectile(obj/item/projectile/P, atom/target, mob/user, iteration)
	var/projectile_chosen_spread_amount = projectile_initial_spread_amount //monkestation edit: so we can choose the angle
	if(isliving(target)) //monkestation edit: changes it to just check for a living target
		if(target && get_dist(target, user) < 10) //monkestation edit: bumps the get_dist() up from 7 to 10
			projectile_chosen_spread_amount = 180 //monkestation edit: "it looks cool"
			P.homing_turn_speed = projectile_turnrate
			P.homing_inaccuracy_min = projectile_pixel_homing_spread
			P.homing_inaccuracy_max = projectile_pixel_homing_spread
			P.set_homing_target(target)
	var/rand_spr = rand()
	var/total_angle = projectile_chosen_spread_amount * 2 //monkestation edit: changed to chosen_spread
	var/adjusted_angle = total_angle - ((projectile_chosen_spread_amount / projectiles_per_fire) * 0.5) //monkestation edit: same as above
	var/one_fire_angle = adjusted_angle / projectiles_per_fire
	var/current_angle = iteration * one_fire_angle * rand_spr - (projectile_chosen_spread_amount / 2) //monkestation edit: same as above
	P.pixel_x = rand(-projectile_location_spread_amount, projectile_location_spread_amount)
	P.pixel_y = rand(-projectile_location_spread_amount, projectile_location_spread_amount)
	P.preparePixelProjectile(target, user, null, current_angle)

//monkestation edit start
/obj/effect/proc_holder/spell/aimed/spell_cards/InterceptClickOn(mob/living/caller, params, atom/target) //will try to target mobs on the same turf if the target is not a mob
	. = ..()
	if(!ismob(target))
		var/turf/target_turf = get_turf(target)
		if(target_turf.contents)
			var/list/possible_targets = typecache_filter_list(target_turf.contents + target_turf, GLOB.typecache_living)
			target_override = pick(possible_targets)

/obj/effect/proc_holder/spell/aimed/spell_cards/before_cast(list/targets) //make the target be the slected mob
	. = ..()
	if(target_override)
		targets[1] = target_override
		target_override = null
//monkestation edit end
