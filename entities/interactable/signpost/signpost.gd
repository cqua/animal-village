extends Interactable

func _ready():
	interact_radius = .5

func interact():
	Player.look_at($StaticBody)
	UI.queue_dialog(
		'They say there\'s an acorn on this beach.')

func get_label():
	return 'Read'
