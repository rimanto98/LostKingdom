extends Area2D

signal increase_bombs

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			emit_signal("increase_bombs")
			self.queue_free()