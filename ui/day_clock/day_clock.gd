extends Control

func _process(delta):
	var time_label = str(Game.hour) + ':'
	if Game.hour < 10:
		time_label = '0' + time_label
	if Game.minute < 10:
		time_label = time_label + '0'
	time_label = time_label + str(Game.minute)
	
	$Label.text = time_label
