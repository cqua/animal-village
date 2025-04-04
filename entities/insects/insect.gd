extends Area3D
class_name Insect

@export var item:Item
var home_position:Vector2
var home_range := 3.0
var speed := .3
var turning_speed := 1.5
var target_angle:float
var movement_timer:float
var facing_angle:float
var running_away:bool = false

@onready var model = $Ant

func _ready():
	home_position = Vector2(position.x,position.z)
	target_angle = randf() * PI * 2
	
func _process(delta):
	if movement_timer > 0 or running_away:
		movement_timer -= delta
		facing_angle = move_toward(facing_angle, target_angle, delta * turning_speed)
		var direction = Vector2.from_angle(facing_angle)
		position += Vector3(direction.x, 0, direction.y) * speed * delta
		model.look_at(global_position + Vector3(direction.x,0,direction.y), Vector3.UP)
	else:
		movement_decision()

func collect():
	if Inventory.add_item(item):
		queue_free()

func movement_decision():
	var position2d = Vector2(position.x,position.z)
	if position2d.distance_to(home_position) > home_range:
		target_angle = (home_position - position2d).angle()
	else:
		var r = randi() % 2
		if r == 0:
			target_angle = target_angle + PI/4
		else:
			target_angle = target_angle - PI/4
		
	movement_timer = randf() * 4 + 3

func run_away():
	running_away = true
	target_angle = PI
	facing_angle = target_angle
	speed *= 8
