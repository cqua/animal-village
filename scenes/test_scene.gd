extends Node3D

func _ready():
	Game.load(self)

func _process(delta):
	if not UI.paused:
		Game.update_clock(delta)
		
		if Input.is_action_just_pressed("OpenMenu"):
			UI.pause()
