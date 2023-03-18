/datum/round_event_control/wizard/fake_antagonists
	name = "Fake Antagonists"
	typepath = /datum/round_event/wizard/fake_antagonists
	weight = 3
	max_occurrences = 3

/datum/round_event/wizard/fake_antagonists/start()
	var/list/candidates = pollGhostCandidates("Would you like to be a Fake Antagonist?", ROLE_TRAITOR) //just making it be traitor because I dont know what else to make it
	if(!candidates)
		return
	var/list/ghost_minds = list()
	for(var/mob/dead/observer/ghost in candidates)
		ghost_minds += ghost.mind

	make_fake_antag(ghost_minds, from_event = TRUE) //selection and spawning is handled by this proc, see fake_antag_creation.dm
