extends Label

func _process(delta):
	if $Timer.time_left < 1:
		self.modulate.a =  $Timer.time_left

func _on_timer_timeout():
	queue_free()
