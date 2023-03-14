/obj/effect/proc_holder/spell/targeted/mind_transfer
	name = "Mind Swap"
	desc = "This spell will randomly swap the minds of everyone around you, yourself included."

	school = "transmutation"
	charge_max = 180 SECONDS //monkestation edit: from 60 seconds to 3 minutes
	clothes_req = FALSE
	invocation = "GIN'YU CAPAN"
	invocation_type = "whisper"
	range = 3 //monkestation edit: from 1 to 3
	cooldown_min = 60 SECONDS //monkestation edit: from 20 seconds to 60
	var/unconscious_amount = 20 SECONDS //monkestation edit: how long to knock out the hit people by mindswap
	max_targets = 0 //monkestation edit
	include_user = TRUE //monkestation edit
	var/made_false_wizard = FALSE //monkestation edit: has the spell made a fake wizard yet, I would like to do this by tracking the wizard's starting mob but I feel that would need snowflakes

	action_icon_state = "mindswap"

/obj/effect/proc_holder/spell/targeted/mind_transfer/badmin //monkestation edit: massive range, people will have no idea whats going on
	name = "Greater Mind Swap"
	desc = "This spell will randomly swap the minds of everyone around you in a huge area, yourself included."
	range = 12

/*
Urist: I don't feel like figuring out how you store object spells so I'm leaving this for you to do.
Make sure spells that are removed from spell_list are actually removed and deleted when mind transferring.
Also, you never added distance checking after target is selected. I've went ahead and did that.
*/
/obj/effect/proc_holder/spell/targeted/mind_transfer/cast(list/targets, mob/living/user = usr, distanceoverride, silent = FALSE) //monkestation edit: reworks the spell to be a random AOE swap
	if(!targets.len)
		if(!silent)
			to_chat(user, "<span class='warning'>No minds found!</span>")
		return

	if(user.suiciding)
		if(!silent)
			to_chat(user, "<span class='warning'>You're killing yourself! You can't concentrate enough to do this!</span>")
		return

//monkestation edit start
	var/list/valid_targets = list()
	for(var/mob/living/possible_target in targets) //remove mobs we dont want swapping to happen with
		if(ismegafauna(possible_target))
			continue

		if(possible_target.stat == DEAD)
			continue

		if(!possible_target.key || !possible_target.mind)
			continue

		if(istype(possible_target.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/foilhat))
			to_chat(possible_target, "<span class='warning'>Your protective headgear successfully deflects mind controlling brainwaves!</span>")
			continue

		if(istype(possible_target, /mob/living/simple_animal/slaughter) || istype(possible_target, /mob/living/simple_animal/hostile/guardian))
			continue

		if(!possible_target == user)
			var/datum/mind/possible_mind = possible_target.mind
			if(possible_target.anti_magic_check() || possible_mind.has_antag_datum(/datum/antagonist/wizard) || possible_mind.has_antag_datum(/datum/antagonist/cult) || possible_mind.has_antag_datum(/datum/antagonist/changeling))
				continue

		valid_targets += possible_target

	var/list/swap_mobs = list() //all mobs getting swapped
	var/list/swap_ghosts = list() //the ghosts of the swapped mobs
	var/mob/living/wizard_body //what body to check for entering with fake wizard creation
	var/datum/mind/wizard_mind //who to bind the fake wizard to
	for(var/mob/living/current_target in valid_targets)
		if(current_target.mind.has_antag_datum(/datum/antagonist/wizard) && ishuman(current_target) && !(made_false_wizard)) //make a fake wizard if swapping with the original body
			wizard_body = current_target
			wizard_mind = current_target.mind
		var/mob/dead/observer/ghost = current_target.ghostize(0)
		swap_mobs += current_target
		swap_ghosts += ghost

	if(!swap_ghosts.len == swap_mobs.len)
		CRASH("Mindswap Mob count not equal to ghost count.")

	cycle_inplace(swap_mobs)

	for(var/i=1, i <= swap_mobs.len, ++i)
		var/mob/living/current_mob = swap_mobs[i]
		var/mob/dead/observer/current_ghost = swap_ghosts[i]
		current_ghost.mind.transfer_to(current_mob)
		if(current_mob == wizard_body && !(made_false_wizard))
			make_fake_wizard(wizard_body, wizard_mind)
			made_false_wizard = TRUE

		if(current_ghost.key)
			current_mob.key = current_ghost.key	//have to transfer the key since the mind was not active
		qdel(current_ghost)

		current_mob.Sleeping(unconscious_amount)
		SEND_SOUND(current_mob, sound('sound/magic/mandswap.ogg'))
	return TRUE

/obj/effect/proc_holder/spell/targeted/mind_transfer/proc/make_fake_wizard(var/mob/living/imposter_mob, var/datum/mind/wizard_mind) //for making the fake wizard
	var/datum/antagonist/wizard/master = wizard_mind.has_antag_datum(/datum/antagonist/wizard)
	if(!master.wiz_team)
		master.create_wiz_team()
	var/datum/antagonist/wizard/apprentice/imposter/imposter = new()
	imposter.master = wizard_mind
	imposter.wiz_team = master.wiz_team
	master.wiz_team.add_member(imposter)
	imposter_mob.mind.add_antag_datum(imposter)
	SSticker.mode.apprentices += imposter_mob.mind
	imposter_mob.mind.special_role = "imposter"

	SEND_SOUND(imposter_mob, sound('sound/effects/magic.ogg')) //I want to replace this with the sus SFX so badly
//monkestation edit end
