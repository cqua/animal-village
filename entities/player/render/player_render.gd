extends Node3D
class_name PlayerRender

var target_facing = Vector2.UP

@onready var animtree :AnimationTree= $AnimationTree
@onready var bugnet_prefab = preload("res://entities/tools/bugnet.tscn")
@onready var tool_node := $metarig/Skeleton3D/BoneAttachment3D/ToolNode

var net_blend :float

func _ready():
	Player.set_render(self)
	update_tool()

func set_target_facing(facing_angle:float):
	target_facing = Vector2.from_angle(facing_angle)

func _process(delta):
	look_at(global_position + Vector3(target_facing.x,0,target_facing.y), Vector3.UP)
	
	var target_blend:float
	if Player.current_action == Player.Action.Ready:
		target_blend = 1
		animtree.set('parameters/attack_net/request', AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
	if Player.current_action == Player.Action.Attack:
		target_blend = 1
	
	net_blend = move_toward(net_blend,target_blend, delta * 6)
	animtree.set('parameters/blend_net/blend_amount', net_blend)

func set_velocity(v:Vector3):
	var speed = Vector3.ZERO.distance_to(v)
	
	animtree.set('parameters/blend_walk/blend_amount', clampf(speed/4,0,1))
	
	if angle_difference(target_facing.normalized().angle(), Vector2(v.x,v.z).normalized().angle()) > PI/2:
		speed *= -1
		print('goin backies')
	animtree.set('parameters/speed_walk/scale', clampf(speed/3,-32,32))

func update_tool():
	for child in tool_node.get_children():
		child.queue_free()
	
	if Player.current_tool:
		var tool = bugnet_prefab.instantiate()
		tool_node.add_child(tool)
		
func attack():
	animtree.set('parameters/attack_net/request', AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
