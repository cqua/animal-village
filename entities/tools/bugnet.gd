extends Node3D

signal bug_catch

func _on_area_3d_area_entered(area):
	if area is Insect and Player.current_action == Player.Action.Attack:
		area.collect()
