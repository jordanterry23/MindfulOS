extends Control

class_name ThoughtBubble

var selected = false
var currentDropZone
var spawn_position : Vector2

var thought : Thought
var offset

func set_thought(new_thought : Thought):
	thought = new_thought
	%Label.text = thought.text

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_position = position
	$PanelContainer.position = -$PanelContainer.size / 2
	if thought != null:
		%Label.text = thought.text
		if(thought.group == Thought.GROUPS.DARK):
			$PanelContainer.theme_type_variation = "DarkPanel"
			$%Label.theme_type_variation = "DarkLabel"

func _on_gui_input(event):	
	if event.is_action_pressed("Click"):
		selected = true
	
	if event.is_action_released("Click"):
		selected = false
		check_drop()
	
	if selected:
		var mouse_pos = get_global_mouse_position()
		var new_pos = Vector2(clamp(mouse_pos.x, 0, get_viewport_rect().size.x),clamp(mouse_pos.y, 0, get_viewport_rect().size.y  - 42))
		
		position = new_pos

func check_drop():
	if currentDropZone != null:
		if currentDropZone.thought_group == thought.group:
			gSignals.drop_successful.emit(self.thought)
			currentDropZone.drop_success()
			queue_free()
		else:
			gSignals.emit_signal(gSignals.drop_fail.get_name())
			currentDropZone.drop_fail()

func resize():
	offset = -$PanelContainer.size / 2
	$PanelContainer.position = offset
	$PanelContainer/Area2D.position = $PanelContainer.size / 2


func _on_area_2d_area_entered(area):
	if area is DropZone:
		currentDropZone = area


func _on_area_2d_area_exited(_area):
	if currentDropZone != null:
		currentDropZone = null


func _on_mouse_entered():
	move_to_front()
	$PanelContainer.size *= 1.1
	


func _on_mouse_exited():
	$PanelContainer.size /= 1.1
	

