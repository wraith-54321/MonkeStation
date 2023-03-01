GLOBAL_VAR_INIT(wizard_war, FALSE) //making this a global var due to things like adding wizard objectives referencing it
GLOBAL_LIST_EMPTY(m_vortex_rifts)

#define P_RITUAL_SHUTTLE_DELAY 30 MINUTES //im giving wizard 10 instead 5 minutes due to their objective having a longer minimum time to complete then nukies
#define P_RITUAL_MIN_PLAYERS 0 //setting it kinda low at 35 for testing, most likely gonna bump it up later
#define P_RITUAL_TIME_LIMIT 5 MINUTES
#define CREATE_RIFT_COUNT 8
#define NEEDED_STABLE_RIFTS 4

//ITEMS

/obj/item/wizard_challenge //might be able to make this and the nukie war item both be children of a parent that has most of the war declare stuff as theres a lot of copypasta between them here
	name = "power ritual channeler"
	desc = "Use this to channel a full spellbooks power into creating magical vortex rifts on the station, which the crew will certainly notice. Your points will not be taken. \
			Doing so will allow us to send you additional power and reinforcements, they will share your goals however will not be bound to you. \
			Once the magical interference from the rituals subsides after 20 minutes you must go to the station and open the rifts. Stabilized rifts will increase the power of spellbooks."
	icon = 'icons/effects/effects.dmi'
	icon_state = "impact_laser_blue"
	var/performing_ritual = FALSE

/obj/item/wizard_challenge/attack_self(mob/living/user)
	if(!check_allowed(user))
		return
	message_admins("CHALLENGE ITEM1")
	performing_ritual = TRUE
	var/are_you_sure = alert(user, "Performing the ritual will give the crew of [station_name()] a large amount of time to prepare. Are you sure you want to perform it? \
					    			You have [DisplayTimeText(P_RITUAL_TIME_LIMIT - world.time-SSticker.round_start_time)] to decide", "Perform Ritual?", "Yes", "No")//- replaced with +
	performing_ritual = FALSE

	if(!check_allowed(user))//I dont know why these are run so often but im just gonna be safe
		return

	if(are_you_sure == "No")
		to_chat(user, "You just dont feel up to it today.")
		return

	performing_ritual = TRUE
	var/custom_message = alert(user, "Do you want to send your own message to the station?", "Customize?", "Yes", "No")
	performing_ritual = FALSE

	if(!check_allowed(user))
		return

	if(custom_message == "Yes")
		performing_ritual = TRUE
		custom_message = stripped_input(user, "Insert your custom declaration", "Declaration")
		performing_ritual = FALSE
	if(CHAT_FILTER_CHECK(custom_message))
		if(user)
			to_chat(user, "<span class='warning'>You message contains forbidden words, please review the server rules and do not attempt to bypass this filter.</span>")
			return

	if(!check_allowed(user))
		return

	for(var/mob/living/carbon/human/crew in GLOB.player_list)
		if(crew.stat == DEAD)
			continue
		var/turf/TTS = get_turf(crew)
		if(TTS && !is_station_level(TTS.z))
			continue
		to_chat(crew, "<span class='reallybig hypnophrase'>[custom_message]</span>")
	message_admins("CHALLENGE ITEM2")
	priority_announce("We have detected a massive magical energy surge coming from [station_name()] due to [user.real_name] casting a power ritual from near by space. \
					   If they are able to stabilze the rifts opening around the station a magical vortex will be summoned to the station casuing massive chaos and profit loss. \
					   Oh also you will most likely die.", "Magical Affairs Division", 'sound/machines/alarm.ogg',  has_important_message = TRUE)
	play_soundtrack_music(/datum/soundtrack_song/bee/future_perception)
	to_chat(user, "You have completed the ritual. No going back now.")
	GLOB.wizard_war = TRUE
	message_admins("CHALLENGE ITEM3")
	create_vortex_rifts()
	for(var/i = 0, i < 3, i++)
		new /obj/item/clothing/suit/space/hardsuit/wizard(user.loc)
		new /obj/item/spellbook_charge(user.loc)
	for(var/i = 0, i < 2, i++)
		new /obj/item/antag_spawner/lesser_wizard(user.loc)
	to_chat(user, "A pile of items appears at your feet.")
	for (var/datum/antagonist/wizard/wizard in GLOB.antagonists)
		if(!wizard.owner)
			continue
		message_admins("CHALLENGE ITEMOBJECTIVE1")
		wizard.objectives = list(null)
		message_admins("CHALLENGE ITEMOBJECTIVE2")
		wizard.create_objectives()
		to_chat(wizard.owner, "Your objetives have been updated.")
		wizard.owner.announce_objectives()
		message_admins("CHALLENGE ITEMOBJECTIVE4")
	message_admins("CHALLENGE ITEM6")
	return qdel(src)

