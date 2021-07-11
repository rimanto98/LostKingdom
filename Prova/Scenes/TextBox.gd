extends NinePatchRect

signal dialog_finished

var selected_position = 0

func _ready():
	$Pointer.position.x = 737
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	yield(get_tree(),"idle_frame")	#attende 1 frame per evitare conflitti tra gli input
	
	if Input.is_action_just_released("ui_accept") && selected_position == 1:
		if $Pointer.visible:
			$Sounds/reject.play()
		emit_signal("dialog_finished")
		hide()	
		set_process(false)
		
	elif Input.is_action_just_released("ui_accept") && selected_position == 0:
		if $Pointer.visible:
			$Sounds/confirm.play()
			if name == "TextBox1":
				$"/root/Global".inMinigame = true
				$"/root/Global".unlockM1 = true
				var fade_class = load("res://Scenes/Fade/Fade.tscn")
				get_parent().add_child(fade_class.instance())
				yield(get_tree().create_timer(0.7),"timeout")
				SceneManager.goto_scene("res://Scenes/Minigame1/MenuMinigame3D/Menu.tscn")
			else:
				$"/root/Global".unlockM2 = true
				$"/root/Global".inMinigame = true
				var fade_class = load("res://Scenes/Fade/Fade.tscn")
				get_parent().add_child(fade_class.instance())
				yield(get_tree().create_timer(0.7),"timeout")
				SceneManager.goto_scene("res://Scenes/Minigame2/Menu/Menu.tscn")
		emit_signal("dialog_finished")
		hide()	
		set_process(false)
	

func _on_Player_view_cabinet_text(text,string):
	$Label.text = text
	if string == "sign":
		$Pointer.hide()
	else:
		$Pointer.show()
	show()
	set_process(true)


func _on_Cabinet_change_selection(left):
	if left:
		selected_position = 0
		$Pointer.position.x = 737
	
	else:
		selected_position = 1
		$Pointer.position.x = 957
