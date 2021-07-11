extends Node

#Platform2D
var inMinigame = false
var unlockM1 = false
var unlockM2 = false
var firstStart = true
var fromMenu = false
var lives = 4

func death():
	lives -= 1
		
func resetLives():
	lives = 4	
	

#SpaceInvadersAI

var points = 0

