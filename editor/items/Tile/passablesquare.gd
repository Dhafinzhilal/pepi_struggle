extends StaticBody2D


func _ready():
	pass # Replace with function body.



func _process(delta):
	if !Global.playing:
		$Collide.visible = true
	else:
		$Collide.visible = false
	
	
