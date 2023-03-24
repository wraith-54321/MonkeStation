GLOBAL_VAR_INIT(random_chem_recipes, FALSE)
GLOBAL_LIST_EMPTY(random_chem_recipe_results)

/datum/round_event_control/wizard/random_chem_recipes //while active all chem recipes will choose another recipe to swap results with
	name = "Random Chemical Recipes"
	weight = 2
	max_occurrences = 2
	earliest_start = 0 MINUTES
	typepath = /datum/round_event/wizard/random_chem_recipes

/datum/round_event/wizard/random_chem_recipes
	startWhen = 1
	endWhen = 300 //10 minutes

/datum/round_event/wizard/random_chem_recipes/start()
//	generate_random_chem_results()
/*	if(!GLOB.random_chem_recipe_results.len) //only call the proc once per round
		if(!generate_random_chem_results()) //dont want to be using the random results if they fail to generate
			end()
			kill() //if it fails to generate no point in having it be running
			return*/
	GLOB.random_chem_recipes = TRUE

/datum/round_event/wizard/random_chem_recipes/end()
	GLOB.random_chem_recipes = FALSE

/*/proc/chemtypesdebug()
	message_admins("chems[english_list(GLOB.chemical_reactions_list_product_index)]")

/proc/generate_random_chem_results() //generates the list of reagents and their new results
	message_admins("Generating random chem results.")
	var/list/shuffled_results = list()
//	var/one = 1
	for(var/reaction in GLOB.chemical_reactions_list)
		message_admins("TEST[reaction]")
		var/datum/chemical_reaction/current_reaction = reaction
		message_admins("TESTEEEEE[current_reaction]")
/*		if(one == 1)
			message_admins("BHrgifsbhiufjdsb")
			one++
			continue*/
		var/datum/chemical_reaction/er = /datum/chemical_reaction/drink/goldschlager
		message_admins("RESULTS[english_list(current_reaction.results)] [english_list(er.results)]")
		if(istype(reaction, /datum/chemical_reaction/drink)) //it fails to read the drink results so a len check runtimes
			message_admins("AHHHHHHHHHHHHHHHHHHHHHHHHHH")
			continue
		if(!current_reaction.results.len)
			message_admins("TESTCONTINUE")
			continue
		message_admins("TEST1")
		if(!GLOB.random_chem_recipe_results[current_reaction]) //make sure it can have its results added later
			GLOB.random_chem_recipe_results[current_reaction] = list()
			message_admins("TEST2")
		shuffled_results += current_reaction.results
		message_admins("TEST3")

//	shuffle_inplace(shuffled_results)
	message_admins("TEST4")
	for(var/reaction_type in GLOB.random_chem_recipe_results)
		message_admins("TEST5")
		reaction_type += pick_n_take(shuffled_results)

/*	if(!GLOB.random_chem_recipe_results == subtypesof(/datum/chemical_reaction)) //if these two are not the same something went wrong with creation
		message_admins("TESTERROR")
		GLOB.random_chem_recipe_results = list()
		CRASH("Random reagent result list length different from subtypesof /datum/chemical_reaction.")*/
	message_admins("TEST6")
	return TRUE */
