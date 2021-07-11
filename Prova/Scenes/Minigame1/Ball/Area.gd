extends Area

var hitstun = 30
var input_vector= Vector3.ZERO

func _process(delta):
	if Input.get_action_strength("ui_left")-Input.get_action_strength("ui_right") != 0 or Input.get_action_strength("ui_up")-Input.get_action_strength("ui_down") != 0:
		input_vector.x = Input.get_action_strength("ui_left")-Input.get_action_strength("ui_right")
		input_vector.z = Input.get_action_strength("ui_up")-Input.get_action_strength("ui_down")
		
	checkInputP2()
		
	var found = false
	if get_parent().hitstun == 0:
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if "Enemy" in body.name or "Ball2" in body.name:
				var knockDir = transform.origin - body.transform.origin
				knockDir = knockDir*40
				get_parent().hit(knockDir,hitstun)
				body.hit(-knockDir,hitstun)
				$Bounce.play()
				#print("1")
				$Timer.start()
	
	if $Timer.time_left == 0 &&  get_parent().hitstun != 0: #correggo il tiro se la direzione è sbagliata (bugfix)
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if "Enemy" in body.name or "Ball2" in body.name:
				var knockDir = input_vector*400
				#print("2")
				get_parent().hit(-knockDir,hitstun)
				body.hit(knockDir,hitstun)
				if !$Bounce.playing:
					$Bounce.play()
				$Timer.start()
				
				
func checkInputP2():
	if Input.is_key_pressed(KEY_J):
		input_vector.x = -1
	elif  Input.is_key_pressed(KEY_L):
		input_vector.x = 1
		
	if Input.is_key_pressed(KEY_I):
		input_vector.y = 1
	elif Input.is_key_pressed(KEY_K):
		input_vector.y = -1
			
			