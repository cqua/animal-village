extends Control

var timer:float

var show := false

func _process(delta):
	if UI.paused:
		visible = false
		return
	else:
		visible = true
		
	timer += delta
	
	if Game.cursor and Player.standing_still_timer > .6:
		position = UI.get_mouse_position_screen() + Vector2.UP * 40
		timer = 0
		var n = Game.cursor.get_first_interactable()
		if n:
			set_text(n.get_label())
		else:
			clear_text()
	else:
		clear_text()
	
	if show:
		scale.y = move_toward(scale.y,1,delta*8)
	else:	
		scale.y = move_toward(scale.y,0,delta*8)

func set_text(text:String):
	$Label.text = text
	show = true

func clear_text():
	show = false
