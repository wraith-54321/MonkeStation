/obj/item/clothing/shoes/yes_slip
	name = "Yes-Slip Shoes"
	desc = "A pair of very slippery sneakers that even slide out of your view."
	icon = 'monkestation/icons/obj/clothing/shoes.dmi'
	worn_icon = 'monkestation/icons/mob/feet.dmi'
	icon_state = "yesslip"
	var/next_slip
	var/slip_length = 2 SECONDS
	var/next_slip_min = 1
	var/next_slip_max = 5

/obj/item/clothing/shoes/yes_slip/step_action()
	. = ..()
	if(next_slip <= world.time)
		var/mob/living/carbon/wearer = loc
		var/turf/location = get_turf(wearer)
		to_chat(wearer, "<span class='clowntext'>[pick("You slip flat on your face!", "Your shoes send you flying!", "An invisible leg of the Honkmother trips you!")]</span>")
		playsound(loc, 'sound/effects/laughtrack.ogg', 50, 1, -1)
		location.handle_slip(wearer, src.slip_length)
		next_slip = world.time + rand(src.next_slip_min,src.next_slip_max) SECONDS


/obj/item/clothing/shoes/yes_slip/devil
	resistance_flags = FIRE_PROOF | ACID_PROOF
	next_slip_min = 5
	next_slip_max = 10//so as to make the devil version not TOO annoying
