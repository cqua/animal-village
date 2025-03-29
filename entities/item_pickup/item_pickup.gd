extends Node3D

@onready var mesh := $MeshInstance3D

var lifetime:float
var item:Item

var player_touching := true

func _process(delta):
    lifetime += delta
    
    mesh.position.y = position.y + .5 + sin(lifetime*2)/8
    mesh.rotate_y(delta)

func set_item(_item:Item):
    item = _item
    var sm : ShaderMaterial = mesh.mesh.material
    sm.set_shader_parameter('Texture', item.sprite)
    #mesh.mesh.material.albedo_texture = item.sprite

func _on_area_3d_body_entered(body):
    if not player_touching and body is PlayerController:
        if Inventory.add_item(item):
            queue_free()

func _on_area_3d_body_exited(body):
    if body is PlayerController:
        player_touching = false
