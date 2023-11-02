using Godot;
using System;

public partial class DrawCollider : CollisionShape2D
{
	public override void _Draw()
	{
		if(Shape is CircleShape2D)
		{
			CircleShape2D circle = (CircleShape2D)Shape;
			DrawCircle(Position, circle.Radius, Color.Color8(100,100,255,255));
		}
		else if (Shape is RectangleShape2D)
		{
			RectangleShape2D rectShape = (RectangleShape2D)Shape;
			Vector2 offset = new Vector2(Position.X - (rectShape.Size.X / 2), Position.Y - (rectShape.Size.Y / 2));
			Rect2 rect = new Rect2(offset, rectShape.Size.X, rectShape.Size.Y );
			DrawRect(rect, DebugColor, true);
		}
		
	}
}
