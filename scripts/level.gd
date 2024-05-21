extends Node2D

var screen_size
var speed := Globals.player_speed
const PLAYER_START_POS = Vector2i(160,552)
const CAMERA_START_POS = Vector2i(576,408)
var loaded_level: PackedScene
enum levels{JUNGLE,SNOW}
var current_level = levels.JUNGLE
var on_walkable_wall:= false



# Called when the node enters the scene tree for the first time.
func _ready():
	_new_game()

func _new_game():
	loaded_level = preload("res://scenes/jungle_ground.tscn")
	_on_ground_generate_next(0)
	$Player.position = PLAYER_START_POS
	$Camera2D.position = CAMERA_START_POS

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_loaded_level()
	
	$Camera2D.position.x += speed*delta
	

func _on_ground_generate_next(new_position):
	var terrain = loaded_level.instantiate()
	terrain.connect("generate_next",_on_ground_generate_next)
	terrain.set_layer()
	terrain.position.x = new_position
	$CurrentGround.add_child(terrain)

func change_loaded_level():
	if current_level != levels.SNOW and Globals.points >= 1000 and Globals.points <=2000:
		loaded_level = load("res://scenes/snow_scene.tscn")
		current_level = levels.SNOW
	
		

func _on_points_timer_timeout():
	Globals.points += 10
	
