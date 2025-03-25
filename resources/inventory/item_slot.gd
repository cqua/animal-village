extends Resource
class_name ItemSlot

@export var item:Item
@export var count:int

func _init(_item = Item.NONE, _count = 0):
	item=_item
	count=_count
