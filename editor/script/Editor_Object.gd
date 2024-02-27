extends Node2D

var can_place = true
var is_panning = true

@onready var level = get_node("/root/main/Level")
@onready var editor = get_node("/root/main/cam_container")
@onready var editor_cam = editor.get_node("Camera2D")
@onready var tab_container = get_node("/root/main/item_select/Control/TabContainer")
@onready var panel_layout = get_node("/root/main/item_select/Control/PanelLayoutTile/VBoxContainer")
@onready var optionbutton1 = panel_layout.get_node("LayerOption")
@onready var tile_map : TileMap = level.get_node("TileMap")

var current_item
var layertile_id :int 

func _ready():
	editor_cam.enabled = true
	pass # Replace with function body.



func _process(delta):
	global_position = get_global_mouse_position()
	var layertile_focus = tile_map.get_layer_z_index(1)
	
	#this condition for placement any object
	if !Global.place_tile:
		#this condition for placing item into level
		if current_item != null and can_place and Input.is_action_just_pressed("mb_left"):
			var new_item = current_item.instantiate()
			level.add_child(new_item)
			new_item.global_position = get_global_mouse_position()
		if can_place and Input.is_action_pressed("ctrl+left"):
			pass
	else:
		if can_place and Input.is_action_pressed("mb_left"):
			#this condition for placing tile into level
			place_tile()
		if can_place and Input.is_action_pressed("ctrl+left"):
			del_tile()
	
	
	move_editor(delta)
	is_panning = Input.is_action_pressed("mb_middle")
	pass

func place_tile():
	global_position = get_global_mouse_position()
	var mousepos = tile_map.local_to_map(global_position)
	tile_map.set_cell(layertile_id, mousepos,Global.current_tile,Vector2i(0,0))
	
func del_tile():
	global_position = get_global_mouse_position()
	var mousepos = tile_map.local_to_map(global_position)
	tile_map.set_cell(layertile_id, mousepos,-1,Vector2i(0,0))

func move_editor(delta):
	var dir = Input.get_vector("a","d","w","s")
	editor.global_position += dir * 1000 * delta
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				editor_cam.zoom += Vector2(0.1,0.1)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				editor_cam.zoom -= Vector2(0.1,0.1)
	if event is InputEventMouseMotion:
		if is_panning:
			editor.global_position -= event.relative * editor_cam.zoom

