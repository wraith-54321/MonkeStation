/obj/item/storage/backpack/duffelbag/cursed //PORTED FROM TG
	name = "living duffel bag"
	desc = "A cursed clown duffel bag that hungers for food of any kind. A warning label suggests that it eats food inside. \
		If that food happens to be a horribly ruined mess or the chef scrapped out of the microwave, or poisoned in some way, \
		then it might have negative effects on the bag..."
	icon = 'monkestation/icons/obj/storage/storage.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/back.dmi'
	icon_state = "duffel-curse"
	item_state = "duffel-curse"
	worn_icon_state = "duffel-curse"
	slowdown = 2
	max_integrity = 100

/obj/item/storage/backpack/duffelbag/cursed/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/curse_of_hunger, add_dropdel = TRUE)

