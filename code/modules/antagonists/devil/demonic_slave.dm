//things that would go in the game mode for this go in here as its a sub antag
/datum/antagonist/demonic_slave
	name = "Demonic Slave"
	roundend_category = "devils"
	antagpanel_category = "Devil"
	job_rank = ROLE_DEMONSLAVE
	var/datum/antagonist/devil/binding_devil


//based on fulp vassel code
/datum/antagonist/demonic_slave/on_gain()
	if(binding_devil)
//		var/datum/antagonist/devil/binding_DD = binding_devil.owner.has_antag_datum(/datum/antagonist/devil)
		var/datum/team/devil_team/boundteam = binding_devil.get_team()
		boundteam.add_member(owner)
		objectives |= boundteam.objectives
		owner.enslave_mind_to_creator(binding_devil.owner.current)
	return ..()

	owner.current.log_message("has been soulbound by [binding_devil.owner.current]!", LOG_ATTACK, color="#960000")

/proc/is_demonicslave(mob/living/M)
	return M?.mind?.has_antag_datum(/datum/antagonist/demonic_slave)

/datum/antagonist/demonic_slave/proc/beginSlaveResurrectionCheck(mob/living/body)//other option is do them in the same check with a var set based on what you are
	if(maxHealth >= 26)
		to_chat(owner.current, "<span class='userdanger'>Your body has been damaged to the point that you may no longer use it.  At the cost of some of your power, you will return to life soon.  Remain in your body.</span>")
//		sleep(DEVILRESURRECTTIME) just not gonna sleep for now
		if (!body ||  body.stat == DEAD)
			if(binding_devil)
//				if(check_banishment(body))
//					to_chat(owner.current, "<span class='userdanger'>Unfortunately, the mortals have finished a ritual that prevents your resurrection.</span>")
//					return -1
//				else
				to_chat(owner.current, "<span class='userdanger'>You have been revived using some of your soul!</span>")
				return hellishslave_resurrection(body)
			else
				to_chat(owner.current, "<span class='userdanger'>You have no binding devil to return to and cannot revive!</span>")
				return -1
		else
			to_chat(owner.current, "<span class='danger'> You seem to have resurrected without your hellish powers.</span>")//what does this even mean/do?
	else
		to_chat(owner.current, "<span class='userdanger'>Your soul has been sapped of the last of its energy and you can no longer revive!</span>")
		return dust(FALSE, TRUE, TRUE)// I think I can just return dust proc due to being called by death, dont know if I have the args set correctly though
//need to add revival on death like devil has

/*/datum/antagonist/demonic_slave/proc/hellishslave_resurrection(mob/living/body)
	message_admins("[key_name_admin(owner)] is resurrecting using their soul.</a>")
	if(SOULVALUE < ARCH_THRESHOLD || !ascendable) // once ascended, arch devils do not go down in power by any means.
		reviveNumber += LOSS_PER_DEATH
		update_hud()
	if(body)
		body.revive(TRUE, TRUE) //Adminrevive also recovers organs, preventing someone from resurrecting without a heart.
		if(istype(body.loc, /obj/effect/dummy/phased_mob/slaughter/))
			body.forceMove(get_turf(body))//Fixes dying while jaunted leaving you permajaunted.
		if(istype(body, /mob/living/carbon/true_devil))
			var/mob/living/carbon/true_devil/D = body
			if(D.oldform)
				D.oldform.revive(1,0) // Heal the old body too, so the devil doesn't resurrect, then immediately regress into a dead body.
		if(body.stat == DEAD)
			create_new_body()
	else
		create_new_body()
	check_regression()*/