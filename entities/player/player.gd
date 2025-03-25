extends Resource
class_name Player

static var _controller

static var _interactables:Array[Node3D]

static func set_controller(c:PlayerController):
	_controller = c

static func get_position() -> Vector3:
	return _controller.position

static func get_angle() -> float:
	return _controller.facing_angle

static func add_interactable(node:Node3D):
	_interactables.push_back(node)
	
static func remove_interactable(node:Node3D):
	for i in range(0,_interactables.size()):
		if _interactables[i]==node:
			_interactables.remove_at(i)
			return

static func interact():
	var n = get_first_interactable()
	if n:
		_interactables.pop_front()
		n.interact()
		return

static func get_first_interactable():
	_interactables = _interactables.filter(func(n): return is_instance_valid(n))
	_interactables.sort_custom(
		func(a, b): 
			return (_controller.global_position.distance_to(a.global_position) < 
				_controller.global_position.distance_to(b.global_position)))
	if _interactables.size() > 0:
		return _interactables[0]
