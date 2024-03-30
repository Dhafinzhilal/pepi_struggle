extends Node2D

@onready var level_cam: Camera2D = get_node("CameraManipulation/Camera2D")
@onready var playerchar: CharacterBody2D = get_node("player")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")

@export var CorrectSound = preload("res://sound/music/dhafin1.mp3")
var end_trans = false


func _ready():
	Music.stream = CorrectSound
	playerchar.set_physics_process(true)
	Global.reset_var()
	LayerTransition.get_ready(2)
	pass

func _process(delta):
	pass

func _on_computer_area_entered(area):
	if area == interaction_player:
		$Computer/computer.play("on")
		$Computer/PointLight2D.enabled = true

func _on_computer_area_exited(area):
	if area == interaction_player:
		$Computer/computer.play("off")
		$Computer/PointLight2D.enabled = false


func _on_start_body_entered(body):
	if playerchar == body:
		if Global.is_tutorial == true:
			Global.in_trans()
			playerchar.set_physics_process(false)
	pass # Replace with function body.
