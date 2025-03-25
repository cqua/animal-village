extends Control
class_name Logger

@onready var log_entry_prefab = preload("res://ui/logger/log_entry.tscn")

func log(message:String, color:Color=Color.WHITE):
	var entry = log_entry_prefab.instantiate()
	entry.text = message
	entry.modulate = color
	$VBoxContainer.add_child(entry)
