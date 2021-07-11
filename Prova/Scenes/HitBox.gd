extends Area2D

signal player_hit

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && Global.lives > 0:
			emit_signal("player_hit")

	
		