/obj/item/wizard_challenge/proc/check_allowed(mob/living/user)
	if(GLOB.player_list.len < P_RITUAL_MIN_PLAYERS)
		to_chat(user, "The chaos caused by this size of crew is too small for rifts to open.")
		return FALSE
	if(GLOB.wizard_war)
		to_chat(user, "The ritual has already been performed.")
		return FALSE
	if(!(user in GLOB.areas_by_type[/area/wizard_station]))
		to_chat(user, "You need to be closer to the power provided by your den.")
		return FALSE
	if(world.time-SSticker.round_start_time > P_RITUAL_TIME_LIMIT)
		to_chat(user, "[station_name()] is no longer in the correct location to be able to perform the ritual on it.")
		return FALSE
	for(var/obj/item/spellbook/book in GLOB.spellbooks)
		if(book.owner == user)
			if(!(book.uses >= 10))
				to_chat(user, "Your spellbook lacks the power to perform the ritual.")
				return FALSE
	return TRUE

//LESSER WIZARD STUFF

/obj/item/antag_spawner/lesser_wizard
	name = "magical reinforcement scroll"
	desc = "A scroll that when used summons another wizard who shares your goals."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"

/obj/item/antag_spawner/lesser_wizard/attack_self(mob/user)
	if(!user.mind.has_antag_datum(/datum/antagonist/wizard))
		to_chat(user, "<span class='danger'>You can't read the writing on the scroll and have no idea what to do with it.</span>")
		return
	if(used)
		to_chat(user, "<span class='warning'>This contract has already been used.</span>")
		return
	to_chat(user, "<span class='danger'>You attempt to call for reinforcements.</span>")
	var/list/candidates = pollGhostCandidates("Do you wish to be considered for ["Reinforcement Wizard"]?", ROLE_WIZARD, null)
	if(candidates.len)
		var/mob/dead/observer/selected = pick(candidates)
		spawn_antag(selected.client, get_turf(src))
		used = TRUE
	else
		to_chat(user, "<span class='warning'>Unable to summon a reinforcement at this time, try again later.</span>")

/obj/item/antag_spawner/wizard_lesser/spawn_antag(client/w_client, turf/spawn_location, null, /datum/mind/user)
	new /obj/effect/particle_effect/smoke(spawn_location)
	var/mob/living/carbon/human/body = new/mob/living/carbon/human(spawn_location)
	w_client.prefs.copy_to(body)
	body.key = w_client.key
	body.mind.assigned_role = "Apprentice"
	body.mind.special_role = "apprentice"
	body.mind.add_antag_datum(/datum/antagonist/wizard/lesser)

/datum/antagonist/wizard/lesser
	name = "Lesser Space Wizard"
	outfit_type = /datum/outfit/wizard/lesser

/datum/outfit/wizard/lesser
	name = "Lesser Wizard"

/datum/outfit/wizard/lesser/post_equip(mob/living/carbon/human/equiped, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/spellbook/book = locate() in equiped.held_items
	if(book)
		book.owner = equiped
		book.uses -= 5
		for(var/datum/spellbook_entry/rod_form/rf_entry in book.entries)
			book.entries -= rf_entry // no easy singalo for you

//EFFECTS/STRUCTURES

/obj/effect/m_vortex_blocker
	name = "vortex rift instability"
	desc = "An unstable point in space caused by a vortex rift near by."
	density = FALSE
	anchored = TRUE
	icon_state = "shieldsparkles"

/obj/structure/magical_vortex_rift
	name = "magical vortex rift"
	desc = "A rift that if stabilized will bring chaos to the station. Or at least more then usual."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/stable = FALSE
	var/announced = FALSE
	var/stabilizations = 0
	var/area
	var/is_interacted = FALSE

/obj/structure/magical_vortex_rift/attack_hand(mob/living/user)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/wizard))
		to_chat(user, "<span class='warning'>You decide touching [src] might not be the best idea.</span>")
		return
	if(stable)
		to_chat(user, "<span class='notice'>This rift is already stable.</span>")
		return
	if(is_interacted)
		to_chat(user, "<span class='notice'>This rift is already being stabilized.</span>")
		return

	to_chat(user, "<span class='notice'>You start to stabilize the [src].</span>")
	is_interacted = TRUE
	if(!do_after(user, 4 SECONDS))
		to_chat(user, "<span class='notice'>You get interrupted.</span>")
		is_interacted = FALSE
		return

	if(!announced)
		priority_announce("A rift is being stabilzed by [user.real_name] in [area].", "Magical Affairs Division", ANNOUNCER_SPANOMALIES,  has_important_message = TRUE)
		announced = TRUE
	to_chat(user, "<span class='notice'>You finish increasing the [src]'s stability.</span>")
	stabilizations++
	is_interacted = FALSE

	if(stabilizations >= 8)
		visible_message("The [src] stabilizes!")
		stable = TRUE
		priority_announce("The rift in [area] has been stabilized by [user.real_name].", "Magical Affairs Division", ,  has_important_message = TRUE)
		for(var/obj/item/spellbook/book in GLOB.spellbooks)
			book.uses++
			book.visible_message("The [src] glows slightly, you feel as though it has grown in power.")
		icon_state = "shield1"
		name = "stabilized magical vortex rift"

	magical_vortex_check()

