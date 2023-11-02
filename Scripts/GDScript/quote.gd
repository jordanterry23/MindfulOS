extends AnimationPlayer

func _ready():
	play("fade_out")




func _on_animation_finished(_anim_name):
	%MessageReader.display_messages()
