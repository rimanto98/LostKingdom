extends TextureRect

var reserves = 0
var timerNode

func _ready():
	timerNode = get_node("/root/SpaceInvadersAI/ActiveAi")

func _on_SpaceInvadersAI_reserveChange(change):
	if change:
		reserves += 1
		
	else:
		reserves -= 1
		
	$Label2.text = str(reserves)
	
	
func _physics_process(delta):
	if $Label4.visible:
		$Label4.text = str(int(timerNode.time_left))
		
