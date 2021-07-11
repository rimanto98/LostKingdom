extends Control

var started = false

func _process(delta):
	if !started:
		started = true
		#$Timer.start()
		#$Audio.play()
		
	elif $Timer.time_left == 0 && $Label.text == "3":
		$Label.text = "2"
		$Timer.start()
	
	elif $Timer.time_left == 0 && $Label.text == "2":
		$Label.text = "1"
		$Timer.start()
		
	elif $Timer.time_left == 0 && $Label.text == "1":
		$Label.rect_position.x -= 250
		$Label.text = "START"
		$Timer.start()
		
	elif $Timer.time_left == 0 && $Label.text == "START":
		self.hide()
		self.set_process(false)