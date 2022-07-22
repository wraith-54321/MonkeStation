/obj/item/clothing/shoes/yes_slip
	name = "Yes-Slip Shoes"
	desc = "A pair of very slippery sneakers that even slide out of your view."
	icon = 'monkestation/icons/obj/clothing/shoes.dmi'
	worn_icon = 'monkestation/icons/mob/feet.dmi'
	icon_state = "yesslip"
	var/next_slip
	var/less_slip = FALSE

/obj/item/clothing/shoes/yes_slip/step_action()
	. = ..()
	if(next_slip <= world.time)
		var/mob/living/carbon/wearer = loc
		var/turf/location = get_turf(wearer)
		to_chat(wearer, "<span class='clowntext'>[pick("You slip flat on your face!", "Your shoes send you flying!", "An invisible leg of the Honkmother trips you!")]</span>")
		playsound(loc, 'sound/effects/laughtrack.ogg', 50, 1, -1)
		if(less_slip)
			location.handle_slip(wearer, 2 SECONDS)
			next_slip = world.time + rand(5,10) SECONDS //so as to make the devil version not TOO annoying
		else
			location.handle_slip(wearer, 2 SECONDS)
			next_slip = world.time + rand(1,5) SECONDS

/obj/item/clothing/shoes/yes_slip/devil
	resistance_flags = FIRE_PROOF | ACID_PROOF
	less_slip = TRUE
