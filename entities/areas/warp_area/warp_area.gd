extends Area3D

@export var path:String


func _on_body_entered(body):
	if body is PlayerController:
		body.force_move_to(position)
		Player.reset_action()
		Game.load_scene(path)
