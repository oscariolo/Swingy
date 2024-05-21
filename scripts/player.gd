extends CharacterBody2D


var speed
const JUMP_VELOCITY = -600.0
var direction:= 1
var boost = 0
var on_walkwall := false
var can_cancel_jump := true

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var gravity:= 0.0
var is_wall_walking := false

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
	_get_gravity()
	if not is_on_floor():
		velocity.y += gravity*delta
	
	_jump_control()
	_wallride_control()
	
	position.x += direction * speed * delta + boost
	
	
	move_and_slide()

func _wallride_control():
	if on_walkwall:
		if Input.is_action_just_pressed("jump"):
			is_wall_walking = true
		if Input.is_action_just_released("jump"):
			is_wall_walking = false
	if is_wall_walking:
		velocity.y = lerp(velocity.y,0.0,0.25)
	
func _jump_control():
	if is_on_floor():
		can_cancel_jump = true
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	if Input.is_action_just_released("jump") and can_cancel_jump:
		velocity.y = lerp(velocity.y,fall_gravity,0.20)
		can_cancel_jump = false

func _get_gravity():
	if velocity.y < 0.0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity
	
