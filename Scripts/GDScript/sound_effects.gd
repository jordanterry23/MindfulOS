extends AudioStreamPlayer2D

var success_sound = ResourceLoader.load("res://Audio/ButtonPress.wav")
var fail_sound = ResourceLoader.load("res://Audio/Hit.wav")
var text_sounds = [
	ResourceLoader.load("res://Audio/keyboard_clicks-01.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-02.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-03.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-04.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-05.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-06.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-07.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-08.wav"),
	ResourceLoader.load("res://Audio/keyboard_clicks-09.wav"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	gSignals.drop_successful.connect(_on_drop_success)
	gSignals.drop_fail.connect(_on_drop_fail)
	bus = "SFX"

func _on_drop_success(_thought):
		stream = success_sound
		play()

func _on_drop_fail():
		stream = fail_sound
		play()

func play_test_sound():
	stream = fail_sound
	play()

func play_text_sound():
	stream = text_sounds.pick_random()
	play()
