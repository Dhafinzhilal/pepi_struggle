extends FileDialog

func refresh():
	self._draw

func _draw():
	set_current_dir("res://scene/saved_level")
