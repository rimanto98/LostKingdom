extends RigidBody2D

var started = false



func _physics_process(delta):
	
	if self.get_colliding_bodies() and $BeforeExplosion.time_left == 0 and !started:
		$BeforeExplosion.start()
		started = true
		
	elif self.get_colliding_bodies() and $BeforeExplosion.time_left == 0 and started:
		var explosion_scene = load("res://Entities/Bomb/Explosion.tscn")
		var explosion_node = explosion_scene.instance()
		explosion_node.position = self.position
		get_node("/root/Game").add_child(explosion_node)
		self.queue_free()
		started = false
		
