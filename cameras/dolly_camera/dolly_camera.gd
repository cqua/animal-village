extends Node3D
class_name CameraController

static var _instance:CameraController
@onready var _camera:=$Camera3D

func _ready():
	_instance = self

func _process(delta):
	if Player.is_instanced():
		var offset = Vector2.from_angle(Player.get_angle()) * .4
		var target_position = Player.get_position() + Vector3(offset.x, 0, offset.y)
		
		position = Vector3(
			lerpf(position.x, target_position.x,.15),
			lerpf(position.y, target_position.y,.15),
			lerpf(position.z, target_position.z,.15)
		)

static func screen_to_world(scrpos:Vector2, depth:float) -> Vector3:
	return _instance._camera.project_position(scrpos, depth)

static func world_to_screen(wldpos:Vector3):
	return _instance._camera.unproject_position(wldpos)
