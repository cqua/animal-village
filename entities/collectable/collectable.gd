extends Interactable

@export var item:Item

func _ready():
    $Decal.texture_albedo = item.sprite

func interact():
    if Inventory.add_item(item):
        queue_free()

func get_label():
    return item.name
