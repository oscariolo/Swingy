extends StaticBody2D

var width
signal generate_next(new_position)
var spawned_next = false
# Called when the node enters the scene tree for the first time.

func _ready():
	width = $CollisionShape2D.get_shape().get_rect().size.x 


func _on_visible_notifier_screen_entered():
	if not spawned_next:
		generate_next.emit(global_position.x+width)
		spawned_next = true
	

func _on_visible_notifier_screen_exited():
	queue_free()

func set_layer():
	var num_grounds = $GroundTextures.get_child_count()
	var ground = randi() % num_grounds
	$GroundTextures.get_child(ground).visible = true
