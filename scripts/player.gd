extends CharacterBody2D

var speed
const JUMP_VELOCITY = -600.0
var MAX_FALL_SPEED = 300.0
var direction:= 1
var boost = 0
var on_walkwall := false
var can_cancel_jump := true
var can_jump:= true
var can_double_jump := true
var rotating:= false
var tween: Tween 

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@export var on_fall_weight: float
var gravity:= 0.0
var is_wall_walking := false


func _ready():
	speed = Globals.player_speed
	$AnimationPlayer.play("idle")

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
	_set_animations()
	if not is_on_floor():
		velocity.y += gravity*delta
	else:
		can_jump = true
		can_double_jump = true
	
	_jump_control()
	
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
	if $CoyoteTimer.time_left >0 and is_on_floor():
			velocity.y = jump_velocity
			can_jump = false
	#Jump input
	if Input.is_action_just_pressed("jump"):
		if can_jump:
			velocity.y = jump_velocity
			can_jump = false
		else:
			if can_double_jump:
				velocity.y = jump_velocity
				can_double_jump = false
			else:
				$CoyoteTimer.start()
			
	#falloff
	if Input.is_action_just_released("jump"):
		velocity.y = lerp(velocity.y,MAX_FALL_SPEED,on_fall_weight)
		can_cancel_jump = false

func _get_gravity():
	if velocity.y < 0.0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity
	
func _set_animations():
	if is_on_floor():
		$AnimationPlayer.play("idle")
	if not can_jump:
		if not can_double_jump:
			$AnimationPlayer.play("double_jumping")
		else:
			$AnimationPlayer.play("jumping")
	
			
func _on_coyote_timer_timeout():
	pass

