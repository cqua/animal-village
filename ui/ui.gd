extends CanvasLayer

@onready var transition_prefab := preload("res://ui/transitions/fade/transition_rect.tscn")
var logger:Logger
var DayClock
var dialog_box:Control
var paused = false

var current_menu:Control
var InteractLabel:Control

var transition_rect:Control

@onready var pause_buffer := $PauseBuffer

func _ready():
	logger = load("res://ui/logger/logger.tscn").instantiate()
	add_child(logger)
	InteractLabel = load("res://ui/interact_label/interact_label.tscn").instantiate()
	add_child(InteractLabel)
	DayClock = load("res://ui/day_clock/day_clock.tscn").instantiate()
	add_child(DayClock)
	dialog_box = load("res://ui/dialog_box/dialog_box.tscn").instantiate()
	add_child(dialog_box)
	dialog_box.dialog_ended.connect(unpause.bind())

func log(message, color=Color.WHITE):
	logger.log(str(message), color)
	
func get_camera() -> Camera3D:
	var viewport := get_viewport()
	return viewport.get_camera_3d()

func get_mouse_position_screen() -> Vector2:
	return get_viewport().get_mouse_position()

func get_mouse_position_world() -> Vector3:
	var camera := get_camera()
	var mouse_position = get_mouse_position_screen()
	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var end := origin + direction * camera.far
	var space_state := camera.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	var result := space_state.intersect_ray(query)
	
	if result.is_empty():
		return end
	return result["position"]

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
	current_menu.closed.connect(unpause.bind())

func unpause():
	pause_buffer.start()
	paused = false
	if current_menu:
		current_menu.queue_free()
		current_menu = null
	Game.time_scale = 1

func queue_dialog(message:String):
	paused = true
	dialog_box.queue(message)

func fade_out():
	paused = true
	if transition_rect:
		transition_rect.queue_free()
		transition_rect = null
	
	transition_rect = transition_prefab.instantiate()
	add_child(transition_rect)
	transition_rect.fadeout(.5)
	await transition_rect.transition_finished

func fade_in():
	if transition_rect:
		transition_rect.queue_free()
		transition_rect = null
	
	transition_rect = transition_prefab.instantiate()
	add_child(transition_rect)
	transition_rect.fadein(.5)
	await transition_rect.transition_finished
	paused = false
