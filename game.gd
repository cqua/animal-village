extends Resource
class_name Game

const HOUR_LENGTH = 90.0
static var time_scale := 1.0

static var item_pickup_prefab:Resource
static var bug_prefab:Resource

static var root:Node3D

static var hour:int = 6
static var minute:int
static var hour_timer:float

static var cursor:CursorCollider
static var interact_highlight:InteractHighlight

static func load(_root:Node3D):
	root = _root
	Item.load()
	Inventory.initialize()
	
	item_pickup_prefab = load("res://entities/item_pickup/item_pickup.tscn")
	bug_prefab = load("res://entities/insects/ant.tscn")
	interact_highlight = load("res://entities/interact_highlight/interact_highlight.tscn").instantiate()
	root.add_child(interact_highlight)
	
	cursor = load("res://entities/cursor_collider/cursor_collider.tscn").instantiate()
	root.add_child(cursor)
	
static func update_clock(delta:float):
	delta *= time_scale
	hour_timer += delta
	minute = int(hour_timer*60/HOUR_LENGTH)
	if hour_timer > HOUR_LENGTH:
		hour_timer -= HOUR_LENGTH
		hour += 1
		if hour > 23:
			hour = 0

static func create_item_pickup(item:Item, position:Vector3):
	var pickup = item_pickup_prefab.instantiate()
	root.add_child(pickup)
	pickup.position = position
	pickup.set_item(item)

static func spawn_bug(item:Item, position:Vector3):
	var bug = bug_prefab.instantiate()
	root.add_child(bug)
	bug.position = position
	bug.run_away()

static func load_scene(path: String) -> void:
	await UI.fade_out()
	root.get_tree().call_deferred('change_scene_to_file', "res://scenes/%s.tscn" % [path])
	await UI.fade_in()
