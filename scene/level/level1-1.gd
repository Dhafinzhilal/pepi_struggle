extends Node2D

@onready var level_cam: Camera2D = get_node("CameraManipulation/Camera2D")
@onready var playerchar: CharacterBody2D = get_node("player")
@onready var player_thing: Area2D = playerchar.get_node("player_thing")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")
@onready var head_player: Area2D = playerchar.get_node("head")
var tween = Tween

var CorrectSound = preload("res://sound/music/bossarnoa_9.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Interactive/water/tween_kinda_suck_tbh.stop()
	Music.stream = CorrectSound
	Global.reset_var()
	LayerTransition.get_ready(1)
	await get_tree().create_timer(2).timeout
	playerchar.set_physics_process(true)
	$Interactive/water/tween_kinda_suck_tbh.play("move_water")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.transition_block:
		$Interactive/water/tween_kinda_suck_tbh.stop()
		
	if Global.transition_block2:
		$Interactive/water/tween_kinda_suck_tbh.stop()
	pass

func _on_water_area_entered(area):
	if head_player == area:
		Global.in_trans()
		$Interactive/water/tween_kinda_suck_tbh.pause()
		playerchar.set_physics_process(false)
	pass # Replace with function body.

func _on_button_button_pressed():
	var pattern2 = $TileMap.tile_set.get_pattern(7)
	$TileMap.set_pattern(0,Vector2i(249,-362),pattern2)
	pass # Replace with function body.

func _on_button_2_button_pressed():
	await get_tree().create_timer(2.2).timeout
	$TileMap.set_cell(0,Vector2i(372,-414),-1,Vector2i(-1,-1))
	pass # Replace with function body.
