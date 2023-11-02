extends Node

var current_scene = null
var level_paths: Array[String] = [
	"res://Scenes/splash.tscn",
	"res://Scenes/disclaimer.tscn",
	"res://Scenes/boot_screen.tscn",
	"res://Scenes/Levels/Title.tscn",
	"res://Scenes/Levels/Intro.tscn",
	"res://Scenes/Levels/Tutorial.tscn",
	"res://Scenes/Levels/Level1.tscn",
	"res://Scenes/Levels/Level2.tscn",
	"res://Scenes/Levels/Level3.tscn",
	"res://Scenes/Levels/Level4.tscn",
	"res://Scenes/Levels/Level5.tscn",
	"res://Scenes/Levels/system_crash.tscn",
	"res://Scenes/reboot_screen.tscn",
	"res://Scenes/Levels/Level6.tscn",
	"res://Scenes/Levels/Epilogue.tscn",
	"res://Scenes/Levels/Credits.tscn"
]
var level_index = 0

func _ready():
	
	# Get current scene
	# Current scene is always the last child of the root, since autoloads are loaded first.
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	level_index = level_paths.find(current_scene.scene_file_path)

func go_to_next_scene():
	level_index += 1
	if(level_index >= level_paths.size()):
		go_to_main_menu()
	else:
		call_deferred("deferred_go_to_scene", level_paths[level_index])

func go_to_scene(path):
	call_deferred ("deferred_go_to_scene", path)

func go_to_scene_index(index:int):
	if index > 0 and index < level_paths.size():
		level_index = index
		call_deferred("deferred_go_to_scene", level_paths[index])
	else:
		level_index = 0
		call_deferred("deferred_go_to_scene", level_paths[0])
	

func deferred_go_to_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	
	current_scene = s.instantiate()
	
	get_tree().root.add_child(current_scene)
	
	#get_tree().current_scene = current_scene


func go_to_credits():
	level_index = level_paths.find("res://Scenes/Levels/Credits.tscn")
	go_to_scene("res://Scenes/Levels/Credits.tscn")

func go_to_main_menu():
	level_index = level_paths.find("res://Scenes/Levels/Title.tscn")
	go_to_scene(level_paths[level_index])
