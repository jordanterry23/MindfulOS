extends Node

var animation_queue = [
	"MindfulOS", 
	"Created", 
	"Directed", 
	"AssistantDirector", 
	"Artwork", 
	"Font",
	"Logo", 
	"Sounds", 
	"Music", 
	"Playtesters", 
	"SpecialThanks",
	"Disclaimer",
	"MadeWithGodot"
]

func _ready():
	Music.play_mindful()
	play_next_animation()

func play_next_animation():
	$AnimationPlayer.play(animation_queue.pop_front())


func _on_animation_player_animation_finished(_anim_name):
	if animation_queue.is_empty():
		SceneManager.go_to_next_scene()
	else:
		play_next_animation()
