extends Node2D

@onready var playerchar: CharacterBody2D = get_node("/root/level/player")
@onready var startrope: Vector2 = $start.position
@onready var endrope: Vector2 = $end.position
@export var rope_color: Color
@export var rope_width: float
@export var rope_speed: float

var progress: float = 0.0


func _ready():
	set_physics_process(false)
	pass
	

func _draw():
	draw_line(startrope,endrope,rope_color,rope_width,true)
	$start/point.modulate = rope_color
	$end/point.modulate = rope_color

func _physics_process(delta):
	progress += rope_speed * delta
	if progress >= 1.0:
		end_zipline()
		Global.is_on_zipline = false
	else:
		playerchar.position = startrope.lerp(endrope, progress)
	pass

func start_zipline():
	Global.is_on_zipline = true
	playerchar.position = startrope
	set_physics_process(true)
	progress = 0.0

func end_zipline():
	playerchar.position = endrope
	set_physics_process(false)

func _on_start_body_entered(body):
	if playerchar == body:
		start_zipline()
	pass
