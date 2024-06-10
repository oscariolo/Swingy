extends Area2D




func _on_body_entered(body):
	if body.name == "Player":
		body.on_walkwall = true
		
		


func _on_body_exited(body):
	if body.name == "Player":
		body.on_walkwall = false
		body.is_wall_walking = false
