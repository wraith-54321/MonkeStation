/datum/map_template/random_shuttles
	var/room_id //The SSmapping random_room_template list is ordered by this var
	var/spawned //Whether this template (on the random_room template list) has been spawned
	var/shuttle_name = ""
	var/centerspawner = TRUE
	var/template_height = 0
	var/template_width = 0
	var/weight = 10 //weight a room has to appear
	var/stock = 1 //how many times this room can appear in a round

/** EXAMPLE OF WEIGHT CHANCES:
 * Given the following list:
 * A = 6, B = 3, C = 1, D = 0
 * A would have a 60% chance of being picked,
 * B would have a 30% chance of being picked,
 * C would have a 10% chance of being picked,
 * and D would have a 0% chance of being picked.
 * You should only pass integers in.
*/

// Wizards Maze Rooms
/datum/map_template/random_shuttles/wizmaze1
	name = "Wizard Maze Shuttle Room 1"
	room_id = "wizmaze_evac_1"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle1.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"//might not be needed but keeping for now

/datum/map_template/random_shuttles/wizmaze2
	name = "Wizard Maze Shuttle Room 2"
	room_id = "wizmaze_evac_2"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle2.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze3
	name = "Wizard Maze Shuttle Room 3"
	room_id = "wizmaze_evac_3"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle3.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze4
	name = "Wizard Maze Shuttle Room 4"
	room_id = "wizmaze_evac_4"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle4.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze5
	name = "Wizard Maze Shuttle Room 5"
	room_id = "wizmaze_evac_5"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle5.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze6
	name = "Wizard Maze Shuttle Room 6"
	room_id = "wizmaze_evac_6"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle6.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze7
	name = "Wizard Maze Shuttle Room 7"
	room_id = "wizmaze_evac_7"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle7.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze8
	name = "Wizard Maze Shuttle Room 8"
	room_id = "wizmaze_evac_8"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle8.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze9
	name = "Wizard Maze Shuttle Room 9"
	room_id = "wizmaze_evac_9"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle9.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze10
	name = "Wizard Maze Shuttle Room 10"
	room_id = "wizmaze_evac_10"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle10.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze11
	name = "Wizard Maze Shuttle Room 11"
	room_id = "wizmaze_evac_11"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle11.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze12
	name = "Wizard Maze Shuttle Room 12"
	room_id = "wizmaze_evac_12"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle12.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze13
	name = "Wizard Maze Shuttle Room 13"
	room_id = "wizmaze_evac_13"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle13.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze14
	name = "Wizard Maze Shuttle Room 14"
	room_id = "wizmaze_evac_14"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle14.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze15
	name = "Wizard Maze Shuttle Room 15"
	room_id = "wizmaze_evac_15"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle15.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

/datum/map_template/random_shuttles/wizmaze16
	name = "Wizard Maze Shuttle Room 16"
	room_id = "wizmaze_evac_16"
	mappath = "monkestation/_maps/RandomRooms/_Shuttles/Wizardmaze/wizmaze_shuttle16.dmm"
	centerspawner = FALSE
	template_height = 3
	template_width = 3
	weight = 1
	shuttle_name = "Wizards Maze"

