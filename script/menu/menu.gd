extends Control

var tween : Tween

func _ready():
	Global.in_menu = false
	$CanvasLayer/PanelMenu.position.y = 680
	pass # Replace with function body.

func _process(delta):
	if !Global.in_menu:
		close_menu()
	else:
		open_menu()
	
	if Input.is_action_just_pressed("esc"):
		Global.in_menu = !Global.in_menu
	pass

func open_menu():
	get_tree().paused = true
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($CanvasLayer/PanelMenu,"position:y",75,0.08).set_ease(Tween.EASE_OUT)
	

func close_menu():
	get_tree().paused = false
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($CanvasLayer/PanelMenu,"position:y",680,0.08).set_ease(Tween.EASE_IN)



func _on_exit_game_pressed():
	get_tree().quit()
	pass



func _on_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass
