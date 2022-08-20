//things that would go in the game mode for this go in here as its a sub antag
/datum/antagonist/demonic_slave
	name = "Demonic Slave"
	roundend_category = "devils"
	antagpanel_category = "Devil"
	job_rank = ROLE_DEMONSLAVE


/proc/add_demonic_slave(mob/living/slv, boundsouls)//gonna have to look at hivemind code for a lot of this

//based on fulp vassel code
/datum/antagonist/demonic_slave/on_gain()
	if(devil.binding_devil)

		owner.enslave_mind_to_creator()
	owner.current.log_message("has been soulbound by [binding_devil.owner.current]!", LOG_ATTACK, color="#960000")