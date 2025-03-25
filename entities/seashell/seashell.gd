extends Area3D

@export var item:Item

func _ready():
	$Decal.texture_albedo = item.sprite

func _on_body_entered(body):
	if body is PlayerController:
		Player.add_interactable(self)
		print('adding')

func _on_body_exited(body):
	if body is PlayerController:
		Player.remove_interactable(self)
		print('removing')

func interact():
	if Inventory.add_item(item):
		queue_free()
