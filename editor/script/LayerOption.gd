extends OptionButton
@onready var editor = get_node("/root/main/Editor_Object")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_LayerOption_item_selected(index):
	editor.layertile_id = get_item_id(index)
	pass # Replace with function body.
