extends Resource
class_name ItemSlot

@export var item:Item
@export var count:int

func _init(_item = Item.NONE, _count = 0):
	item=_item
	count=_count

func copy():
	var _slot = new()
	_slot.item = item
	_slot.count = count
	return _slot
