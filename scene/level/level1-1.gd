extends Node2D

@onready var level_cam: Camera2D = get_node("CameraManipulation/Camera2D")
@onready var playerchar: CharacterBody2D = get_node("player")
@onready var player_thing: Area2D = playerchar.get_node("player_thing")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")
@onready var head_player: Area2D = playerchar.get_node("head")
var tween = Tween
var time_begin
var time_delay

# Called when the node enters the scene tree for the first time.
func _ready():
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	Global.playing = true
	Global.phase = 2
	Global.is_on_zipline = false
	Music.play()
	$Interactive/water/tween_kinda_suck_tbh.play("move_water")
	$Interactive/water/tween_kinda_suck_tbh.seek(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = (Time.get_ticks_usec() - time_begin) / 1000000.0
	time -= time_delay
	time = max(0, time)
	print("Time is: ", time)
	pass

func _on_water_area_entered(area):
	if head_player == area:
		get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_button_button_pressed():
	var pattern = $TileMap.tile_set.get_pattern(4)
	var pattern2 = $TileMap.tile_set.get_pattern(5)
	$TileMap.set_pattern(0,Vector2i(250,-362),pattern)
	$TileMap.set_pattern(1,Vector2i(250,-362),pattern2)
	pass # Replace with function body.


func _on_button_2_button_pressed():
	await get_tree().create_timer(2.1).timeout
	$TileMap.set_cell(0,Vector2i(372,-414),-1,Vector2i(-1,-1))
	pass # Replace with function body.
