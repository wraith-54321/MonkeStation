/datum/objective/devil

/datum/objective/devil/soulquantity
	explanation_text = "You shouldn't see this text.  Error:DEVIL1"
	target_amount = 4

/datum/objective/devil/soulquantity/New()
	target_amount = pick(4,5,6)
	update_explanation_text()

/datum/objective/devil/soulquantity/update_explanation_text()
	explanation_text = "Purchase, and retain control over at least [target_amount] souls."

/datum/objective/devil/soulquantity/check_completion()
	var/count = 0
	var/datum/antagonist/devil/devilDatum = owner.has_antag_datum(/datum/antagonist/devil)
	var/list/souls = devilDatum.soulsOwned
	for(var/S in souls) //Just a sanity check.
		var/datum/mind/L = S
		if(L.soulOwner == owner)
			count++
	return (count >= target_amount) || ..()



/datum/objective/devil/sintouch
	explanation_text = "You shouldn't see this text.  Error:DEVIL3"

/datum/objective/devil/sintouch/New()
	target_amount = pick(4,5)
	explanation_text = "Ensure at least [target_amount] mortals are sintouched."

/datum/objective/devil/sintouch/check_completion()
	var/list/touched = get_antag_minds(/datum/antagonist/sintouched)
	return (touched.len >= target_amount) || ..()



/datum/objective/devil/outsell
	explanation_text = "You shouldn't see this text.  Error:DEVIL5"

/datum/objective/devil/outsell/New()

/datum/objective/devil/outsell/update_explanation_text()
	var/datum/antagonist/devil/opponent = target.has_antag_datum(/datum/antagonist/devil)
	explanation_text = "Purchase and retain control over more souls than [opponent.truename], known to mortals as [target.name], the [target.assigned_role]."

/datum/objective/devil/outsell/check_completion()
	var/selfcount = 0
	var/datum/antagonist/devil/devilDatum = owner.has_antag_datum(/datum/antagonist/devil)
	var/list/souls = devilDatum.soulsOwned
	for(var/S in souls)
		var/datum/mind/L = S
		if(L.soulOwner == owner)
			selfcount++
	var/targetcount = 0
	devilDatum = target.has_antag_datum(/datum/antagonist/devil)
	souls = devilDatum.soulsOwned
	for(var/S in souls)
		var/datum/mind/L = S
		if(L.soulOwner == target)
			targetcount++
	return (selfcount > targetcount) || ..()



datum/objective/devil_team/acension
	name = "acend"
	explanation_text = "Collect the souls needed to open a portal to hell then protect it to reach devilic acension before the other devils and their slaves on the station."

datum/objective/devil_team/acension/check_completion()
	var/datum/team/devil_team/teamacend
	return teamacend.team_acended || ..()