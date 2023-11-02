extends Node

func _ready():
	Music.play_mindful()


func _on_settings_menu_settings_closed():
	$MainMenu.visible = true
	$SettingsMenu.visible = false


func _on_main_menu_navigate_to_settings():
	$MainMenu.visible = false
	$SettingsMenu.visible = true
