extends Area2D

signal enemy_death

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			if not body.invincible && Global.lives > 0:
				emit_signal("enemy_death")
				body.velocity.y = -500
