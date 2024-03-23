extends Node2D

@onready var playerchar: CharacterBody2D = get_node("/root/level/player")
@export var jump_height: float = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func _on_hitbox_body_entered(body):
	if playerchar == body:
		playerchar.velocity.y = -jump_height
	pass # Replace with function body.
