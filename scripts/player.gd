extends CharacterBody2D


var speed
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	speed = Globals.player_speed

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity*delta
	
	if Input.is_action_just_pressed("jump"):
		velocity.y += JUMP_VELOCITY
	#
	#position.x += speed*delta
	
	move_and_slide()

