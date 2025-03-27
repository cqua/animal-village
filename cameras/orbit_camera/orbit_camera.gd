extends Node3D

@export var camera_distance=4.0
var speed = 3.0

func _process(delta):
	$YAxis/Height/Camera3D.position = Vector3.BACK * camera_distance
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	
	$YAxis.rotate_y(input_dir.x*delta * speed)
	var new_height = $YAxis/Height.rotation.x + input_dir.y*delta * speed
	
	if (clampf(new_height,-PI/2,0) == new_height):
		$YAxis/Height.rotate_x(input_dir.y*delta * speed)
