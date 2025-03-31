extends CharacterBody3D
class_name PlayerController

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const RUN_MULT = 1.6
const TOOL_MULT = .4

var render : PlayerRender

var target_facing_angle:float
var facing_angle:float = PI/2

var input_dir:Vector2
var pause_buffer:float

@onready var nav_agent := $NavigationAgent3D

var interact_target:Node3D
var in_forced_rotation:=false

func _ready():
	Player.set_controller(self)
	
	for child in get_children():
		if child is PlayerRender:
			render = child

func _process(delta):
	if UI.paused:
		input_dir = Vector2.ZERO
		pause_buffer = .15
		clear_interact_target()
		
	elif pause_buffer > 0:
		pause_buffer -= delta
	else:
		if Player.current_action == Player.Action.Attack:
			Player.reset_action()
		if interact_target and position.distance_to(interact_target.global_position) < interact_target.interact_radius:
			Player.reset_action()
			interact_target.interact()
			interact_target = null
		
		if Input.is_action_just_pressed("Interact"):
			Player.reset_action()
			set_interact_target()
		
		elif Input.is_action_just_pressed("SwapTool"):
			Player.reset_action()
			Player.swap_tool()
			pause_buffer = .15
		else:
			input_dir = Input.get_vector("Left", "Right", "Up", "Down")
			
			if Player.current_tool and Input.is_action_just_pressed("UseTool"):
				Player.set_action(Player.Action.Ready)
				interact_target = null
			
			if Player.current_action == Player.Action.Ready and Input.is_action_just_released('UseTool'):
				Player.set_action(Player.Action.Attack)
				pause_buffer = .6
				input_dir = Vector2.ZERO
				render.attack()
		
		if input_dir.x != 0 or input_dir.y != 0:
			if Input.is_action_pressed('Run') and Player.current_action != Player.Action.Run:
				Player.set_action(Player.Action.Run)
			if Input.is_action_just_released('Run') and Player.current_action == Player.Action.Run:
				Player.reset_action()
			Player.standing_still_timer = 0
			clear_interact_target()
		else:
			if Player.current_action == Player.Action.Run:
				Player.reset_action()
				
			Player.standing_still_timer += delta

func _physics_process(delta):
	delta *= Game.time_scale
	
	if in_forced_rotation:
		facing_angle = lerp_angle(facing_angle,target_facing_angle, .15)
		if is_zero_approx(angle_difference(facing_angle,target_facing_angle)):
			in_forced_rotation = false
	else:
	
		if interact_target:
			#follow path to target
			var direction = (nav_agent.get_next_path_position() - position).normalized()
			direction.y = 0
			velocity = direction * SPEED
			target_facing_angle = Vector2(direction.x,direction.z).angle()
			facing_angle = lerp_angle(facing_angle,target_facing_angle, .15)
		
		else:
			# Add the gravity.
			if not is_on_floor():
				velocity += get_gravity() * delta

			if input_dir.x != 0 or input_dir.y != 0:
				if Player.current_action != Player.Action.Ready:
					target_facing_angle = input_dir.normalized().angle()
				
				var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
				if Player.current_action == Player.Action.Ready:
					velocity *= TOOL_MULT
				if Player.current_action == Player.Action.Run:
					velocity *= RUN_MULT
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
		
		if Player.current_action == Player.Action.Ready:
			var cursor_pos = Game.cursor.global_position
			var vector_to_cursor = cursor_pos - global_position
			target_facing_angle = Vector2(vector_to_cursor.x, vector_to_cursor.z).normalized().angle()
		
		if velocity.x != 0 or velocity.z != 0 or Player.current_action == Player.Action.Ready:
			facing_angle = lerp_angle(facing_angle,target_facing_angle, .15)
		render.set_velocity(velocity)
	render.set_target_facing(facing_angle)

func set_interact_target():
	var target = Game.cursor.get_first_interactable()
	if target:
		interact_target = target
		nav_agent.target_position = interact_target.global_position

func clear_interact_target():
	interact_target = null

func force_rotation(angle):
	target_facing_angle = angle
	in_forced_rotation = true
	render.set_velocity(Vector3.ZERO)
