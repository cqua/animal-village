extends Node3D

@onready var mesh := $MeshInstance3D

var lifetime:float
var item:Item

func _process(delta):
	lifetime += delta
	
	mesh.position.y = position.y + .5 + sin(lifetime*2)/8
	mesh.rotate_y(delta)

func set_item(_item:Item):
	item = _item
	mesh.mesh.material.albedo_texture = item.sprite

func _on_area_3d_body_entered(body):
	if body is PlayerController:
		Player.add_interactable(self)

func _on_area_3d_body_exited(body):
	if body is PlayerController:
		Player.remove_interactable(self)

func interact():
	if Inventory.add_item(item):
		queue_free()
