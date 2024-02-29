extends Control

@onready var editor = get_node("/root/main/Editor_Object")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global.playing:
		if not Rect2(Vector2(),size).has_point(get_global_mouse_position()):
			editor.can_place = true
		else:
			editor.can_place = false
	else:
		editor.can_place = false


	
