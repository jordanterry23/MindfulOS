extends Control

signal navigate_to_settings

func _on_start_button_toggled(button_pressed):
	$PopUpMenu.visible = button_pressed
	if button_pressed == false:
		%StartButton.release_focus()
		


func _on_settings_button_pressed():
	%StartButton.set_pressed(false)
	%StartButton.release_focus()
	print("Settings Button Pressed.")
	navigate_to_settings.emit()



func _on_main_menu_button_pressed():
	%StartButton.set_pressed(false)
	%StartButton.release_focus()
	SceneManager.go_to_main_menu()

