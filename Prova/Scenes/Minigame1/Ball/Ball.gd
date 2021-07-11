extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = -20
const ROTSPEED = 7
const GRAVITY = 20
var knockDir

var initialPos
var canMove = true
var hitstun = 0

var lives = 3

var slowFallstart = false  
var velocityCooldownStart = false
var activeVelocityStart = false

var velocityBoost = false

signal lifeLost

signal boostAvailable
var boostAggiornato = false

signal death

var multy = false

func _ready():
	initialPos = translation
	if get_parent().name == "Minigame1Multy":
		multy = true

func _process(delta):
	
	checkVelocityBoost()

	if hitstun > 0:
		hitstun -= 1
		slowFallstart = true
		
	elif hitstun <= 0:
		canMove = true
		if slowFallstart:
			$SlowFall.start()
			slowFallstart = false
	
	if (translation.y <= -15):
		fall()
		
	if !self.translation.y < 0:	
		if canMove:
			normalMovement()
			velocity.y = GRAVITY
		
		else:
			velocity = knockDir
			
			velocity.y = -100
	else:
		velocity.y = GRAVITY
		if not $Sounds/Fall.playing:
			$Sounds/Fall.play()
		
	velocity = velocity.normalized()*SPEED*delta*50
	
	if $SlowFall.time_left != 0:
		velocity.y = -7
		
	move_and_slide(velocity)
	
func fall():
	lives -= 1
	emit_signal("lifeLost",lives)
	if lives > 0:
		translation = initialPos
		$Sounds/Respawn.play()
	else:
		emit_signal("death")
	
func hit(knockDir,hitstun):
	canMove = false
	self.knockDir = knockDir
	self.hitstun = hitstun
	
func normalMovement():
	var boost = 1
	if velocityBoost:
		boost = 3
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
			velocity.x = 0
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED*boost
		$MeshInstance.rotate_z(deg2rad(-ROTSPEED*boost))
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED*boost
		$MeshInstance.rotate_z(deg2rad(ROTSPEED*boost))
		
	else:
		velocity.x = 0
				
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0	
		
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED*boost
		$MeshInstance.rotate_x(deg2rad(-ROTSPEED*boost))
		
	elif Input.is_action_pressed("ui_down"):
		velocity.z = SPEED*boost
		$MeshInstance.rotate_x(deg2rad(ROTSPEED*boost))
		
	else:
		velocity.z = 0


func checkVelocityBoost():
	var input = KEY_Z
	if multy:
		input = KEY_SHIFT

	if Input.is_key_pressed(input) && ($VelocityCooldown.time_left == 0 || not velocityCooldownStart) && not velocityBoost:
		velocityCooldownStart = true
		velocityBoost = true
		emit_signal("boostAvailable",false)
		boostAggiornato = false
		$ActiveVelocity.start()
		activeVelocityStart = true
		
	elif $ActiveVelocity.time_left == 0 && activeVelocityStart:
		activeVelocityStart = false
		velocityBoost = false
		$VelocityCooldown.start()
		
	elif $VelocityCooldown.time_left == 0 && not boostAggiornato && $ActiveVelocity.time_left == 0:
		emit_signal("boostAvailable",true)
		boostAggiornato = true
