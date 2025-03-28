extends Resource
class_name Player

static var _controller:PlayerController

static var standing_still_timer:float

static func is_instanced():
	if _controller:
		return true
	return false

static func set_controller(c:PlayerController):
	_controller = c

static func get_position() -> Vector3:
	return _controller.position

static func get_angle() -> float:
	return _controller.facing_angle

static func look_at(object:Node3D):
	var direction := (object.global_position - _controller.global_position).normalized()
	_controller.force_rotation(Vector2(direction.x,direction.z).angle())
