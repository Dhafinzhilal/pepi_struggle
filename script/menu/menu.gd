extends Control

@onready var playerchar: CharacterBody2D = get_node("/root/level/player")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")
var tween : Tween

func _ready():
	Global.in_menu = false
	$CanvasLayer/PanelMenu.visible = false
	$CanvasLayer/PanelMenu.position.y = 680
	pass # Replace with function body.

func _process(delta):
	if !Global.in_menu:
		close_menu()
		$"CanvasLayer/PanelMenu/Panel/MainMenu/Exit Game".disabled = true
		$"CanvasLayer/PanelMenu/Panel/MainMenu/Back to Hub".disabled = true
		$"CanvasLayer/PanelMenu/Panel/MainMenu/Restart".disabled = true
		$CanvasLayer/PanelMenu/Settings/FullScreen/CheckButton.disabled = true
	elif Global.in_menu:
		open_menu()
		$CanvasLayer/PanelMenu/Settings/FullScreen/CheckButton.disabled = false
		$"CanvasLayer/PanelMenu/Panel/MainMenu/Exit Game".disabled = false
		$"CanvasLayer/PanelMenu/Panel/MainMenu/Back to Hub".disabled = false
		$"CanvasLayer/PanelMenu/Panel/MainMenu/Restart".disabled = false
	
	if Input.is_action_just_pressed("esc"):
		Global.in_menu = !Global.in_menu
	
	if Global.transition_block or Global.transition_block2:
		close_menu()
	pass

func open_menu():
	$CanvasLayer/PanelMenu.visible = true
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


func _on_restart_pressed():
	Global.transition_block = true
	await get_tree().create_timer(1).timeout
	Global.playing = false
	Global.end_trans = true
	pass # Replace with function body.


func _on_back_to_hub_pressed():
	Global.transition_block2 = true
	await get_tree().create_timer(1).timeout
	Global.playing = false
	Global.end_trans = true
	pass # Replace with function body.
