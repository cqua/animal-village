extends Node3D
class_name PlayerRender

var target_facing = Vector2.UP

func set_target_facing(facing_angle:float):
	target_facing = Vector2.from_angle(facing_angle)

func _process(delta):
	look_at(global_position + Vector3(target_facing.x,0,target_facing.y), Vector3.UP)

func set_velocity(v:Vector3):
	if(Vector3.ZERO.distance_to(v) > .1):
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Idle")
