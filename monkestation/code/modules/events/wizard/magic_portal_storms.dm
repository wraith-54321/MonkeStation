/datum/round_event_control/greater_summon_apes
	name = "Greater Summon Apes"
	typepath = /datum/round_event/portal_storm/greater_summon_apes
	weight = 1
	max_occurrences = 1
	earliest_start = 0 MINUTES
	wizardevent = TRUE

/datum/round_event/portal_storm/greater_summon_apes //monke
	boss_types = list(/mob/living/simple_animal/hostile/gorilla = 4, /mob/living/carbon/monkey/angry/armed/boss = 2)
	hostile_types = list(/mob/living/carbon/monkey/angry/armed = 2, /mob/living/carbon/monkey/angry/armed/gun = 4, /mob/living/carbon/monkey/angry/armed/melee = 4)

/datum/round_event/portal_storm/greater_summon_apes/announce()
	set waitfor = 0
	sound_to_playing_players('sound/magic/lightning_chargeup.ogg')
	sleep(80)
	priority_announce("Monke.", "Monke Update", sound = 'sound/creatures/monkey/monkey_screech_1.ogg')
	sleep(20)
	sound_to_playing_players('sound/magic/lightningbolt.ogg')

/datum/round_event_control/summon_clowns
	name = "Clown Storm"
	typepath = /datum/round_event/portal_storm/clown_storm
	weight = 1
	max_occurrences = 1
	earliest_start = 0 MINUTES
	wizardevent = TRUE

/datum/round_event/portal_storm/clown_storm //HONK
	boss_types = list(/mob/living/simple_animal/hostile/retaliate/clown/clownhulk/chlown = 2, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk/honcmunculus = 1,
					  /mob/living/simple_animal/hostile/retaliate/clown/clownhulk/destroyer = 1, /mob/living/simple_animal/hostile/retaliate/clown/clownhulk = 1)

	hostile_types = list(/mob/living/simple_animal/hostile/retaliate/clown = 18, /mob/living/simple_animal/hostile/retaliate/clown/mutant = 2,
						 /mob/living/simple_animal/hostile/retaliate/clown/lube = 2, /mob/living/simple_animal/hostile/retaliate/clown/fleshclown = 2,
						 /mob/living/simple_animal/hostile/retaliate/clown/longface = 2, /mob/living/simple_animal/hostile/retaliate/clown/honkling = 2,
						 /mob/living/simple_animal/hostile/retaliate/clown/banana = 2)

/datum/round_event/portal_storm/announce()
	set waitfor = 0
	sound_to_playing_players('sound/magic/lightning_chargeup.ogg')
	sleep(80)
	priority_announce("The intern \"hit the clown button.\"", sound = SSstation.announcer.get_rand_alert_sound())
	sleep(20)
	sound_to_playing_players('sound/magic/lightningbolt.ogg')
