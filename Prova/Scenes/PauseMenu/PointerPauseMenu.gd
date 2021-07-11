extends Sprite

var positions = []
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	for node in get_parent().get_children():
		if node is Label and node.visible:
			positions.append(node)
	yield(get_tree().create_timer(0.1),"timeout")
	set_selection(0,true)
	visible = true
	self.set_process(false)
	
	
func set_selection(new_index,default):
	if new_index<len(positions) and new_index >= 0:
		index = new_index
		var selected_node = positions[index]
		if !default:
			$Sounds/changeOption.play()
		position = Vector2(selected_node.rect_position.x - (get_rect().size.x*scale.x)/2 - 20,(selected_node.rect_position.y)+selected_node.rect_size.y/2)
		
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		set_selection(index-1,false)
			
	elif Input.is_action_just_pressed("ui_down"):
		set_selection(index+1,false)
			
	if Input.is_action_just_pressed("ui_accept"):
		var selected_node = positions[index]
			
		if selected_node.modulate.a == 1: #1 corrisponde al 100% (canale alpha)
			$Sounds/confirmOption.play()
			selected_node.callback()
			self.set_process(false)
				
		else:
			$Sounds/rejectOption.play()
	