extends Camera2D

func set_up_borders(start_position:Vector2):
	var current_cam_size = get_viewport_rect().size/zoom*0.5
	$LevelBoundaries/Left.position -= Vector2(current_cam_size.x,current_cam_size.y)
	$LevelBoundaries/Right.position += Vector2(current_cam_size.x,-current_cam_size.y)
	
