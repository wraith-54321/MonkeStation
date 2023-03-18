//create fake antags here

/proc/make_fake_antag(var/list/possible_minds, var/from_event = FALSE) //turns minds into random fake antags
	var/chosen_type
	if(!possible_minds.len)
		return
	if(!from_event)
		chosen_type = pickweight(list("fake_nukie" = 2, "fake_traitor" = 5))
	else
		chosen_type = pickweight(list("fake_nukie" = 2, "fake_traitor_three" = 5))

	switch(chosen_type)
		if("fake_nukie")
			var/nukie_mind = pick(possible_minds)
			make_fake_nukie(nukie_mind)
		if("fake_traitor")
			var/traitor_mind = pick(possible_minds)
			make_fake_traitor(traitor_mind)
		if("fake_traitor_three")
			for(var/i = 0, i < 3, i++)
				if(!possible_minds.len)
					return
				var/traitor_mind = pick_n_take(possible_minds)
				make_fake_traitor(traitor_mind)

/proc/make_fake_nukie(var/datum/mind/nukie_mind) //turn a mind into a fake nukie
	if(!nukie_mind)
		return

	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/carpspawn/landmark in GLOB.landmarks_list)
		spawn_locs += landmark.loc
	if(!spawn_locs.len)
		return MAP_ERROR

	var/mob/living/carbon/human/operative = new(pick(spawn_locs))
	var/datum/preferences/prefs = new
	prefs.copy_to(operative)
	operative.dna.update_dna_identity()
	var/datum/mind/Mind = new /datum/mind(nukie_mind.key)
	Mind.assigned_role = "Fake Lone Operative"
	Mind.special_role = "Fake Lone Operative"
	Mind.active = 1
	Mind.transfer_to(operative)
	Mind.add_antag_datum(/datum/antagonist/nukeop/lone/fake)
	ADD_TRAIT(operative, TRAIT_PACIFISM, MAGIC_TRAIT)

	message_admins("[ADMIN_LOOKUPFLW(operative)] has been made into a fake lone operative by an event or wizard.")
	log_game("[key_name(operative)] was spawned as a fake lone operative by an event or wizard.")

/proc/make_fake_traitor(var/datum/mind/traitor_mind) //turn a mind into a fake traitor
	if(!traitor_mind)
		return

	var/spawn_loc
	spawn_loc = find_safe_turf()
	if(!spawn_loc)
		return

	var/mob/living/carbon/human/traitor = new(spawn_loc)
	var/datum/preferences/prefs = new
	prefs.copy_to(traitor)
	traitor.dna.update_dna_identity()
	traitor.equipOutfit(/datum/outfit/hollow_sword/original_traitor)
	new /obj/effect/particle_effect/smoke(traitor.loc)
	var/datum/mind/Mind = new /datum/mind(traitor_mind.key)
	Mind.assigned_role = "Fake Traitor"
	Mind.special_role = "Fake Traitor"
	Mind.active = 1
	Mind.transfer_to(traitor)
	Mind.add_antag_datum(/datum/antagonist/traitor/fake)
	ADD_TRAIT(traitor, TRAIT_PACIFISM, MAGIC_TRAIT)

	message_admins("[ADMIN_LOOKUPFLW(traitor)] has been made into a fake traitor by an event or wizard.")
	log_game("[key_name(traitor)] was spawned as a fake traitor by an event or wizard.")

