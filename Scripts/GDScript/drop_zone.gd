extends Area2D

class_name DropZone

@export var thought_group : Thought.GROUPS
var animationQueue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if thought_group == Thought.GROUPS.DARK:
		%Label.text = "Reprocess"
	else:
		%Label.text = str(Thought.GROUPS.keys()[thought_group]).capitalize()
	%AnimatedSprite2D.animation = "Close"
	%AnimatedSprite2D.frame = 4
			
func resize():
	$CollisionShape2D.position = $PanelContainer.size/2
	$CollisionShape2D.shape.size = $PanelContainer.size

func drop_success():
		%AnimatedSprite2D.play("Accept")

func drop_fail():
	%AnimatedSprite2D.stop()
	%AnimatedSprite2D.play("Reject")
		
func play_next_animation():
	if !animationQueue.is_empty():
		var animation = animationQueue.pop_front()
		%AnimatedSprite2D.play(animation)

func queue_animation(animationName : String):
	if %AnimatedSprite2D.is_playing() and %AnimatedSprite2D.animation == animationName:
		return
	animationQueue.append(animationName)
	if !%AnimatedSprite2D.is_playing():
		play_next_animation()


func _on_area_entered(area):
	if area != null:			
		%AnimatedSprite2D.play("Open")


func _on_area_exited(area):
	if area != null:
		if %AnimatedSprite2D.animation == "Accept":
			queue_animation("Close")
		else:
			%AnimatedSprite2D.play("Close")
