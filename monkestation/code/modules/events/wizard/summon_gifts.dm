/datum/round_event_control/wizard/summon_gifts
	name = "Gifts For Everyone!"
	weight = 3
	max_occurrences = 2
	earliest_start = 0 MINUTES
	typepath = /datum/round_event/wizard/summon_gifts //why no work, maybe localhost

/datum/round_event/wizard/summon_gifts/start() //what it says on the tin
	message_admins("GIFTS")
	for(var/mob/living/carbon/gifted_mob in GLOB.mob_living_list) //sentient monkeys get gifts too!
		message_admins("GIFTS1")
		message_admins("GIFTSME[gifted_mob]")
		if(gifted_mob.mind && !(gifted_mob.stat == DEAD)) //as funny as it would be the dead dont get gifts
			message_admins("GIFTS2")
			var/obj/item/a_gift/anything/wiz_name/gift = new
			if(!gifted_mob.put_in_hands(gift))
				message_admins("GIFTS3")
				gifted_mob.dropItemToGround(gift)
			playsound(get_turf(gifted_mob),'sound/magic/summon_guns.ogg', 50, 1)

/obj/item/a_gift/anything/wiz_name
	name = "Mysterious Gift" //these are not chrimstmas gifts and should not be named as such
