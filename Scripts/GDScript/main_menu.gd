extends PanelContainer

signal navigate_to_settings

func _ready():
	Music.play_mindful()

func _on_start_button_pressed():
	SceneManager.go_to_next_scene()


func _on_settings_button_pressed():
	navigate_to_settings.emit()
	

func _on_credits_button_pressed():
	SceneManager.go_to_credits()
