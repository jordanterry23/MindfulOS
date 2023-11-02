extends AudioStreamPlayer2D

signal stopped

var mindful = ResourceLoader.load("res://Audio/Ever Mindful.mp3")
var dark = ResourceLoader.load("res://Audio/Gathering Darkness.mp3")
var state = PAUSED

enum {
	PAUSED,
	MINDFUL,
	DARK
}

func _ready():
	bus = "Music"

func play_dark():
	if stream != dark:
		stream = dark
		state = DARK
		play()

func play_mindful():
	if state != MINDFUL:
		stream = mindful
		state = MINDFUL
		play()

func slow_to_stop():
	var tween = create_tween()
	tween.tween_property(self, "pitch_scale", 0.1, 1)
	tween.tween_callback(on_slowed)
	

func on_slowed():
	stop()
	stopped.emit()
	pitch_scale = 1
