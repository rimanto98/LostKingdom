extends Area2D

signal in_cabinet_range

signal out_cabinet_range

var checked = false #serve ad evitare di inviare continuamente il segnale out_cabinet_range

var text 

func _ready():
	text = $Label.text

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	var player_out = true
	
	for body in bodies:
		if body.name == "Player":
			emit_signal("in_cabinet_range",text,"sign")
			checked = false
			player_out = false
			
	if (!checked) && (player_out):
		emit_signal("out_cabinet_range")
		checked = true
