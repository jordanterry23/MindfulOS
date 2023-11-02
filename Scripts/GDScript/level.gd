extends Node

class_name Level

var thoughts_empty = false
var thoughts_put_away = false
@export var dark_version : bool = false

func _ready():
	thoughts_empty = false
	thoughts_put_away = false
	
	if !dark_version:
		Music.play_mindful()
	elif(dark_version and Music.playing == false):
		Music.play_dark()

func _on_spawn_manager_thoughts_empty():
	if dark_version:
		SceneManager.go_to_next_scene()
	
	thoughts_empty = true
	_check_level_completion()

func _on_spawn_manager_thoughts_put_away():
	thoughts_put_away = true
	_check_level_completion()
	
func _check_level_completion():
	if thoughts_empty and thoughts_put_away:
		$Transitioner.fade_out()

func _on_dialog_box_closed():
	$SpawnManager.start()

func _on_transitioner_faded_out():
	SceneManager.go_to_next_scene()
	

func _on_settings_menu_settings_closed():
	$SettingsMenu.visible = false
