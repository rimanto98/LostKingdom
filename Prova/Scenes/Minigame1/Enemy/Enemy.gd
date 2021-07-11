extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = -20
const ROTSPEED = 6
const GRAVITY = 20
var knockDir
var hitstun = 0

var initialPos

var target

var cont = 0

var rest = false
var canMove = true
var lives = 3

var needTimer = false

var slowFallstart = false  
var velocityCooldownStart = false
var activeVelocityStart = false

var velocityBoost = false

signal lifeLost

signal boostAvailable
var boostAggiornato = false

signal death

func _ready():
	initialPos = translation
	target = get_node("/root/Minigame1/Ball")
	randomize()

func _process(delta):
	
	checkVelocityBoost()

	if hitstun > 0:
		hitstun -= 1
		needTimer = true
		
	elif hitstun <= 0:
		canMove = true
		if needTimer:
			$SlowFall.start()
			needTimer = false	
	
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
	if lives > 0:
		emit_signal("lifeLost",lives)
		translation = initialPos
		$Sounds/Respawn.play()
	else:
		emit_signal("death")
	
func normalMovement():
	var boost = 1
	if velocityBoost:
		boost = 2
	if target.translation.y >= 0:
		translation = self.translation.linear_interpolate(target.translation,0.015*boost)
		look_at(target.translation,Vector3(0,0.5,0))

	elif !rest:
		translation = self.translation.linear_interpolate(initialPos,0.015*boost)
		look_at(initialPos,Vector3(0,0.5,0))

	if !rest:
		$MeshInstance.rotate_x(deg2rad(-ROTSPEED*boost))


func _on_EnemySafeSpot_rest(needRest):
	rest = needRest
	
	
func hit(knockDir,hitstun):
	self.knockDir = knockDir
	canMove = false
	self.hitstun = hitstun
	
func checkVelocityBoost():		
	if ($VelocityCooldown.time_left == 0 || not velocityCooldownStart) && not velocityBoost && $Decision.time_left == 0:
		$Decision.start()
		var r = randf()
		#print(r)
		if r < 0.4:
			print("boost")
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
	