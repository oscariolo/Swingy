extends Node2D

var speed= 10
var direction = Vector2.ZERO
@export var lerp_coef:= 0.1
var current_pos_head:= Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = current_pos_head


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_follow_up_relative_to(current_pos_head)
	current_pos_head += Vector2(-2,0)*speed
	global_position = current_pos_head
	

func _follow_up_relative_to(new_head_position):
	var children_arrows = $ChildrenArrows.get_children()
	var diff = Vector2(60,0)
	var father_position = new_head_position
	for child in children_arrows:
		var prev_pos_child = child.global_position as Vector2
		child.global_position = prev_pos_child.lerp(father_position - diff,lerp_coef)
		father_position = child.global_position
		

func _on_free_timeout():
	queue_free()
