//put axe antag datums and objectives here, these are meant to be very hard

//FAKE NUKIE
/datum/antagonist/nukeop/lone/fake
	name = "Beer Operative"
	nukeop_outfit = /datum/outfit/hollow_sword/beer_nukie
	team_type = /datum/team/nuclear/beer

/datum/antagonist/nukeop/lone/fake/assign_nuke()
	if(nuke_team && !nuke_team.tracked_nuke)
		nuke_team.memorized_code = random_nukecode()
		var/obj/machinery/nuclearbomb/beer/nuke = locate() in GLOB.nuke_list
		if(nuke)
			nuke_team.tracked_nuke = nuke
			if(nuke.r_code == "ADMIN")
				nuke.r_code = nuke_team.memorized_code
			else //Already set by admins/something else?
				nuke_team.memorized_code = nuke.r_code
		else //if the station lacks a beer nuke it tries to drop pod one in on a safe turf, but dont try too many times
			message_admins("No beer nuke found for fake lone op, attemping to create one.")
			nuke_team.memorized_code = null
			try_spawn_beernuke()

/datum/antagonist/nukeop/lone/fake/proc/try_spawn_beernuke() //create the nuke
	var/nuke_creation_attemps = 0 //dont try and make them too many times
	while(nuke_creation_attemps < 3)
		nuke_creation_attemps++
		var/turf/nuke_loc = find_safe_turf()
		var/obj/machinery/nuclearbomb/beer/new_nuke = new()
		var/obj/structure/closet/supplypod/pod = new()
		new /obj/effect/pod_landingzone(nuke_loc, pod)
		new_nuke.forceMove(pod)
	if(nuke_creation_attemps < 3)
		assign_nuke()
	else
		CRASH("Unable to create beer nuke for fake lone op.")

/datum/objective/nuclear_beer
	name = "nuclear beer"
	explanation_text = "Your a totally real nuke op, but you dont want to hurt anyone! Activate the Nanotrasen Brand Nuclear Fission Explosive to cover the station in booze"
	martyr_compatible = 1

/datum/objective/nuclear_beer/check_completion()
	for(var/obj/machinery/nuclearbomb/beer/nuke in GLOB.nuke_list) //if there is somehow more then one any of them work
		if(nuke.exploded)
			return TRUE
	return ..()

/datum/team/nuclear/beer
	core_objective = /datum/objective/nuclear_beer

//FAKE TRAITOR
/datum/antagonist/traitor/fake
	name = "Fake Traitor"
	should_equip = FALSE

/datum/antagonist/traitor/fake/forge_human_objectives() //dont want them getting murder based objectives
	var/datum/objective/steal/steal_objective = new
	steal_objective.owner = owner
	steal_objective.find_target()
	add_objective(steal_objective)

	var/datum/objective/gimmick/gimmick_objective = new
	gimmick_objective.owner = owner
	gimmick_objective.find_target()
	gimmick_objective.update_explanation_text()
	add_objective(gimmick_objective)

	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/escape/escape_objective = new
		escape_objective.owner = owner
		add_objective(escape_objective)
