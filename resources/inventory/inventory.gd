extends Resource
class_name Inventory

const SIZE = 15
static var _slots:Array[ItemSlot]

static func initialize():
	for i in range(0,SIZE):
		var slot = ItemSlot.new(Item.NONE)
		_slots.push_back(slot)
	
	_slots[0].item = Item.ARTIFACT_LIONSPAW
	_slots[0].count = 4

static func get_slot_at(n:int) -> ItemSlot:
	return _slots[n]

static func add_item(item:Item, count:=1) -> bool:
	var empty_slot_index = -1
	for i in range(0,SIZE):
		if _slots[i].item == item and _slots[i].count + count <= item.stack_size:
			_slots[i].count += count
			return true
		if empty_slot_index<0 and not _slots[i].item:
			empty_slot_index = i
	
	if empty_slot_index >= 0:
		_slots[empty_slot_index].item = item
		_slots[empty_slot_index].count = count
		return true
	
	return false

static func drop_item_from_slot(index:int, count:=-1):
	var slot = _slots[index]
	
	if count<0:
		count=slot.count
	for i in range(0,count):
		Game.create_item_pickup(slot.item, Player.get_position() + Vector3(randf()-.5,0,randf()-.5))
	
	slot.count -= count
	if slot.count <= 0:
		slot.count = 0
		slot.item = Item.NONE
