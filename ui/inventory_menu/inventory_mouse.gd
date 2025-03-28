extends Control
class_name InventoryMenu

const INVENTORY_COLUMNS = 5
const INVENTORY_SIZE = 15

static var _menu_prefab

@onready var item_slot_prefab := preload("res://ui/elements/item_slot/item_slot_button.tscn")
@onready var held_item_sprite := $HeldItemSprite

var grabbed_slot_button:ItemSlotButton
var hovered_slot_button:ItemSlotButton

signal closed

func _ready():
	for i in range(0,INVENTORY_SIZE):
		var slot :Button= item_slot_prefab.instantiate()
		$Panel/GridContainer.add_child(slot)
		slot.set_slot_by_index(i)
		slot.button_down.connect(grab_slot.bind(slot))
		slot.mouse_entered.connect(set_hovered_slot.bind(slot))
		slot.mouse_exited.connect(unset_hovered_slot.bind(slot))

func _process(delta):
		#Inventory.drop_item_from_slot(hovered_slot_index)
		#UI.unpause()
	held_item_sprite.global_position = UI.get_mouse_position_screen()
	
	if Input.is_action_just_released("Interact") and grabbed_slot_button:
		drop_slot()
	
	if Input.is_action_just_pressed('OpenMenu'):
		closed.emit()

static func load():
	_menu_prefab = load("res://ui/inventory_menu/inventory_mouse.tscn")

static func open():
	if not _menu_prefab:
		InventoryMenu.load()
	
	return _menu_prefab.instantiate()
	
func grab_slot(slot_button:ItemSlotButton):
	var slot = slot_button.get_slot()
	if slot and slot.item:
		grabbed_slot_button = slot_button
		$HeldItemSprite.texture = slot.item.sprite
		grabbed_slot_button.clear_display()
	
func drop_slot():
	if grabbed_slot_button:
		if hovered_slot_button:
			var grabbed_slot = grabbed_slot_button.get_slot()
			var hovered_slot = hovered_slot_button.get_slot()
			var moved_slot :ItemSlot= grabbed_slot.copy()
			
			if hovered_slot and hovered_slot.item:
				Inventory.set_slot_at(grabbed_slot_button.index, hovered_slot)
			else:
				Inventory.delete_slot_at(grabbed_slot_button.index)
			grabbed_slot_button.update_display()
			
			Inventory.set_slot_at(hovered_slot_button.index, moved_slot)
			hovered_slot_button.update_display()
		else:
			Inventory.drop_item_from_slot(grabbed_slot_button.index)
			grabbed_slot_button.update_display()
		
		$HeldItemSprite.texture = null
		grabbed_slot_button = null

func set_hovered_slot(slot_button:Button):
	hovered_slot_button = slot_button

func unset_hovered_slot(slot_button:Button):
	if hovered_slot_button and hovered_slot_button.index == slot_button.index:
		hovered_slot_button = null
	
