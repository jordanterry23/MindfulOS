extends CollisionShape2D

func _draw():
	
	if self.shape is CircleShape2D:
		draw_circle(position, self.shape.radius, debug_color)
	elif  self.shape is RectangleShape2D:
		draw_rect(shape.get_rect(), debug_color, true)
		