/obj/structure/magical_vortex_rift/Initialize(mapload)
	. = ..()
	message_admins("RIFT CREATED")
	GLOB.m_vortex_rifts += src
	var/turf/vortex_turf = get_turf(src)
	area = get_area(vortex_turf)
	for(var/turf/spawn_turf in range(2, src))
		if(spawn_turf in range(1, src)) //hopefully to reduce lag
			continue
		new /obj/effect/m_vortex_blocker(spawn_turf)
	message_admins("RIFT SPOT [get_turf(src)]")
	message_admins("RIFT AREA [get_area(vortex_turf)]")
	message_admins("RIFT CREATED3 [area]")
	return ..()

/obj/structure/magical_vortex_rift/Destroy()
	. = ..()
	GLOB.m_vortex_rifts -= src
	return ..()

//OBJECTIVE

/datum/objective/m_vortex
	var/rift_spots = list()
	var/rifts = list()

/datum/objective/m_vortex/New()
	for(var/obj/structure/magical_vortex_rift/rift in GLOB.m_vortex_rifts)
		var/turf/rift_turf = get_turf(rift)
		var/area/rift_area = get_area(rift_turf)
		rift_spots += rift_area
		rifts += rift
		update_explanation_text()

/datum/objective/m_vortex/update_explanation_text()
	explanation_text = "Stabilize [NEEDED_STABLE_RIFTS] Vortex Rifts by interacting with them, they are located in [english_list(rift_spots)].</b>"

/datum/objective/m_vortex/check_completion()
	var/stable_rifts = 0
	for(var/obj/structure/magical_vortex_rift/check_rift in rifts)
		if(check_rift.stable)
			stable_rifts++
	if(stable_rifts >= NEEDED_STABLE_RIFTS)
		return TRUE
	else
		return FALSE

//GENERAL PROCS

/proc/create_vortex_rifts()
	message_admins("CREATE RIFTS1")
	var/sanity = 0
	var/list/rift_locations = list()
	while(rift_locations.len < CREATE_RIFT_COUNT && sanity < 100)
		var/area/rift_area = pick(GLOB.sortedAreas - rift_locations)
		if(rift_area && is_station_level(rift_area.z) && (rift_area.area_flags & VALID_TERRITORY))
			rift_locations += rift_area
		sanity++
		message_admins("CREATE RIFTS2")
	for(var/area/area in rift_locations)
		var/turf/rift_turf = pick(get_area_turfs(area))
		new /obj/structure/magical_vortex_rift(rift_turf)
		message_admins("CREATE RIFTS3")
	message_admins("CREATE RIFTS4")
	return

/proc/magical_vortex_check()
	var/list/stable_rifts = list()
	for(var/obj/structure/magical_vortex_rift/rift in GLOB.m_vortex_rifts)
		if(rift.stable)
			stable_rifts += rift
	if(stable_rifts.len >= NEEDED_STABLE_RIFTS)
		return summon_magical_vortex()
	return

/proc/summon_magical_vortex()
	for(var/obj/item/spellbook/book in GLOB.spellbooks)
		book.uses += 10

	set_security_level(SEC_LEVEL_DELTA)
	priority_announce("You have failed to protect company assets and a Magical Vortex has been summoned to your station. \
					  Your contracts have been terminated.", "Magical Affairs Division", 'sound/machines/clockcult/ark_scream.ogg',  has_important_message = TRUE)

	SSevents.doFastMode(10)

	var/list/candidates = pollGhostCandidates("Do you wish to be considered for a vortex wizard?", ROLE_WIZARD, null)
	for(var/i = 0, i < 4, i++)
		shuffle_inplace(candidates)
		var/mob/dead/observer/selected = pick_n_take(candidates)
		candidates -= selected
		var/mob/living/carbon/human/new_character = makeBody(selected)
		new_character.mind.make_Wizard()

	SSshuttle.emergencyNoRecall = TRUE
	if(SSshuttle.emergency.timeLeft(1) > SSshuttle.emergencyCallTime * 0.4)
		SSshuttle.emergency.request(null, "WARNING: SYSTEM ERROR. DISPATCHING SHUTTLE.", set_coefficient = 0.4)

	rightandwrong(SUMMON_MAGIC, null, 10)
	rightandwrong(SUMMON_GUNS, null, 10)

	return

#undef P_RITUAL_SHUTTLE_DELAY
#undef P_RITUAL_MIN_PLAYERS
#undef P_RITUAL_TIME_LIMIT
#undef CREATE_RIFT_COUNT
#undef NEEDED_STABLE_RIFTS
