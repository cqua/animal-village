extends Node3D
class_name InteractHighlight

func _ready():
	clear()

func _process(delta):
	if UI.paused:
		visible = false
		return
	
	if Player._controller.interact_target:
		return
	
	if Game.cursor:
		var n = Game.cursor.get_first_interactable()
		if n:
			highlight_node(n)
		else:
			clear()
	else:
		clear()
	
	if visible:
		scale.y = move_toward(scale.y,1,delta*8)
	else:
		scale.y = move_toward(scale.y,0,delta*8)

func highlight_node(obj:Node3D):
	position = obj.position
	visible = true

func clear():
	visible = false
