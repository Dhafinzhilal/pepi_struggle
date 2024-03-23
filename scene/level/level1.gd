extends Node2D

@onready var level_cam: Camera2D = get_node("CameraManipulation/Camera2D")
@onready var playerchar: CharacterBody2D = get_node("player")
@onready var player_thing: Area2D = playerchar.get_node("player_thing")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")
@onready var music = get_node("music")
var is_acivated = false


func _ready():
	Global.playing = true
	$CameraManipulation/Start1.set_priority(0)
	$CameraManipulation/CameraP1.set_priority(6)


func _process(delta):
	if Input.is_action_just_pressed("o"):
		Global.playing = !Global.playing
	pass

func _on_button_button_pressed():
	$Interactive/Button/sprite.play("active")
	$TileMap.set_cell(0,Vector2i(18,-1),-1,Vector2i(-1,-1))
	$TileMap.set_cell(0,Vector2i(18,-2),-1,Vector2i(-1,-1))
	$TileMap.set_cell(0,Vector2i(18,-3),-1,Vector2i(-1,-1))
	pass # Replace with function body.


func _on_button_2_button_pressed():
	var pattern = $TileMap.tile_set.get_pattern(3)
	$Interactive/Button2/sprite.play("active")
	$TileMap.set_pattern(0,Vector2i(149,-42),pattern)
	pass # Replace with function body.


func _on_cutscene_body_entered(body):
	if playerchar == body:
		$CameraManipulation/Camera12.set_priority(2)
		$CameraManipulation/Camera1.set_priority(6)
	pass # Replace with function body.


func _on_view_1_area_entered(area):
	if player_thing == area:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera2.set_priority(5)
	pass 


func _on_view_p_1_body_entered(body):
	if playerchar == body:
		$CameraManipulation/Camera2.set_priority(1)
		$CameraManipulation/Camera3.set_priority(5)
	pass # Replace with function body.


func _on_view_p_2_body_entered(body):
	if playerchar == body:
		$CameraManipulation/Camera3.set_priority(2)
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera4.set_priority(5)
	pass # Replace with function body.

func _on_view_out_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(6)
		$CameraManipulation/CameraP1.set_tween_duration(1)
		$CameraManipulation/CameraP1.set_tween_ease(2)
		$CameraManipulation/Camera2.set_priority(1)
	pass # Replace with function body.


func _on_view_2_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera5.set_priority(5)
	pass # Replace with function body.


func _on_view_3_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera7.set_priority(2)
		$CameraManipulation/Camera6.set_priority(6)
	pass # Replace with function body.


func _on_view_4_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera6.set_priority(0)
		$CameraManipulation/Camera7.set_priority(7)
	pass # Replace with function body.


func _on_view_5_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera7.set_priority(2)
		$CameraManipulation/Camera8.set_priority(6)
		$CameraManipulation/Camera8.set_limit(SIDE_LEFT, 5088)
		$CameraManipulation/Camera8.set_limit(SIDE_TOP, -10000)
		$CameraManipulation/Camera8.set_limit(SIDE_BOTTOM, -944)
	pass # Replace with function body.


func _on_view_6_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera8.set_priority(2)
		$CameraManipulation/Camera7.set_priority(6)
		$CameraManipulation/Camera7.set_tween_duration(0)
		$CameraManipulation/Camera8.set_limit(SIDE_LEFT, -10000000)
		$CameraManipulation/Camera8.set_limit(SIDE_TOP, -10000000)
		$CameraManipulation/Camera8.set_limit(SIDE_BOTTOM, 10000000)
	pass # Replace with function body.


func _on_view_7_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera8.set_priority(2)
		$CameraManipulation/Camera9.set_priority(6)
		$CameraManipulation/Camera8.set_limit(SIDE_LEFT, -10000000)
		$CameraManipulation/Camera8.set_limit(SIDE_TOP, -10000000)
		$CameraManipulation/Camera8.set_limit(SIDE_BOTTOM, 10000000)
	pass # Replace with function body.


func _on_view_8_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera8.set_priority(6)
		$CameraManipulation/Camera8.set_tween_duration(1.2)
		$CameraManipulation/Camera9.set_priority(2)
		$CameraManipulation/Camera8.set_limit(SIDE_LEFT, 5088)
		$CameraManipulation/Camera8.set_limit(SIDE_TOP, -10000)
		$CameraManipulation/Camera8.set_limit(SIDE_BOTTOM, -944)
	pass # Replace with function body.

func _on_view_9_area_entered(area):
	if player_thing == area:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera9.set_priority(2)
		$CameraManipulation/Camera10.set_priority(6)
	pass # Replace with function body.


func _on_view_10_area_entered(area):
	if player_thing == area:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera11.set_priority(6)
		$CameraManipulation/Camera10.set_priority(2)
	pass # Replace with function body.


func _on_view_11_body_entered(body):
	if playerchar == body:
		$CameraManipulation/CameraP1.set_priority(1)
		$CameraManipulation/Camera11.set_priority(2)
		$CameraManipulation/Camera10.set_priority(2)
		$CameraManipulation/Camera12.set_priority(6)
	pass # Replace with function body.
