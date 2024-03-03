extends FileDialog

func _ready():
	set_current_path("res://scene/saved_level/")

func refresh():
	self._draw
	

func _draw():
	set_current_dir("res://")
