extends Node

var playing = 0
var current_tile = 0
var place_tile = false
var current_layertile = 0
var is_tile_scene = 0
var in_menu = false
var is_on_zipline = false
var end_trans = false


var phase = 0

var transition_block = false
var transition_block2 = false
var is_tutorial = false
var transmission = 0

var filesystem_shown = false

func reset_var():
	Global.transition_block = false
	Global.transition_block2 = false
	Global.in_menu = false
	Global.transmission = 0
	Global.playing = false
	Global.is_on_zipline = false
	Global.end_trans = false
	Music.stop()

func in_trans():
	await get_tree().create_timer(0.4).timeout
	LayerTransition.play_anim(false)
	await get_tree().create_timer(1).timeout
	Global.transmission = 1
	Global.end_trans = true

func any_trans():
	await get_tree().create_timer(0.4).timeout
	LayerTransition.play_anim(false)
