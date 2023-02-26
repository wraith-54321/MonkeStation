/obj/effect/proc_holder/spell/aoe_turf/conjure/spacetime_portal
	name = "Space Time Portal"
	desc = "Opens a rip in space time allowing various hostile beings to come to the station."
	invocation = "RI PN TEAR"
	action_icon = 'icons/mob/nest.dmi'
	action_icon_state = "nether"
	invocation_type = "shout"
	charge_max = 120 SECONDS
	cooldown_min = 40 SECONDS
	range = 2

	summon_type = list(/obj/structure/spawner/nether, /obj/structure/spawner/clown, /obj/structure/spawner/mining, /obj/structure/spawner/skeleton, /obj/structure/spawner/syndicate)

	summon_lifespan = 600 SECONDS//10 minutes just to be safe

/obj/effect/proc_holder/spell/aoe_turf/conjure/spacetime_portal/badmin//admin only version of the spell for when you want to cause some chaos
	name = "space time portals"
	desc = "Makes a large amount of rips in space time, go wild!"
	summon_amt = 5
