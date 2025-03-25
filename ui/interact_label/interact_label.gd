extends Control

var timer:float

func _process(delta):
	if not visible:
		timer = 1
		clear_text()
		return
	
	timer += delta
	
	position = CameraController.world_to_screen(Player.get_position()) + Vector2.UP * 80
	if timer > .15:
		timer = 0
		var n = Player.get_first_interactable()
		if n:
			set_text(n.item.name)
		else:
			clear_text()
	

func set_text(text:String):
	$Label.text = text
	$Label.visible=true

func clear_text():
	$Label.text = ''
	$Label.visible=false
