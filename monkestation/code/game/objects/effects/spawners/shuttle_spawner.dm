/obj/effect/spawner/random_shuttles
	name = "random room spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_room"
	dir = NORTH
	var/room_width = 0
	var/room_height = 0

/obj/effect/spawner/random_shuttles/New(loc, ...)
	. = ..()
	if(!isnull(SSmapping.random_shuttle_spawners))
		SSmapping.random_shuttle_spawners += src

/obj/effect/spawner/random_shuttles/Initialize(mapload)
	message_admins("Entering /obj/effect/spawner/random_shuttles/Initialize()")
	..()
	if(!length(SSmapping.random_shuttle_templates))
		message_admins("Room spawner created with no templates available. This shouldn't happen.")
		return INITIALIZE_HINT_QDEL
	var/list/possible_shuttle_templates = list()
	var/datum/map_template/random_shuttles/shuttle_candidate
	shuffle_inplace(SSmapping.random_shuttle_templates)
	for(var/ID in SSmapping.random_shuttle_templates)
		shuttle_candidate = SSmapping.random_shuttle_templates[ID]
		if(shuttle_candidate.weight == 0 || room_height != shuttle_candidate.template_height || room_width != shuttle_candidate.template_width)
			shuttle_candidate = null
			continue
		possible_shuttle_templates[shuttle_candidate] = shuttle_candidate.weight
	if(possible_shuttle_templates.len)
		message_admins("[possible_shuttle_templates.len]")
		var/datum/map_template/random_shuttles/template = pickweight(possible_shuttle_templates)
		template.load(get_turf(src), centered = template.centerspawner)
		message_admins("Exiting /obj/effect/spawner/random_shuttles/Initialize() template load")
	return INITIALIZE_HINT_QDEL

/// Wizard maze shuttle spawner
/obj/effect/spawner/random_shuttles/wizmaze
	name = "wizards maze spawner"
	room_width = 3
	room_height = 3





