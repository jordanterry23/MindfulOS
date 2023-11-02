extends Node

class_name MessageReader

signal finished

@export var start_on_ready:bool = true

@export var message  = [
	"You are your own worst enemy,",
	"but never forget that you don't have to fight alone.",
	"Be kind to yourself, even when it's hard.",
]

func _ready():
	if (start_on_ready):
		display_messages()

func display_messages():
	
	while message.size() > 0:
		var line = message.pop_front()
		$Message.text += "\n"
		for letter in line:
			SFX.play_text_sound()
			$Message.text += letter
			$LetterTimer.start()
			await $LetterTimer.timeout
	
		$LineTimer.start()
		await $LineTimer.timeout
	
	finished.emit()


func _on_finished():
	$FinishTimer.start()
	await $FinishTimer.timeout
	$Transitioner.fade_out()


func _on_transitioner_faded_out():
	SceneManager.go_to_next_scene()
