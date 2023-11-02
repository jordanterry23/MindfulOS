using Godot;
using System;
using System.Runtime.CompilerServices;

public partial class DropZone : Area2D
{
	[Export] CollisionShape2D collider;
	[Export] PanelContainer panel;
	[Export] public CenterContainer container;
	RectangleShape2D rect;

	public override void _Ready()
	{
		rect = collider.Shape as RectangleShape2D;
		OnResize();
	}

	public void OnResize()
	{
		Vector2 offset = panel.Size / 2;
		rect.Size = panel.Size;
		collider.Position = offset;
	}

}
