extends Control

func _ready():
	if Music.playing:
		Music.stop()
	$AnimationPlayer.play("fade")


func _on_animation_player_animation_finished(_anim_name):
	SceneManager.go_to_next_scene()
	pass # Replace with function body.
