extends Control

var target_alpha:float
var speed:float

signal transition_finished

func _process(delta):
	if speed > 0:
		modulate.a = move_toward(modulate.a, target_alpha, delta * speed)
		if modulate.a == target_alpha:
			transition_finished.emit()
			speed = 0

func fadeout(seconds:float):
	seconds = clampf(seconds,0.001,10)
	speed = 1/seconds
	target_alpha = 1
	modulate.a = 0

func fadein(seconds:float):
	seconds = clampf(seconds,0.001,10)
	speed = 1/seconds
	target_alpha = 0
	modulate.a = 1
