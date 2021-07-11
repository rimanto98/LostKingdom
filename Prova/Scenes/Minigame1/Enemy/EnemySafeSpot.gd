extends Area

signal rest

var checked = false #per evitare di inviare il segnale continuamente

func _process(delta):
	var found = false
	
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if "Enemy" in body.name:
			emit_signal("rest",true)
			found = true
			checked = false
			
	if !found && !checked:
		emit_signal("rest",false)
		checked = true
