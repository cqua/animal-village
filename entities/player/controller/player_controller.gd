extends CharacterBody3D
class_name PlayerController

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var render : PlayerRender

var target_facing_angle:float
var facing_angle:float

var input_dir:Vector2
var pause_buffer:float
var standing_still_timer:float

func _ready():
	Player.set_controller(self)
	
	for child in get_children():
		if child is PlayerRender:
			render = child

func _process(delta):
	if UI.paused:
		input_dir = Vector2.ZERO
		pause_buffer = .15
		UI.hide_interact_label()
		
	elif pause_buffer > 0:
		pause_buffer -= delta
	else:
		if Input.is_action_just_pressed("Confirm"):
			print(Player._interactables.size())
			Player.interact()
		
		input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if input_dir.x != 0 or input_dir.y != 0:
			standing_still_timer = 0
		else:
			standing_still_timer += delta
		
		if standing_still_timer > .15:
			UI.display_interact_label()
		else:
			UI.hide_interact_label()

func _physics_process(delta):
	delta *= Game.time_scale
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if input_dir.x != 0 or input_dir.y != 0:
		target_facing_angle = input_dir.normalized().angle()
		facing_angle = lerp_angle(facing_angle,target_facing_angle, .15)
		
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	render.set_target_facing(facing_angle)
