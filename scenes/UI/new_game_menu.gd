extends HBoxContainer
signal new_game
signal options

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_new_game_pressed():
	new_game.emit()


func _on_btn_options_pressed():
	options.emit()
