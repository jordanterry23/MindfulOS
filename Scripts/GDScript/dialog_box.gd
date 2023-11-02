extends PanelContainer

signal closed

#try to find a way to make this more customizable later.
#Could use this in future projects.
func _on_response_button_pressed():
	closed.emit()
	queue_free()


func _on_close_button_pressed():
	closed.emit()
	queue_free()
