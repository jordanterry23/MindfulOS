extends PanelContainer

signal settings_closed

var sfx_index = AudioServer.get_bus_index("SFX")
var music_index = AudioServer.get_bus_index("Music")

var volume_initialized = false

func _ready():
	%MusicVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(music_index))
	%SoundEffectsVolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_index))

func _on_close_button_pressed():
	visible = false
	settings_closed.emit()


func _on_back_button_pressed():
	visible = false
	settings_closed.emit()


func _on_music_checkbox_toggled(button_pressed):
	AudioServer.set_bus_mute(music_index, !button_pressed)
	%MusicVolumeSlider.visible = button_pressed


func _on_sound_effects_toggled(button_pressed):
	AudioServer.set_bus_mute(sfx_index, !button_pressed)
	%SoundEffectsVolumeSlider.visible = button_pressed


func _on_main_menu_navigate_to_settings():
	visible = true


func _on_sound_effects_volume_slider_value_changed(value):
	
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))


func _on_music_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))
	


func _on_start_menu_navigate_to_settings():
	visible = true


func _on_sound_effects_volume_slider_drag_ended(_value_changed):
	SFX.play_test_sound()
