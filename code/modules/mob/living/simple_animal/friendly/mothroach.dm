/mob/living/simple_animal/mothroach
	name = "mothroach"
	desc = "An ancient ancestor of the moth that surprisingly looks like the crossbreed of a moth and a cockroach."

	icon_state = "mothroach"
	icon_living = "mothroach"
	icon_dead = "mothroach_dead"
	held_state = "mothroach"
	held_lh = 'icons/mob/pets_held_lh.dmi'
	held_rh = 'icons/mob/pets_held_rh.dmi'
	head_icon = 'icons/mob/pets_held.dmi'

	butcher_results = list(/obj/item/food/meat/slab/mothroach = 3, /obj/item/stack/sheet/animalhide/mothroach = 1)
	gold_core_spawnable = FRIENDLY_SPAWN
	density = TRUE
	mob_biotypes = list(MOB_ORGANIC, MOB_BUG)
	mob_size = MOB_SIZE_SMALL
	mobility_flags = MOBILITY_FLAGS_DEFAULT
	can_be_held = TRUE
	worn_slot_flags = ITEM_SLOT_HEAD
	ventcrawler = VENTCRAWLER_ALWAYS
	gold_core_spawnable = FRIENDLY_SPAWN

	health = 25
	maxHealth = 25
	speed = 1.25

	verb_say = "flutters"
	verb_ask = "flutters inquisitively"
	verb_exclaim = "flutters loudly"
	verb_yell = "flutters loudly"
	response_help = "pets"
	attacked_sound = null

	faction = list("neutral")

	ai_controller = /datum/ai_controller/basic_controller/mothroach

/mob/living/simple_animal/mothroach/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if(resting)
		icon_state = "mothroach_rest"
	else
		icon_state = "mothroach"
	regenerate_icons()

/mob/living/simple_animal/mothroach/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(src.stat == DEAD)
		return
	else
		playsound(loc, 'sound/voice/moth/scream_moth.ogg', 50, TRUE)

/mob/living/simple_animal/mothroach/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(src.stat == DEAD)
		return
	else
		playsound(loc, 'sound/voice/moth/scream_moth.ogg', 50, TRUE)

/datum/ai_controller/basic_controller/mothroach
	blackboard = list()

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/mothroach,
	)
