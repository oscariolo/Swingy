extends Node

var screen_size
var speed := Globals.player_speed
const PLAYER_START_POS = Vector2i(100,550)
const CAMERA_START_POS = Vector2i(660,340)
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
	$Player.global_position = PLAYER_START_POS
	$FollowCamera.global_position = CAMERA_START_POS
	$FollowCamera.set_up_borders(CAMERA_START_POS)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_loaded_level()
	
	$FollowCamera.position.x += speed*delta
	

func _on_ground_generate_next(new_position):
	var terrain = loaded_level.instantiate()
	terrain.connect("generate_next",_on_ground_generate_next)
	terrain.set_layer()
	terrain.position.x = new_position
	$CurrentGround.add_child(terrain)

func change_loaded_level():
	if current_level != levels.SNOW and Globals.points >= 100 and Globals.points <=200:
		var region_rect_x = 30
		var current_region = $ParallaxBackground/ParallaxLayer/Sprite2D.get_region_rect() as Rect2
		current_region.position.x = region_rect_x
		$ParallaxBackground/ParallaxLayer/Sprite2D.set_region_rect(current_region)
		loaded_level = load("res://scenes/snow_scene.tscn")
		current_level = levels.SNOW
		
	
		

func _on_points_timer_timeout():
	Globals.points += 10
	


func _on_spawn_arrow_timeout():
	var new_arrow = preload("res://scenes/arrow.tscn").instantiate()
	new_arrow.current_pos_head.x = $FollowCamera/LevelBoundaries/Right.global_position.x
	new_arrow.current_pos_head.y = randf_range(200,600)
	$Projectiles.add_child(new_arrow)
	
	
