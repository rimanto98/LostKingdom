extends Control

var enter_node

var reading_guide = false

func _ready():
	pass

func _input(event):
	if  Input.is_action_just_released("ui_cancel")&& not reading_guide:
		changePauseState()

func changePauseState():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	if(visible):
		$ColorRect/MarginContainer/VBoxContainer/MenuEntries/Pointer.set_process(true)
	else:
		$ColorRect/MarginContainer/VBoxContainer/MenuEntries/Pointer.set_process(false)




func _on_Guide_guide(state):
	reading_guide = state
