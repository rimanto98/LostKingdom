extends CanvasLayer

var treVite = false
var dueVite = false
var unaVita = false

func _on_Player_bomb_taken(bombs):
	$BombCount/Label.text = str(bombs)


func _physics_process(delta):
	if Global.lives == 3 and !treVite:
		$LifeBar/Hearts/AnimatedHeart3.queue_free()
		treVite = true
		
	elif Global.lives == 2 and !dueVite:
		$LifeBar/Hearts/AnimatedHeart2.queue_free()
		dueVite = true
		
	elif Global.lives == 1 and !unaVita:
		$LifeBar/Hearts/AnimatedHeart1.queue_free()
		unaVita = true


func _on_Player_bomb_dropped(bombs):
	$BombCount/Label.text = str(bombs)

