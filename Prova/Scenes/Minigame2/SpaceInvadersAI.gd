extends Node2D

var speedEnemy = preload("res://Scenes/Minigame2/Enemies/SpeedEnemy.tscn")
var enemyIn = false
var wave1 = preload("res://Scenes/Minigame2/Enemies/Wave1.tscn")
var wave2 = preload("res://Scenes/Minigame2/Enemies/Wave2.tscn")
var wave3 = preload("res://Scenes/Minigame2/Enemies/Wave3.tscn")
var wave4 = preload("res://Scenes/Minigame2/Enemies/Wave4.tscn")
var wave5 = preload("res://Scenes/Minigame2/Enemies/Wave5.tscn")
var waves = []
var fade_class = load("res://Scenes/Fade/Fade.tscn")
var currentWave = 0
var waveInstance 
var enemiesLeft
var aiActive = false
signal aiOutput
var gameEnd = false

var reservesAvailable = 0
var totalReservesPlusOne = 1
signal reserveChange

func _ready():
	#Engine.set_target_fps(45)
	get_tree().paused = true
	var fade_instance = fade_class.instance()
	fade_instance.set_fade_in(true)
	add_child(fade_instance)
	#yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = false
	$"/root/Global".points = 0
	waves = [wave1,wave2,wave3,wave4,wave5]
	randomize()
	$SpeedEnemySpawn.start()
	waveInstance = wave1.instance()
	add_child(waveInstance)
	currentWave += 1
	$UI/Wave/Label2.text = str(currentWave)
	
func _process(delta):
	#print (reservesAvailable)
	if $"/root/Global".points / (1000*totalReservesPlusOne) > 0:
		totalReservesPlusOne += 1
		reservesAvailable += 1
		emit_signal("reserveChange",1)
	
	if Input.is_action_just_released("AiActivate") && reservesAvailable > 0 && !aiActive:
		reservesAvailable -= 1
		emit_signal("reserveChange",0)
		$UI/Automode/Label3.show()
		$UI/Automode/Label4.show()
		aiActive = true
		$ActiveAi.start()
		$Player.controlledByAi = true
	if $SpeedEnemySpawn.time_left == 0:
		#print("try")
		generateEnemy()
		$SpeedEnemySpawn.start()
	enemiesLeft = waveInstance.get_children()
	
	if enemiesLeft.size() == 0:
		changeWave()
		
	if $ActiveAi.time_left == 0 && aiActive:
		aiActive = false
		$Player.controlledByAi = false
		$UI/Automode/Label3.hide()
		$UI/Automode/Label4.hide()
	
	if aiActive && !gameEnd:
		if $AiFrequencyCall.time_left == 0:
			saveInput()
			emit_signal("aiOutput",readOutput())
			#print(readOutput())
			$AiFrequencyCall.start()
		
		
	#print(currentWave)
	
func generateEnemy():
	if randf() < 0.3 && !enemyIn:
		var speedEnemyInstance = speedEnemy.instance()
		add_child(speedEnemyInstance)
		enemyIn = true
		yield(get_tree().create_timer(7), "timeout")
		enemyIn = false
		
func changeWave():
	if currentWave == 5:
		gameEnd = true
		stopProcess()
		add_child(fade_class.instance())
		yield(get_tree().create_timer(0.7),"timeout")
		SceneManager.goto_scene("res://Scenes/Minigame2/GameScreens/WinScreen.tscn")
	else:
		remove_child(waveInstance)
		waveInstance = waves[currentWave].instance()
		add_child(waveInstance)
		currentWave += 1
		$UI/Wave/Label2.text = str(currentWave)
			
func saveInput():
	var input = "player("+ str(int($Player.position.x))+","+str($Player.position.y)+").\n"
	var dir = 1
	#il terzo valore è il tipo 5=Speed 10=Shooting 15=Shield
	for enemy in enemiesLeft:
		dir = !enemy.goLeft
		var price = 15
		if "Shooting" in enemy.name: 
			price = 10	
		input += "enemy("+str(enemy.position.x)+","+str(enemy.position.y)+","+str(price)+").\n"
	#1=destra 0=sinistra
	input += "dirWave("+str(int(dir))+").\n"

	if $SpeedEnemy != null:
		#passiamo l'input con l'offset per semplificare lo sparo dello Speed
		var xValue
		if $SpeedEnemy.right:
			xValue = int($SpeedEnemy.position.x) + 500
		else:
			xValue = int($SpeedEnemy.position.x) - 500
		if xValue > 70 && xValue < 1840:
			input += "enemy("+str(xValue)+","+str(int($SpeedEnemy.position.y))+",5).\n"
			#input +="dirSpeed("+str(int($SpeedEnemy.right))+").\n"
	
	
	var children = get_tree().get_root().get_children()
	for child in children:
		if "EnemyBullet" in child.name:
			input += "enemyBullet("+str(child.position.x)+","+str(int(child.position.y))+").\n"
	
		
	$"/root/AiManager".save(input)
	
	
func readOutput():
	return $"/root/AiManager".read()
	

func stopProcess():
	self.set_process(false)

func _on_Player_dead():
	gameEnd = true
	stopProcess()
	add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame2/GameScreens/GameOver.tscn")
