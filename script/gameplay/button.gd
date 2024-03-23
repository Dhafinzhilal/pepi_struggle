extends Area2D

var is_activated = false
@onready var playerchar: CharacterBody2D = get_node("/root/level/player")
signal buttonPressed

# Called when the node enters the scene tree for the first time.
func _ready():
	is_activated = false
	pass

func _process(delta):
	if is_activated:
		emit_signal("buttonPressed")
	pass


func _on_body_entered(body):
	if playerchar == body:
		is_activated = true
	pass
