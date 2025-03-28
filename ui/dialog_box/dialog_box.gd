extends Control
class_name DialogBox

signal dialog_ended

var timer := 99.0
var show := false
@onready var panel := $PanelContainer
@onready var content := $PanelContainer/MarginContainer/Label

var current_line:String

var text_speed := 40.0

var printing := false

func _ready():
	panel.scale = Vector2.ZERO
	
func _process(delta):
	var target_scale = 0
	if show:
		target_scale = 1
		timer += delta
		if timer > 0:
			if printing:
				var char_index = int(timer * text_speed)
				if char_index < current_line.length() and not Input.is_action_just_pressed('Interact'):
					content.text = current_line.substr(0,char_index)
				else:
					content.text = current_line
					printing = false
			else:
				if Input.is_action_just_pressed('Interact'):
					content.text = ''
					show = false
					dialog_ended.emit()
	
	panel.pivot_offset = panel.size / 2
	panel.scale = Vector2(
		lerpf(panel.scale.x,target_scale,.15),
		lerpf(panel.scale.y,target_scale,.35))

func queue(message:String):
	show = true
	current_line = message
	timer = -.4
	printing = true
