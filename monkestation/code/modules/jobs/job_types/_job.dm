
///////////////////////////////////////
//Tracking Procs for every department//
///////////////////////////////////////

//////////////////////////////////////////
//Keeps track of any engineering members//
//////////////////////////////////////////

/datum/job/proc/get_any_engineers()
	for(var/mob/living/carbon/human/player in GLOB.carbon_list)
		if(player.mind && (player.mind.assigned_role in GLOB.engineering_positions))
			return TRUE
	return FALSE

//////////////////////////////////////
//Keeps track of any medical members//
//////////////////////////////////////
//Does not include: Geneticist, Virologist, Brig Physician

/datum/job/proc/get_any_medical()
	for(var/mob/living/carbon/human/player in GLOB.carbon_list)
		if(player.mind && (player.mind.assigned_role in list(
			"Chief Medical Officer",
			"Medical Doctor",
			"Paramedic",
			"Chemist"
		)))
			return TRUE
	return FALSE

//////////////////////////////////////
//Keeps track of any science members//
//////////////////////////////////////
//Does not include: Exploration Crew

/datum/job/proc/get_any_scientists()
	for(var/mob/living/carbon/human/player in GLOB.carbon_list)
		if(player.mind && (player.mind.assigned_role in list(
			"Research Director",
			"Scientist",
			"Roboticist")))
			return TRUE
	return FALSE

////////////////////////////////////
//Keeps track of any Cargo members//
////////////////////////////////////
//Includes mining, as cargo techs would already have access on low-pop

/datum/job/proc/get_any_supply()
	for(var/mob/living/carbon/human/player in GLOB.carbon_list)
		if(player.mind && (player.mind.assigned_role in GLOB.supply_positions))
			return TRUE
	return FALSE

//////////////////////////////////////
//Keeps track of any Service members//
//////////////////////////////////////
//Only includes Bartender, Janitor, Chef & Botanist as they would be semi-important

/datum/job/proc/get_any_service()
	for(var/mob/living/carbon/human/player in GLOB.carbon_list)
		if(player.mind && (player.mind.assigned_role in list(
			"Bartender",
			"Botanist",
			"Cook",
			"Janitor"
			)))
			return TRUE
	return FALSE
