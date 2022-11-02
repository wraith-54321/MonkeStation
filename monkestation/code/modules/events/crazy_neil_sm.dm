/datum/round_event_control/crazy_neil_sm
	name = "Crazy Neils Discount Supermatters"
	typepath = /datum/round_event/crazy_neil_sm
	max_occurrences = 1
	weight = 10
	min_players = 20

/datum/round_event/crazy_neil_sm/start()
	start_crazy_sm()

/proc/start_crazy_sm()
	var/initial_send_time = world.time
	var/payoff = 20000
	var/order_number = rand(1, 100000)
	priority_announce("Incoming subspace communication. Secure channel opened at all communication consoles.", "Incoming Message", SSstation.announcer.get_rand_report_sound())
	var/datum/comm_message/confirm_order = new

	confirm_order.title = "Confirm Order [order_number]"
	confirm_order.content = "This is Crazy Neil's discount supermatters calling to confirm your order of (1) spicy supermatter(s). The cancellation fee is [payoff]."
	confirm_order.possible_answers = list("Cancel Order.", "Confirm Order.")
	confirm_order.answer_callback = CALLBACK(GLOBAL_PROC, .proc/crazy_neil_answered, confirm_order, payoff, initial_send_time, order_number)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/send_spicy_crystal, confirm_order, order_number, FALSE), 2 MINUTES)
	SScommunications.send_message(confirm_order, unique = TRUE)

/proc/crazy_neil_answered(datum/comm_message/confirm_order, payoff, initial_send_time, order_number, var/response_max_time = 2 MINUTES)
	if(world.time > initial_send_time + response_max_time)
		priority_announce("Order [order_number] has already shipped.",sender_override = "Crazy Neils Discount Supermatters")
		return
	if(confirm_order && confirm_order.answered == TRUE)
		var/datum/bank_account/budget = SSeconomy.get_dep_account(ACCOUNT_CAR)
		if(budget)
			if(budget.adjust_money(-payoff))
				priority_announce("Why would you make an order and then cancel it?",sender_override = "Crazy Neils Discount Supermatters")
				return
			else
				priority_announce("Sorry, this does not cover order cancel costs, we will not be stopping the order pod.",sender_override = "Crazy Neils Discount Supermatters")
				send_spicy_crystal(confirm_order, order_number, TRUE)

/proc/send_spicy_crystal(datum/comm_message/confirm_order, order_number, skip_answer_check)
	if(!skip_answer_check && confirm_order?.answered == 1)
		return

	var/turf/drop_loc = find_safe_turf()//if they dont pay it should do some damage
	var/obj/machinery/power/supermatter_crystal/shard/engine/spicymatter = new(drop_loc)
	var/obj/structure/closet/supplypod/car_pod/pod = new()
	new /obj/effect/pod_landingzone(drop_loc, pod)
	spicymatter.matter_power += 3000
	spicymatter.name = "The Spicy Matter"
	priority_announce("Order [order_number] has shipped.",sender_override = "Crazy Neils Discount Supermatters")
	notify_ghosts("Crazy Neil has an object of interest: [spicymatter]!", source=spicymatter, action=NOTIFY_ORBIT, header="Something's Interesting!")

	message_admins("[ADMIN_LOOKUPFLW(spicymatter)] has been spawned by crazy neils supermatters")
