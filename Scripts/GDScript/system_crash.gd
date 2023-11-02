extends Node

func _ready():
	Music.connect(Music.stopped.get_name(), _on_music_stopped)
	Music.slow_to_stop()

func _on_music_stopped():
	display_text()
	
func display_text():
	%CriticalSystemFailureLabel.visible = true
	$Timer.start(5)
	await $Timer.timeout
	%ErrorText.visible = true
	$Timer.start(3)
	await $Timer.timeout
	%ErrorText.text += "\nThe system has detected a critical error and needs to restart."
	$Timer.start(3)
	await $Timer.timeout
	%ErrorText.text += "\nPlease wait while we attempt recovery."
	$Timer.start(3)
	await $Timer.timeout
	var count = 0
	while(count < 3):
		%AttemptingRecoveryLabel.text = "Attempting Recovery"
		for dot in 3:
			%AttemptingRecoveryLabel.text += "."
			$Timer.start(1)
			await $Timer.timeout
		
		count += 1
		
	%AttemptingRecoveryLabel.text += "\nRecovery completed. The system will reboot shortly."
	
	$Timer.start(5)
	await $Timer.timeout
	
	SceneManager.go_to_next_scene()
