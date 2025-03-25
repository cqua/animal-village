extends Panel
class_name Cursor

var target_position:Vector2

func _process(delta):
	position = Vector2(
		lerpf(position.x,target_position.x,.35),
		#move_toward(position.x,target_position.x,delta),
		lerpf(position.y,target_position.y,.35)
		#move_toward(position.y,target_position.y,delta)
	)

func move_to(_position:Vector2):
	target_position = _position
