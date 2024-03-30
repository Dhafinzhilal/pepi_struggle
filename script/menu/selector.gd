extends Control

@onready var playerchar: CharacterBody2D = get_node("/root/level/player")
@onready var interaction_player: Area2D = playerchar.get_node("interactive_hitbox")
@onready var computer_hint = get_node("/root/level/Computer/Sprite2D")
var tween : Tween
var selection = false
var area_selector = false

func _ready():
	$"CanvasLayer/Level Selction".visible = false
	$"CanvasLayer/Level Selction".position.y = 680
	pass # Replace with function body.

func _process(delta):
	if !selection and !Global.in_menu:
		close_seletor()
	elif selection:
		open_selector()
		
	if area_selector:
		if Input.is_action_just_pressed("space"):
			selection = !selection
	
	if !area_selector:
		close_seletor()
		selection = false
	
	if Global.transition_block:
		close_seletor()
		selection = false
	pass


func open_selector():
	$"CanvasLayer/Level Selction".visible = true
	$"CanvasLayer".visible = true
	Global.is_tutorial = true
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($"CanvasLayer/Level Selction","position:y",75,0.08).set_ease(Tween.EASE_OUT)

func close_seletor():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($"CanvasLayer/Level Selction","position:y",680,0.08).set_ease(Tween.EASE_IN)

func _on_interactive_hitbox_area_entered(area):
	if interaction_player == area:
		computer_hint.visible = true
		area_selector = true
	pass # Replace with function body.


func _on_interactive_hitbox_area_exited(area):
	if interaction_player == area:
		computer_hint.visible = false
		area_selector = false
	pass # Replace with function body.
