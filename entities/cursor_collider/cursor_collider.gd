extends Node3D
class_name CursorCollider

var interactables:Array[Interactable]
var _bodies:Array[Node3D]

func _process(delta):
	global_position = UI.get_mouse_position_world()

func get_first_interactable():
	interactables = interactables.filter(func(n): return is_instance_valid(n))
	interactables.sort_custom(
		func(a, b): 
			return (global_position.distance_to(a.global_position) < 
				global_position.distance_to(b.global_position)))
	if interactables.size() > 0:
		return interactables[0]

func _on_area_3d_area_entered(area:Area3D):
	if area is Interactable:
		interactables.push_back(area)

func _on_area_3d_area_exited(area):
	for i in range(0,interactables.size()):
		if interactables[i]==area:
			interactables.remove_at(i)
			return

func _on_area_3d_body_entered(body):
	_bodies.push_back(body)

func _on_area_3d_body_exited(body):
	for i in range(0,_bodies.size()):
		if _bodies[i]==body:
			_bodies.remove_at(i)
			return
