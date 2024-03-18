extends Node2D

@onready var level_cam: Camera2D = get_node("CameraManipulation/Camera2D")
@onready var playerchar: CharacterBody2D = get_node("player")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")
@onready var music = get_node("Menu/music")


func _ready():
	Global.playing = true
	music.play()

func _process(delta):
	if Input.is_action_just_pressed("o"):
		Global.playing = !Global.playing
	pass

