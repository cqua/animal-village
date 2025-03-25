extends Control

var slot:ItemSlot

func set_slot(_slot:ItemSlot):
	slot = _slot
	if slot.count > 0:
		$Panel/Image.texture = slot.item.sprite
		if slot.count > 1:
			$Panel/CountLabel.text = str(slot.count)
