extends Node


func _on_Ball_lifeLost(lives):
	if lives == 2:
		$RotatingBall2.hide()
		
	else:
		$RotatingBall.hide()


func _on_Enemy_lifeLost(lives):
	_on_Ball_lifeLost(lives)


func _on_Ball2_lifeLost(lives):
	_on_Ball_lifeLost(lives)
