extends Area2D

signal in_cabinet_range

signal out_cabinet_range

var checked = false #serve ad evitare di inviare continuamente il segnale out_cabinet_range

var text = "Do you want to play?       Yes     No"

var left = true

var reading = 0 #se reading è dispari allora il giocatore sta leggendo

signal change_selection

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	var player_out = true
	
	for body in bodies:
		if body.name == "Player":
			emit_signal("in_cabinet_range",text,"cabinet")
			checked = false
			player_out = false
			if Input.is_key_pressed(KEY_RIGHT) && left && reading%2 != 0:
				left = false
				$changeOption.play()
				emit_signal("change_selection",left)
				
			elif Input.is_key_pressed(KEY_LEFT) && !left && reading%2 != 0:
				left = true
				$changeOption.play()
				emit_signal("change_selection",left)
			
	if (!checked) && (player_out):
		emit_signal("out_cabinet_range")
		checked = true

func _on_Player_view_cabinet_text(text,string):
	reading += 1
