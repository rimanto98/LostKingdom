extends KinematicBody2D

var direction = Vector2(1, 0)
const SPEED = 120
var goLeft = false
var fade_class = load("res://Scenes/Fade/Fade.tscn")

func gotHit():
	$CollisionShape2D.disabled = true
	$CollisionShape2D.scale = Vector2(0.001,0.001)
	yield(get_tree().create_timer(0.2),"timeout")
	$AnimatedSprite.hide()
	$Sounds/EnemyDeath.play()
	$Particles2D.emitting = true
	yield(get_tree().create_timer(0.9),"timeout")
	self.queue_free()
	
func getMovement():
	var dir = 1
	if goLeft:
		dir = -1
	#print (direction*SPEED*dir)
	if self.get_global_position().y > 900:
		SceneManager.goto_scene("res://Scenes/Minigame2/GameScreens/GameOver.tscn")
	return direction*SPEED*dir