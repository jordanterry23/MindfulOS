using Godot;

public partial class ThoughtBubble : PanelContainer
{
	[Export] public ThoughtGroup group;
	[Export] Area2D area;

	GlobalSignals gs;
	Vector2 spawnPos;
	Vector2 dragOffset = new Vector2();
	DropZone currentDropZone = null;
	bool selected = false;

	public override void _Ready()
	{
		gs = GetNode<GlobalSignals>("/root/GlobalSignals");
		spawnPos = Position;
		area.Position = new Vector2(Size.X / 2, Size.Y / 2);
		dragOffset = new Vector2(Size.X/2, Size.Y/2);
	}

	public void OnGuiInput(InputEvent input)
	{
		if(input.IsActionPressed("Click"))
		{
			GD.Print("Clicked.");
			selected = true;
		}

		if (input.IsActionReleased("Click"))
		{
			GD.Print("Released");
			selected = false;
			CheckDrop();
		}

		if (selected)
		{

			GlobalPosition = GetGlobalMousePosition() - dragOffset;
		}


		//if (input is InputEventScreenDrag)
		//{
		//	InputEventScreenDrag drag = (InputEventScreenDrag)input;

		//	Vector2 mousePos = GetGlobalMousePosition();
		//	Vector2 offset = new Vector2(Size.X / 2, Size.Y / 2);
		//	Vector2 newPos = mousePos - offset;
		//	Position = newPos;

			
		//}
		

		
	}

	void CheckDrop()
	{
		if(currentDropZone != null)
		{
			gs.EmitSignal(GlobalSignals.SignalName.OnDropSuccess);
			QueueFree();
		}
	}

	public enum ThoughtGroup
	{
		None,
		Home,
		Work,
		School,
		Social,
		Dark
	}

	public void OnAreaEntered(Area2D area)
	{
		if(area is DropZone)
		{
			GD.Print("Found a dropzone!");
			currentDropZone = (DropZone)area;
		}
	}

	public void OnAreaExited(Area2D area) 
	{
		GD.Print("Exited dropzone.");
		currentDropZone = null;
	}
}
