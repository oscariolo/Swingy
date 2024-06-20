extends Control

func _input(event):
	if event is InputEventKey and $SplashScene.visible:
		fade_from($SplashScene,$NewGameMenu)

func fade_from(current_control:Control,new_control: Control):
	var fade_out:Tween = create_tween()
	var modulate_out = current_control.get_theme_color("font_color","Label")
	modulate_out.a = 0
	fade_out.tween_property(current_control,"modulate",modulate_out,0.5)
	await fade_out.finished
	current_control.set_visible(false)
	var fade_in:Tween = create_tween()
	new_control.set_visible(true)
	new_control.modulate.a = 0
	var modulate_in = new_control.modulate
	modulate_in.a = 1
	fade_in.tween_property(new_control,"modulate",modulate_in,0.5)
	

func _on_new_game_menu_new_game():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
