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

func unpause():
	pause_buffer.start()
	paused = false
	if current_menu:
		current_menu.queue_free()
		current_menu = null
	Game.time_scale = 1
