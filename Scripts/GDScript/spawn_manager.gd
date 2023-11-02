extends Timer

class_name SpawnManager

@export var json_path : String
@export var thought_bubbble : PackedScene
@export var min_spawn_time = 1.0
@export var max_spawn_time = 5.0
@export var spawn_region_min: Vector2
@export var spawn_region_max: Vector2
@export var shuffle = true
@export var slow_mode = false
var thoughts = []
var thoughtCount = 0
var darkThoughtCount = 0

signal thoughts_empty
signal thoughts_put_away

# Called when the node enters the scene tree for the first time.
func _ready():	
	gSignals.start_level.connect(start)
	gSignals.drop_successful.connect(_on_drop_success)
	timeout.connect(on_timeout)
	randomize()
	get_random_wait_time()
	
	get_thoughts_from_file(json_path)
	
	if shuffle:
		thoughts.shuffle()

func get_thoughts_from_file(path: String):
	if !FileAccess.file_exists(path):
		printerr("Spawn Manager: Thoughts json does not exist at " + path)
		get_tree().quit()
	var import = FileAccess.open(path,FileAccess.READ)
	
	var data = JSON.parse_string(import.get_as_text()) as Dictionary
	
	for thought_data in data["thoughts"]:
		var thought = Thought.new(
				Thought.GROUPS.get(thought_data["group"]), 
				thought_data["text"]
			)
		
		thoughts.append(thought)
		
	
func on_timeout():
	if(thoughts.size() > 0):
		spawn_item()
		
	if slow_mode:
		stop()
			
	get_random_wait_time()

func get_random_wait_time():
	wait_time = randf_range(min_spawn_time, max_spawn_time)

func get_random_spawn_position() -> Vector2:
	var x = randf_range(spawn_region_min.x, spawn_region_max.x)
	var y = randf_range(spawn_region_min.y, spawn_region_max.y)
	
	return Vector2(x,y)
	
func spawn_item():
	var instance := thought_bubbble.instantiate() as ThoughtBubble
	instance.thought = thoughts.pop_front()
	instance.global_position = get_random_spawn_position()
	add_child(instance)
	if !instance.thought.group == Thought.GROUPS.DARK:	
		thoughtCount += 1
	else:
		if Music.state == Music.MINDFUL:
			Music.play_dark()
		
	if !thoughts.size() > 0:
		thoughts_empty.emit()
		if thoughtCount == 0:
			thoughts_put_away.emit()

func _on_drop_success(thought: Thought):
	
	if thought.group == Thought.GROUPS.DARK:
		darkThoughtCount -= 1
		if darkThoughtCount <= 0:
			Music.play_mindful()
	else:
		thoughtCount -= 1
	
	if thoughtCount == 0 and !thoughts.size() > 0:
		thoughts_put_away.emit()
		
	if slow_mode:
		start()
