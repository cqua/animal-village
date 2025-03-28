extends Button
class_name ItemSlotButton

var index:int

func set_slot_by_index(_index:int):
	index = _index
	
	update_display()

func get_slot():
	if index<0:
		return null
	
	return Inventory.get_slot_at(index)

func clear_slot():
	index = -1
	update_display()

func update_display():
	var slot = get_slot()
	if slot and slot.item and slot.count > 0:
		icon = slot.item.sprite
		if slot.count > 1:
			$CountLabel.text = str(slot.count)
		else:
			$CountLabel.text = ''
	else:
		icon = null
		$CountLabel.text =''

func clear_display():
	icon = null
	$CountLabel.text =''
