extends TextureRect

func _on_Player_lifeLost(lives):
	if lives == 2:
		$Sprite2.hide()
		
	else:
		$Sprite.hide()