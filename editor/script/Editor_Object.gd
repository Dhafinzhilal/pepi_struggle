extends Node2D

var can_place = true
var is_panning = true
var do_save = false

@onready var level = get_node("/root/main/Level")
@onready var editor = get_node("/root/main/cam_container")
@onready var editor_cam = editor.get_node("Camera2D")
@onready var in_game_cam = level.get_node("CameraManipulation")
@onready var editor_container = get_node("/root/main/item_select/Control")
@onready var tab_container = get_node("/root/main/item_select/Control/TabContainer")
@onready var panel_layout = get_node("/root/main/item_select/Control/PanelLayoutTile/VBoxContainer")
@onready var optionbutton1 = panel_layout.get_node("LayerOption")
@onready var tile_map : TileMap = level.get_node("TileMap")
@onready var popup_filesystem: FileDialog = get_node("/root/main/item_select/FileDialog")

var level_children = []
var current_item
var layertile_id :int


func _ready():
	editor_cam.enabled = true
	pass # Replace with function body.

func _process(delta):
	global_position = get_global_mouse_position()
	Global.current_layertile = layertile_id
	
	#this condition for placement any object
	if !Global.place_tile:
		#this condition for placing item into level
		if !Global.filesystem_shown:
			if current_item != null and can_place and Input.is_action_just_pressed("mb_left"):
				
				var new_item = current_item.instantiate()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()
			if Input.is_action_just_pressed("mb_right"):
				pass
	else:
		if !Global.filesystem_shown:
			if can_place and Input.is_action_pressed("mb_left"):
				#this condition for placing tile into level
				place_tile()
			if can_place and Input.is_action_pressed("mb_right"):
				del_tile()
	
	if !Global.filesystem_shown:
		if Input.is_action_just_pressed("o"):
			can_place = false
			Global.playing = !Global.playing
			editor_container.visible = !Global.playing
	
		if !Global.playing:
			move_editor(delta)
			is_panning = Input.is_action_pressed("mb_middle")
	
	if Input.is_action_just_pressed("ctrl+s"):
		Global.filesystem_shown = true
		do_save = true
		@warning_ignore("int_as_enum_without_cast")
		popup_filesystem.file_mode = 4
		popup_filesystem.show()
	
	if Input.is_action_just_pressed("ctrl+l"):
		Global.filesystem_shown = true
		do_save = true
		@warning_ignore("int_as_enum_without_cast")
		popup_filesystem.file_mode = 0
		popup_filesystem.show()
		
	get_level_children()

func place_tile():
	global_position = get_global_mouse_position()
	var mousepos = tile_map.local_to_map(global_position)
	tile_map.set_cell(layertile_id, mousepos,Global.current_tile,Vector2i(0,0),Global.is_tile_scene)
	
func del_tile():
	global_position = get_global_mouse_position()
	var mousepos = tile_map.local_to_map(global_position)
	tile_map.set_cell(layertile_id, mousepos,-1,Vector2i(-1,-1))

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

func save_level():
	var toSave: PackedScene = PackedScene.new()
	tile_map.owner = level
	toSave.pack(level)
	ResourceSaver.save(toSave,popup_filesystem.current_path + ".tscn")
	pass

func load_level():
	var toLoad: PackedScene = PackedScene.new()
	toLoad = ResourceLoader.load(popup_filesystem.current_path)
	var this_level = toLoad.instantiate()
	get_parent().remove_child(level)
	level.queue_free()
	get_parent().add_child(this_level)
	tile_map = get_parent().get_node("Level/TileMap")
	level = this_level
	
func get_level_children():
	for child in level.get_children():
		if child.get_class() not in ["Camera2D", "TileMap"]:
			level_children.append(child)
	return level_children

func _on_file_dialog_confirmed():
	if popup_filesystem.title == "Save a Level":
		save_level()
	else:
		load_level()
	do_save = false
	Global.filesystem_shown = false
	pass

func _on_file_dialog_canceled():
	do_save = false
	Global.filesystem_shown = false
	pass 
