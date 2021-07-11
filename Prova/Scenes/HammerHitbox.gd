extends Area2D

var hit = false
var avviato = false

func _physics_process(delta):
	
	if hit and avviato:
		$ActiveHammerHitbox.start()
		hit = false
			
	if $ActiveHammerHitbox.time_left == 0:
		hit = false	
		avviato = false
	
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Enemy" in body.name and !hit and !avviato:
			body._on_HurtBox_enemy_death()
			hit = true
			avviato = true