extends Resource
class_name Player

enum Action {
	None,
	Ready,
	Attack,
	Run
}

static var _controller:PlayerController
static var _render:PlayerRender

static var standing_still_timer:float

static var current_tool:Item
static var current_action:Action

static func is_instanced():
	if _controller:
		return true
	return false

static func set_controller(c:PlayerController):
	_controller = c

static func set_render(r:PlayerRender):
	_render = r

static func get_position() -> Vector3:
	return _controller.position

static func get_angle() -> float:
	return _controller.facing_angle

static func look_at(object:Node3D):
	var direction := (object.global_position - _controller.global_position).normalized()
	_controller.force_rotation(Vector2(direction.x,direction.z).angle())

static func get_interact_target():
	if _controller and _controller.interact_target:
		return _controller.interact_target
	else:
		return null

static func swap_tool():
	if current_tool:
		current_tool = null
	else:
		current_tool = Item.TOOL_BUGNET
	
	_render.update_tool()

static func set_action(action:Action):
	current_action = action

static func reset_action():
	current_action = Action.None

static func bug_catch(bug:Insect):
	bug.interact()
