extends Area

var hitstun = 30

func _process(delta):
	var found = false
	
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if "Ball" in body.name:
			pass
			#var knockDir = transform.origin - body.transform.origin
			#get_parent().hit(knockDir,hitstun)
			#body.hit(-knockDir,hitstun)