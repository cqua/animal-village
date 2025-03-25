extends Control
class_name InventoryMenu

const INVENTORY_COLUMNS = 5
const INVENTORY_SIZE = 15

static var _menu_prefab

@onready var item_slot_prefab := preload("res://ui/elements/item_slot/item_slot.tscn")
@onready var cursor_prefab := preload("res://ui/elements/cursor/cursor.tscn")

var cursor:Cursor
var cursor_index:Vector2
var hovered_slot_index:int

func _ready():
	for i in range(0,INVENTORY_SIZE):
		var slot = item_slot_prefab.instantiate()
		$Panel/GridContainer.add_child(slot)
		slot.set_slot(Inventory.get_slot_at(i))
	
	cursor = cursor_prefab.instantiate()
	add_child(cursor)

func _process(delta):
	if Input.is_action_just_pressed('Confirm'):
		Inventory.drop_item_from_slot(hovered_slot_index)
		UI.unpause()
	var input_dir = Vector2(
		1 if Input.is_action_just_pressed("ui_right") else -1 if Input.is_action_just_pressed("ui_left") else 0,
		1 if Input.is_action_just_pressed("ui_down") else -1 if Input.is_action_just_pressed("ui_up") else 0
	)
	cursor_index = Vector2(
		int(cursor_index.x + input_dir.x)%INVENTORY_COLUMNS,
		int(cursor_index.y + input_dir.y)%int(INVENTORY_SIZE/INVENTORY_COLUMNS)
	)
	if cursor_index.x < 0:
		cursor_index.x = cursor_index.x + INVENTORY_COLUMNS
	if cursor_index.y < 0:
		cursor_index.y = cursor_index.y + int(INVENTORY_SIZE/INVENTORY_COLUMNS)
	
	var slots = $Panel/GridContainer.get_children()
	hovered_slot_index = int(cursor_index.x+cursor_index.y*5)
	var hovered_slot = slots[hovered_slot_index]
	cursor.move_to(hovered_slot.global_position)
	if hovered_slot.slot.item:
		$Panel/HoveredItemLabel.text = hovered_slot.slot.item.name
	else:
		$Panel/HoveredItemLabel.text=''

static func load():
	_menu_prefab = load("res://ui/inventory_menu/inventory_menu.tscn")

static func open():
	if not _menu_prefab:
		InventoryMenu.load()
	
	return _menu_prefab.instantiate()
	
