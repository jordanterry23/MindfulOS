extends Node

@export var reboot = false

func _ready():
	if reboot:
		$AnimationPlayer.play("reboot")
	else:
		$AnimationPlayer.play("boot")
		

func _on_animation_player_animation_finished(_anim_name):
	SceneManager.go_to_next_scene()
