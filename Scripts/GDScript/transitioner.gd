extends Control

signal faded_out

func fade_out():
	$AnimationPlayer.play("fade_out")

func _ready():
	$AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "fade_out"):
		faded_out.emit()
