/obj/item/projectile/spellcard
	name = "enchanted card"
	desc = "A piece of paper enchanted to give it extreme durability and stiffness, along with edges sharp enough to slice anyone unfortunate enough to get hit by a charged one."
	icon_state = "spellcard"
	damage_type = BRUTE
	damage = 1 //monkestation edit: from 2 to 1
	projectile_piercing = PASSMOB //monkestation edit
	projectile_phasing = (ALL & (~PASSMOB)) //monkestation edit
	speed = 1.5 //monkestation edit
	var/last_hit = 0 //monkestation edit

/*/obj/item/projectile/spellcard/New(loc, spell_level)
	. = ..()
	damage += spell_level*/ //monkestation edit: insanely strong

//monkestation edit start
/obj/item/projectile/spellcard/Impact(atom/A) //can multihit
	. = ..()
	if(world.time >= last_hit + 0.3 SECONDS) //dont rapid fire hit
		impacted = list()
	last_hit = world.time
//monkestation edit end
