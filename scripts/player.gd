extends CharacterBody2D


var speed
const JUMP_VELOCITY = -600.0
var direction:= 1
var boost = 0
var on_walkwall := false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	speed = Globals.player_speed

func _manage_input():
	if Input.is_action_pressed("left"):
		direction = -1
		boost = 0
	elif Input.is_action_pressed("right"):
		direction = 1
		boost = 10
	else:
		direction = 1
		boost = 0

func _physics_process(delta):
	_manage_input()
	if not is_on_floor():
		velocity.y += gravity*delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
	
	
	
	
	
	position.x += direction * speed * delta + boost
	
	
	move_and_slide()

