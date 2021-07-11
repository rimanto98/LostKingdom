extends Area2D


var hit = false
var avviato = false

func _physics_process(delta):
	
	if hit and avviato:
		$ActiveTime.start()
		hit = false
			
	if $ActiveTime.time_left == 0:
		hit = false	
		avviato = false
	
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name and !hit and !avviato and not get_parent().invincible:
			body._on_HitBox_player_hit()
			hit = true
			avviato = true