extends CanvasLayer

var Logger:Logger
var DayClock
var paused = false

var current_menu:Control
var InteractLabel:Control

@onready var pause_buffer := $PauseBuffer

func _ready():
	Logger = load("res://ui/logger/logger.tscn").instantiate()
	add_child(Logger)
	InteractLabel = load("res://ui/interact_label/interact_label.tscn").instantiate()
	add_child(InteractLabel)
	DayClock = load("res://ui/day_clock/day_clock.tscn").instantiate()
	add_child(DayClock)
	
func _process(delta):
	if paused:
		if Input.is_action_just_pressed("OpenMenu"):
			UI.unpause()

func log(message, color=Color.WHITE):
	Logger.log(str(message), color)

func pause():
	if pause_buffer.time_left>0:
		return
	
	paused = true
	if current_menu:
		current_menu.queue_free()
		current_menu = null
	
	current_menu = InventoryMenu.open()
	add_child(current_menu)
	Game.time_scale = 0

func unpause():
	pause_buffer.start()
	paused = false
	if current_menu:
		current_menu.queue_free()
		current_menu = null
	Game.time_scale = 1

func display_interact_label():
	InteractLabel.visible=true
	
func hide_interact_label():
	InteractLabel.visible=false
