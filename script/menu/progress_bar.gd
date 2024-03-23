extends Control

@export var duration:float = 60
@onready var bar = get_node("CanvasLayer/TextureProgressBar")
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	bar.position.y = 700
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.phase == 2:
		tween = create_tween()
		tween.tween_property(bar,"position:y",632,0.2).set_ease(Tween.EASE_OUT)
	pass

func _on_timer_timeout():
	bar.value += 1
	pass # Replace with function body.
