using Godot;
using System;

public partial class GameAudio : AudioStreamPlayer2D
{
	GlobalSignals gs;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		gs = GetNode<GlobalSignals>("/root/GlobalSignals");
		gs.OnDropSuccess += OnDropSuccess;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void OnDropSuccess()
	{
		Play();
	}
}
