extends CharacterBody2D

class_name player

#variable main
@export var speed : float = 330.0
@export var jump_strength : float = 450.0
@export var dash_speed : float = 1200.0
@export var health : int = 3
@export var gravity : float = 1000.0

var accel : float = 25.0

@onready var timer_dash = $Dash_cooldown
var tween : Tween

var max_jump : int = 1
var current_jump : int = 0

var can_dash = true
var dashdir : int

var init = false
var spawnpoint = Vector2(0,0)
var player_point = false

#function input
func input():
	var input_dir = Input.get_axis("a","d")
	var input_jump = Input.is_action_pressed("w")
	var input_dive = Input.is_action_just_pressed("s")
	var input_dash = Input.is_action_just_pressed("shift")
	
	#movement
	if input_dir:
		velocity.x = move_toward(velocity.x,speed * input_dir, accel)
		$character.play("walk")
	elif !input_dir:
		velocity.x = move_toward(velocity.x,0,accel * 2)
	
	if !input_dir and !velocity.x and is_on_floor():
		$character.play("default")
	
	if velocity.x > 0 and input_dir == -1:
		velocity.x = 0
	elif velocity.x < 0 and input_dir == 1:
		velocity.x = 0

	#jump
	if input_jump and current_jump < max_jump:
		velocity.y = -jump_strength
		current_jump += 1
	elif is_on_floor() :
		current_jump = 0
	
	#air dive
	if input_dive and !is_on_floor():
		velocity.x = 0
		velocity.y = 900
	
	#dash
	if input_dir == 1:
		dashdir = 1
	elif input_dir == -1:
		dashdir = -1
	
	if input_dash and can_dash:
		velocity.x = move_toward(velocity.x, dashdir * dash_speed,dash_speed/1.5)
		can_dash = false
	
	#misc
	if !is_on_floor() and velocity.y > 0:
		$character.play("fall")
		
	if velocity.y < 0:
		$character.play("jump")
	
	if !is_on_floor() and velocity.x > speed:
		$character.play("fall")
		
	if input_dir == 1:
		$character.flip_h = false
		#$item_hand/items_player/AnimatedSprite2D.flip_v = false
		#turn_2()
	elif input_dir == -1:
		$character.flip_h = true
		#$item_hand/items_player/AnimatedSprite2D.flip_v = true
		#turn_1()

	return input_dir

#function physic
func _physics_process(delta):
	if !init:
		spawnpoint = global_position
		init = true
		
	if !Global.playing:
		global_position = spawnpoint
		velocity = Vector2(0,0)
	else:
		input()
		if not is_on_floor():
			velocity.y += gravity * delta
		if !Global.is_on_zipline:
			$character.stop
		else:
			$character.play("jump")
		move_and_slide()

func start_zipline(zipline):
	zipline.start_zipline(self)

#func animation
func turn_1():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($item_hand,"rotation_degrees",180,0.1)

func turn_2():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($item_hand,"rotation_degrees",0,0.1)

func _on_dash_cooldown_timeout():
	can_dash = true
