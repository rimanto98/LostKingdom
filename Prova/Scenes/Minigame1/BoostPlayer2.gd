extends Node

var available = true
var cooldown = 0

var hidden = true

func _on_Enemy_boostAvailable(isAvailable):
	available = isAvailable
	#cooldown = time
	
func _process(delta):
	if available && not hidden:
		$Frame/ColorRect.hide()
		$Label.show()
		hidden = true
		
	elif hidden && not available:
		$Frame/ColorRect.show()
		$Label.hide()
		hidden = false
		
		


func _on_Ball2_boostAvailable(isAvailable):
	available = isAvailable
