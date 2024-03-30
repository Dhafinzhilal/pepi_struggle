extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Global.playing)
	if Global.end_trans:
		if Global.transition_block:
			get_tree().reload_current_scene()
		elif Global.transition_block2:
			get_tree().change_scene_to_file("res://scene/level/hub.tscn")
		elif Global.transmission == 1:
			get_tree().change_scene_to_file("res://scene/level1-1.tscn")
	
	if Global.transition_block:
		Global.any_trans()
		
	if Global.transition_block2:
		Global.any_trans()
	pass

func play_anim(trans:bool):
	if trans == true:
		$layer_transition/Animation.play("transition_out")
	else:
		$layer_transition/Animation.play("transition_in")
	pass # Replace with function body.
	

func get_ready(long_wait:int):
	await get_tree().create_timer(long_wait).timeout
	LayerTransition.play_anim(true)
	await get_tree().create_timer(1).timeout
	Global.playing = true
	Music.play()
	pass
