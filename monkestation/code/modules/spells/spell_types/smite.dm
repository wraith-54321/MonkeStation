/obj/effect/proc_holder/spell/pointed/smite
	name = "Smite"
	desc = "A spell to strike down your foes from the heavens."
	action_icon_state = "gib"
	base_icon_state = "gib"
	invocation_type = "shout"
	invocation = "EI NATH!!"
	range = 2
	charge_max = 25 SECONDS //most of the effects are not very deadly
	cooldown_min = 8 SECONDS
	clothes_req = FALSE // TRUE

/obj/effect/proc_holder/spell/pointed/smite/cast(list/targets, mob/user) //I tried making a smite global proc to avoid copypasta but with admin checking and such it was just not working
	var/list/punishment_list = list(ADMIN_PUNISHMENT_LIGHTNING, ADMIN_PUNISHMENT_BRAINDAMAGE, ADMIN_PUNISHMENT_GIB, ADMIN_PUNISHMENT_FIREBALL, ADMIN_PUNISHMENT_MAZING, \
									 ADMIN_PUNISHMENT_CLUWNE, ADMIN_PUNISHMENT_IMMERSE, ADMIN_PUNISHMENT_GHOST, ADMIN_PUNISHMENT_DEMOCRACY, ADMIN_PUNISHMENT_ANARCHY, \
									 ADMIN_PUNISHMENT_TOE, ADMIN_PUNISHMENT_TOEPLUS, ADMIN_PUNISHMENT_BREAD)
	if(!targets.len)
		return FALSE

	for(var/mob/living/target in targets)
		if(target == user)
			continue

		if(target.anti_magic_check())
			to_chat(user, "<span class='warning'>The spell had no effect!</span>")
			target.visible_message("<span class='warning'>Looks like [target] has more favor with the gods then [user]!</span>")
			continue

		if(istype(target, /mob/living/carbon))
			punishment_list += ADMIN_PUNISHMENT_NUGGET
		if(target.mind) //dont want them dying to their own smite for no reason
			punishment_list += ADMIN_PUNISHMENT_FLOORCLUWNE

		target.visible_message("<span class='danger'>[target] looks up in horror as they see fate crashing down upon them!</span>", \
							   "<span class='danger'>The gods look at you, amused. Oh no.</span>")
		if(prob(4)) //making rod one in 25 due to it being more damaging then the rest
			var/turf/T = get_turf(target)
			var/startside = pick(GLOB.cardinals)
			var/turf/startT = spaceDebrisStartLoc(startside, T.z)
			var/turf/endT = spaceDebrisFinishLoc(startside, T.z)
			new /obj/effect/immovablerod(startT, endT,target)
		else
			var/picked_smite = pick(punishment_list)
			message_admins("SMITETYPE [picked_smite]")
			switch(picked_smite)
				if(ADMIN_PUNISHMENT_LIGHTNING)
					var/turf/T = get_step(get_step(target, NORTH), NORTH)
					T.Beam(target, icon_state="lightning[rand(1,12)]", time = 5)
					target.adjustFireLoss(75)
					if(ishuman(target))
						var/mob/living/carbon/human/H = target
						H.electrocution_animation(40)
					to_chat(target, "<span class='userdanger'>The gods have punished you for your sins!</span>")
				if(ADMIN_PUNISHMENT_BRAINDAMAGE)
					target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 199, 199)
				if(ADMIN_PUNISHMENT_GIB)
					target.gib(FALSE)
				if(ADMIN_PUNISHMENT_FIREBALL)
					new /obj/effect/temp_visual/target(get_turf(target))
				if(ADMIN_PUNISHMENT_ROD)
					var/turf/T = get_turf(target)
					var/startside = pick(GLOB.cardinals)
					var/turf/startT = spaceDebrisStartLoc(startside, T.z)
					var/turf/endT = spaceDebrisFinishLoc(startside, T.z)
					new /obj/effect/immovablerod(startT, endT,target)

				if(ADMIN_PUNISHMENT_MAZING)
					if(!puzzle_imprison(target))
						to_chat(usr,"<span class='warning'>Imprisonment failed!</span>")
						return

				if(ADMIN_PUNISHMENT_FLOORCLUWNE)
					if(!ishuman(target))
						to_chat(usr,"<span class='warning'>You may only floorcluwne humans!</span>")
						return

					var/turf/T = get_turf(target)
					var/mob/living/simple_animal/hostile/floor_cluwne/FC = new(T)
					FC.invalid_area_typecache = list()  // works anywhere
					FC.delete_after_target_killed = TRUE
					FC.force_target(target)
					FC.stage = 4

				if(ADMIN_PUNISHMENT_CLUWNE)
					message_admins("[usr] cluwned [target]")
					target.cluwne()

				if(ADMIN_PUNISHMENT_NUGGET)
					var/mob/living/carbon/C = target
					for(var/X in C.bodyparts)
						var/obj/item/bodypart/BP = X
						if(BP.body_part != HEAD && BP.body_part != CHEST)
							if(BP.dismemberable)
								BP.dismember()

				if(ADMIN_PUNISHMENT_IMMERSE)
					immerse_player(target)

				if(ADMIN_PUNISHMENT_GHOST)
					if (target.key)
						target.ghostize(FALSE,SENTIENCE_FORCE)
					else
						target.set_playable()
				if(ADMIN_PUNISHMENT_TOE)
					if(!ishuman(target))
						to_chat(usr, "<span class='warning'>Only humanoids can stub their toes!</span>")
						return
					var/mob/living/carbon/human/H = target
					to_chat(H, "<span class='warning'>You stub your toe on an invisible table!</span>")
					H.stub_toe(5)
				if(ADMIN_PUNISHMENT_TOEPLUS)
					if(!ishuman(target))
						to_chat(usr, "<span class='warning'>Only humanoids can stub their toes!</span>")
						return
					ADD_TRAIT(target, TRAIT_ALWAYS_STUBS, "adminabuse")

				if(ADMIN_PUNISHMENT_DEMOCRACY)
					target._AddComponent(list(/datum/component/deadchat_control, DEMOCRACY_MODE, list(
					 "up" = CALLBACK(GLOBAL_PROC, .proc/_step, target, NORTH),
					 "down" = CALLBACK(GLOBAL_PROC, .proc/_step, target, SOUTH),
					 "left" = CALLBACK(GLOBAL_PROC, .proc/_step, target, WEST),
					 "right" = CALLBACK(GLOBAL_PROC, .proc/_step, target, EAST)), 40))

				if(ADMIN_PUNISHMENT_ANARCHY)
					target._AddComponent(list(/datum/component/deadchat_control, ANARCHY_MODE, list(
					 "up" = CALLBACK(GLOBAL_PROC, .proc/_step, target, NORTH),
					 "down" = CALLBACK(GLOBAL_PROC, .proc/_step, target, SOUTH),
					 "left" = CALLBACK(GLOBAL_PROC, .proc/_step, target, WEST),
					 "right" = CALLBACK(GLOBAL_PROC, .proc/_step, target, EAST)), 10))

				if(ADMIN_PUNISHMENT_BREAD)
					var/mutable_appearance/bread_appearance = mutable_appearance('icons/obj/food/burgerbread.dmi',"bread")
					var/mutable_appearance/transform_scanline = mutable_appearance('monkestation/icons/effects/effects.dmi',"transform_effect")
					target.transformation_animation(bread_appearance,time= 5 SECONDS,transform_overlay=transform_scanline,reset_after=TRUE)
					addtimer(CALLBACK(GLOBAL_PROC, .proc/breadify, target), 5 SECONDS)
