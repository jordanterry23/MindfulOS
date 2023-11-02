extends Control

func _ready():
	$AnimationPlayer.play("fade_in")
	


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "fade_in"):
		$AnimationPlayer/ColorRect/VBoxContainer/UnderstandButton.disabled = false
	
	if(anim_name == "fade_out"):
		SceneManager.go_to_next_scene()


func _on_understand_button_pressed():
	$AnimationPlayer.play("fade_out")
