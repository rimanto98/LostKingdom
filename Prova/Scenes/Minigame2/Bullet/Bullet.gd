extends RigidBody2D
 
func _ready():
	pass # Replace with function body.

func _process(delta):
	if self.global_position.y < -10:
		self.queue_free()
		
		
func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		self.queue_free()
		body.gotHit()
		#print(body.name)

	elif "Bullet" in body.name:
		self.queue_free()