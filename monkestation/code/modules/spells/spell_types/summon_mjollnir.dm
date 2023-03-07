/obj/effect/proc_holder/spell/targeted/conjure_item/summon_mjollnir
	name = "Summon Mjollnir"
	desc = "Summons the mighty Mjollnir to you for a limited time."
	invocation_type = "shout"
	invocation = "I HAV TH POWR"
	clothes_req = FALSE
	charge_max = 40 SECONDS//65
	level_max = 0
	item_type = /obj/item/mjollnir
	action_icon = 'icons/obj/items_and_weapons.dmi'
	action_icon_state = "mjollnir0"

/obj/effect/proc_holder/spell/targeted/conjure_item/summon_mjollnir/after_cast(list/targets, user = usr)
	if(item)
		var/obj/item/mjollnir/hammer = item
		hammer.summoned = TRUE
		hammer.owner = user
		QDEL_IN(hammer, 40 SECONDS)//25
